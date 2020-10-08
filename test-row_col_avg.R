test_that("row col avg works", {
  x <- c(2,2)
  y <- c(2,2)
  x_w <- c(2,6)
  y_w <- c(1,5)
  df_w <- data.frame(x_w, y_w)
  df <- data.frame(x,y)
  return <- 'totals_row'
  totals(df, 'totals_row', df_w )
  #totals(2 * 2, 4)
})
