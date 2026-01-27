# HospitalDB_ETL

A structured **ETL pipeline project** simulating a hospital database workflow. The project ingests raw data, transforms it, performs quality checks, and prepares it for analytics. The workflow is divided into **six phases**, demonstrating end-to-end data engineering best practices.

---

## Project Overview

This project covers the full lifecycle of hospital data management:

- **Data Ingestion:** Load raw CSV files into staging tables.  
- **Data Transformation:** Apply business rules and transformations.  
- **Data Quality:** Perform integrity, consistency, and completeness checks.  
- **Automation & Orchestration:** Schedule and orchestrate ETL pipelines using Python and Airflow.  
- **Monitoring & Alerts:** Implement notifications, logging, and CI/CD for production readiness.  

---

## Project Phases

### Phase 1 – Raw Data & Initial Load
- Store raw CSVs for appointments, patients, doctors, treatments, billings, visits, and branches.
- SQL loaders for ingesting raw CSVs into staging tables.
- Data quality checks for missing values, duplicates, referential integrity, and business rules.

### Phase 2 – Indexing & Optimizations
- Create database indexes to optimize query performance.
- Implement efficient SQL queries for reporting and analytics.
- Set up materialized views for frequently queried aggregates.

### Phase 3 – Incremental Processing
- Implement ETL scripts for incremental updates.
- Automated batch refresh workflows (`refresh_incremental.bat`).
- Maintain logs and incremental data tracking.

### Phase 4 – Airflow Orchestration
- DAGs orchestrate ETL pipelines end-to-end.
- Python ETL scripts for extraction, transformation, loading, and quality checks.
- Notifications and monitoring for ETL failures.
- Virtual environments isolated (`venv_airflow/`) and ignored from Git.

### Phase 5 – CI/CD & Production Readiness
- GitHub Actions workflows for automated ETL runs.
- Monitoring scripts for logs, errors, and data issues.
- Notifications via email and Slack alerts.
- Incremental SQL procedures for automated data refresh.

### Phase 6 – Documentation & Monitoring SQL
- Detailed ETL documentation and usage guides.
- SQL alerts, monitoring tables, and zero-row load checks.
- Data quality audit tables and automated validation scripts.

---

## Repo Structure Overview

