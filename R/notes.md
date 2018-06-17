create experiment like so:
experiment = experiment(
 id = "your id",
 auth = "your authorization token",
)
see: https://github.com/RevolutionAnalytics/azureml


https://github.com/r-lib/R6/issues/42:
R6list <- R6Class(
  "R6list",
  public = list(
    orig = NULL,
    initialize = function(x) {
      self$orig <- x
    },
    as.list = function() {
      self$orig
    }
  )
)

as.list.R6list <- function(x, ...) {
  x$as.list()
}

similar stuff for python:
- https://github.com/mitdbg/modeldb/blob/master/server/codegen/sqlite/createDb.sql
