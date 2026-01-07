# Quick Start Script
# Run this to start the entire project

Write-Host "==================================" -ForegroundColor Cyan
Write-Host "Retail Data Warehouse - Quick Start" -ForegroundColor Cyan
Write-Host "==================================" -ForegroundColor Cyan
Write-Host ""

# Check if Docker is running
Write-Host "Checking Docker..." -ForegroundColor Yellow
docker info > $null 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: Docker is not running. Please start Docker Desktop first." -ForegroundColor Red
    exit 1
}
Write-Host "✓ Docker is running" -ForegroundColor Green
Write-Host ""

# Start services
Write-Host "Starting all services..." -ForegroundColor Yellow
docker-compose up -d

if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Services started successfully" -ForegroundColor Green
    Write-Host ""
    
    Write-Host "Waiting for services to initialize (60 seconds)..." -ForegroundColor Yellow
    Start-Sleep -Seconds 60
    
    Write-Host ""
    Write-Host "==================================" -ForegroundColor Cyan
    Write-Host "Service URLs:" -ForegroundColor Cyan
    Write-Host "==================================" -ForegroundColor Cyan
    Write-Host "Airflow UI:  http://localhost:8081" -ForegroundColor White
    Write-Host "  Username:  admin" -ForegroundColor Gray
    Write-Host "  Password:  admin" -ForegroundColor Gray
    Write-Host ""
    Write-Host "Trino UI:    http://localhost:8080" -ForegroundColor White
    Write-Host ""
    Write-Host "MySQL:       localhost:3306" -ForegroundColor White
    Write-Host "  Database:  retail_db" -ForegroundColor Gray
    Write-Host "  Username:  dbt_user" -ForegroundColor Gray
    Write-Host "  Password:  dbt_password" -ForegroundColor Gray
    Write-Host ""
    
    Write-Host "==================================" -ForegroundColor Cyan
    Write-Host "Next Steps:" -ForegroundColor Cyan
    Write-Host "==================================" -ForegroundColor Cyan
    Write-Host "1. Open Airflow UI: http://localhost:8081" -ForegroundColor White
    Write-Host "2. Enable the 'retail_dw_etl' DAG" -ForegroundColor White
    Write-Host "3. Trigger the DAG manually" -ForegroundColor White
    Write-Host "4. Monitor the pipeline execution" -ForegroundColor White
    Write-Host ""
    
    Write-Host "Check service status:" -ForegroundColor Yellow
    docker-compose ps
} else {
    Write-Host "ERROR: Failed to start services" -ForegroundColor Red
    Write-Host "Check logs with: docker-compose logs" -ForegroundColor Yellow
    exit 1
}

