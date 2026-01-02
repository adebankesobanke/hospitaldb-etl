🏥 HospitalDB_ETL — Phase 2 README
Materialized Views, Functions, Stored Procedures & Indexing

Phase 2 focuses on transforming the cleaned and validated data (from Phase 1) into optimized analytical structures using SQL performance engineering. The purpose is to prepare the database for fast reporting, analytics, and downstream BI tools (Power BI, Metabase, Tableau, etc.).

This phase contains:

Materialized Views — Precomputed tables for fast analytics

Functions — Reusable SQL logic

Stored Procedures — Automating transformation workflows

Indexing Scripts — Improving query performance

📂 Folder Structure
phase2/
│
├── sql/
│   ├── materialized_views/
│   │   ├── 01_mv_patient_summary.sql
│   │   ├── 02_mv_doctor_workload.sql
│   │   ├── 03_mv_visit_stats.sql
│   │   ├── 04_mv_lab_results_summary.sql
│   │   ├── 05_mv_billing_summary.sql
│   │   └── 06_mv_medication_summary.sql
│   │
│   ├── functions/
│   │   ├── fn_calculate_patient_age.sql
│   │   └── fn_normalize_text.sql
│   │
│   ├── procedures/
│   │   ├── sp_refresh_materialized_views.sql
│   │   ├── sp_load_incremental_data.sql
│   │   └── sp_run_data_quality_checks.sql
│   │
│   └── indexes/
│       ├── 01_index_patients.sql
│       ├── 02_index_doctors.sql
│       ├── 03_index_visits.sql
│       ├── 04_index_diagnoses.sql
│       ├── 05_index_medications.sql
│       ├── 06_index_lab_results.sql
│       └── 07_index_billing.sql
│
└── README.md

🧱 1. Materialized Views

Materialized views are used to precompute and store summarized tables to speed up analytical workloads.

Included Views
File	Description
01_mv_patient_summary.sql	Overview of patients, age, visit counts, billing totals
02_mv_doctor_workload.sql	Workload and performance metrics for each doctor
03_mv_visit_stats.sql	Daily/monthly visit statistics
04_mv_lab_results_summary.sql	Patient-level lab test frequency & latest results
05_mv_billing_summary.sql	Billing totals, outstanding balances, payment status
06_mv_medication_summary.sql	Medications per visit, drug usage patterns

These views serve as the foundation for BI dashboards.

⚙️ 2. SQL Functions

Functions represent reusable logic.

Included Functions
File	Purpose
fn_calculate_patient_age.sql	Computes real-time patient age from DOB
fn_normalize_text.sql	Cleans string fields (trim, upper-case, remove noise)

These are used inside staging scripts, materialized views, and data quality routines.

🛠 3. Stored Procedures

Stored procedures automate ETL steps for ease of execution.

Included Procedures
File	Purpose
sp_refresh_materialized_views.sql	Automatically refreshes all materialized views
sp_load_incremental_data.sql	Loads only new or modified rows (incremental load)
sp_run_data_quality_checks.sql	Runs all DQ checks and logs results

These procedures make the ETL pipeline reproducible and Airflow-ready (Phase 4).

🚀 4. Indexing Scripts

Indexes improve query performance on frequently accessed columns.

Included Index Scripts
Table	Index Types
Patients	patient_id, gender, date_of_birth
Doctors	doctor_id, specialty
Visits	visit_id, doctor_id, patient_id, visit_date
Diagnoses	visit_id, icd_code
Medications	visit_id, drug_name
Lab Results	visit_id, test_name
Billing	visit_id, patient_id, status

These indexes drastically accelerate joins and reporting workloads across the data warehouse.

📌 How Phase 2 Fits Into the Full ETL Workflow
Phase 1 → Phase 2 → Phase 3 → Phase 4
Phase	Purpose
Phase 1	Raw → Staging → Cleaned tables
Phase 2	Analytics layer → Functions → MVs → Indexing
Phase 3	Build final Star Schema (Fact + Dimension tables)
Phase 4	Automate ETL using Airflow DAGs
