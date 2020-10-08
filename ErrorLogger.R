
#' Error Logger
#'
#' @param db_valid does the db exist object from dbCanConnect(); also from RequestLogging()$db_valid
#' @param key unique key that you would like to match with items from RequestLogging()$key
#' @param error_message specific error message for that if else statment in your api
#' @param input_error which input was it that errored out
#' @param db_connection standard db connection object; also from RequestLogging()$con
#' @param db_error_table the name of the database table where errors will be logged; if one does not exist it will create it for you
#' @param csv_error_table path of the csv file where error logs will be stored if the database fails
#'
#' @return will append a database table, or create a database table, or append a csv file, or create a csv file with error logs
#' @export
#'
#' @examples
#' # Using the returned object from req_log_list <- RequestLogging(),
#' # insert within an if else statement testing the input of an api:
#' #
#' # if(is.null(govclass) == TRUE){
#' #
#' #    res$status <- 400
#' #
#' #    govclass_null_msg <- paste0(res$status, ":",
#' #                                "GovClass is missing from your input and is required")
#' #
#' #    ErrorLogger(db_valid = req_log_list$db_valid, key = req_log_list$key,
#' #                error_message = govclass_error_msg, input_error = govclass,
#' #                db_connection = req_log_list$con, db_error_table = "api_error_log",
#' #                csv_error_table = "api/api_error_log.csv")
#' #
#' #    return(list(error = govclass_null_msg))
#' #  }

ErrorLogger <- function(db_valid, key, error_message, input_error, db_connection, db_error_table, csv_error_table) {

  error_tab <- tibble(unique_key = key,
                      error_message = error_message,
                      invalid_input = input_error)

  csv_exists <- file.exists(csv_error_table)

  if(db_valid == TRUE) {

    table_exists <- dbExistsTable(conn = db_connection, name = db_error_table)

    if(table_exists == TRUE){

      dbAppendTable(conn = db_connection, name = db_error_table, value = error_tab)

    } else {

      dbWriteTable(conn = db_connection, name = db_error_table, value = error_tab)

    }

  } else {

    if(csv_exists == TRUE) {

      write.table(error_tab, file = csv_error_table, append = TRUE, col.names = F, sep = ",", row.names = F)

    } else {

      write.table(error_tab, file = csv_error_table, col.names = T, sep = ",", row.names = F)

    }

  }

}

