CREATE TABLE patients (
patient_id SERIAL PRIMARY KEY,
first_name VARCHAR(100) NOT NULL,
last_name VARCHAR(100) NOT NULL,
date_of_birth DATE,
gender VARCHAR(10),
phone VARCHAR(20)
);
