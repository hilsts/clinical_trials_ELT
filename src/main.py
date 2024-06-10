import pipeline_utils 
from multiprocessing.pool import ThreadPool
import subprocess 
import os

MODE = os.environ.get('CLINICAL_TRIALS_RANGE_EXTRACT', None)


if __name__ == '__main__':
    if MODE:
        
        urls = pipeline_utils.gen_url_range_date('2023-10-01', '2024-05-01')

        pool = ThreadPool(5)

        results = pool.map(pipeline_utils.get_studies_from_range_url, urls)

        for studies in results:

            pipeline_utils.insert_studies(studies)

    else:

        pipeline_utils.get_api_test_data()


    subprocess.call(['dbt', 'run'])

    


    


