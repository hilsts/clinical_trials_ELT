# clinical_trials_ELT

## Setup

First clone this repository.

````bash
git clone git@github.com:hilsts/clinical_trials_ELT.git
````

Then build the docker image and wait the process to finish.

```bash
cd clinical_trials_ELT

docker build -t clinical_trials:latest .
```

Once the build process is over it's possible to start the execution of the pipeline.

## Execution

1. Default Test

To execute the container in default mode just run:

```bash
sudo docker run -ti clinical_trials
```

This will run the pipeline in test mode extracting only 1000 studies, it's the fastest way to the functioning.

2. Range Test

To try a bigger extraction from the API, one can use the enviroment variable as follows.

```bash
sudo docker run -ti -e CLINICAL_TRIALS_RANGE_EXTRACT="true" clinical_trials
```

## Artifacts

At the end of the pipeline execution as results the data warehouse schema anf DuckDB file will be saved in the **dw** folder inside the container.

It can be retrieved with the following command with the containerId:

```bash
docker cp containerId:/clinical_trials_elt/dw path/to/copy
```

1. Database and dw schema file

The **clinical_trials.duckdb** file contains all the data extracted from the API in the **clinical_trials_raw** schema, there one can find all the normalized data as [dlt database schema](https://dlthub.com/docs/general-usage/destination-tables#child-and-parent-tables). The parent and child tables schema can be found in the dw/schemas/export/clinical_trials.schema.yaml path.

The DB also contains the **clinical_trials_staging** schema that contains the transformed data.


2. DBT Models and Files

DBT models can be found and edited in the models/ folder.

The dbt_project and profiles file can be found in the root folder of the project.
