#' Setup an experiment environment
#'
#' Use this function to create an experiment environment that holds all information
#' about which experiment was run by who with what results
#'
#' @param experiment_name A character string name of the current experiment
#' @param experiment_author A character string specifying who ran the experiment
#' @param experiment_description A character string giving a short description
#' @param project_name A character string giving the project name used to group experiments
#' @param project_description A character string describing the project in more detail
#' @return An experiment environment
#' @import data.table
new_experiment = function(experiment_name,
                          experiment_author = Sys.getenv("USERNAME"),
                          experiment_description = NA,
                          project_name = "default",
                          project_description = "default project") {

  env = new.env()
  class(env) = "experiment"

  env$dim.projects = data.table(project_name = project_name,
                                project_description = project_description
                                )

  env$dim.experiments = data.table(experiment_name = experiment_name,
                                   experiment_author = experiment_author,
                                   experiment_description = experiment_description
                                   )


  env$fact.experiment_runs = data.table(datetime_recorded = character(),
                                        run_description = character(),
                                        commit_id = character(),
                                        model_method = character(),
                                        model_type = character(),
                                        model_label = character(),
                                        model_validation_technique = character(),
                                        model_response = character(),
                                        model_features = character(),
                                        model_total_train_time = numeric(),
                                        data_used = character(),
                                        tune_results = list(),
                                        resampling_results = list()
                                        )
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
## - make project description optional if existing project is used
