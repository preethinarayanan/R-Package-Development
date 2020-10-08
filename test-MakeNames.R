context("MakeNames test")

testthat::test_that("MakeNames makes nice names", {
  expect_true(all(names(MakeNames(iris)) == c("sepal_length", "sepal_width",
                                              "petal_length", "petal_width",  "species")))
  expect_true(all(c("class", "sex", "age", "survived", "freq") == names(MakeNames(as.data.frame(Titanic)))))
})
