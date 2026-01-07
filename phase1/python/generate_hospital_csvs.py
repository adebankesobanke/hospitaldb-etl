import pandas as pd
import random
from faker import Faker
from datetime import datetime, timedelta
import os

fake = Faker()

OUTPUT_DIR = "phase1/csv"
os.makedirs(OUTPUT_DIR, exist_ok=True)

# -------------------------
# CONFIG
# -------------------------
NUM_BRANCHES = 20
NUM_DOCTORS = 120
NUM_PATIENTS = 500
NUM_VISITS = 1200
NUM_TREATMENTS = 2500

# -------------------------
# BRANCHES
# -------------------------
branches = []
for i in range(1, NUM_BRANCHES + 1):
    branches.append([
        i,
        f"Hospital Branch {i}",
        fake.address().replace("\n", ", "),
        fake.city(),
        fake.state()
    ])

branches_df = pd.DataFrame(branches, columns=[
    "branch_id", "branch_name", "address", "city", "state"
])
branches_df.to_csv(f"{OUTPUT_DIR}/branches.csv", index=False)

# -------------------------
# DOCTORS
# -------------------------
specializations = ["Cardiology", "Neurology", "Orthopedics", "Pediatrics", "Oncology"]

doctors = []
for i in range(1, NUM_DOCTORS + 1):
    doctors.append([
        i,
        fake.first_name(),
        fake.last_name(),
        random.choice(specializations),
        random.randint(1, NUM_BRANCHES)
    ])

doctors_df = pd.DataFrame(doctors, columns=[
    "doctor_id", "first_name", "last_name", "specialization", "branch_id"
])
doctors_df.to_csv(f"{OUTPUT_DIR}/doctors.csv", index=False)

# -------------------------
# PATIENTS
# -------------------------
patients = []
for i in range(1, NUM_PATIENTS + 1):
    patients.append([
        i,
        fake.first_name(),
        fake.last_name(),
        random.choice(["Male", "Female"]),
        fake.date_of_birth(minimum_age=1, maximum_age=90),
        fake.phone_number(),
        fake.email(),
        fake.address().replace("\n", ", "),
        random.randint(1, NUM_BRANCHES)
    ])

patients_df = pd.DataFrame(patients, columns=[
    "patient_id", "first_name", "last_name", "gender",
    "date_of_birth", "phone", "email", "address", "branch_id"
])
patients_df.to_csv(f"{OUTPUT_DIR}/patients.csv", index=False)

# -------------------------
# VISITS
# -------------------------
visits = []
for i in range(1, NUM_VISITS + 1):
    visits.append([
        i,
        random.randint(1, NUM_PATIENTS),
        random.randint(1, NUM_DOCTORS),
        fake.date_between(start_date="-2y", end_date="today"),
        random.choice(["Emergency", "Routine", "Follow-up"]),
        random.randint(1, NUM_BRANCHES)
    ])

visits_df = pd.DataFrame(visits, columns=[
    "visit_id", "patient_id", "doctor_id",
    "visit_date", "visit_type", "branch_id"
])
visits_df.to_csv(f"{OUTPUT_DIR}/visits.csv", index=False)

# -------------------------
# APPOINTMENTS
# -------------------------
appointments_df = visits_df.copy()
appointments_df.columns = [
    "appointment_id", "patient_id", "doctor_id",
    "appointment_date", "status", "branch_id"
]
appointments_df["status"] = random.choices(
    ["Scheduled", "Completed", "Cancelled"], k=len(appointments_df)
)
appointments_df.to_csv(f"{OUTPUT_DIR}/appointments.csv", index=False)

# -------------------------
# TREATMENTS
# -------------------------
treatment_names = ["X-Ray", "MRI", "CT Scan", "Blood Test", "Surgery", "Physiotherapy"]

treatments = []
for i in range(1, NUM_TREATMENTS + 1):
    treatments.append([
        i,
        random.randint(1, NUM_VISITS),
        random.choice(treatment_names),
        round(random.uniform(50, 5000), 2)
    ])

treatments_df = pd.DataFrame(treatments, columns=[
    "treatment_id", "visit_id", "treatment_name", "cost"
])
treatments_df.to_csv(f"{OUTPUT_DIR}/treatments.csv", index=False)

# -------------------------
# BILLINGS
# -------------------------
billings = []
for i in range(1, NUM_VISITS + 1):
    billings.append([
        i,
        i,
        random.randint(1, NUM_PATIENTS),
        round(random.uniform(100, 10000), 2),
        random.choice(["Paid", "Pending", "Cancelled"]),
        fake.date_between(start_date="-2y", end_date="today"),
        random.randint(1, NUM_BRANCHES)
    ])

billings_df = pd.DataFrame(billings, columns=[
    "billing_id", "visit_id", "patient_id",
    "amount", "payment_status", "billing_date", "branch_id"
])
billings_df.to_csv(f"{OUTPUT_DIR}/billings.csv", index=False)

print("✅ All CSV files generated successfully")
