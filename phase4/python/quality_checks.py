"""
DATA QUALITY CHECKS MODULE
Runs validation rules on the staging database.
"""

import psycopg2
import logging

DB_CONFIG = {
    "host": "localhost",
    "database": "hospitaldb",
    "user": "postgres",
    "password": "yourpassword"
}

def run_data_quality_checks():
    conn = psycopg2.connect(**DB_CONFIG)
    cur = conn.cursor()

    checks = [
        ("Check for null patient IDs", 
         "SELECT COUNT(*) FROM stg_patients WHERE patient_id IS NULL"),

        ("Check visit dates before discharge", 
         """SELECT COUNT(*) FROM stg_visits 
            WHERE discharge_date < visit_date"""),

        ("Check negative length of stay", 
         "SELECT COUNT(*) FROM stg_visits WHERE length_of_stay < 0"),
    ]

    for description, query in checks:
        cur.execute(query)
        result = cur.fetchone()[0]
        logging.info(f"{description}: {result}")

    cur.close()
    conn.close()
