CREATE TABLE IF NOT EXISTS raw_doctors (
    doctor_id       INT PRIMARY KEY,
    first_name      VARCHAR(100),
    last_name       VARCHAR(100),
    specialization  VARCHAR(100),
    phone           VARCHAR(20),
    email           VARCHAR(150),
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
