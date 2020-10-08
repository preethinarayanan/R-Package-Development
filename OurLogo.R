#' OurLogo
#'
#' @description return logos from Brown & Brown Insurance company logo, Arrowhead logo, and kittens package logo
#'
#' Follow this link to see Brown and Brown logo styleguide: (https://bbins365.sharepoint.com/sites/intranet/departments/communications)
#'
#'
#'
#'
#' @param logo choose which logo to print. Input "bb" for Brown and Brown logo, "arrowhead" for Arrowhead General Insurance logo, and "kittens" for kittens package logo
#' @param rmd default is TRUE, print logo using htmltools package for Rmd version. rmd = FALSE will print a regular PNG picture on the screen.
#' @param width default is 200px, if desired specify the desired width in pixels
#'
#' @return logos
#' @export
#'
#' @importFrom magick "image_read"
#' @importFrom htmltools "img"
#' @importFrom knitr "image_uri"
#'
#' @examples
#'
#' # Brown and Brown logo from using htmltools in an Rmd
#' \dontrun{
#' OurLogo(logo = "bb")
#' }
#' # Arrowhead logo print picture only
#' \dontrun{
#' OurLogo(logo = "arrowhead", rmd = FALSE)
#' }
#'
#'

OurLogo <- function(logo = "bb", rmd = TRUE, width = "200px"){
  if(logo == "bb"){
    img_name <- "bbins_logo.png"
  }
  if(logo == "arrowhead"){
    img_name <- "arrowhead.png"
  }
  if(logo == "kittens"){
    img_name <- "pkg-logo.png"
  }

  img_path <- system.file(paste0("logos/", img_name), package = 'kittens')

  if(rmd == TRUE){
    img_print <- img(src = image_uri(img_path),
                     style = paste0('position:absolute; top:0; right:0; padding:10px; width:', width))
  } else {
    img_print <- image_read(img_path)
  }
  return(img_print)
}



