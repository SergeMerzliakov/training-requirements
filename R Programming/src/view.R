# All rendering to the screen
source("constant.R")
source("model.R")


# print game turn
print_game_turn <- function(game) {
  cat("\n#-------------------------------------------------------#\n")
  cat(paste0("                    TURN ", game$turn,"\n\n"))
}


print_board <- function(game){
	m <- game$board
  cat("\n     Game Board         Movement Guide (Select '1'...'9' for your move)\n")
  cat("     --- --- ---                   --- --- ---\n")
  cat(paste0("    | ", draw_cell(m[1, 1]), " | ", draw_cell(m[1, 2]) , " | ", draw_cell(m[1, 3]), " |                 | 1 | 2 | 3 |\n"))
  cat("     --- --- ---                   --- --- ---\n")
  cat(paste0("    | ", draw_cell(m[2, 1]), " | ", draw_cell(m[2, 2]) , " | ", draw_cell(m[2, 3]), " |                 | 4 | 5 | 6 |\n"))
  cat("     --- --- ---                   --- --- ---\n")
  cat(paste0("    | ", draw_cell(m[3, 1]), " | ", draw_cell(m[3, 2]) , " | ", draw_cell(m[3, 3]), " |                 | 7 | 8 | 9 |\n"))
  cat("     --- --- ---                   --- --- ---\n")
}

print_winner <- function(game) {
  cat("\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n")
  cat("\n                       GAME OVER\n")
  cat("\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n\n")
  cat(paste0("            The ", ifelse(game$winner == game$player, "Player", "Computer"), " won the game\n\n"))
}


print_draw <- function() {
  cat("\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n")
  cat("\n                       GAME IS A DRAW\n")
  cat("\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n\n")
}


# 
draw_cell <- function(cell_data){
  if (cell_data == EMPTY)
      return(" ")
  else if (cell_data == PLAYER_X)
      return("X")
  else if (cell_data == PLAYER_O)
      return("O")
  return(cell_data)
}

# standardize messages to screen
# msg -
game_message <- function(msg) {
  cat(paste0("\n~~~ ", msg, " ~~~\n"))
}

print_game_banner <- function() {
  cat("----------------------------------------------------\n")
  cat("----------------------------------------------------\n")
  cat("          Welcome to Tic Tac Toe\n")
  cat("\n")
  cat("     Copyright 2021 - Serge Merzliakov\n")
  cat("----------------------------------------------------\n")
  cat("----------------------------------------------------\n")
  cat("\n")
  Sys.sleep(0.5)
  cat("  Your computer opponent today is...")
  Sys.sleep(0.8)
  cat(sample(opponents, 1), "\n")
  Sys.sleep(0.5)
  cat("\n----------------------------------------------------\n")
  Sys.sleep(0.5)
}

print_shutdown_message <- function() {
  Sys.sleep(0.5)
  cat("\n----------------------------------------------------\n")
  cat("                   GOODBYE\n")
  cat("----------------------------------------------------\n")
}
