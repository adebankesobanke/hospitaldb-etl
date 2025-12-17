-- Partition Visits table by year
CREATE TABLE partitioned_visits (
    LIKE staging_visits INCLUDING ALL
) PARTITION BY RANGE (EXTRACT(YEAR FROM visit_date));
