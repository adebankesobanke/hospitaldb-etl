CREATE OR REPLACE FUNCTION get_top_spending_patients(top_n INT)
RETURNS TABLE(patient_id INT, total_spend NUMERIC) AS $$
BEGIN
    RETURN QUERY
    SELECT
        v.patient_id,
        SUM(b.amount) AS total_spend
    FROM stg_visits v
    JOIN stg_billing b
        ON v.visit_id = b.visit_id
    GROUP BY v.patient_id
    ORDER BY total_spend DESC
    LIMIT top_n;
END;
$$ LANGUAGE plpgsql;
