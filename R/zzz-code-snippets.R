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

# TODO
# -print() method to show runs
# -summary() method to show overview
# -check caret lm() train object: https://www.rdocumentation.org/packages/caret/versions/6.0-80/topics/train


