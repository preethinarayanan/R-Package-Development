#' API request logging
#'
#' @param req the incoming request stream
#' @param db_table_name name of the database table where you would like to log the request information (if one does not exist it will be created with this name)
#' @param csv_file_name name of the csv file where you would like to store the request information (if the DB fails)
#' @param option must provide a connection option from: "wc", "postgres_log", "tag_local", "tag_server", "pda_local", "pda_server", "general"
#' @param driver_type the type of driver to be used to make the connections; defaults to "native_client_11"; other options are "native_client_17", "odbc_17", and "other" (if using other option must specify driver in specific_driver input)
#' @param specific_driver the specific driver to be used in conjunction with the "other" option in driver_type input; default is NULL
#' @param server the intended server to be used in the "wc" option; ex: "sql02-2" or "sql02-3"; default is NULL
#' @param database the designated database to be used in the "wc" option; ex: "SubmissionDB"; default is NULL
#' @param user the username for the "postgres_log" option; default is NULL; recommend storing this .Renviron file
#' @param password the password for the "postgres_log", "tag_local", "tag_server", or "pda" options; default is NULL; recommend storing in .Renviron file
#' @param ... to be used for the "general" option; if none of the options fit your needs enter in the desired parameters
#'
#'
#' @importFrom digest "digest"
#' @importFrom dplyr "tibble"
#' @importFrom lubridate "ymd_hms"
#' @importFrom DBI "dbConnect" "dbCanConnect" "dbExistsTable" "dbAppendTable" "dbWriteTable"
#' @importFrom purrr "safely"
#' @importFrom utils "write.table"
#'
#'
#'
#' @return a list containing the connection object, unique key, and a safely object from testing the DB connection using TestConn()
#' @export
#'
#' @examples
#' \dontrun{
#'  #* Log information about incoming request
#'  #* @filter logger
#'   function(req){
#'
#'     req <- req
#'
#'     req_log_list <- RequestLogging(req = req,
#'                                    option = "postgres_log",
#'                                    user = Sys.getenv('DB_USER'),
#'                                    password = Sys.getenv('DB_PASS'),
#'                                    db_table_name = "api_req_log",
#'                                    csv_file_name = "api/api_req_log.csv")
#'
#'     con <<- req_log_list$con
#'
#'     key <<- req_log_list$key
#'
#'     db_exists <<- req_log_list$db_exists
#'
#'     plumber::forward()
#'  }
#' }

RequestLogging <- function(req, db_table_name, csv_file_name, option, driver_type = "native_client_11", specific_driver = NULL, server = NULL, database = NULL, user = NULL, password = NULL, ...) {

  key <- digest(Sys.time())

  new_req_log <- tibble(
    date_time = ymd_hms(Sys.time()),
    request_method = req$REQUEST_METHOD,
    path_info = req$PATH_INFO,
    http_user_agent = req$HTTP_USER_AGENT,
    remote_address = req$REMOTE_ADDR,
    unique_key = key)

  db_valid <- TestConn(option = option,
                       driver_type = driver_type,
                       specific_driver = specific_driver,
                       server = server,
                       database = database,
                       user = user,
                       password = password, ...)$result

  csv_exists <- file.exists(csv_file_name)

  if(db_valid == TRUE) {

    con <- CreateConn(option = option,
                      driver_type = driver_type,
                      specific_driver = specific_driver,
                      server = server,
                      database = database,
                      user = user,
                      password = password, ...)

    db_exists <- dbExistsTable(conn = con, name = db_table_name)

    if(db_exists == TRUE)

      dbAppendTable(conn = con, name = db_table_name, value = new_req_log)

    else {

      dbWriteTable(conn = con, name = db_table_name, value = new_req_log)

    }

  } else {

    con <- NULL

    db_valid <- FALSE

    if(csv_exists == TRUE) {

      write.table(new_req_log, file = csv_file_name, append = TRUE, col.names = F, sep = ",", row.names = F)

    } else {

      write.table(new_req_log, file = csv_file_name, col.names = T, sep = ",", row.names = F)

    }

  }

  return(list(con = con, key = key, db_valid = db_valid))
}
