#' Setup an experiment environment
#'
#' Use this function to create an experiment environment that holds all information
#' about which experiment was run by who with what results
#'
#' @param project_name A character string giving the project name used to group experiments
#' @param experiment_name A character string name of the current experiment
#' @param experiment_author A character string specifying who ran the experiment
#' @param experiment_description A character string giving a short description
#' @return An experiment environment
new_experiment = function(project_name, experiment_name, experiment_author = Sys.getenv("USERNAME")) {
  env = new.env()
  class(env) = "experiment"

  env$project_name = project_name
  env$experiment_name = experiment_name
  env$experiment_author = experiment_author
  env$experiment_description = experiment_description

  env
}



## Infos
#  - train() s3 generics etc:
# https://github.com/topepo/caret/blob/9a435dcc5b3a115130c79bf8b012d4b9f2fe212d/pkg/caret/R/train.default.R

## TODO:
## - add check whether there already is an experiment saved for local project,
##    if yes, ask if it should be reused
##    use_existing <- readline(prompt="Do you want to continue your previous experiment? [y]/[n]: ")
## - option to query existing projects so user can add experiment to existing project
