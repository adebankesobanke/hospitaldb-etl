# HospitalDB: Healthcare Data Analytics & ETL Pipeline

A PostgreSQL-based **healthcare data analytics and ETL project** simulating a hospital database workflow. The project ingests raw hospital data, cleans and transforms it, performs data quality checks, and prepares reliable datasets for analysis and reporting.

The project demonstrates the connection between **data engineering and data analytics** by taking data from its raw form through transformation and validation to analysis-ready datasets.

---

## Project Overview

The project covers the end-to-end processing of hospital data:

* **Data Ingestion:** Load raw CSV files into staging tables.
* **Data Transformation:** Clean and transform data using SQL and Python.
* **Data Quality:** Check data for missing values, duplicates, referential integrity, and business-rule violations.
* **Incremental Processing:** Process newly added or updated records without repeatedly reprocessing the entire dataset.
* **Performance Optimization:** Use indexes and materialized views to improve query performance.
* **Analytics & Reporting:** Prepare structured datasets and SQL queries for healthcare and operational analysis.
* **Automation:** Schedule ETL workflows using Windows Task Scheduler.

---

## Project Objectives

The project was designed to answer two important questions:

### 1. Can raw hospital data be transformed into reliable, analysis-ready data?

The ETL pipeline performs data ingestion, cleaning, transformation, validation, and loading into structured PostgreSQL tables.

### 2. Can the resulting data support meaningful analysis?

The curated data can be used to analyze healthcare and operational metrics such as:

* Patient admissions
* Patient activity
* Treatment costs
* Hospital revenue
* Branch-level performance
* Readmission patterns
* Other operational KPIs

---

# Project Phases

## Phase 1 – Raw Data & Initial Load

Raw CSV files contain data relating to:

* Patients
* Doctors
* Appointments
* Treatments
* Visits
* Billings
* Hospital branches

SQL loaders are used to ingest the raw data into staging tables.

Initial data quality checks include:

* Missing values
* Duplicate records
* Referential integrity
* Invalid values
* Business-rule violations

---

## Phase 2 – Data Transformation & Optimization

The staging data is transformed and prepared for analytical use.

Key activities include:

* Data cleaning
* Data type standardization
* Business-rule transformations
* SQL-based transformations
* Database indexing
* Query optimization
* Materialized views for frequently accessed analytical queries

---

## Phase 3 – Incremental Processing

The pipeline supports incremental processing so that new or updated records can be processed without unnecessarily reprocessing historical data.

Key components include:

* Incremental ETL scripts
* Watermark-based processing
* Batch refresh workflows
* Incremental data tracking
* Pipeline logging

This approach improves processing efficiency and demonstrates an understanding of how production data pipelines handle continuously changing datasets.

---

## Phase 4 – Automation & Scheduling

ETL workflows are automated using **Python and Windows Task Scheduler**.

The automated workflow supports:

* Data extraction
* Transformation
* Loading
* Data quality checks
* Incremental processing
* Logging

---

## Phase 5 – Analytics & Reporting

The curated hospital data can be used to generate analytical insights and operational reports.

Examples of analytical questions include:

* How many patients were admitted over a given period?
* Which hospital branches have the highest patient volume?
* What are the trends in hospital revenue?
* What are the average treatment costs?
* How do patient outcomes vary across branches?
* What patterns can be observed in readmissions?

SQL queries, analytical views, and aggregated datasets support these analyses.

---

## Phase 6 – Monitoring & Data Quality

The project includes monitoring and validation processes designed to identify data and pipeline issues.

Examples include:

* Data quality audit tables
* Missing-data checks
* Duplicate checks
* Referential integrity checks
* Zero-row load checks
* Pipeline logging
* SQL-based monitoring queries
* Error detection

These checks help ensure that downstream analysis is based on reliable data.

---

# Data Flow

```text
Raw CSV Files
      ↓
Staging Tables
      ↓
Data Cleaning & Transformation
      ↓
Data Quality Checks
      ↓
Curated PostgreSQL Tables
      ↓
Analytical Queries / Views
      ↓
Reports & Insights
```

---

# SQL & Data Analysis

SQL is used throughout the project for both data engineering and analytical tasks.

Techniques include:

* JOINs
* GROUP BY
* Common Table Expressions (CTEs)
* Window Functions
* Aggregations
* Subqueries
* Analytical Views
* Data Validation Queries
* KPI Calculations

These techniques support both **data preparation and analytical reporting**.

---

# Performance Optimization

PostgreSQL optimization techniques were implemented to improve query performance.

### Indexing

Indexes were created on frequently queried columns to reduce query execution time.

### Materialized Views

Materialized views were used for frequently accessed aggregated results, reducing the need to repeatedly perform expensive calculations.

### Partitioning

Where applicable, large datasets can be partitioned using appropriate date-based fields to improve data management and query performance.

---

# Technologies Used

Technology                   | Purpose                                
 -------------------------- | --------------------------------------- 
 **PostgreSQL**             | Database, storage and SQL analytics    
 **SQL**                    | Transformation, validation and analysis 
 **Python**                 | ETL processing and automation           
 **Pandas**                 | Data cleaning and transformation        
 **Windows Task Scheduler** | ETL scheduling                         |
 **Git/GitHub**             | Version control                         

---

# Key Skills Demonstrated

### Data Analytics

* SQL analysis
* KPI development
* Data aggregation
* Data interpretation
* Healthcare reporting
* Data quality analysis

### Data Engineering

* ETL pipeline development
* Incremental processing
* Data cleaning and transformation
* Data validation
* Data modeling
* Pipeline automation

### Database

* PostgreSQL
* Indexing
* Materialized views
* Query optimization
* Relational data modeling

---

# Key Learning Outcomes

This project strengthened my practical understanding of how data moves from **raw operational records to reliable analytical datasets**.

Key areas include:

* Relational database design
* SQL-based analysis
* ETL development
* Data cleaning
* Data quality and validation
* Incremental data processing
* Watermark-based processing
* Query optimization
* Analytical reporting
* Pipeline automation

The project also demonstrated how **data engineering and data analytics work together**: reliable data pipelines provide the foundation for accurate analysis and reporting.

---

# Future Improvements

Potential future enhancements include:

* Additional automated data quality checks
* More advanced Power BI dashboards
* Pipeline monitoring and alerting
* Cloud deployment
* Automated orchestration
* Data lineage tracking
* Integration with real-time data sources

---

## Author

**Adebanke Sobanke**

**Data Analyst | SQL | Python | Power BI | Data Engineering**

GitHub: [github.com/adebankesobanke](https://github.com/adebankesobanke)
