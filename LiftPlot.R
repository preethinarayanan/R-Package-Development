
#' Lift Plot
#'
#' @param lift_table a data frame or tibble that was created by the LiftTable function that has percentiles, actuals, and predictions
#' @param plot_title default is just "Lift Plot", customizable plot title
#' @param x_axis_title default is "Decile"
#' @param y_axis_title default is "Prediction"
#'
#' @importFrom ggplot2 "ggplot" "aes" "geom_line" "geom_point" "geom_line" "scale_color_manual" "scale_x_continuous" "theme" "element_text" "labs"
#'
#' @return a plot of the empirical and predicted values for each bin created; theme is default theme
#' @export
#'
#' @examples
#'
#' mydata <- read.csv("https://stats.idre.ucla.edu/stat/data/binary.csv")
#'
#' model <- glm(admit~., data = mydata, family = "binomial")
#'
#' mydata$preds <- predict(model, newdata = mydata, type = "response")
#'
#' lift_table <- LiftTable(test_df = mydata, predictions = preds, actuals = admit)
#'
#' LiftPlot(lift_table = lift_table)

LiftPlot <- function(lift_table, plot_title = "Lift Plot", x_axis_title = "Decile", y_axis_title = "Prediction") {

  ggplot(lift_table, aes(x = bins, group = 1)) +
    geom_line(aes(y = actual, colour = "actual")) +
    geom_point(aes(y = actual, colour = "actual")) +
    geom_line(aes(y = predicted, colour = "predicted")) +
    geom_point(aes(y = predicted, colour = "predicted")) +
    scale_color_manual(values = c("black", "red")) +
    scale_x_continuous(breaks = seq(1,10,1)) +
    theme(plot.title = element_text(size = 10),
          legend.position = "bottom") +
    labs(x = x_axis_title,
         y = y_axis_title,
         title = plot_title)

}
