import psycopg2
import pandas as pd
from logging_config import logger

CSV_PATH = "phase1/csv/patients.csv"

def load_patients_csv():
    try:
        logger.info(f"Starting raw_patients CSV load from {CSV_PATH}")

        df = pd.read_csv(CSV_PATH)
        row_count = len(df)

        conn = psycopg2.connect(
            host="localhost",
            database="hospitaldb_etl",
            user="postgres",
            password="your_password"
        )
        cur = conn.cursor()

        for _, row in df.iterrows():
            cur.execute(
                """
                INSERT INTO raw_patients
                (patient_id, first_name, last_name, gender, date_of_birth)
                VALUES (%s, %s, %s, %s, %s)
                """,
                (
                    row["patient_id"],
                    row["first_name"],
                    row["last_name"],
                    row["gender"],
                    row["date_of_birth"]
                )
            )

        conn.commit()
        cur.close()
        conn.close()

        logger.info(f"Successfully loaded {row_count} rows into raw_patients")

    except Exception as e:
        logger.error(f"Failed to load raw_patients from CSV: {e}")
        raise


if __name__ == "__main__":
    load_patients_csv()
