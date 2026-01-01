# Run Airflow on Windows (no daemon, no pwd module)

$env:VIRTUAL_ENV = "C:\Users\user\Desktop\Projects\HospitalDB_ETL\airflow_venv"
$env:PATH = "$env:VIRTUAL_ENV\Scripts;" + $env:PATH

$env:AIRFLOW__CORE__LOAD_EXAMPLES = "False"

Start-Process powershell -ArgumentList "-NoExit", "-Command airflow scheduler"

Start-Process powershell -ArgumentList "-NoExit", "-Command airflow webserver --port 8080 --debug"
