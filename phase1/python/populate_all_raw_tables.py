import psycopg2
import random
from datetime import datetime, timedelta
import faker

# Initialize Faker for realistic names and addresses
fake = faker.Faker()

# PostgreSQL connection
conn = psycopg2.connect(
    host="localhost",
    database="hospitaldb-etl",
    user="postgres",
    password="your_password"
)
cur = conn.cursor()

# --- 1. Raw Branches ---
cur.execute("DROP TABLE IF EXISTS raw_branches CASCADE")
cur.execute("""
CREATE TABLE raw_branches (
    branch_id INT PRIMARY KEY,
    branch_name VARCHAR(100),
    address VARCHAR(255),
    city VARCHAR(50),
    state VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)
""")

branches = []
for branch_id in range(1, 21):  # 20 branches
    branches.append((
        branch_id,
        f"{fake.city()} Medical Center",
        fake.address(),
        fake.city(),
        fake.state(),
        datetime.now() - timedelta(days=random.randint(0, 365))
    ))
cur.executemany("""
INSERT INTO raw_branches (branch_id, branch_name, address, city, state, created_at)
VALUES (%s, %s, %s, %s, %s, %s)
""", branches)
print("✅ raw_branches populated")

# --- 2. Raw Patients ---
cur.execute("DROP TABLE IF EXISTS raw_patients CASCADE")
cur.execute("""
CREATE TABLE raw_patients (
    patient_id INT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    gender VARCHAR(10),
    date_of_birth DATE,
    phone VARCHAR(20),
    email VARCHAR(150),
    address VARCHAR(255),
    branch_id INT REFERENCES raw_branches(branch_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)
""")

patients = []
for patient_id in range(1, 501):  # 500 patients
    gender = random.choice(['Male', 'Female'])
    patients.append((
        patient_id,
        fake.first_name_male() if gender == 'Male' else fake.first_name_female(),
        fake.last_name(),
        gender,
        fake.date_of_birth(minimum_age=0, maximum_age=90),
        fake.phone_number(),
        fake.email(),
        fake.address(),
        random.choice(range(1, 21)),  # branch_id
        datetime.now() - timedelta(days=random.randint(0, 365))
    ))
conn = psycopg2.connect(
    host="localhost",
    database="hospitaldb_etl",
    user="postgres",
    password="your_password"
)

conn.autocommit = True   # 👈 ADD THIS LINE HERE

cur = conn.cursor()

# --- 3. Raw Doctors ---
cur.execute("DROP TABLE IF EXISTS raw_doctors CASCADE")
cur.execute("""
CREATE TABLE raw_doctors (
    doctor_id INT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    specialty VARCHAR(50),
    phone VARCHAR(20),
    email VARCHAR(150),
    branch_id INT REFERENCES raw_branches(branch_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)
""")

specialties = ['Cardiology', 'Neurology', 'Oncology', 'Pediatrics', 'General']
doctors = []
for doctor_id in range(1, 51):  # 50 doctors
    doctors.append((
        doctor_id,
        fake.first_name(),
        fake.last_name(),
        random.choice(specialties),
        fake.phone_number(),
        fake.email(),
        random.choice(range(1, 21)),
        datetime.now() - timedelta(days=random.randint(0, 365))
    ))
cur.executemany("""
INSERT INTO raw_doctors (doctor_id, first_name, last_name, specialty, phone, email, branch_id, created_at)
VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
""", doctors)
print("✅ raw_doctors populated")

# --- 4. Raw Visits ---
cur.execute("DROP TABLE IF EXISTS raw_visits CASCADE")
cur.execute("""
CREATE TABLE raw_visits (
    visit_id INT PRIMARY KEY,
    patient_id INT REFERENCES raw_patients(patient_id),
    doctor_id INT REFERENCES raw_doctors(doctor_id),
    visit_date TIMESTAMP,
    branch_id INT REFERENCES raw_branches(branch_id),
    reason VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)
""")

visits = []
for visit_id in range(1, 1001):  # 1000 visits
    visits.append((
        visit_id,
        random.choice(range(1, 501)),  # patient_id
        random.choice(range(1, 51)),   # doctor_id
        datetime.now() - timedelta(days=random.randint(0, 365)),
        random.choice(range(1, 21)),   # branch_id
        fake.sentence(nb_words=6),
        datetime.now() - timedelta(days=random.randint(0, 365))
    ))
cur.executemany("""
INSERT INTO raw_visits (visit_id, patient_id, doctor_id, visit_date, branch_id, reason, created_at)
VALUES (%s, %s, %s, %s, %s, %s, %s)
""", visits)
print("✅ raw_visits populated")

# --- 5. Raw Treatments ---
cur.execute("DROP TABLE IF EXISTS raw_treatments CASCADE")
cur.execute("""
CREATE TABLE raw_treatments (
    treatment_id INT PRIMARY KEY,
    visit_id INT REFERENCES raw_visits(visit_id),
    treatment_name VARCHAR(100),
    cost DECIMAL(10,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)
""")

treatment_types = ['Medication', 'Surgery', 'Therapy', 'Checkup', 'Vaccination']
treatments = []
for treatment_id in range(1, 1001):
    treatments.append((
        treatment_id,
        random.choice(range(1, 1001)),  # visit_id
        random.choice(treatment_types),
        round(random.uniform(100, 5000), 2),
        datetime.now() - timedelta(days=random.randint(0, 365))
    ))
cur.executemany("""
INSERT INTO raw_treatments (treatment_id, visit_id, treatment_name, cost, created_at)
VALUES (%s, %s, %s, %s, %s)
""", treatments)
print("✅ raw_treatments populated")

# --- 6. Raw Billing ---
cur.execute("DROP TABLE IF EXISTS raw_billing CASCADE")
cur.execute("""
CREATE TABLE raw_billing (
    bill_id INT PRIMARY KEY,
    visit_id INT REFERENCES raw_visits(visit_id),
    amount DECIMAL(10,2),
    payment_method VARCHAR(50),
    payment_status VARCHAR(50),
    branch_id INT REFERENCES raw_branches(branch_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)
""")

payment_methods = ['Cash', 'Card', 'Insurance', 'Online']
payment_statuses = ['Paid', 'Pending', 'Cancelled']
billings = []
for bill_id in range(1, 1201):
    billings.append((
        bill_id,
        random.choice(range(1, 1001)),  # visit_id
        round(random.uniform(50, 5000), 2),
        random.choice(payment_methods),
        random.choice(payment_statuses),
        random.choice(range(1, 21)),    # branch_id
        datetime.now() - timedelta(days=random.randint(0, 365))
    ))
cur.executemany("""
INSERT INTO raw_billing (bill_id, visit_id, amount, payment_method, payment_status, branch_id, created_at)
VALUES (%s, %s, %s, %s, %s, %s, %s)
""", billings)
print("✅ raw_billing populated")

# Commit and close connection
conn.commit()
cur.close()
conn.close()
print("🎉 All raw tables successfully populated!")
conn.commit()
print("✅ Transaction committed")

cur.close()
conn.close()
conn.commit()