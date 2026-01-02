import logging
import sys
import pandas as pd
import psycopg2
from psycopg2.extras import execute_values

# ------------------------------------------------------
# CONFIGURATION
# ------------------------------------------------------

DB_CONFIG = {
    "dbname": "hospitaldb",
    "user": "postgres",
    "password": "your_password",
    "host": "localhost",
    "port": 5432
}

RAW_DATA_PATH = "phase4/python/data/raw/"
TRANSFORMED_DATA_PATH = "phase4/python/data/transformed/"

logging.basicConfig(
    filename="phase4/python/logs/etl.log",
    level=logging.INFO,
    format="%(asctime)s - %(levelname)s - %(message)s"
)


# ------------------------------------------------------
# EXTRACT
# ------------------------------------------------------

def extract_csv(file_name: str) -> pd.DataFrame:
    """Load raw CSV file into a pandas DataFrame."""
    try:
        df = pd.read_csv(RAW_DATA_PATH + file_name)
        logging.info(f"Extracted file: {file_name} ({len(df)} records)")
        return df
    except Exception as e:
        logging.error(f"Extract Error for {file_name}: {str(e)}")
        raise


# ------------------------------------------------------
# TRANSFORM
# ------------------------------------------------------

def clean_patient_data(df: pd.DataFrame) -> pd.DataFrame:
    """Example transformation logic for patient data."""
    try:
        df.columns = df.columns.str.lower()

        # strip spaces
        df = df.apply(lambda col: col.str.strip() if col.dtype == "object" else col)

        # drop duplicates
        df = df.drop_duplicates()

        logging.info(f"Transformed patient dataframe → {len(df)} rows after cleaning")
        return df
    except Exception as e:
        logging.error(f"Transform Error (patient data): {str(e)}")
        raise


# ------------------------------------------------------
# LOAD
# ------------------------------------------------------

def connect_db():
    """Create PostgreSQL database connection."""
    try:
        conn = psycopg2.connect(**DB_CONFIG)
        logging.info("Database connection established")
        return conn
    except Exception as e:
        logging.error(f"Database Connection Failed: {e}")
        raise


def load_to_staging(df: pd.DataFrame, table_name: str):
    """Bulk load a DataFrame into a PostgreSQL staging table."""
    try:
        conn = connect_db()
        cur = conn.cursor()

        cols = ",".join(df.columns)
        values = [tuple(x) for x in df.to_numpy()]

        sql = f"INSERT INTO {table_name} ({cols}) VALUES %s"

        execute_values(cur, sql, values)
        conn.commit()

        logging.info(f"Loaded {len(df)} records into {table_name}")
        conn.close()

    except Exception as e:
        logging.error(f"Load Error into {table_name}: {e}")
        raise


# ------------------------------------------------------
# MAIN ETL PROCESS
# ------------------------------------------------------

def run_etl():
    """
    Full ETL Pipeline:
    1. Extract CSVs
    2. Clean & Transform
    3. Load into PostgreSQL staging tables
    """

    logging.info("ETL Pipeline Started")

    try:
        # ------------------- Extract -------------------
        patients_df = extract_csv("patients.csv")

        # ------------------ Transform -------------------
        patients_clean_df = clean_patient_data(patients_df)

        # Save transformed version
        patients_clean_df.to_csv(TRANSFORMED_DATA_PATH + "patients_clean.csv", index=False)

        # ------------------- Load ----------------------
        load_to_staging(patients_clean_df, "staging_patients")

        logging.info("ETL Pipeline Completed Successfully")

    except Exception as e:
        logging.error(f"ETL Pipeline Failed: {str(e)}")
        print("ETL Failed. Check logs for details.")
        sys.exit(1)


if __name__ == "__main__":
    run_etl()
