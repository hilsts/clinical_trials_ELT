select 
    type,
    title,
    description,
    population_description,
    time_frame,
    _dlt_parent_id as studies_id,
    _dlt_id as id,
    denom_units_selected,
    unit_of_measure
from
    clinical_trials_raw.studies__results_section__outcome_measures_module__outcome_measures
