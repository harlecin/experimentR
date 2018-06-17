#' Log model run output
#'
#' This function can be used to track model runs from caret train objects. You can
#' also pass in a metric and values as a key value pair to log arbitrary model
#' results.
#'
#' @export log
log = function(x, ...) {
  UseMethod("log")
}

#' Log output from caret train objects
#'
#' This function is a convenience logging wrapper for caret train objects.
#' It will automatically extract the following information:
#'   - model method
#'   - model type
#'   - model label
#'   - control settings used (e.g. 10x3 repeated-cv)
#'   - tuning results
#'   - resampling results for final model
#'
#' @param caret_train A train object from caret
#' @param experiment An experiment object
#' @param description An optional character string describing the experiment run
#' @export
log.train = function(caret_train, experiment, description = NULL) {
  experiment$description = description
  experiment$commit_id = system("git rev-parse --short HEAD", intern = TRUE)
  experiment$datetime_recorded = paste0(Sys.Date()," ", Sys.time())
  experiment$method = caret_train$method
  experiment$model_type = caret_train$modelType
  experiment$model_label = caret_train$modelInfo$label

  ## trainControl settings
  experiment$control = caret_train$control

  ## change from wide to long!
  ## tuning results
  experiment$tuning_results = caret_train$results

  ## resample values for final model
  experiment$resampling_results = caret_train$resample
  ## change format - why is final-user > final-elapsed?
  experiment$timing = caret_train$times

  ## create run-history:
  ## - new run is added to current experiment
  ## - new data is appended

  ## add features used
  # y = caret_train$terms[[2]]
  # X = caret_train$terms[[3]]
  ## same data used?
  ## capture set.seed() used
  ## add feature importance
  ## overfit measure from mlr

}

#' Log arbitrary metrics provided as key-value pairs
#'
#' @param metric_name A character vector specifying the names of the metrics you
#'   want to log. If you provide a character string this name will be used for
#'   all metric results.
#' @param metric A numeric vector of the same length as metric_name giving the
#'   result corresponding to the metric defined in metric_name
#' @param experiment An experiment object to store your metrics in
#' @return NULL
log.default = function(metric_name, metric, experiment) {

}


# TODO
# - refactor common logging part from .train and .default into function log_base()
# - add check if project is under version control to record commit id
