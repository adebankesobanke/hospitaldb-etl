CREATE OR REPLACE FUNCTION calculate_avg_visit_interval(p_patient_id INT)
RETURNS NUMERIC AS $$
DECLARE
    avg_interval NUMERIC;
BEGIN
    SELECT AVG(EXTRACT(DAY FROM v.visit_date - LAG(v.visit_date) OVER (ORDER BY v.visit_date)))
    INTO avg_interval
    FROM stg_visits v
    WHERE v.patient_id = p_patient_id;

    RETURN COALESCE(avg_interval, 0);
END;
$$ LANGUAGE plpgsql;

