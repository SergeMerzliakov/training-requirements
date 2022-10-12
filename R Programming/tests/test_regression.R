source("setup_board.R")
source("../src/ai.R", chdir = TRUE)
source("../src/model.R", chdir = TRUE)
source("../src/view.R", chdir = TRUE)
library(testthat)

NO_MOVE <- -1

# pick a free square at random
random_square <- function(board) {
  # single index access to matrix is in column major order
  # this converts those in row major order - which humans
  # prefer
  row_first <- c(1, 4, 7, 2, 5, 8, 3, 6, 9)
  free_squares <- row_first[which(board == EMPTY)]
  if (length(free_squares) > 0)
    return(free_squares[sample(seq_along(free_squares), 1)])
  
  return(NO_MOVE)
}

# simulate a single game. Needs a unique random seed for each
# game
simulate_game <- function() {
  game <- new_game()
  game$player <- PLAYER_X
  opponent <- PLAYER_O
  game_history <- vector()
  
  while (game$completed == F) {
    move_x <- random_square(game$board)
    if (move_x == NO_MOVE) {
      game$completed <- T
      game$draw <- T
    }else {
      game <- add_move(game$player, move_x, game)
      game_history <- append(game_history, move_x)
      game <- computer_move(opponent, game)
      game$turn <- game$turn + 1
      #print_board(game)
      game <- game_won(game)
    }
  }
  return(game_history)
}

# simulate lots of games as a final regression test
test_that("simulate many games", {
  n <- 0
  total_games <- 3000
  
  tryCatch({
      while (n < total_games) {
        set.seed(n)
        history <- simulate_game()
        n <- n + 1
      } 
    }, error = function(error_message) {
      # print moves for failed game - to aid in debugging
      print(paste0(" >>> Turn history for X for failed game = ", paste0(history, collapse = " -> ")))
      message(error_message)
    })
  expect_equal(n, total_games)
  print(paste0("Simulated ", total_games, " games successfully"))
})






