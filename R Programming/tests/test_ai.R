source("setup_board.R")
source("../src/ai.R", chdir = TRUE)
source("../src/model.R", chdir = TRUE)
library(testthat)


test_that("corner_strategy with single choice", {
  game <- board_setup_1(100)
  result <- corner_strategy(game$board)
  expect_equal(result$success, TRUE)
  expect_equal(result$move, 7)

  game <- board_setup_1(101)
  result <- corner_strategy(game$board)
  expect_equal(result$success, TRUE)
  expect_equal(result$move, 7)
})


test_that("corner_strategy is random", {
  game <- board_setup_2(45)
  result <- corner_strategy(game$board)
  expect_equal(result$success, TRUE)
  expect_equal(result$move, 7, info=paste0("actual move 1 is", result$move))

  game <- board_setup_2(101)
  result <- corner_strategy(game$board)
  expect_equal(result$success, TRUE)
  expect_equal(result$move, 3, info=paste0("actual move 2 is", result$move))
})

test_that("corner_strategy is random - 2", {
  game <- board_setup_3(11)
  result <- corner_strategy(game$board)
  expect_equal(result$success, TRUE)
  expect_equal(result$move, 3, info=paste0("actual move 1 is", result$move))

  result <- corner_strategy(game$board)
  expect_equal(result$success, TRUE)
  expect_equal(result$move, 3, info=paste0("actual move 2 is ", result$move))

  result <- corner_strategy(game$board)
  expect_equal(result$success, TRUE)
  expect_equal(result$move, 9, info=paste0("actual move 3 is", result$move))
})


test_that("check_for_win_strategy for Player X", {
  game <- board_win_setup_1(11)
  result <- check_for_win_strategy(PLAYER_X, game$board)
  expect_equal(result$success, TRUE)
  expect_equal(result$move, 7, info=paste0("actual winning move selected is", result$move))
})

test_that("check_for_win_strategy for Player O", {
  game <- board_win_setup_1(11)
  result <- check_for_win_strategy(PLAYER_O, game$board)
  expect_equal(result$success, TRUE)
  expect_equal(result$move, 7, info=paste0("actual winning move selected is", result$move))
})
