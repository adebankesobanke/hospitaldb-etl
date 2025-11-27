-- 1. Total hospital revenue
SELECT SUM(total_amount) AS total_revenue
FROM billings;


-- 2. Revenue by branch
SELECT br.branch_name, SUM(b.total_amount) AS revenue
FROM billings b
JOIN appointments a ON b.appointment_id = a.appointment_id
JOIN branches br ON a.branch_id = br.branch_id
GROUP BY br.branch_name
ORDER BY revenue DESC;


-- 3. Doctor performance by completed appointments
SELECT d.first_name || ' ' || d.last_name AS doctor_name,
COUNT(a.appointment_id) AS completed_appointments
FROM appointments a
JOIN doctors d ON a.doctor_id = d.doctor_id
WHERE a.status = 'Completed'
GROUP BY doctor_name
ORDER BY completed_appointments DESC;


-- 4. Appointment volume per branch
SELECT br.branch_name, COUNT(a.appointment_id) AS total_appointments
FROM appointments a
JOIN branches br ON a.branch_id = br.branch_id
GROUP BY br.branch_name;


-- 5. Daily revenue trend
SELECT billing_date, SUM(total_amount) AS daily_revenue
FROM billings
GROUP BY billing_date
ORDER BY billing_date;
