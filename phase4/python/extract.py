"""
EXTRACTION MODULE
Loads raw CSV files from Phase 1.
"""

import pandas as pd
import os

RAW_PATH = "phase1/csv"

def extract_csv_files():
    files = {
        "patients": "patients_raw.csv",
        "visits": "visits_raw.csv"
    }

    data = {}
    for key, file_name in files.items():
        file_path = os.path.join(RAW_PATH, file_name)
        df = pd.read_csv(file_path)

        data[key] = df

    return data
