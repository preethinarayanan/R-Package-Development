#' Create a Server Connection
#'
#' @param option must provide a connection option from: "wc", "postgres_log", "tag_local", "tag_server", "pda_local", "pda_server", "general"
#' @param driver_type the type of driver to be used to make the connections; defaults to "native_client_11"; other options are "native_client_17", "odbc_17", and "other" (if using other option must specify driver in specific_driver input)
#' @param specific_driver the specific driver to be used in conjunction with the "other" option in driver_type input; default is NULL
#' @param server the intended server to be used in the "wc" option; ex: "sql02-2" or "sql02-3"; default is NULL
#' @param database the designated database to be used in the "wc" option; ex: "SubmissionDB"; default is NULL
#' @param user the username for the "postgres_log" option; default is NULL; recommend storing this .Renviron file
#' @param password the password for the "postgres_log", "tag_local", "tag_server", or "pda" options; default is NULL; recommend storing in .Renviron file
#' @param ... to be used for the "general" option; if none of the options fit your needs enter in the desired parameters
#'
#' @importFrom odbc "odbc"
#' @importFrom DBI "dbConnect"
#' @importFrom RPostgres "Postgres"
#'
#' @return a database connection object using dbconnect from DBI package
#' @export
#'
#' @examples
#' #example for wc option
#' \dontrun{
#' wc_conn <- CreateConn(option = "wc", server = "sql02-2", database = "SubmissionDB")
#' }
#' #example for postgres_log option
#' \dontrun{
#' log_conn <- CreateConn(option = "postgres_log", user = Sys.getenv("DB_USER"),
#'                        password = Sys.getenv("DB_PASS"))
#' }
#' #example for tag_local or tag_server option
#' \dontrun{
#' tag_local_conn <- CreateConn(option = "tag_local", driver_type = "native_client_17",
#'                              password = .Advocator_pass)
#' tag_server_conn <- CreateConn(option = "tag_server", driver_type = "odbc_17",
#'                               password = .Advocator_pass)
#' }
#' #example for pda option
#' \dontrun{
#' pda_local_conn <- CreateConn(option = "pda_local", driver_type = "native_client_17",
#'                              password = .Advocator_pass)
#' pda_server_conn <- CreateConn(option = "pda_server", driver_type = "odbc_17",
#'                               password = .Advocator_pass)
#' }

CreateConn <- function(option, driver_type = "native_client_11", specific_driver = NULL, server = NULL, database = NULL, user = NULL, password = NULL, ...) {


  driver <- switch(driver_type,
                   "native_client_11" = "{SQL Server Native Client 11.0}",
                   "native_client_17" = "{SQL Server Native Client 17.0}",
                   "odbc_17" = "{ODBC Driver 17 for SQL Server}",
                   "other" = specific_driver)

  if(option == "wc") {

    odbc_conn <- dbConnect(drv = odbc(),
                           Driver = driver,
                           Server = server,
                           Database = database,
                           Trusted_Connection = "yes",
                           Port = 1433)

    return(odbc_conn)

  } else if(option == "postgres_log") {

    postgres_conn <- dbConnect(drv = Postgres(),
                               dbname = "datascience",
                               host = "642-452-dataccience-stag.postgres.database.azure.com",
                               port = 5432,
                               user = user,
                               password = password)

    return(postgres_conn)

  } else if(option == "tag_local") {

    tag_local_conn <- dbConnect(drv = odbc(),
                                Driver = driver,
                                Server = "dbserver02.arcadvantage.local",
                                Database = "DISABILITY",
                                UID = "Arrowhead",
                                PWD = password,
                                Port = 1433)

    return(tag_local_conn)

  } else if(option == "tag_server") {

    tag_server_conn <- dbConnect(drv = odbc(),
                                 Driver = driver,
                                 Server = "10.1.100.211",
                                 Database = "DISABILITY",
                                 UID = "Arrowhead",
                                 PWD = password,
                                 Port = 1433)

    return(tag_server_conn)

  } else if(option == "pda_local") {

    pda_local_conn <- dbConnect(drv = odbc(),
                          Driver = driver,
                          Server = "dbserver02.arcadvantage.local",
                          Database = "PDA",
                          UID = "Arrowhead",
                          PWD = password,
                          Port = 1433)

    return(pda_local_conn)

  } else if(option == "pda_server") {

    pda_server_conn <- dbConnect(drv = odbc(),
                                 Driver = driver,
                                 Server = "10.1.100.211",
                                 Database = "PDA",
                                 UID = "Arrowhead",
                                 PWD = password,
                                 Port = 1433)

    return(pda_server_conn)

  } else if(option == "general") {

    general_conn <- dbConnect(...)

    return(general_conn)

  } else {

    stop("Please provide one of the options: wc, postgres_log, tag_local, tag_server, pda, or general.")

  }

}

