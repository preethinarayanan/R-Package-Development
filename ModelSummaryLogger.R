
#' Model Summary Logger (GLM)
#'
#' @param model fitted model object you would like to log information on
#' @param pin_name_basic the name of the pin that already exists to log the basic info from your model
#' @param desired_pin_name_basic the desired name of the pin used to log the basic info from you rmodel, if a pin does not already exist
#' @param pin_name_coef the name of the pin that already exists to log the coefficients from your model
#' @param desired_pin_name_coef the desired name of the pin used to log the coefficients from your model, if a pin does not already exist
#'
#' @return an updated pin object or a new pin object if one was not created already
#' @export
#' @importFrom broom "tidy"
#' @importFrom dplyr "%>%" "tibble" "bind_cols" "bind_rows"
#' @importFrom pins "pin" "pin_get"
#' @importFrom digest "digest"
#' @importFrom lubridate "ymd_hms"
#' @importFrom stats "coef"
#'
#' @examples
#' # model <- glm(mpg ~ factor(gear) + hp + factor(am), mtcars, family = "gaussian")
#'
#' # this will create arbitrary pin logs using the model id
#' # ModelSummaryLogger(model = model)
#'
#' # this will create logs using the desired names that were provided
#' # ModelSummaryLogger(model = model, desired_pin_name_basic = "cool_basic_model_log",
#' #                    desired_pin_name_coef = "cool_coef_model_log")
#'
#' # ModelSummaryLogger(model = model, desired_pin_name_basic = "cool_basic_model_log",
#' #                    desired_pin_name_coef = "cool_coef_model_log")
#'
#'
#' # if you are using this for the first time with no pin_name for basic or coef
#' # then the function will create a  pin for you of the name
#'
#' # "model_logger_coef_id number" for the coef table and
#' # "model_logger_basic_id number" for the basic summary table
#'
#' # once this is created, please feel free to rename it and then fill
#' # in the pin_name input before you run it again to update it


ModelSummaryLogger <- function(model = NULL, pin_name_basic = NULL, desired_pin_name_basic = NULL, pin_name_coef = NULL, desired_pin_name_coef = NULL) {

  ## check if there is a model
  if(is.null(model)) {
    model_message <- "Please provide a fitted model object"
  } else {

    #################################### model logging for coefficients #################################

    model_id <- digest(Sys.time())
    model_summary <- model %>% tidy()

    if(is.null(pin_name_coef) && is.null(desired_pin_name_coef)){

      pin_name <- paste0("model-logger-coef-", model_id)
      model_number <- rep(1, nrow(model_summary))
      pin_coef_message <- paste0("A generic model log as been pinned to rsconnect with the name ", pin_name,
                                 ". Please rename this as desired and re-run using that pin name input.")

    } else if (is.null(pin_name_coef) && !is.null(desired_pin_name_coef)){

      pin_name <- desired_pin_name_coef
      model_number <- rep(1, nrow(model_summary))
      pin_coef_message <- paste0("A coefficient table named ", pin_name,
                                 " has been successfully pinned, please check your records")
    } else {

      pin_name <- pin_name_coef
      old_log_coef <- pin_get(pin_name_coef, board = "rsconnect")
      model_number <- rep(max(old_log_coef$model_number) + 1, nrow(model_summary))
      pin_coef_message <- paste0("The coefficient table named ", pin_name,
                                 " has been successfully updated in pins, please check your records")
    }

    model_number_id <- tibble(model_id = rep(model_id, nrow(model_summary)), model_number = model_number)

    ## binds all columns

    model_summary %<>% bind_cols(model_number_id)

    if(!is.null(pin_name_coef)){
      model_summary %<>% bind_rows(old_log_coef)
    }

    ## add to pin
    model_summary %>% pin(name = pin_name, board = "rsconnect")

    #################################### basic model logging ################################

    if(is.null(pin_name_basic) && is.null(desired_pin_name_basic)){

      model_number <- 1
      pin_name_b <- paste0("model-logger-basic-", model_id)
      pin_basic_message <- paste0("A generic model log as been pinned to rsconnect with the name ", pin_name_b,
                                  ". Please rename this as desired and re-run using that pin name input.")

    } else if(is.null(pin_name_basic) && !is.null(desired_pin_name_basic)){

      model_number <- 1
      pin_name_b <- desired_pin_name_basic
      pin_basic_message <- paste0("A basic summary table named ", pin_name_b,
                                  " has been successfully pinned, please check your records")
    } else {

      pin_name_b <- pin_name_basic
      old_log_basic <- pin_get(pin_name_basic, board = "rsconnect")
      model_number <- max(old_log_basic$model_number) + 1
      pin_basic_message <- paste0("The basic summary table named ", pin_name_b,
                                  " has been successfully updated in pins, please check your records")
    }
    df <- tibble(time = ymd_hms(Sys.time()),
                 model_id = model_id,
                 model_number = model_number,
                 coef_count = length(coef(model)),
                 training_set_row = nrow(model$model),
                 number_factor_levels = model$xlevels %>% unlist() %>% length())

    if(!is.null(pin_name_basic)){
      df %<>% bind_rows(old_log_basic)
    }
    ### pin to board
    df %>% pin(name = pin_name_b, board = "rsconnect")
  }
  print(mget(ls(pattern = "message")))
}









