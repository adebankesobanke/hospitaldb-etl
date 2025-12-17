-- Partition Billing table by year
CREATE TABLE partitioned_billing (
    LIKE staging_billing INCLUDING ALL
) PARTITION BY RANGE (EXTRACT(YEAR FROM billing_date));
