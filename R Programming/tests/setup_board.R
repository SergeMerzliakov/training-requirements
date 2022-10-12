source("../src/model.R", chdir = TRUE)

#  --- --- ---
# | X |   | O |
#  --- --- ---
# |   | X |   |
#  --- --- ---
# |   |   | O |
#  --- --- ---
board_setup_1 <- function() {
  game <- new_game()

  game$board[1, 1] <- PLAYER_X
  game$board[1, 3] <- PLAYER_O
  game$board[2, 2] <- PLAYER_X
  game$board[3, 3] <- PLAYER_O

  return(game)
}

#  --- --- ---
# | X |   |   |
#  --- --- ---
# |   | X |   |
#  --- --- ---
# |   |   | O |
#  --- --- ---
board_setup_2 <- function() {
  game <- new_game()

  game$board[1, 1] <- PLAYER_X
  game$board[2, 2] <- PLAYER_X
  game$board[3, 3] <- PLAYER_O

  return(game)
}


#  --- --- ---
# | X |   |   |
#  --- --- ---
# |   | O |   |
#  --- --- ---
# |   |   |   |
#  --- --- ---
board_setup_3 <- function() {
  game <- new_game()

  game$board[1, 1] <- PLAYER_X
  game$board[2, 2] <- PLAYER_O

  return(game)
}


#  --- --- ---
# | X |   | X |
#  --- --- ---
# |   |   |   |
#  --- --- ---
# | X |   | X |
#  --- --- ---
# artificial scenario
board_setup_4 <- function() {
  game <- new_game()

  game$board[1, 1] <- PLAYER_X
  game$board[1, 3] <- PLAYER_X
  game$board[3, 1] <- PLAYER_X
  game$board[3, 3] <- PLAYER_X

  return(game)
}

#  --- --- ---
# | X |   | O |
#  --- --- ---
# | X | O |   |
#  --- --- ---
# |   |   |   |
#  --- --- ---
board_win_setup_1 <- function() {
  game <- new_game()

  game$board[1, 1] <- PLAYER_X
  game$board[1, 3] <- PLAYER_O
  game$board[2, 1] <- PLAYER_X
  game$board[2, 2] <- PLAYER_O

  return(game)
}
