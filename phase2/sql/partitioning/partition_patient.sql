-- Example: Partition Patients table by Year of Birth
CREATE TABLE partitioned_patients (
    LIKE staging_patients INCLUDING ALL
) PARTITION BY RANGE (EXTRACT(YEAR FROM birth_date));

-- Example partitions
CREATE TABLE partitioned_patients_1980s PARTITION OF partitioned_patients
    FOR VALUES FROM (1980) TO (1990);

CREATE TABLE partitioned_patients_1990s PARTITION OF partitioned_patients
    FOR VALUES FROM (1990) TO (2000);
