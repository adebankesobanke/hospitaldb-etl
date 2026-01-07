import psycopg2
import pandas as pd
import os

# PostgreSQL connection
DB_PARAMS = {
    "host": "localhost",
    "database": "hospitaldb",
    "user": "postgres",
    "password": "your_password_here"  # replace with your PostgreSQL password
}

CSV_FOLDER = os.path.join(os.getcwd(), "phase1", "csv")

TABLES_ORDER = [
    "branches",
    "patients",
    "doctors",
    "appointments",
    "treatments",
    "visits",
    "billing"
]

CREATE_TABLE_QUERIES = {
    "branches": """
    DROP TABLE IF EXISTS raw_branches CASCADE;
    CREATE TABLE raw_branches (
        branch_id   INT PRIMARY KEY,
        branch_name VARCHAR(100),
        address     VARCHAR(255),
        city        VARCHAR(50),
        state       VARCHAR(50),
        created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );
    """,
    "patients": """
    DROP TABLE IF EXISTS raw_patients CASCADE;
    CREATE TABLE raw_patients (
        patient_id  INT PRIMARY KEY,
        first_name  VARCHAR(100),
        last_name   VARCHAR(100),
        gender      VARCHAR(10),
        date_of_birth DATE,
        phone       VARCHAR(20),
        email       VARCHAR(150),
        address     VARCHAR(255),
        branch_id   INT,
        FOREIGN KEY (branch_id) REFERENCES raw_branches(branch_id),
        created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );
    """,
    "doctors": """
    DROP TABLE IF EXISTS raw_doctors CASCADE;
    CREATE TABLE raw_doctors (
        doctor_id   INT PRIMARY KEY,
        first_name  VARCHAR(100),
        last_name   VARCHAR(100),
        specialty   VARCHAR(100),
        phone       VARCHAR(20),
        email       VARCHAR(150),
        branch_id   INT,
        FOREIGN KEY (branch_id) REFERENCES raw_branches(branch_id),
        created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );
    """,
    "appointments": """
    DROP TABLE IF EXISTS raw_appointments CASCADE;
    CREATE TABLE raw_appointments (
        appointment_id INT PRIMARY KEY,
        patient_id     INT,
        doctor_id      INT,
        appointment_date TIMESTAMP,
        branch_id      INT,
        FOREIGN KEY (patient_id) REFERENCES raw_patients(patient_id),
        FOREIGN KEY (doctor_id) REFERENCES raw_doctors(doctor_id),
        FOREIGN KEY (branch_id) REFERENCES raw_branches(branch_id),
        created_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );
    """,
    "treatments": """
    DROP TABLE IF EXISTS raw_treatments CASCADE;
    CREATE TABLE raw_treatments (
        treatment_id INT PRIMARY KEY,
        appointment_id INT,
        treatment_type VARCHAR(100),
        cost DECIMAL(10,2),
        branch_id INT,
        FOREIGN KEY (appointment_id) REFERENCES raw_appointments(appointment_id),
        FOREIGN KEY (branch_id) REFERENCES raw_branches(branch_id),
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );
    """,
    "visits": """
    DROP TABLE IF EXISTS raw_visits CASCADE;
    CREATE TABLE raw_visits (
        visit_id INT PRIMARY KEY,
        patient_id INT,
        doctor_id INT,
        visit_date TIMESTAMP,
        branch_id INT,
        FOREIGN KEY (patient_id) REFERENCES raw_patients(patient_id),
        FOREIGN KEY (doctor_id) REFERENCES raw_doctors(doctor_id),
        FOREIGN KEY (branch_id) REFERENCES raw_branches(branch_id),
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );
    """,
    "billing": """
    DROP TABLE IF EXISTS raw_billing CASCADE;
    CREATE TABLE raw_billing (
        bill_id INT PRIMARY KEY,
        appointment_id INT,
        amount DECIMAL(10,2),
        payment_method VARCHAR(50),
        payment_status VARCHAR(50),
        branch_id INT,
        FOREIGN KEY (appointment_id) REFERENCES raw_appointments(appointment_id),
        FOREIGN KEY (branch_id) REFERENCES raw_branches(branch_id),
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );
    """
}

def load_csv_to_table(conn, table_name):
    csv_file = os.path.join(CSV_FOLDER, f"{table_name}.csv")
    if not os.path.exists(csv_file):
        print(f"❌ CSV file not found: {csv_file}")
        return

    df = pd.read_csv(csv_file)
    cols = ",".join(df.columns)
    values_placeholder = ",".join(["%s"] * len(df.columns))
    insert_query = f"INSERT INTO raw_{table_name} ({cols}) VALUES ({values_placeholder})"

    with conn.cursor() as cur:
        for _, row in df.iterrows():
            cur.execute(insert_query, tuple(row))
    conn.commit()
    print(f"✅ Loaded CSV '{table_name}.csv' into table 'raw_{table_name}' ({len(df)} rows)")

def main():
    conn = psycopg2.connect(**DB_PARAMS)
    print("✅ Connected to PostgreSQL")

    # Create tables
    for table in TABLES_ORDER:
        with conn.cursor() as cur:
            cur.execute(CREATE_TABLE_QUERIES[table])
            conn.commit()
            print(f"✅ Created table 'raw_{table}' (if not existed)")

    # Load CSVs in order
    for table in TABLES_ORDER:
        load_csv_to_table(conn, table)

    conn.close()
    print("✅ PostgreSQL connection closed")

if __name__ == "__main__":
    main()
