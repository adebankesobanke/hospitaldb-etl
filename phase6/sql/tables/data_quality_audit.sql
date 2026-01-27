CREATE TABLE IF NOT EXISTS analytics.data_quality_audit (
    audit_id        BIGSERIAL PRIMARY KEY,
    check_name      TEXT NOT NULL,
    table_name      TEXT NOT NULL,
    row_count       BIGINT,
    severity        TEXT CHECK (severity IN ('INFO', 'WARN', 'ERROR')),
    message         TEXT,
    checked_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);