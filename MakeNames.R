#' MakeNames
#'
#' @description  creates standard variable names,
#' removing non-alphaumeric characters and replacing these with `_`
#'
#' @param df a data_frame, tibble or data.table
#'
#' @return returns the data_frame, tibble or data.table with altered names.
#' @export
#' @importFrom magrittr "%>%" "%<>%"
#' @examples
#' iris2 <- MakeNames(iris)
#' rbind(colnames(iris), colnames(iris2))
MakeNames <- function(df) {

  colnames(df) %<>%
    tolower() %>%
    gsub(".", pattern = "[^[:alnum:]]+", replacement = "_") %>%
    trimws

  df
}
