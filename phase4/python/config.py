# config.py
# Database connection settings for HospitalDB_ETL

import psycopg2
from psycopg2 import sql

# PostgreSQL credentials
DB_CONFIG = {
    "host": "localhost",       # or your DB server IP
    "port": 5432,
    "database": "hospitaldb_etl",
    "user": "etl_user",
    "password": "StrongPassword123!"  # replace with your real password
}

def get_connection():
    """
    Returns a new PostgreSQL connection using the config above.
    """
    try:
        conn = psycopg2.connect(**DB_CONFIG)
        return conn
    except Exception as e:
        print(f"Error connecting to database: {e}")
        raise

def close_connection(conn):
    """
    Closes the PostgreSQL connection.
    """
    if conn:
        conn.close()
