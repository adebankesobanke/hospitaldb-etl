import psycopg2
import random
from faker import Faker
from datetime import datetime
from logging_config import logger

def populate_all_raw_tables():
    try:
        logger.info("Starting population of all raw tables")

        conn = psycopg2.connect(
            host="localhost",
            database="hospitaldb_etl",
            user="postgres",
            password="your_password"
        )
        cur = conn.cursor()

        # Example: branches
        branches = [(i, f"Hospital Branch {i}") for i in range(1, 21)]
        cur.executemany(
            "INSERT INTO raw_branches (branch_id, branch_name) VALUES (%s, %s)",
            branches
        )
        logger.info(f"Inserted {len(branches)} rows into raw_branches")

        conn.commit()
        cur.close()
        conn.close()

        logger.info("Successfully populated all raw tables")

    except Exception as e:
        logger.error(f"Failed during raw table population: {e}")
        raise


if __name__ == "__main__":
    populate_all_raw_tables()
