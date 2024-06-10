select 
    d._dlt_parent_id as outcome_measures_id,
    dc._dlt_id as id,
    d.units,
    dc.group_id,
    dc.value
from
    clinical_trials_raw.studies__results_section__outcome_measures_module__outcome_measures__denoms d 
    inner join clinical_trials_raw.studies__results_section__outcome_measures_module__outcome_measures__denoms__counts dc 
    on d._dlt_id = dc._dlt_parent_id