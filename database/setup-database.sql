-- check if db exists and create it if necessary
if db_id('MODEL_DB') is null
	begin
		print 'db does not exists, creating db MODEL_LOG and schemas...'
		create database MODEL_DB
		
		-- create schemas in model_db
		--USE MODEL_DB	
		--create schema dim
		--create schema fact

		print 'db and schemas successfully created'
	end
else 
	print 'db already exits'


USE MODEL_DB

-- create db tables

-- Dimension tables
	-- Projects table
	-- One project can have multiple experiments
drop table if exists dbo.projects
begin
	create table dbo.projects (
	project_id int not null IDENTITY(1,1) PRIMARY KEY,
	project_name nvarchar(255) not null,
	project_description nvarchar(255) not null
	)
end

	-- Experiment table
	-- Mapping experiments to projects
drop table if exists dbo.experiments
begin
	create table dbo.experiments (
	experiment_id int not null IDENTITY(1,1) PRIMARY KEY,
	project_id int not null,
	--constraint project_id foreign key (project_id)
	--	references dbo.projects (project_id)
	--		ON DELETE CASCADE    
	--		ON UPDATE CASCADE,
	experiment_name nvarchar(255) not null,
	experiment_description nvarchar(255) not null,
	experiment_author nvarchar(255) not null
	)
end

-- foreign key constraint --> needs to be declared after fact.experiment_runs!
--drop table if exists dbo.run_metrics
--begin
--	create table dbo.run_metrics (
--	run_id int not null,
--	constraint run_id foreign key (run_id)
--		references fact.experiment_runs (run_id)
--			ON DELETE CASCADE    
--			ON UPDATE CASCADE,
--	metric_name nvarchar(255) not null,
--	metric_value numeric not null
--	)
--end

-- Fact Table: Experiment runs
	-- Table contains all runs associated with each experiment and project 
drop table if exists dbo.experiment_runs
begin
	create table dbo.experiment_runs (
	run_id int not null IDENTITY(1,1) PRIMARY KEY,
	experiment_id int not null,
	--constraint experiment_id foreign key (experiment_id)
	--	references dbo.experiments (experiment_id),
	project_id int not null,
	--constraint project_id foreign key (project_id)
	--	references dbo.projects (project_id),
	datetime_recorded nvarchar(255) not null,
	run_description nvarchar(255),
	commit_id nvarchar(255),
	model_method nvarchar(255),
	model_type nvarchar(255),
	model_label nvarchar(255),
	model_validation_technique nvarchar(255),
	model_response nvarchar(255),
	model_features nvarchar(2048),
	model_total_train_time numeric, 
	data_used nvarchar(255)
	)
end


drop table if exists dbo.tuning_results
begin
	create table dbo.tuning_results (
	run_id int,
	hyperparam nvarchar(255),
	value numeric
	)
end
-- TODO:
/*
- Check CASCADE/UPDATE behaviour for foreign keys
*/