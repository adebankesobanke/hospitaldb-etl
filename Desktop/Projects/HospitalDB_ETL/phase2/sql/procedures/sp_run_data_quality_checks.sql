DROP PROCEDURE IF EXISTS sp_run_data_quality_checks;

CREATE OR REPLACE PROCEDURE sp_run_data_quality_checks()
LANGUAGE plpgsql
AS $$
DECLARE
    invalid_patient_count INTEGER;
    invalid_billing_count INTEGER;
    invalid_visit_dates INTEGER;
BEGIN
    RAISE NOTICE 'Running Data Quality Checks...';

    -- Example DQ Check 1: Null patient IDs in visits
    SELECT COUNT(*) INTO invalid_patient_count
    FROM staging_visits
    WHERE patient_id IS NULL;

    IF invalid_patient_count > 0 THEN
        RAISE WARNING '% records found with NULL patient_id in visits!', invalid_patient_count;
    ELSE
        RAISE NOTICE 'Patient ID Null Check: OK';
    END IF;


    -- Example DQ Check 2: Negative billing amounts
    SELECT COUNT(*) INTO invalid_billing_count
    FROM staging_billing
    WHERE amount < 0;

    IF invalid_billing_count > 0 THEN
        RAISE WARNING '% records found with negative billing amounts!', invalid_billing_count;
    ELSE
        RAISE NOTICE 'Billing Amount Check: OK';
    END IF;


    -- Example DQ Check 3: Invalid visit dates
    SELECT COUNT(*) INTO invalid_visit_dates
    FROM staging_visits
    WHERE visit_date > CURRENT_DATE;

    IF invalid_visit_dates > 0 THEN
        RAISE WARNING '% records found with future visit dates!', invalid_visit_dates;
    ELSE
        RAISE NOTICE 'Visit Date Check: OK';
    END IF;

    RAISE NOTICE 'Data Quality Checks Completed.';
END;
$$;
