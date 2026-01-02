CREATE TABLE IF NOT EXISTS raw.patients_raw (
    patient_id        INT PRIMARY KEY,
    first_name        VARCHAR(100),
    last_name         VARCHAR(100),
    gender            VARCHAR(10),
    date_of_birth     DATE,
    phone             VARCHAR(20),
    email             VARCHAR(150),
    address           VARCHAR(255),
    branch_id         INT,
    FOREIGN KEY (branch_id) REFERENCES raw.branches_raw(branch_id),
    created_at        TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
