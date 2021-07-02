# The game model state
# No UI interactions here

source("constant.r")

# Convert key character to player code of PLAYER_X or PLAYER_0
# exists with error on invalid codeEnter your turn
key_to_player <- function(player_key) {
  if (player_key == X_KEY) {
    return(PLAYER_X) }
  else if (player_key == O_KEY) {
    return(PLAYER_O)
  }
  stop(paste0("Invalid player key code: ", player_key))
}

# rand_seed - for repeatability of some AI moves which are randomly determined
# returns a game object as a list with:
# completed  = <boolean>
# turn = <integer>  Game turn set to 1 at start.
# player = <integer> which side player will choose - 'X' or '0'. initialized to EMPTY
# board = 3x3 matrix initialized with EMPTY values
# winner = <integer> initialized with EMPTY. On game completion set to PLAYER_X or PLAYER_O
new_game <- function(rand_seed = 1) {
  set.seed(rand_seed)
  game <- list(completed = FALSE,
               turn = as.integer(1),
               player = EMPTY,
               board = matrix(EMPTY, nrow = 3, ncol = 3),
               winner = EMPTY,
               draw = FALSE)
  return(game)
}

# player <integer> PLAYER_X or PLAYER_O
# move <integer> 1-9 
# game <list> game object

add_move <- function(player, move, game) {
  pos <- row_col(move)
  game$board[pos$row, pos$col] <- player
  return(game)
}


# check to see if any player has won the game.
# game won state defined game$completed flag set to TRUE, and
# game$winner is set to winning player
game_won <- function(game) {
  x_winning_row <- PLAYER_X * 3
  o_winning_row <- PLAYER_O * 3

  # check for winning horizontal or vertical rows
  row_sums <-  rowSums(game$board)
  col_sums <-  colSums(game$board)
  diag_sum <- sum(diag(game$board))
  reverse_diag_sum <- reverse_diagonal_sum(game$board)

  if (x_winning_row %in% row_sums || x_winning_row %in% col_sums || x_winning_row == diag_sum || x_winning_row == reverse_diag_sum){
    game$winner <- PLAYER_X
    game$completed <- T
  } else if (o_winning_row %in% row_sums || o_winning_row %in% col_sums || o_winning_row == diag_sum || o_winning_row == reverse_diag_sum) {
    game$winner <- PLAYER_O
    game$completed <- T
  }
  return(game)
}


# convert a move from scalar integer (1-9) into cartesian coordinates.
# move=1 --> board[1,1]
# move=2 --> board[1,2]
# move=9 --> board[3,3]
row_col <- function(move) {
  if (move < 1 || move > 9)
    stop("Invalid move argument for 3x3 matrix. Should be a number from 1-9.")
  row <- ceiling(move / 3)
  col <- ifelse(move %% 3 > 0, move %% 3, 3)
  return(list(row = row, col = col))
}

# convert cartesian coordinates [y,x] to scalar integer (1-9)
# coord = list(row=N, col=N)
# board[1,1] --> 1
# board[1,2] --> 2
# board[3,3] --> 9
row_col_to_move <- function(coord) {
  if (coord$row < 1 || coord$row > 3)
    stop("Invalid row argument for 3x3 matrix. Should be a number from 1-3.")
  if (coord$col < 1 || coord$col > 3)
    stop("Invalid column argument for 3x3 matrix. Should be a number from 1-3.")
  return((coord$row - 1) * 3 + coord$col)
}


# return diagonal of game baord from bottom-left to top-right corners
# assumes square matrix of 3x3
reverse_diagonal_sum <- function(m) {
  if (length(m) != 9)
    stop("Invalid matrix - not square of size 3x3")

  return(m[3, 1] + m[2, 2] + m[1, 3])
}
