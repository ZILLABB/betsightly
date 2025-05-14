# Run all tests for the BetSightly project

# Set error action preference
$ErrorActionPreference = "Stop"

# Function to display colored output
function Write-ColorOutput($ForegroundColor) {
    $fc = $host.UI.RawUI.ForegroundColor
    $host.UI.RawUI.ForegroundColor = $ForegroundColor
    if ($args) {
        Write-Output $args
    }
    else {
        $input | Write-Output
    }
    $host.UI.RawUI.ForegroundColor = $fc
}

# Function to run tests with proper error handling
function Run-Tests {
    param (
        [string]$TestType,
        [string]$Command
    )
    
    Write-ColorOutput Green "Running $TestType tests..."
    
    try {
        Invoke-Expression $Command
        if ($LASTEXITCODE -ne 0) {
            Write-ColorOutput Red "$TestType tests failed with exit code $LASTEXITCODE"
            return $false
        }
        Write-ColorOutput Green "$TestType tests passed!"
        return $true
    }
    catch {
        Write-ColorOutput Red "$TestType tests failed with error: $_"
        return $false
    }
}

# Create results directory if it doesn't exist
if (-not (Test-Path -Path "test-results")) {
    New-Item -ItemType Directory -Path "test-results" | Out-Null
}

# Track overall success
$overallSuccess = $true

# Run frontend tests
Write-ColorOutput Cyan "===== Running Frontend Tests ====="
$frontendSuccess = Run-Tests "Frontend" "npm test -- --coverage --watchAll=false --ci --reporters=default --reporters=jest-junit --testResultsProcessor=jest-junit"

if (-not $frontendSuccess) {
    $overallSuccess = $false
}

# Run backend tests
Write-ColorOutput Cyan "===== Running Backend Tests ====="

# Change to backend directory
Push-Location backend

# Run unit tests
$backendUnitSuccess = Run-Tests "Backend Unit" "python -m pytest tests/unit -v --junitxml=../test-results/backend-unit.xml"

if (-not $backendUnitSuccess) {
    $overallSuccess = $false
}

# Run integration tests
$backendIntegrationSuccess = Run-Tests "Backend Integration" "python -m pytest tests/integration -v --junitxml=../test-results/backend-integration.xml"

if (-not $backendIntegrationSuccess) {
    $overallSuccess = $false
}

# Run API tests
$backendApiSuccess = Run-Tests "Backend API" "python -m pytest tests/api -v --junitxml=../test-results/backend-api.xml"

if (-not $backendApiSuccess) {
    $overallSuccess = $false
}

# Return to original directory
Pop-Location

# Display overall result
if ($overallSuccess) {
    Write-ColorOutput Green "===== All tests passed! ====="
}
else {
    Write-ColorOutput Red "===== Some tests failed! ====="
    exit 1
}

# Display test coverage information
Write-ColorOutput Cyan "===== Test Coverage ====="
Write-ColorOutput Yellow "Frontend coverage report is available in coverage/lcov-report/index.html"
Write-ColorOutput Yellow "Backend coverage report is available in backend/.coverage"

# Open coverage reports if requested
$openReports = Read-Host "Do you want to open the coverage reports? (y/n)"
if ($openReports -eq "y") {
    Start-Process "coverage/lcov-report/index.html"
    Push-Location backend
    python -m pytest --cov-report=html
    Start-Process "htmlcov/index.html"
    Pop-Location
}

exit 0
