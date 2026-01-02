# Phase 3 – Star Schema Design

## Overview

Phase 3 of the HospitalDB_ETL project focuses on designing a **Star Schema** data warehouse for hospital analytics.  
A Star Schema consists of:

- **Fact Tables:** Contain measurable, quantitative data.  
- **Dimension Tables:** Contain descriptive attributes that provide context to facts.  

This schema allows efficient querying and reporting for hospital operations, billing, and patient care analysis.

---

## Dimension Tables

| Table Name      | Description                     | Key Columns |
|-----------------|---------------------------------|-------------|
| `dim_patient`   | Patient details                 | patient_id, name, gender, DOB, address |
| `dim_doctor`    | Doctor details                  | doctor_id, name, specialty, department |
| `dim_department`| Hospital department details      | department_id, name, location |
| `dim_time`      | Dates for analysis              | date_id, day, month, quarter, year |

---

### **dim_patient**

Stores patient information such as name, gender, date of birth, address, and contact details.

### **dim_doctor**

Stores doctor information, including specialty and department assignment.

### **dim_department**

Stores hospital department details for reporting and grouping.

### **dim_time**

Stores calendar date attributes for time-based analysis (day, month, quarter, year, day of week, is_weekend).

---

## Fact Tables

| Table Name         | Description                           | Measures / Key Columns |
|-------------------|---------------------------------------|-----------------------|
| `fact_visits`      | Records patient visits                | visit_id, patient_id, doctor_id, department_id, visit_date, length_of_stay, diagnosis |
| `fact_billing`     | Stores billing transactions           | billing_id, visit_id, patient_id, billing_date, amount, status |
| `fact_lab_results` | Lab test results per visit            | lab_result_id, visit_id, test_name, result, cost, test_date |
| `fact_medications` | Medications prescribed per visit      | medication_id, visit_id, drug_name, dose, cost, prescription_date |


## Star Schema Diagram

markdown
Copy code
    dim_patient          dim_doctor
         \                  /
          \                /
           \              /
             fact_visits
           /      |       \
          /       |        \
 dim_department  dim_time   fact_billing
                               |
                         fact_lab_results
                               |
                         fact_medications
yaml
Copy code

- **Fact tables** sit at the center and reference dimension tables through foreign keys.  
- **Dimension tables** provide context for analysis, enabling filtering and aggregation.
