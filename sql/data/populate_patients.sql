INSERT INTO patients (first_name, last_name, date_of_birth, gender, phone)
SELECT
'Patient' || g,
'Lastname' || g,
DATE '1970-01-01' + (RANDOM()*18000)::INT,
(ARRAY['Male','Female'])[FLOOR(RANDOM()*2)+1],
'070' || LPAD((RANDOM()*9999999)::INT::TEXT, 7, '0')
FROM generate_series(1, 200) g;
