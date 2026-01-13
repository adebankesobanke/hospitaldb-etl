CREATE OR REPLACE PROCEDURE analytics.refresh_materialized_views()
LANGUAGE plpgsql
AS $$
DECLARE
    view_name TEXT;
BEGIN
    RAISE NOTICE 'Starting materialized view refresh...';

    FOR view_name IN
        SELECT matviewname
        FROM pg_matviews
        WHERE schemaname = 'analytics'
    LOOP
        BEGIN
            EXECUTE format('REFRESH MATERIALIZED VIEW analytics.%I', view_name);

            INSERT INTO analytics.mv_refresh_audit (
                mv_name,
                last_refreshed,
                refresh_status,
                error_message
            )
            VALUES (
                view_name,
                CURRENT_TIMESTAMP,
                'SUCCESS',
                NULL
            )
            ON CONFLICT (mv_name)
            DO UPDATE SET
                last_refreshed = EXCLUDED.last_refreshed,
                refresh_status = 'SUCCESS',
                error_message = NULL;

        EXCEPTION WHEN OTHERS THEN
            INSERT INTO analytics.mv_refresh_audit (
                mv_name,
                last_refreshed,
                refresh_status,
                error_message
            )
            VALUES (
                view_name,
                CURRENT_TIMESTAMP,
                'FAILED',
                SQLERRM
            )
            ON CONFLICT (mv_name)
            DO UPDATE SET
                last_refreshed = EXCLUDED.last_refreshed,
                refresh_status = 'FAILED',
                error_message = SQLERRM;
        END;
    END LOOP;

    RAISE NOTICE 'Materialized views refreshed and audit log updated.';
END;
$$;