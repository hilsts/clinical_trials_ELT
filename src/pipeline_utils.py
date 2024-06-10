from dlt.sources.helpers import requests
import dlt
import pandas as pd

TEST_URL = "https://clinicaltrials.gov/api/v2/studies?pageSize=1000"

def get_api_test_data():
    """
    Retrieve test data from the API and store into duckDB 
    using dlt pipeline.
    This function uses a static URL to get 1000 studies.
    :return: dlt pipeline run info
    """
    
    base_data = requests.get(TEST_URL).json()

    return insert_studies(base_data['studies'])

    
def insert_studies(studies):

    pipeline = dlt.pipeline(
        pipeline_name="clinical_trials",
        destination=dlt.destinations.duckdb("dw/clinical_trials.duckdb"),
        dataset_name="clinical_trials_raw",
        export_schema_path='./dw/schemas/export',
        import_schema_path='./dw/schemas/import'
    )

    return pipeline.run(studies, table_name='studies')

def get_studies_from_range_url(url):
    """
    Function that retrives data for a URL with filter and pagination.
    :url: URL string  
    :return: A list with all studies from filter pagination.
    """

    res = requests.get(url)
    data = res.json()
    print('STARTED ' + url)
    all_data = data['studies']
    next_token = data['nextPageToken']

    while next_token:

        data = requests.get(url+f"&pageToken={next_token}").json()
        all_data += data['studies']

        if 'nextPageToken' in data.keys():

            next_token = data['nextPageToken']

        else:

            next_token = False 

    print('FINISHED ' + url)

    return all_data

def gen_url_range_date(start, end):
    """
    Generates URLs to request with a monthly date range filter for the LastUpdatePostDate field.
    :start: Start date (%Y-%m-%d), it's recommended to use the first day of a month.
    :end: End date (%Y-%m-%d)
    :return: List of URLs
    """

    dates = pd.date_range(start=start, end=end, freq='MS').strftime('%Y-%m-%d').to_list()
    base_url = "https://clinicaltrials.gov/api/v2/studies?query.term=AREA%5BLastUpdatePostDate%5DRANGE%5B{start}%2C+{end}%5D&countTotal=true"
    print(dates)
    urls = []
    for i in range(len(dates)):

        try:

            urls.append(base_url.format(start=dates[i], end=dates[i+1]))

        except Exception as e:
            print(e)
            pass 

    return urls


