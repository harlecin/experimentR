#' Upload experiment object to database
#'
#' @param con_string A connection string
#' @param experiment An experiment object to upload
upload_experiment = function(con, experiment) UseMethod("upload_experiment")


#' Upload experiment object to SQL Server
#'
#' @param con_string A sql server 2016+ connection string
#' @param experiment An experiment object to upload
#' @import odbc
upload_experiment.sqlserver = function(con_string, experiment) {

  con =  odbc::dbConnect(odbc::odbc(), .connection_string = connection_string)


  ## get project record
  project_name = experiment$dim.projects$project_name
  project_record = DBI::dbGetQuery(con, paste0("SELECT * FROM dbo.projects WHERE project_name ='",project_name,"'"))

  ## only insert record if it does not exist
  if (nrow(project_record) == 0) {
    DBI::dbWriteTable(conn = con,
                      name = "projects",
                      experiment$dim.projects,
                      append = T)

    project_record = DBI::dbGetQuery(con, paste0("SELECT * FROM dbo.projects WHERE project_name ='",project_name,"'"))
  }

  # Write data to experiments
  experiment_name = experiment$dim.experiments$experiment_name
  experiment_record = DBI::dbGetQuery(con, paste0("SELECT * FROM dbo.experiments WHERE experiment_name ='",experiment_name,"'"))

  ## only insert record if it does not exist
  if (nrow(experiment_record) == 0) {
    DBI::dbWriteTable(conn = con,
                      name = "experiments",
                      data.table(project_id = project_record$project_id, experiment$dim.experiments),
                      append = T)

    experiment_record = DBI::dbGetQuery(con, paste0("SELECT * FROM dbo.experiments WHERE experiment_name ='",experiment_name,"'"))
  }

  experiment_runs_datetime_client = unique(experiment$fact.experiment_runs$datetime_recorded)
  experiment_runs_datetime_server = DBI::dbGetQuery(con, paste0("SELECT run_id, datetime_recorded FROM dbo.experiment_runs WHERE datetime_recorded in (",paste0("'",paste0(experiment_runs_datetime_client, collapse = "', '"),"'",collapse = ""),")"))

  delta_runs_recorded = !(experiment_runs_datetime_client %in% experiment_runs_datetime_server$datetime_recorded)

  experiment_runs_missing = experiment_runs_datetime_client[delta_runs_recorded]

  if (length(experiment_runs_missing) != 0) {
    ## insert runs except tune_results and resampling_results:
    DBI::dbWriteTable(conn = con,
                      name = "experiment_runs",
                      data.table(experiment_id = experiment_record$experiment_id,
                                 project_id = project_record$project_id,
                                 experiment$fact.experiment_runs[datetime_recorded %in% experiment_runs_missing,!c("tune_results", "resampling_results"), with = F]),
                      append = T)

    experiment_runs_datetime_server = DBI::dbGetQuery(con, paste0("SELECT run_id, datetime_recorded FROM dbo.experiment_runs WHERE datetime_recorded in (",paste0("'",paste0(experiment_runs_datetime_client, collapse = "', '"),"'",collapse = ""),")"))
    ## include? code has to run from top anyway...
    delta_runs_recorded = !(experiment_runs_datetime_client %in% experiment_runs_datetime_server$datetime_recorded)
    experiment_runs_missing = experiment_runs_datetime_client[delta_runs_recorded]
  }

  ## run_id and datetime_recorded have to be filtered from experiment list -> looping to add entries to table!
  # run_ids = experiment_runs_datetime_server$run_id
  #
  # for (i in seq_along(run_ids)) {
  #   DBI::dbWriteTable(conn = con,
  #                     name = "tuning_results",
  #                     data.table(run_id = run_ids[[i]],
  #                                experiment$fact.experiment_runs$tune_results[[i]]),
  #                     append = T)
  # }

  # dbWriteTable(con, "cars", head(cars, 3))
  # dbExecute(
  #   con,
  #   "INSERT INTO cars (speed, dist) VALUES (1, 1), (2, 2), (3, 3)"
  # )

  ## OUTPUT,@@identity etc not working?
  # DBI::dbGetQuery(con, "SELECT SCOPE_IDENTITY()")
  # dbCommit(con)
  # dbDisconnect(con)
}

# TODO:
# - check why dbWriteTable does not work with schemas other than dbo
# - check if dbWriteTable attribute is 0, else do not insert records -> necessary?
# - add foreign keys to database again?
# - refactor above into functions to check if record exists
# - record primary keys inserted for given records in experiment_runs
#   - use those keys to insert tune_results and resampling_results into separate tables
#       -> currently workaround based on datetime_recorded! Refactor?
#   - how should we handle duplicate runs?

