#' Not in operator
#'
#' @description does the opposite of %in%
#'
#' @param x not needed, placeholder
#' @param table not needed, placeholder
#'
#' @export
#' @importFrom purrr "negate"
#'
#' @example
#' # eight_cyl <- mtcars[which(mtcars$cyl %not_in% c(4, 6)), ]

`%not_in%` <- negate(`%in%`)
