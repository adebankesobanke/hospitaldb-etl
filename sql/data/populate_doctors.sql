INSERT INTO doctors (first_name, last_name, specialization, phone, email)
SELECT
'Doctor' || g,
'Surname' || g,
(ARRAY['Cardiology','Neurology','Oncology','Pediatrics','Orthopedics'])[FLOOR(RANDOM()*5)+1],
'080' || LPAD((RANDOM()*9999999)::INT::TEXT, 7, '0'),
'doctor' || g || '@hospital.com'
FROM generate_series(1, 50) g;
