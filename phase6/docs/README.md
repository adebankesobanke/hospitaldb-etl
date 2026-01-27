# Phase 6 – Data Quality & Validation Layer

## Overview
Phase 6 introduces data quality guardrails to prevent silent failures
in the HospitalDB ETL pipeline.

This phase ensures that incremental loads not only succeed technically
but also produce meaningful data.

## Implemented Checks
- Zero-row load detection (hard failure)
- Low row-count threshold detection (warning)
- Severity-based logging (INFO / WARN / ERROR)
- Centralized data quality audit table

## Why This Matters
Silent data failures are more dangerous than pipeline crashes.
This phase ensures downstream analytics never consume empty or invalid datasets.

## Integration
Phase 6 is executed automatically at the end of Phase 5 incremental refresh
via the `analytics.run_incremental_refresh()` procedure.

## Tables Added
- analytics.data_quality_audit

## Functions Added
- analytics.check_zero_row_loads()
