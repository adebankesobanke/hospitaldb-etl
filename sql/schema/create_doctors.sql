CREATE TABLE doctors (
doctor_id SERIAL PRIMARY KEY,
first_name VARCHAR(100) NOT NULL,
last_name VARCHAR(100) NOT NULL,
specialization VARCHAR(150) NOT NULL,
phone VARCHAR(20),
email VARCHAR(150)
);
