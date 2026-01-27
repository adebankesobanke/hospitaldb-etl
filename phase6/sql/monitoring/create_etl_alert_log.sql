CREATE TABLE IF NOT EXISTS analytics.etl_alert_log (
    alert_id SERIAL PRIMARY KEY,
    alert_type TEXT NOT NULL,
    object_name TEXT NOT NULL,
    detected_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    details TEXT
);