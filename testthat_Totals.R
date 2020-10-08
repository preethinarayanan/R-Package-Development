
testthat::test_that("check function",
                    {Totals(df= data.frame(a = c(1:3), b= c(3:5), c=c(5:7)), "totals_row")})

testthat::test_that("check function",
                    {Totals(df= data.frame(a = c(1:3), b= c(3:5), c=c(5:7)), "weighted_avg",
                            w1 = data.frame(a=c(7:9),b=c(9:11),c=c(11:13)))})
