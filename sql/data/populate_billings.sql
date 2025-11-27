INSERT INTO billings (appointment_id, total_amount, payment_status, billing_date)
SELECT
g,
ROUND(RANDOM()*50000, 2),
(ARRAY['Paid','Pending'])[FLOOR(RANDOM()*2)+1],
CURRENT_DATE - (RANDOM()*365)::INT
FROM generate_series(1, 500) g;
