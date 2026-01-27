@echo off
setlocal

REM ==============================
REM Set paths
REM ==============================
set PSQL="C:\Program Files\PostgreSQL\17\bin\psql.exe"
set PROJECT_ROOT=C:\Users\user\Desktop\Projects\HospitalDB_ETL
set LOG_DIR=%PROJECT_ROOT%\phase3\logs

REM Ensure logs directory exists
if not exist "%LOG_DIR%" mkdir "%LOG_DIR%"

set LOG_FILE=%LOG_DIR%\incremental_refresh.log

REM ==============================
REM Start logging
REM ==============================
echo --------------------------------------- >> "%LOG_FILE%"
echo Incremental refresh started at %DATE% %TIME% >> "%LOG_FILE%"

REM ==============================
REM Run incremental refresh
REM ==============================
%PSQL% -U postgres -d hospitaldb ^
  -c "CALL analytics.run_incremental_refresh();" >> "%LOG_FILE%" 2>&1

REM ==============================
REM End logging
REM ==============================
echo Incremental refresh finished at %DATE% %TIME% >> "%LOG_FILE%"

endlocal

