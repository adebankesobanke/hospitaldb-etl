CREATE TABLE billings (
billing_id SERIAL PRIMARY KEY,
appointment_id INT REFERENCES appointments(appointment_id),
total_amount NUMERIC(10,2) NOT NULL,
payment_status VARCHAR(20) CHECK (payment_status IN ('Paid','Pending')),
billing_date DATE NOT NULL
);
