# All game controlling logic and UI interaction with the player
source("model.R")
source("view.R")
source("ai.R")

# play a single game
# returns TRUE if user wants to play again, FALSE if they want to quit
play_game <- function() {
  # playing game state
  set.seed(sample(1:1000, 1))
  game <- new_game()
  user_key <- get_key(message = "Choose a side - X's or 'O's ['q' to quit]",
                      allowed_keys = c(X_KEY, O_KEY, QUIT_KEY))
  if (user_key == QUIT_KEY) {
    return(FALSE)
  }

  game$player <- key_to_player(user_key)
  while (user_key != QUIT_KEY) {
    # or game over
    game <- single_turn(game)

    if (game$completed) {
      if (game$winner != EMPTY) {
        print_board(game)
        print_winner(game)
      }
      else if (game$draw) {
        print_board(game)
        print_draw()
      }
      # ask to play again
      play_again <- get_key(message = "Another game? Enter 'y' to play again. ['q' to quit]", allowed_keys = c(QUIT_KEY, 'y'))
      if (play_again == QUIT_KEY) {
        return(FALSE)
      }
      return(TRUE) # play again
    }
  }
}

# play single turn of the given game
single_turn <- function(game) {
  print_game_turn(game)
  if (game$player == PLAYER_X) {
    print_board(game)
    game <- single_player_move(game)
    if (!game$completed)
      game <- single_computer_move(PLAYER_O, game)
  }
  else {
    game <- single_computer_move(PLAYER_X, game)
    if (!game$completed) {
      print_board(game)
      game <- single_player_move(game)
    }
  }

  game$turn <- game$turn + 1
  return(game)
}


# perform all steps for a single move for human player
single_player_move <- function(game) {
  move <- player_move(game)
  if (move == QUIT_KEY) {
    game_message("Abandoning Game...Coward! Flee while you still can!")
    game$completed <- TRUE
    return(game)
  }
  game <- add_move(game$player, move, game)

  # check if this was a winning move
  game <- game_won(game)
  return(game)
}

# perform all steps for a single move for computer
single_computer_move <- function(computer_player, game) {
  Sys.sleep(0.2)
  game_message("Computer's Turn...")
  Sys.sleep(0.6)
  game <- computer_move(computer_player, game)
  if (game$draw) {
    game$completed <- TRUE
  }

  # check if this was a winning move
  game <- game_won(game)
  return(game)
}

# get players move
player_move <- function(game) {
  repeat {
    player_symbol <- ifelse(game$player == PLAYER_X, "X", "O")
    raw_key <- get_key(paste0("Enter your turn [select 1..9] - You are the ", player_symbol, "'s ['q' to quit]"), c(QUIT_KEY, VALID_MOVES))
    if (raw_key == QUIT_KEY) {
      return(QUIT_KEY)
    }
    move <- as.numeric(raw_key)
    pos <- row_col(move)
    if (game$board[pos$row, pos$col] == EMPTY) {
      break
    }
    game_message("That square has been played. Pick another.")
  }
  return(move)
}
