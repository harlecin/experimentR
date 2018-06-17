#' Setup an experiment environment
#'
#' Use this function to create an experiment environment that holds all information
#' about which experiment was run by who with what results
#'
#' @param project A character string giving the project name used to group experiments
#' @param experiment_name A character string name of the current experiment
#' @param experimenter A character string specifying who ran the experiment
#' @return An experiment environment
new_experiment = function(project, experiment_name, experimenter = Sys.getenv("USERNAME")) {
  env = new.env()
  class(env) = "experiment"

  env$project = project
  env$experiment_name = experiment_name
  env$experimenter = experimenter

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
