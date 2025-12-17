"""
ETL ORCHESTRATOR — Phase 4
HospitalDB_ETL Project

This script coordinates the entire ETL workflow:
1. Extract data from raw CSV sources
2. Transform using validation + cleaning
3. Load into PostgreSQL staging tables
4. Run data quality checks and produce logs

Author: Adebanke
"""

import logging
from extract import extract_csv_files
from transform import clean_patient_data, clean_visit_data
from load import load_to_postgres
from quality_checks import run_data_quality_checks

logging.basicConfig(
    filename="etl_orchestrator.log",
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(message)s",
)

def run_etl():
    logging.info("Starting HospitalDB ETL pipeline")

    # --- EXTRACT ---
    raw_data = extract_csv_files()
    logging.info("Extraction complete")

    # --- TRANSFORM ---
    cleaned_patient_df = clean_patient_data(raw_data["patients"])
    cleaned_visit_df = clean_visit_data(raw_data["visits"])
    logging.info("Transformation complete")

    # --- LOAD ---
    load_to_postgres(cleaned_patient_df, "stg_patients")
    load_to_postgres(cleaned_visit_df, "stg_visits")
    logging.info("Load into Postgres complete")

    # --- DATA QUALITY ---
    run_data_quality_checks()
    logging.info("Data quality checks complete")

    logging.info("ETL pipeline finished successfully")


if __name__ == "__main__":
    run_etl()
