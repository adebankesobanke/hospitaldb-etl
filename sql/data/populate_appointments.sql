INSERT INTO appointments (patient_id, doctor_id, branch_id, appointment_date, status)
SELECT
FLOOR(RANDOM()*200)+1,
FLOOR(RANDOM()*50)+1,
FLOOR(RANDOM()*10)+1,
NOW() - (RANDOM()*365)::INT * INTERVAL '1 day',
(ARRAY['Scheduled','Completed','Cancelled'])[FLOOR(RANDOM()*3)+1]
FROM generate_series(1, 500);
