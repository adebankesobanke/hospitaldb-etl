"""
LOAD MODULE
Loads cleaned dataframes into PostgreSQL staging tables.
"""

import logging
import psycopg2
from psycopg2.extras import execute_values

DB_CONFIG = {
    "host": "localhost",
    "database": "hospitaldb",
    "user": "postgres",
    "password": "yourpassword"
}

def load_to_postgres(df, table_name: str):
    logging.info(f"Loading data into {table_name}")

    conn = psycopg2.connect(**DB_CONFIG)
    cursor = conn.cursor()

    # Build INSERT query dynamically
    cols = ",".join(df.columns)
    values = [tuple(row) for row in df.to_numpy()]

    insert_query = f"""
        INSERT INTO {table_name} ({cols})
        VALUES %s
    """

    try:
        execute_values(cursor, insert_query, values)
        conn.commit()
        logging.info(f"{len(df)} rows loaded into {table_name}")

    except Exception as e:
        logging.error(f"Error loading into {table_name}: {e}")
        conn.rollback()

    finally:
        cursor.close()
        conn.close()
