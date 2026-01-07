from airflow import DAG
from airflow.providers.postgres.operators.postgres import PostgresOperator
from datetime import datetime
from pathlib import Path

BASE_DIR = Path(__file__).resolve().parents[1]

with DAG(
    dag_id="hospitaldb_full_refresh",
    start_date=datetime(2024, 1, 1),
    schedule_interval="0 2 * * *",
    catchup=False,
    tags=["hospitaldb", "etl"]
) as dag:

    refresh_phase2_mv = PostgresOperator(
        task_id="refresh_phase2_materialized_views",
        postgres_conn_id="hospitaldb_postgres",
        sql=str(BASE_DIR / "sql/refresh_phase2_materialized_views.sql")
    )

    refresh_phase3_reporting = PostgresOperator(
        task_id="refresh_phase3_reporting_tables",
        postgres_conn_id="hospitaldb_postgres",
        sql=str(BASE_DIR / "sql/refresh_phase3_reporting_tables.sql")
    )

    refresh_dashboards = PostgresOperator(
        task_id="refresh_dashboards",
        postgres_conn_id="hospitaldb_postgres",
        sql=str(BASE_DIR / "sql/refresh_dashboards.sql")
    )

    refresh_phase2_mv >> refresh_phase3_reporting >> refresh_dashboards
