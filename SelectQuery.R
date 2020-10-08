#' Select Query Function
#'
#' @param connection your desired database connection
#' @param select_query the select portion of the query you wish to pull from sql
#' @param where_query the from and where portion of the query you wish to pull from sql
#'
#' @return returns a data frame using the query specified
#' @export
#'
#' @importFrom DBI "dbDisconnect"
#'
#' @examples
#' \dontrun{
#' conn <- CreateConn(option = "wc", server = "sql02-2", database = "SubmissionDB")
#'
#' df <- SelectQuery(connection = conn, select_query = "select *",
#'                   where_query = "from SubmissionLatest")
#' }
SelectQuery <- function(connection, select_query, where_query){

  query_text <- paste0(select_query, "\n ", where_query)

  query_text <- paste(strwrap(query_text, width = 100000, simplify = TRUE), collapse = " ")

  data <- SQLExecute(connection = connection, statement_get_query = query_text)

  return(data)

}
