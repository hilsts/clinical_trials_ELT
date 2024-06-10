select 
    _dlt_id as id,
    id as group_id,
    _dlt_parent_id as outcome_measures_id,
    title,
    description
from
    clinical_trials_raw.studies__results_section__outcome_measures_module__outcome_measures__groups