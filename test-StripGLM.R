context("MakeNames test")

testthat::test_that("strip models", {
  expect_true(length(kittens::StripGLM(lm(mpg~., mtcars))) < length(lm(mpg~., mtcars)))
  expect_true(length(kittens::StripGLM(glm(mpg~., mtcars, family = "gaussian"))) < length(glm(mpg~., mtcars, family = "gaussian")))
})

