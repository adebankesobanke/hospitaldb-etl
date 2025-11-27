CREATE TABLE appointments (
appointment_id SERIAL PRIMARY KEY,
patient_id INT REFERENCES patients(patient_id),
doctor_id INT REFERENCES doctors(doctor_id),
branch_id INT REFERENCES branches(branch_id),
appointment_date TIMESTAMP NOT NULL,
status VARCHAR(20) CHECK (status IN ('Scheduled','Completed','Cancelled'))
);
