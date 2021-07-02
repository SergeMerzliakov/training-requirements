source("../src/model.R", chdir = TRUE)
library(testthat)


test_that("key_to_player", {
  expect_equal(key_to_player(X_KEY), PLAYER_X)
  expect_equal(key_to_player(O_KEY), PLAYER_O)
})


test_that("row_col_to_move creates move position - 1:9", {
  expect_equal(row_col_to_move(list(row=1, col=1)), P1_1)
  expect_equal(row_col_to_move(list(row=1, col=2)), P1_2)
  expect_equal(row_col_to_move(list(row=3, col=1)), P3_1)
})


test_that("row_col creates correct coordinates", {
  expect_equal(row_col(1), list(row = 1, col = 1))
  expect_equal(row_col(3), list(row = 1, col = 3))
  expect_equal(row_col(4), list(row = 2, col = 1))
  expect_equal(row_col(7), list(row = 3, col = 1))
})


test_that("row_col rejects invalid coordinates", {
  expect_error(row_col(0), "Invalid move.+")
  expect_error(row_col(10), "Invalid move.+")
})


test_that("reverse_diagonal_sum", {
  m <- matrix(c(4, 5, 6, 7, 8, 9, 10, 11, 12), nrow = 3, ncol = 3)
  expect_equal(reverse_diagonal_sum(m), 6 + 8 + 10)
})


test_that("reverse_diagonal_sum rejects non 3x3 matrices", {
  m <- matrix(1:16, nrow = 4, ncol = 4)
  expect_error(reverse_diagonal_sum(m),"Invalid matrix.+")
})


test_that("new_game creates correct initial game object", {
  expect_equal(new_game(), list(completed = FALSE,
                                turn = as.integer(1),
                                player = EMPTY,
                                board = matrix(EMPTY, nrow = 3, ncol = 3),
                                winner = EMPTY,
                                draw = FALSE))
})


test_that("add_move", {
  game <- new_game()
  MOVE <- 7
  game <- add_move(PLAYER_X, MOVE, game)

  coord <- row_col(MOVE)
  expect_equal(game$board[coord$row, coord$col], PLAYER_X)
})


test_that("add_move invalid", {
  game <- new_game()
  MOVE <- 100
  expect_error(add_move(PLAYER_X, MOVE, game), "Invalid move.+")
})


test_that("game_won by row", {

  # ROW 1
  game <- new_game()
  game <- add_move(PLAYER_X, 1, game)
  game <- add_move(PLAYER_X, 2, game)
  game <- add_move(PLAYER_X, 3, game)

  game <- game_won(game)

  expect_equal(game$completed, TRUE)
  expect_equal(game$winner, PLAYER_X)

  # ROW 2
  game <- new_game()
  game <- add_move(PLAYER_O, 4, game)
  game <- add_move(PLAYER_O, 5, game)
  game <- add_move(PLAYER_O, 6, game)

  game <- game_won(game)

  expect_equal(game$completed, TRUE)
  expect_equal(game$winner, PLAYER_O)

  # ROW 3
  game <- new_game()
  game <- add_move(PLAYER_O, 7, game)
  game <- add_move(PLAYER_O, 8, game)
  game <- add_move(PLAYER_O, 9, game)

  game <- game_won(game)

  expect_equal(game$completed, TRUE)
  expect_equal(game$winner, PLAYER_O)
})


test_that("game_won by column", {

  # COL 1
  game <- new_game()
  game <- add_move(PLAYER_X, 1, game)
  game <- add_move(PLAYER_X, 4, game)
  game <- add_move(PLAYER_X, 7, game)

  game <- game_won(game)

  expect_equal(game$completed, TRUE)
  expect_equal(game$winner, PLAYER_X)

  # COL 2
  game <- new_game()
  game <- add_move(PLAYER_O, 2, game)
  game <- add_move(PLAYER_O, 5, game)
  game <- add_move(PLAYER_O, 8, game)

  game <- game_won(game)

  expect_equal(game$completed, TRUE)
  expect_equal(game$winner, PLAYER_O)

  # COL 3
  game <- new_game()
  game <- add_move(PLAYER_O, 3, game)
  game <- add_move(PLAYER_O, 6, game)
  game <- add_move(PLAYER_O, 9, game)

  game <- game_won(game)

  expect_equal(game$completed, TRUE)
  expect_equal(game$winner, PLAYER_O)
})


test_that("game_won diagonal", {
  game <- new_game()
  game <- add_move(PLAYER_X, 1, game)
  game <- add_move(PLAYER_X, 5, game)
  game <- add_move(PLAYER_X, 9, game)

  game <- game_won(game)

  expect_equal(game$completed, TRUE)
  expect_equal(game$winner, PLAYER_X)
})


test_that("game_won by reverse diagonal", {
  game <- new_game()
  game <- add_move(PLAYER_X, 7, game)
  game <- add_move(PLAYER_X, 5, game)
  game <- add_move(PLAYER_X, 3, game)

  game <- game_won(game)

  expect_equal(game$completed, TRUE)
  expect_equal(game$winner, PLAYER_X)
})
