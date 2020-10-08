
#' Lift Table
#'
#' @param test_df Your test data frame that has both predictions and empirical responses
#' @param predictions Your predicted response results
#' @param actuals Your empirical response results
#' @param bin_size default is 10, making these deciles. Insert any number that is desired
#'
#' @importFrom magrittr "%<>%"
#' @importFrom dplyr "arrange" "mutate" "ntile" "group_by" "summarise"
#' @return Will return a new table with bins arrange from low to high by the prediction variable; summarized means of actual and predicted values in those bins
#' @export
#'
#' @examples
#' mydata <- read.csv("https://stats.idre.ucla.edu/stat/data/binary.csv")
#'
#' model <- glm(admit ~., data = mydata, family = "binomial")
#'
#' mydata$preds <- predict(model, newdata = mydata, type = "response")
#'
#' lift_table <- LiftTable(test_df = mydata, predictions = preds, actuals = admit)

LiftTable <- function(test_df, predictions, actuals, bin_size = 10) {

  test_df %<>%
    arrange({{predictions}}) %>%
    mutate(bins = ntile({{predictions}}, bin_size)) %>%
    group_by(bins) %>%
    summarise(actual = mean({{actuals}}),
              predicted = mean({{predictions}}),
              sum_actual = sum({{actuals}}),
              .groups = "keep")

  return(test_df)
}








