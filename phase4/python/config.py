# DB and file path configuration (replace with real values or use env vars)
import os

# Load from environment variables for security
DB_CONFIG = {
    "host": os.getenv("DB_HOST", "localhost"),
    "port": os.getenv("DB_PORT", 5432),
    "database": os.getenv("DB_NAME", "hospitaldb"),
    "user": os.getenv("DB_USER", "postgres"),
    "password": os.getenv("DB_PASSWORD", "password")
}

CSV_PATHS = {
    "patients": "phase1/csv_loaders/patients.csv",
    "visits": "phase1/csv_loaders/visits.csv",
    "billing": "phase1/csv_loaders/billing.csv",
}

LOG_PATH = "phase4/python/etl.log"
