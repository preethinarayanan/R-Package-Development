context("CatchAll test")

testthat::test_that("CatchAll catches all", {
  expect_true(table(CatchAll(df = mtcars, group = "cyl", cutoff = 10) %>% dplyr::select(cyl)) %>% .[[3]] == 7)

  expect_true(table(CatchAll(df = mtcars, group = "cyl", cutoff = 20, wanted = "4") %>% dplyr::select(cyl)) %>% .[[2]] == 21)
})
