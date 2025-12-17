CREATE TABLE IF NOT EXISTS raw_appointments (
    appointment_id   INT PRIMARY KEY,
    patient_id       INT,
    doctor_id        INT,
    appointment_date TIMESTAMP,
    reason           VARCHAR(255),
    status           VARCHAR(50),
    created_at       TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
