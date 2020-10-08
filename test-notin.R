library(kittens)
context("not in test")

testthat::test_that("not in means not in", {
  expect_false(8 %not_in% mtcars$cyl)
  expect_true(8 %in% mtcars$cyl)
})
