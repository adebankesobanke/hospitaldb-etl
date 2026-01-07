Phase 4 – Platform & Orchestration README
# Phase 4 – Platform & Orchestration

## Overview
Phase 4 adds **production-grade orchestration, automation, monitoring, and alerts** to the HospitalDB ETL project.  
It ensures that data flows from raw ingestion → analytics → reporting → dashboards **automatically and reliably**.

This phase contains:

1. **Airflow DAGs** – Schedule and orchestrate ETL steps  
2. **Airflow SQL scripts** – Refresh materialized views, reporting tables, and dashboards  
3. **Notifications** – Email/Slack alerts on DAG failures  
4. **Monitoring** – Task and DAG-level monitoring documentation  
5. **Logs** – Guidance for where logs are stored and how to access them  
6. **CI/CD** – GitHub Actions workflow for automated validation

---

## Folder Structure



phase4/
├── airflow/
│ ├── dags/
│ │ └── hospitaldb_refresh_dag.py # Orchestrates all ETL tasks
│ └── sql/
│ ├── refresh_phase2_materialized_views.sql
│ ├── refresh_phase3_reporting_tables.sql
│ └── refresh_dashboards.sql
├── notifications/
│ └── notify_failure.py # Email / Slack alert scripts
├── monitoring/
│ ├── README.md # Documentation & monitoring guidance
│ └── optional_monitoring_scripts.sql # Optional monitoring queries
└── logs/
├── README.md # Log locations & access instructions
└── .gitkeep # Keeps folder tracked in Git
.github/
└── workflows/
└── hospitaldb_ci.yml # CI/CD workflow


---

## 1. Airflow DAGs

- `hospitaldb_refresh_dag.py` orchestrates the **entire ETL pipeline**:
  1. Refresh Phase 2 materialized views
  2. Refresh Phase 3 reporting tables
  3. Refresh dashboards

- Tasks are sequenced with proper dependencies and retries.

---

## 2. Airflow SQL Scripts

- Stored under `phase4/airflow/sql/`
- Includes:
  - `refresh_phase2_materialized_views.sql`  
  - `refresh_phase3_reporting_tables.sql`  
  - `refresh_dashboards.sql`  

- DAG calls these scripts to refresh tables and dashboards automatically.

---

## 3. Notifications

- **Purpose:** Alert stakeholders immediately if a task fails.
- Implemented using Airflow `on_failure_callback`.
- Supports:
  - **Email alerts** (default)
  - **Slack alerts** (optional)
- Example: `notify_failure.py` contains reusable failure notification logic.

---

## 4. Monitoring

- Airflow UI provides built-in DAG and task monitoring:
  - Execution time
  - Retry counts
  - SLA alerts

- Monitoring folder contains:
  - Optional SQL scripts to track ETL health
  - Documentation on what metrics to monitor

---

## 5. Logs

- Logs are **not stored in Git**, but live in:


$AIRFLOW_HOME/logs/
Postgres server logs

- The `phase4/logs/README.md` documents:
- Locations
- How to access
- How to troubleshoot failures

---

## 6. CI/CD (GitHub Actions)

- **Workflow file:** `.github/workflows/hospitaldb_ci.yml`
- **Purpose:** Automated validation for any push or pull request
- Checks that SQL files exist
- Validates Airflow DAG syntax
- Prevents broken code from entering `main` branch
- Simple and portfolio-ready

---
