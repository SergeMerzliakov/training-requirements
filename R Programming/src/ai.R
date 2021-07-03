# All AI logic for computers moves is here
source("model.R")

# computer AI move
# computer_player <integer>
# game <game state as a list>
computer_move <- function(computer_player, game) {

  # Step 1 - See if we can win this turn
  defeat_opponent <- check_for_win_strategy(computer_player, game$board)
  if (defeat_opponent$success) {
    game <- add_move(computer_player, defeat_opponent$move, game)
    return(game)
  }

  #  Step 2 - make sure we are not about to lose!
  block_opponent <- check_for_win_strategy(game$player, game$board)
  if (block_opponent$success) {
    game <- add_move(computer_player, block_opponent$move, game)
    return(game)
  }

  # Step 3 - take corners - attempting to get a fork
  take_corner <- corner_strategy(game$board)
  if (take_corner$success) {
    game <- add_move(computer_player, take_corner$move, game)
    return(game)
  }

  # Step 4 - take first available square
  default_move <- default_strategy(game$board)
  if (default_move$success){
    game <- add_move(computer_player, default_move$move, game)
  }
  else{ # game is a draw
    game$draw <- T
  }

  return(game)
}

# randomly pick a free corner
# return list (success=true, move=integer) 
# if succeeded result$success is TRUE
corner_strategy <- function(board) {
  result <- list(success = FALSE, move = EMPTY)

  # check if any corners available
  empty_corners <- board[c(1, 3, 7, 9)] == -1
  if (is.na(table(empty_corners)["TRUE"]) || table(empty_corners)["TRUE"] == 0)
    return(result)

  corner_func <- function(row, col, board, corner_move) {
    result <- list(success = FALSE, move = -1)
    if (board[row, col] == EMPTY) {
      result$success <- TRUE
      result$move <- corner_move
    }
    return(result)
  }

  corner_evaluators <- list(corner_func(1, 1, board, CORNER_1), corner_func(1, 3, board, CORNER_2),
                            corner_func(3, 1, board, CORNER_3), corner_func(3, 3, board, CORNER_4))

  # pick corner at random
  repeat {
    rand_corner <- sample(1:4, 1)
    corner_result <- corner_evaluators[rand_corner][[1]]
    if (corner_result$success)
      break
  }

  return(corner_result)
}

# return list (success=true, move=integer)
# For the given player, try and find a winning move
# player - human or computer
# board - game board (3x3 matrix)
check_for_win_strategy <- function(player, board) {
  result <- list(success = FALSE, move = EMPTY)

  # 2 * human - 1 : 2 positions played with one empty
  winning_row <- 2 * player + EMPTY

  # check rows
  win_row <- match(winning_row, rowSums(board), nomatch = EMPTY)
  if (win_row != EMPTY) {
    row_data <- board[win_row,]
    result$move <- (win_row - 1) * 3 + match(EMPTY, row_data)
    result$success <- TRUE
    return(result)
  }

  # check columns
  win_col <- match(winning_row, colSums(board), nomatch = EMPTY)
  if (win_col != EMPTY) {
    col_data <- board[,win_col]
    result$move <- (match(EMPTY, col_data) - 1) * 3 + win_col
    result$success <- TRUE
    return(result)
  }

  # check diagonal
  diag_sum <- sum(diag(board))
  if (winning_row == diag_sum) {
    if (board[1, 1] == EMPTY) {
      result$move <- P1_1
      result$success <- TRUE
      return(result)
    }
    else if (board[2, 2] == EMPTY) {
      result$move <- P2_2
      result$success <- TRUE
      return(result)
    }
    result$move <- P3_3
    result$success <- TRUE
    return(result)
  }

  # check opposite diagonal
  reverse_diag_sum <- reverse_diagonal_sum(board)
  if (winning_row == reverse_diag_sum) {
    if (board[3, 1] == EMPTY) {
      result$move <- P3_1
      result$success <- TRUE
      return(result)
    }
    else if (board[2, 2] == EMPTY) {
      result$move <- P2_2
      result$success <- TRUE
      return(result)
    }
    result$move <- P1_3
    result$success <- TRUE
    return(result)
  }

  # no winning positions for player
  return(result)
}

# pick first empty square
# if no square found, game is a draw
default_strategy <- function(board) {
  result <- list(success = FALSE, move = EMPTY)
  empty_square <- match(EMPTY, board, nomatch = NO_MATCH)
  if (empty_square != NO_MATCH) {
    result$success <- TRUE
    result$move <- empty_square
  }
  return(result)
}
