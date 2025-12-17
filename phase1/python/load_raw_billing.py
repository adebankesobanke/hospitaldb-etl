import psycopg2
import pandas as pd
import os

# --- CONFIGURATION ---
DB_CONFIG = {
    "host": "localhost",
    "port": 5432,
    "database": "hospitaldb-etl",
    "user": "postgres",
    "password": "YOUR_PASSWORD_HERE"  # replace with your postgres password
}

CSV_DIR = "C:/Users/user/Desktop/Projects/HospitalDB_ETL/phase1/csv"  # path to your CSVs

# --- HELPER FUNCTION ---
def load_csv_to_table(cursor, table_name, csv_file, columns):
    file_path = os.path.join(CSV_DIR, csv_file)
    if not os.path.exists(file_path):
        print(f"❌ CSV file not found: {file_path}")
        return

    df = pd.read_csv(file_path)
    # Keep only required columns
    df = df[columns]
    for _, row in df.iterrows():
        values = tuple(row[col] for col in columns)
        placeholders = ", ".join(["%s"] * len(values))
        insert_sql = f"INSERT INTO raw.{table_name} ({', '.join(columns)}) VALUES ({placeholders})"
        cursor.execute(insert_sql, values)
    print(f"✅ Loaded CSV '{csv_file}' into table '{table_name}' ({len(df)} rows)")

# --- MAIN SCRIPT ---
def main():
    try:
        conn = psycopg2.connect(**DB_CONFIG)
        cursor = conn.cursor()
        print("✅ Connected to PostgreSQL")

        # 1️⃣ Create raw schema
        cursor.execute("CREATE SCHEMA IF NOT EXISTS raw;")
        conn.commit()

        # 2️⃣ Create raw tables
        tables_sql = {
            "raw_branches": """
                CREATE TABLE IF NOT EXISTS raw.raw_branches (
                    branch_id   INT PRIMARY KEY,
                    branch_name VARCHAR(100),
                    address     VARCHAR(255),
                    city        VARCHAR(100),
                    state       VARCHAR(50),
                    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
                );
            """,
            "raw_patients": """
                CREATE TABLE IF NOT EXISTS raw.raw_patients (
                    patient_id   INT PRIMARY KEY,
                    first_name   VARCHAR(100),
                    last_name    VARCHAR(100),
                    gender       VARCHAR(10),
                    date_of_birth DATE,
                    phone        VARCHAR(20),
                    email        VARCHAR(150),
                    address      VARCHAR(255),
                    branch_id    INT,
                    created_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                    FOREIGN KEY (branch_id) REFERENCES raw.raw_branches(branch_id)
                );
            """,
            "raw_visits": """
                CREATE TABLE IF NOT EXISTS raw.raw_visits (
                    visit_id    INT PRIMARY KEY,
                    patient_id  INT,
                    visit_date  DATE,
                    reason      VARCHAR(255),
                    branch_id   INT,
                    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                    FOREIGN KEY (patient_id) REFERENCES raw.raw_patients(patient_id),
                    FOREIGN KEY (branch_id) REFERENCES raw.raw_branches(branch_id)
                );
            """,
            "raw_doctors": """
                CREATE TABLE IF NOT EXISTS raw.raw_doctors (
                    doctor_id   INT PRIMARY KEY,
                    first_name  VARCHAR(100),
                    last_name   VARCHAR(100),
                    specialty   VARCHAR(100),
                    phone       VARCHAR(20),
                    email       VARCHAR(150),
                    branch_id   INT,
                    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                    FOREIGN KEY (branch_id) REFERENCES raw.raw_branches(branch_id)
                );
            """,
            "raw_treatments": """
                CREATE TABLE IF NOT EXISTS raw.raw_treatments (
                    treatment_id INT PRIMARY KEY,
                    visit_id     INT,
                    doctor_id    INT,
                    treatment    VARCHAR(255),
                    created_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                    FOREIGN KEY (visit_id) REFERENCES raw.raw_visits(visit_id),
                    FOREIGN KEY (doctor_id) REFERENCES raw.raw_doctors(doctor_id)
                );
            """,
            "raw_billing": """
                CREATE TABLE IF NOT EXISTS raw.raw_billing (
                    bill_id        INT PRIMARY KEY,
                    visit_id       INT,
                    amount         DECIMAL(10,2),
                    payment_method VARCHAR(50),
                    payment_status VARCHAR(50),
                    branch_id      INT,
                    created_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                    FOREIGN KEY (visit_id) REFERENCES raw.raw_visits(visit_id),
                    FOREIGN KEY (branch_id) REFERENCES raw.raw_branches(branch_id)
                );
            """
        }

        for name, sql in tables_sql.items():
            cursor.execute(sql)
            conn.commit()
            print(f"✅ Created table '{name}' (if not existed)")

        # 3️⃣ Load CSVs in order
        load_csv_to_table(cursor, "raw_branches", "branches.csv",
                          ["branch_id", "branch_name", "address", "city", "state"])
        load_csv_to_table(cursor, "raw_patients", "patients.csv",
                          ["patient_id", "first_name", "last_name", "gender", "date_of_birth", "phone", "email", "address", "branch_id"])
        load_csv_to_table(cursor, "raw_visits", "visits.csv",
                          ["visit_id", "patient_id", "visit_date", "reason", "branch_id"])
        load_csv_to_table(cursor, "raw_doctors", "doctors.csv",
                          ["doctor_id", "first_name", "last_name", "specialty", "phone", "email", "branch_id"])
        load_csv_to_table(cursor, "raw_treatments", "treatments.csv",
                          ["treatment_id", "visit_id", "doctor_id", "treatment"])
        load_csv_to_table(cursor, "raw_billing", "billings.csv",
                          ["bill_id", "visit_id", "amount", "payment_method", "payment_status", "branch_id"])

        conn.commit()
        print("✅ All CSVs loaded successfully!")

    except Exception as e:
        print("❌ Error:", e)
    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()
        print("✅ PostgreSQL connection closed")

if __name__ == "__main__":
    main()
