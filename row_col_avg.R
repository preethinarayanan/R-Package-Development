#' @title Totals
#'
#' @description calculate row sum, col sum, weighted average
#'
#' @param df the data frame you wish to perform the row sum or column sum function
#'
#' @param return specify either totals_row or totals_col or weighted_avg
#'
#' @param w1 is the weighted average parameter for the df. Not required for totals_row, totals_col
#'
#' @importFrom dplyr "summarise_all" "summarise_if" "funs" "%>%"
#' @importFrom stats "weighted.mean"
#'
#' @return returns specify either totals_row or totals_col or weighted_avg of the data frame or tibble with summary of rows or columns
#'
#' @return is 'totals_row' for row total calcualtion
#'
#' @return is 'totals_col' for column total calculation
#'
#' @return is "weighted_avg"' for weighted_avg calculation
#'
#'
#'
#' @export
#'
#' @examples
#' x <- c(2,2)
#' y <- c(2,2)
#' x_w <- c(2,6)
#' y_w <- c(1,5)
#' df_w <- data.frame(x_w, y_w)
#' df <- data.frame(x,y)
#' return <- 'totals_row'
#' Totals(df,return, df_w)
#'

Totals <- function(df, return, w1 = NULL) {
  if(is.null(w1) & return == "totals_row") {

    rowtotal <- rowSums(Filter(is.numeric, df), na.rm = TRUE)

    totals_row <- rbind(Filter(is.numeric,df),totals = rowtotal)

    return(list("rowtotal" = rowtotal, "totals_row" = totals_row, "table_totals_row" = table(totals_row)))

  } else if (is.null(w1) & return == "totals_col") {

    colsum_df <- colSums(Filter(is.numeric, df), na.rm = TRUE)

    summarise_col <- df %>% summarise_if(is.numeric, sum, na.rm = TRUE)

    col_sum <- summarise_all(df, funs(if(is.numeric(.)) sum(.) else "Character values found"))

    totals_col <- cbind(Filter(is.numeric,df), totals = colsum_df)

    return (list("colsum_df" = colsum_df, "totals_col" = totals_col, "table_col_sum" = table(col_sum),"summarise_col"= summarise_col))

  } else {

    weighted_avg <- weighted.mean(Filter(is.numeric, df), w1, na.rm=TRUE)

    return ("weighted_avg" = weighted_avg)
  }
}




