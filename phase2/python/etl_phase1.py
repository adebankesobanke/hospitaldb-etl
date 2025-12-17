"""
Utility functions for HospitalDB Phase 1 ETL
"""
"""
ETL Pipeline for Phase 1 HospitalDB
- Loads CSVs into raw tables
- Transforms data into staging tables
- Performs basic data quality checks
"""

import pandas as pd
from config import DB_CONFIG, CSV_FILES
from utils import create_db_engine, load_csv_to_db, check_nulls

# -----------------------------
# Create database engine
# -----------------------------
engine = create_db_engine(DB_CONFIG)

# -----------------------------
# Load CSVs into raw tables
# -----------------------------
for table, csv_path in CSV_FILES.items():
    load_csv_to_db(f"raw_{table}", csv_path, engine)

# -----------------------------
# Transform raw tables into staging tables
# -----------------------------
def transform_to_staging():
    # Transform patients
    patients_df = pd.read_sql("SELECT * FROM raw_patients", engine)
    patients_df["full_name"] = patients_df["first_name"] + " " + patients_df["last_name"]
    patients_df.to_sql("staging_patients", engine, if_exists="replace", index=False)
    print("[SUCCESS] staging_patients created!")

    # Transform visits
    visits_df = pd.read_sql("SELECT * FROM raw_visits", engine)
    visits_df["visit_year"] = pd.to_datetime(visits_df["visit_date"]).dt.year
    visits_df.to_sql("staging_visits", engine, if_exists="replace", index=False)
    print("[SUCCESS] staging_visits created!")

    # Transform billing
    billing_df = pd.read_sql("SELECT * FROM raw_billing", engine)
    billing_df["billing_year"] = pd.to_datetime(billing_df["billing_date"]).dt.year
    billing_df.to_sql("staging_billing", engine, if_exists="replace", index=False)
    print("[SUCCESS] staging_billing created!")

# -----------------------------
# Run data quality checks
# -----------------------------
def run_data_quality_checks():
    tables = ["staging_patients", "staging_visits", "staging_billing"]
    for table in tables:
        df = pd.read_sql(f"SELECT * FROM {table}", engine)
        check_nulls(df, table)

# -----------------------------
# Main ETL execution
# -----------------------------
if __name__ == "__main__":
    transform_to_staging()
    run_data_quality_checks()

