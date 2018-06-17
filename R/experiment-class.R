#' Setup an experiment environment
#'
#' Use this function to create an experiment environment that holds all information
#' about which experiment was run by who with what results
#'
#'
#' @param experiment_name
#' @param experimenter
#' @return experiment environment
new_experiment = function(experiment_name, experimenter = Sys.getenv("USERNAME")) {
  env = new.env()
  class(env) = "experiment"

  env$experiment_name = experiment_name
  env$experimenter = experimenter

  env
}



## Infos
#  - train() s3 generics etc:
# https://github.com/topepo/caret/blob/9a435dcc5b3a115130c79bf8b012d4b9f2fe212d/pkg/caret/R/train.default.R

## TODO:
## add check whether there already is an experiment saved for local project,
## if yes, ask if it should be reused
## use_existing <- readline(prompt="Do you want to continue your previous experiment? [y]/[n]: ")
