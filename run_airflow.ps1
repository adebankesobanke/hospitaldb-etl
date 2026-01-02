# Run Airflow (Windows-friendly script)

$env:AIRFLOW__CORE__LOAD_EXAMPLES = "False"

$venvPath = ".\airflow_venv\Scripts\Activate.ps1"
if (Test-Path $venvPath) {
    Write-Host "Activating virtual environment..."
    & $venvPath
} else {
    Write-Host "Virtual environment not found! Please create it first."
    exit
}

Write-Host "Initializing Airflow database..."
airflow db init

Write-Host "Creating Airflow admin user..."
airflow users create --username admin --firstname Admin --lastname User --role Admin --email adebankesobanke@gmail.com --password Ashakeade@1974

Write-Host "Starting Airflow webserver..."
Start-Process powershell -ArgumentList "airflow webserver --port 8080" -NoNewWindow

Write-Host "Starting Airflow scheduler..."
Start-Process powershell -ArgumentList "airflow scheduler" -NoNewWindow

Write-Host "Airflow is running at http://localhost:8080"

