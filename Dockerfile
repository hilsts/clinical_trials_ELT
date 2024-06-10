FROM ubuntu:22.04

RUN apt-get update && apt-get install -y python3 python3-pip

RUN mkdir -m 777 /clinical_trials_elt

COPY / /clinical_trials_elt

WORKDIR /clinical_trials_elt

RUN pip install -r requirements.txt

RUN export DBT_PROFILE_DIR=profiles.yml
RUN export DBT_PROJECT_DIR=dbt_project.yml

CMD ["python3", "/clinical_trials_elt/src/main.py"]