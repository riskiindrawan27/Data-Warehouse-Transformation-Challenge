# Stop Script
# Run this to stop all services

Write-Host "==================================" -ForegroundColor Cyan
Write-Host "Stopping all services..." -ForegroundColor Cyan
Write-Host "==================================" -ForegroundColor Cyan
Write-Host ""

docker-compose down

if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ All services stopped successfully" -ForegroundColor Green
    Write-Host ""
    Write-Host "To start again, run: .\start.ps1" -ForegroundColor Yellow
    Write-Host "To remove all data, run: docker-compose down -v" -ForegroundColor Yellow
} else {
    Write-Host "ERROR: Failed to stop services" -ForegroundColor Red
    exit 1
}
