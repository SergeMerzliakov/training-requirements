
# keys
QUIT_KEY <- 'q'
NEW_GAME_KEY <- 'n'
X_KEY <- 'x'
O_KEY <- 'o'

VALID_MOVES <- as.character(c(1:9))

# global constants
EMPTY <- -1
NO_MATCH <- -1

# board players
PLAYER_X <- 2
PLAYER_O <- 3

# board positions - top-left to bottom-right, traversing by row
P1_1 <- 1
P1_2 <- 2
P1_3 <- 3
P2_1 <- 4
P2_2 <- 5
P2_3 <- 6
P3_1 <- 7
P3_2 <- 8
P3_3 <- 9


CORNER_1 <- 1 # position 1,1
CORNER_2 <- 3 # position 1,3
CORNER_3 <- 7 # position 3,1
CORNER_4 <- 9 # position 3,3


# list of opponents on startup - no actual game impact!
opponents <- c("HAL 9000", "a T-1000 Terminator", "R2-D2", "Optimus Prime", "A Borg Cube")
