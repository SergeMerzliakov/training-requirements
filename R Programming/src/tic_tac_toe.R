source("input.R")
source("game.R")

#----------------------------------------------------
#----------------------------------------------------
# MAIN GAME LOOP AND ENTRY POINT
#----------------------------------------------------
#----------------------------------------------------

run_tic_tac_toe <- function() {
  print_game_banner()

  user_key <- ''

  while (user_key != QUIT_KEY) {
    user_key <- get_key("Press 'n' to start a new game. ['q' to quit]", allowed_keys = c(NEW_GAME_KEY, QUIT_KEY))
    if (user_key == NEW_GAME_KEY) {
      play_again <- play_game()
      if (!play_again)
        break
    }
  }

  print_shutdown_message()
}
