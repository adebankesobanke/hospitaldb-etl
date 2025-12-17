from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import datetime
from phase4.python.etl_pipeline import extract, transform, run_dq_checks, load_dimension_and_fact
from helpers import create_db_engine

default_args = {
    "owner": "etl_admin",
    "start_date": datetime(2025, 12, 10),
    "email_on_failure": True,
    "retries": 2
}

def build_engine():
    return create_db_engine()

with DAG(
    dag_id="hospitaldb_full_etl",
    default_args=default_args,
    schedule_interval="@daily",
    catchup=False
) as dag:

    task_extract = PythonOperator(
        task_id="extract_raw",
        python_callable=lambda: extract(build_engine())
    )

    task_transform = PythonOperator(
        task_id="transform_staging",
        python_callable=lambda: transform(build_engine())
    )

    task_dq = PythonOperator(
        task_id="run_data_quality_checks",
        python_callable=lambda: run_dq_checks(build_engine())
    )

    task_load = PythonOperator(
        task_id="load_dim_fact",
        python_callable=lambda: load_dimension_and_fact(build_engine())
    )

    task_extract >> task_transform >> task_dq >> task_load

