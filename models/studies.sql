select 
    _dlt_id as id,
    protocol_section__identification_module__nct_id as nct_id,
    protocol_section__identification_module__organization__full_name as organization_name,
    protocol_section__identification_module__brief_title as brief_title,
    protocol_section__identification_module__official_title as official_title,
    protocol_section__status_module__overall_status as official_status,
    case when protocol_section__status_module__start_date_struct__date.len() != 10 
        then strptime(protocol_section__status_module__start_date_struct__date, '%Y-%m')
        else strptime(protocol_section__status_module__start_date_struct__date, '%Y-%m-%d') 
    end as start_date,
    case when protocol_section__status_module__primary_completion_date_struct__date.len() != 10 
        then strptime(protocol_section__status_module__primary_completion_date_struct__date, '%Y-%m')
        else strptime(protocol_section__status_module__primary_completion_date_struct__date, '%Y-%m-%d') 
    end as primary_completion_date,
    case when protocol_section__status_module__study_first_submit_date.len() != 10 
        then strptime(protocol_section__status_module__study_first_submit_date, '%Y-%m')
        else strptime(protocol_section__status_module__study_first_submit_date, '%Y-%m-%d') 
    end as first_submit_date,
    case when protocol_section__status_module__study_first_post_date_struct__date.len() != 10 
        then strptime(protocol_section__status_module__study_first_post_date_struct__date, '%Y-%m')
        else strptime(protocol_section__status_module__study_first_post_date_struct__date, '%Y-%m-%d') 
    end as first_post_date,
    protocol_section__description_module__brief_summary as brief_summary,
    protocol_section__description_module__detailed_description as detailed_description,
    protocol_section__design_module__study_type as study_type,
    has_results,
    protocol_section__eligibility_module__eligibility_criteria as eligibility_criteria,
    protocol_section__eligibility_module__eligibility_criteria as healthy_volunteers,
    protocol_section__eligibility_module__sex as sex,
    protocol_section__eligibility_module__minimum_age as minimum_age,
    protocol_section__eligibility_module__maximum_age as maximum_age,
    protocol_section__eligibility_module__study_population as study_population,
    protocol_section__eligibility_module__sampling_method as sampling_method
from
    clinical_trials_raw.studies
