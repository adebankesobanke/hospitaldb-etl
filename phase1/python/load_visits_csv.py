import psycopg2
import pandas as pd
from logging_config import logger

CSV_PATH = "phase1/csv/visits.csv"

def load_visits_csv():
    try:
        logger.info("Starting raw_visits CSV load")

        df = pd.read_csv(CSV_PATH)

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
                INSERT INTO raw_visits (visit_id, patient_id, visit_date)
                VALUES (%s, %s, %s)
                """,
                (row["visit_id"], row["patient_id"], row["visit_date"])
            )

        conn.commit()
        cur.close()
        conn.close()

        logger.info(f"Loaded {len(df)} rows into raw_visits")

    except Exception as e:
        logger.error(f"Failed to load raw_visits: {e}")
        raise


if __name__ == "__main__":
    load_visits_csv()
