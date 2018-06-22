#' experiment class
#'
#' @importFrom R6 R6Class
# experiment = R6Class(
#   "experiment",
#   private = list(
#     run_history = NULL
#   ),
#   public = list(
#     experiment_name = NULL,
#     experimenter = NULL,
#
#     initialize = function(experiment_name=NA, experimenter=Sys.getenv("USERNAME")) {
#       self$experiment_name = experiment_name
#       self$experimenter = experimenter
#     },
#     ## Klasse ableiten und log_caret implementieren?
#     log = function(caret_model, description) {
#       private$run_history = 1
#     }
#   )
# )





# Code snippets:
# dbGetQuery(conn = con, "SELECT * FROM testSAM.test_schema2.hcai_unit_tests")
#
# table_id = DBI::Id(schema = "dim",
#              table = "test")

#
# sql_values <- sqlData(con, values, row.names)
# table <- dbQuoteIdentifier(con, table)
# fields <- dbQuoteIdentifier(con, names(sql_values))
#
# # Convert fields into a character matrix
# rows <- do.call(paste, c(sql_values, sep = ", "))
# SQL(paste0(
#   "INSERT INTO ", table, "\n",
#   "  (", paste(fields, collapse = ", "), ")\n",
#   "VALUES\n",
#   paste0("  (", rows, ")", collapse = ",\n")
# ))

# create experiment like so:
#   experiment = experiment(
#     id = "your id",
#     auth = "your authorization token",
#   )
#   see: https://github.com/RevolutionAnalytics/azureml
#
#
#   https://github.com/r-lib/R6/issues/42:
#     R6list <- R6Class(
#       "R6list",
#       public = list(
#         orig = NULL,
#         initialize = function(x) {
#           self$orig <- x
#         },
#         as.list = function() {
#           self$orig
#         }
#       )
#     )
#
#   as.list.R6list <- function(x, ...) {
#     x$as.list()
#   }
#
#   similar stuff for python:
#     - https://github.com/mitdbg/modeldb/blob/master/server/codegen/sqlite/createDb.sql

# dbWriteTable(con, "cars", head(cars, 3))
# dbExecute(
#   con,
#   "INSERT INTO cars (speed, dist) VALUES (1, 1), (2, 2), (3, 3)"
# )

## OUTPUT,@@identity etc not working?
# DBI::dbGetQuery(con, "SELECT SCOPE_IDENTITY()")
# dbCommit(con)
# dbDisconnect(con)




## get project record
# SQL injection protection not necessary here
# project_name = experiment$dim.projects$project_name
# project_record = dbSendQuery(con, "SELECT * FROM dbo.projects  WHERE project_name = ?")
# dbBind(project_record, list(project_name))
# dbFetch(project_record)
# dbClearResult(project_record)

# TODO
# -print() method to show runs
# -summary() method to show overview
# -check caret lm() train object: https://www.rdocumentation.org/packages/caret/versions/6.0-80/topics/train


