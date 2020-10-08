#' Strip GLM
#'
#' @description Strips the glm object of most of the unused items that inflate storage size, however the resulting object will only be able to predict new test cases
#' @author credit to: http://www.win-vector.com/blog/2014/05/trimming-the-fat-from-glm-models-in-r/
#'
#' @param model the model object you would like to strip down
#'
#' @return returns the stripped model object; do not use this function if you need to perform other processes besides prediction of test cases
#'
#' @export
#'
#' @examples
#' model <- glm(mpg ~., data = mtcars[1:25,]) # list of 30 items
#' model <- StripGLM(model) # now list of 21 items
#' preds <- predict(model, newdata = mtcars[26:32,]) # still runs

StripGLM = function(model) {
  model$y = c()
  model$model = c()

  model$residuals = c()
  model$fitted.values = c()
  model$effects = c()
  model$qr$qr = c()
  model$linear.predictors = c()
  model$weights = c()
  model$prior.weights = c()
  model$data = c()


  model$family$variance = c()
  model$family$dev.resids = c()
  model$family$aic = c()
  model$family$validmu = c()
  model$family$simulate = c()
  attr(model$terms,".Environment") = c()
  attr(model$formula,".Environment") = c()

  return(model)
}
