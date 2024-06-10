select  
    _dlt_id as id,
    _dlt_parent_id as outcome_measures_id,
    non_inferiority_type,
    p_value,
    statistical_method,
    param_type,
    ci_pct_value,
    ci_num_sides,
    ci_lower_limit,
    ci_upper_limit
from 
    clinical_trials_raw.studies__results_section__outcome_measures_module__outcome_measures__analyses

