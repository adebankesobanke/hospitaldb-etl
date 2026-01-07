import psycopg2
from psycopg2.extras import execute_values
from datetime import date
import random

# -----------------------------
# DATABASE CONNECTION
# -----------------------------
conn = psycopg2.connect(
    host="localhost",
    database="hospitaldb-etl",   # ⚠️ must match your NEW database exactly
    user="postgres",
    password="postgres"         # change only if yours is different
)

conn.autocommit = True
cur = conn.cursor()

print("✅ Connected to PostgreSQL")

# -----------------------------
# RESET RAW SCHEMA
# -----------------------------
cur.execute("""
DROP SCHEMA IF EXISTS raw CASCADE;
CREATE SCHEMA raw;
""")

print("✅ raw schema reset")

# -----------------------------
# CREATE TABLES (NO FKs YET)
# -----------------------------
cur.execute("""
CREATE TABLE raw.branches (
    branch_id INT PRIMARY KEY,
    branch_name VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50)
);
""")

cur.execute("""
CREATE TABLE raw.patients (
    patient_id INT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    gender VARCHAR(10),
    date_of_birth DATE,
    branch_id INT
);
""")

cur.execute("""
CREATE TABLE raw.visits (
    visit_id INT PRIMARY KEY,
    patient_id INT,
    visit_date DATE,
    branch_id INT
);
""")

cur.execute("""
CREATE TABLE raw.billing (
    billing_id INT PRIMARY KEY,
    visit_id INT,
    amount NUMERIC(10,2),
    payment_status VARCHAR(20)
);
""")

print("✅ Raw tables created")

# -----------------------------
# INSERT DATA
# -----------------------------

# Branches
branches = [(i, f"Hospital Branch {i}", "City", "State") for i in range(1, 21)]
execute_values(
    cur,
    "INSERT INTO raw.branches VALUES %s",
    branches
)
print("✅ raw.branches populated")

# Patients
patients = []
for i in range(1, 501):
    patients.append((
        i,
        f"First{i}",
        f"Last{i}",
        random.choice(["Male", "Female"]),
        date(1980, 1, 1),
        random.randint(1, 20)
    ))

execute_values(
    cur,
    "INSERT INTO raw.patients VALUES %s",
    patients
)
print("✅ raw.patients populated (500 rows)")

# Visits
visits = []
for i in range(1, 1001):
    visits.append((
        i,
        random.randint(1, 500),
        date(2024, 1, 1),
        random.randint(1, 20)
    ))

execute_values(
    cur,
    "INSERT INTO raw.visits VALUES %s",
    visits
)
print("✅ raw.visits populated (1000 rows)")

# Billing
billings = []
for i in range(1, 1001):
    billings.append((
        i,
        i,
        round(random.uniform(50, 500), 2),
        random.choice(["PAID", "PENDING"])
    ))

execute_values(
    cur,
    "INSERT INTO raw.billing VALUES %s",
    billings
)
print("✅ raw.billing populated (1000 rows)")

# -----------------------------
# ADD FOREIGN KEYS (LAST)
# -----------------------------
cur.execute("""
ALTER TABLE raw.patients
ADD CONSTRAINT fk_patients_branch
FOREIGN KEY (branch_id) REFERENCES raw.branches(branch_id);
""")

cur.execute("""
ALTER TABLE raw.visits
ADD CONSTRAINT fk_visits_patient
FOREIGN KEY (patient_id) REFERENCES raw.patients(patient_id);

ALTER TABLE raw.visits
ADD CONSTRAINT fk_visits_branch
FOREIGN KEY (branch_id) REFERENCES raw.branches(branch_id);
""")

cur.execute("""
ALTER TABLE raw.billing
ADD CONSTRAINT fk_billing_visit
FOREIGN KEY (visit_id) REFERENCES raw.visits(visit_id);
""")

print("✅ Foreign keys added")

cur.close()
conn.close()
print("🎉 RAW LAYER BOOTSTRAP COMPLETE")
