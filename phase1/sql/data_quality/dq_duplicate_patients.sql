-- PURPOSE: Detect potential duplicate patient records using name + date of birth + phone.
--          This helps identify data integrity issues in the patients table.

WITH duplicates AS (
    SELECT 
        full_name,
        date_of_birth,
        phone,
        COUNT(*) AS count_duplicates
    FROM raw_patients
    GROUP BY full_name, date_of_birth, phone
    HAVING COUNT(*) > 1
)
SELECT * FROM duplicates;
