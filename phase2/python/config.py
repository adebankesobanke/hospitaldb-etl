"""
Configuration file for HospitalDB Phase 1 ETL
- Database connection details
- CSV file paths
"""

# -----------------------------
# Database connection settings
# -----------------------------
DB_CONFIG = {
    "host": "localhost",
    "port": 5432,
    "database": "hospitaldb",
    "user": "your_username",
    "password": "your_password"
}

# -----------------------------
# CSV file paths
# -----------------------------
CSV_FILES = {
    "patients": "phase1/csv_loaders/patients.csv",
    "visits": "phase1/csv_loaders/visits.csv",
    "billing": "phase1/csv_loaders/billing.csv"
}
