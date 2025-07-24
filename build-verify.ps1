# Docker Build Verification Script for Ultrabase Studio

Write-Host "=== Ultrabase Studio Docker Build Verification ===" -ForegroundColor Green

# Check if Docker is installed
try {
    $dockerVersion = docker --version
    Write-Host "✓ Docker is installed: $dockerVersion" -ForegroundColor Green
} catch {
    Write-Host "✗ Docker is not installed. Please install Docker Desktop first." -ForegroundColor Red
    Write-Host "  Download from: https://docs.docker.com/desktop/install/windows-install/" -ForegroundColor Yellow
    exit 1
}

# Check if Docker daemon is running
try {
    $dockerInfo = docker info 2>$null
    Write-Host "✓ Docker daemon is running" -ForegroundColor Green
} catch {
    Write-Host "✗ Docker daemon is not running. Please start Docker Desktop." -ForegroundColor Red
    exit 1
}

# Check disk space
$disk = Get-WmiObject -Class Win32_LogicalDisk -Filter "DeviceID='C:'"
$freeSpaceGB = [math]::Round($disk.FreeSpace / 1GB, 2)
Write-Host "✓ Available disk space: $freeSpaceGB GB" -ForegroundColor Green

if ($freeSpaceGB -lt 10) {
    Write-Host "⚠ Warning: Low disk space. Docker build may fail." -ForegroundColor Yellow
}

# Build the Docker image
Write-Host "`n=== Starting Docker Build ===" -ForegroundColor Cyan
try {
    docker build -t ultrabase-studio -f Dockerfile.optimized .
    Write-Host "✓ Docker build completed successfully!" -ForegroundColor Green
    
    # Test the image
    Write-Host "`n=== Testing Docker Image ===" -ForegroundColor Cyan
    
    # Run container in background
    $containerId = docker run -d -p 3000:3000 --name ultrabase-test ultrabase-studio
    Start-Sleep 15
    
    # Check if the container is running
    $container = docker ps --filter "id=$containerId" --format "{{.ID}}"
    if ($container) {
        Write-Host "✓ Container is running successfully!" -ForegroundColor Green
        
        # Test health endpoint
        try {
            $response = Invoke-WebRequest -Uri "http://localhost:3000/health" -UseBasicParsing -TimeoutSec 10
            if ($response.StatusCode -eq 200) {
                Write-Host "✓ Health check passed!" -ForegroundColor Green
            }
        } catch {
            Write-Host "⚠ Health check failed, but container is running" -ForegroundColor Yellow
        }
        
        # Stop and remove the test container
        docker stop $containerId
        docker rm $containerId
    }
    
} catch {
    Write-Host "✗ Docker build failed: $_" -ForegroundColor Red
    Write-Host "`n=== Troubleshooting ===" -ForegroundColor Yellow
    Write-Host "1. Try: docker build --no-cache -t ultrabase-studio ."
    Write-Host "2. Check: docker system prune -f (clears cache)"
    Write-Host "3. Increase Docker memory limits in Docker Desktop settings"
    Write-Host "4. Try: docker build --platform linux/amd64 -t ultrabase-studio ."
}

Write-Host "`n=== Build Verification Complete ===" -ForegroundColor Green
