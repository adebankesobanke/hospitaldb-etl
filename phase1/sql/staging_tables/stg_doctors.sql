CREATE TABLE IF NOT EXISTS stg_doctors AS
SELECT
    doctor_id,
    INITCAP(first_name) AS first_name,
    INITCAP(last_name) AS last_name,
    INITCAP(specialization) AS specialization,
    REGEXP_REPLACE(phone, '[^0-9]', '') AS phone,
    LOWER(email) AS email,
    created_at
FROM raw_doctors;
