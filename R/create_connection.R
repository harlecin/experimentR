#' Create a database connection object
#'
#' @param server A character string specifying the server name
#' @param db A character string specifying the database name
#' @param schema.table A character string specifying schema.table
#' @return A database string with class sqlserver
#' @export odbc
create_connection_string = function(server, db, schema.table) {


  connection_string = paste0("Driver={SQL Server};server=",server,";database=",db,";trusted_connection=yes")

  class(connection_string) = "sqlserver"

  connection_string
}

# TODO:
# - How can we s3 dispatch on classes with blanks, such as "Microsoft SQL Server"?
