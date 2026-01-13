@echo off
echo Refresh started at %DATE% %TIME% >> C:\Users\user\Desktop\HospitalDBase\logs\mv_refresh.log

"C:\Program Files\PostgreSQL\17\bin\psql.exe" ^
-d hospitaldb ^
-U postgres ^
-c "CALL analytics.refresh_materialized_views();" >> C:\Users\user\Desktop\HospitalDBase\logs\mv_refresh.log 2>&1

echo Refresh finished at %DATE% %TIME% >> C:\Users\user\Desktop\HospitalDBase\logs\mv_refresh.log
