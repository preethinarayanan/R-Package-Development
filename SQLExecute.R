#' Execute selected statements in SQL
#'
#' @param connection the connection object from using CreateConn() or another way
#' @param statement_execute Execute an update statement, query number of rows affected, and then close result set
#' @param statement_get_query Send query, retrieve results and then clear result set
#' @param statement_exist_table Does a table exist?
#' @param statement_remove_table Remove a table from the database
#'
#' @return what is return depends on the inputs provided, can get query, execute query etc...
#' @export
#' @importFrom DBI "dbConnect" "dbExecute" "dbGetQuery" "dbExistsTable" "dbRemoveTable" "dbDisconnect"
#' @importFrom odbc "odbc"
#' @examples
#' \dontrun{
#' conn <- CreateConn(option = "wc", server = "sql02-2", database = "SubmissionDB")
#'
#' SQLExecute(connection = conn, statement_exist_table = "SubmissionLatest")
#' }

SQLExecute <- function(connection, statement_execute = NULL, statement_get_query = NULL,
                   statement_exist_table = NULL, statement_remove_table = NULL){

  # run query
  if(!is.null(statement_execute)){
    db_table <- dbExecute(connection, statement_execute)
    return(db_table)
  }
  if(!is.null(statement_get_query)){
    db_table <- dbGetQuery(connection, statement_get_query)
    return(db_table)
  }
  if(!is.null(statement_exist_table)){
    dbExistsTable(connection, statement_exist_table)
  }
  if(!is.null(statement_remove_table)){
    dbRemoveTable(connection, statement_remove_table)
  }
  # Disconnect and remove connection
  dbDisconnect(connection)

  rm(connection)

}
