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

  ## insert runs except tune_results and resampling_results:
  dbBegin(con)
  DBI::dbWriteTable(conn = con,
                    name = "experiment_runs",
                    data.table(experiment_id = experiment_record$experiment_id,
                               project_id = project_record$project_id,
                               experiment$fact.experiment_runs[,!c("tune_results", "resampling_results"), with = F]),
                    append = T)

  scope_identity = DBI::dbGetQuery(con, "SELECT SCOPE_IDENTITY() from dbo.experiment_runs")
  dbCommit(con)
}

# TODO:
# - check why dbWriteTable does not work with schemas other than dbo
# - add foreign keys to database again?
# - refactor above into functions to check if record exists
# - record primary keys inserted for given records in experiment_runs
#   - use those keys to insert tune_results and resampling_results into separate tables
#   - how should we handle duplicate runs?


# Code snippets:
# dbGetQuery(conn = con, "SELECT * FROM testSAM.test_schema2.hcai_unit_tests")
#
# table_id = DBI::Id(schema = "dim",
#              table = "test")
