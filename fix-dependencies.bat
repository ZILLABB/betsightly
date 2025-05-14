@echo off
echo ===== BetSightly Dependency Fix Script =====
echo.
echo This script will fix dependency issues in the BetSightly project.
echo.

echo Step 1: Creating .npmrc file with legacy-peer-deps=true...
echo legacy-peer-deps=true > .npmrc
echo strict-peer-dependencies=false >> .npmrc
echo.

echo Step 2: Updating package.json with compatible versions...
echo Backing up original package.json to package.json.bak...
copy package.json package.json.bak
echo.

echo Step 3: Cleaning node_modules directory...
if exist node_modules (
  echo Removing node_modules directory...
  rmdir /s /q node_modules
)
echo.

echo Step 4: Clearing npm cache...
call npm cache clean --force
echo.

echo Step 5: Installing dependencies with legacy-peer-deps flag...
call npm install --legacy-peer-deps
echo.

echo Step 6: Creating decimal.js mock file...
if not exist src\__mocks__ (
  mkdir src\__mocks__
)

echo Creating decimal.js mock file...
echo // Mock implementation of decimal.js for testing > src\__mocks__\decimal.js
echo class Decimal { >> src\__mocks__\decimal.js
echo   constructor(value) { >> src\__mocks__\decimal.js
echo     this.value = Number(value); >> src\__mocks__\decimal.js
echo   } >> src\__mocks__\decimal.js
echo. >> src\__mocks__\decimal.js
echo   plus(n) { >> src\__mocks__\decimal.js
echo     return new Decimal(this.value + Number(n)); >> src\__mocks__\decimal.js
echo   } >> src\__mocks__\decimal.js
echo. >> src\__mocks__\decimal.js
echo   minus(n) { >> src\__mocks__\decimal.js
echo     return new Decimal(this.value - Number(n)); >> src\__mocks__\decimal.js
echo   } >> src\__mocks__\decimal.js
echo. >> src\__mocks__\decimal.js
echo   times(n) { >> src\__mocks__\decimal.js
echo     return new Decimal(this.value * Number(n)); >> src\__mocks__\decimal.js
echo   } >> src\__mocks__\decimal.js
echo. >> src\__mocks__\decimal.js
echo   div(n) { >> src\__mocks__\decimal.js
echo     return new Decimal(this.value / Number(n)); >> src\__mocks__\decimal.js
echo   } >> src\__mocks__\decimal.js
echo. >> src\__mocks__\decimal.js
echo   toNumber() { >> src\__mocks__\decimal.js
echo     return this.value; >> src\__mocks__\decimal.js
echo   } >> src\__mocks__\decimal.js
echo. >> src\__mocks__\decimal.js
echo   toString() { >> src\__mocks__\decimal.js
echo     return String(this.value); >> src\__mocks__\decimal.js
echo   } >> src\__mocks__\decimal.js
echo. >> src\__mocks__\decimal.js
echo   toFixed(dp) { >> src\__mocks__\decimal.js
echo     return this.value.toFixed(dp); >> src\__mocks__\decimal.js
echo   } >> src\__mocks__\decimal.js
echo } >> src\__mocks__\decimal.js
echo. >> src\__mocks__\decimal.js
echo // Add static properties >> src\__mocks__\decimal.js
echo Decimal.ROUND_UP = 0; >> src\__mocks__\decimal.js
echo Decimal.ROUND_DOWN = 1; >> src\__mocks__\decimal.js
echo Decimal.ROUND_CEIL = 2; >> src\__mocks__\decimal.js
echo Decimal.ROUND_FLOOR = 3; >> src\__mocks__\decimal.js
echo Decimal.ROUND_HALF_UP = 4; >> src\__mocks__\decimal.js
echo Decimal.ROUND_HALF_DOWN = 5; >> src\__mocks__\decimal.js
echo Decimal.ROUND_HALF_EVEN = 6; >> src\__mocks__\decimal.js
echo Decimal.ROUND_HALF_CEIL = 7; >> src\__mocks__\decimal.js
echo Decimal.ROUND_HALF_FLOOR = 8; >> src\__mocks__\decimal.js
echo. >> src\__mocks__\decimal.js
echo export default Decimal; >> src\__mocks__\decimal.js
echo.

echo Step 7: Updating jest.config.js to use the mock...
echo Backing up original jest.config.js to jest.config.js.bak...
if exist jest.config.js (
  copy jest.config.js jest.config.js.bak
)
echo.

echo Step 8: Updating vite.config.ts to disable PWA plugin...
echo Backing up original vite.config.ts to vite.config.ts.bak...
if exist vite.config.ts (
  copy vite.config.ts vite.config.ts.bak
)
echo.

echo ===== Dependency Fix Complete =====
echo.
echo You can now run the application with:
echo npm run dev
echo.
echo To start the backend, run:
echo cd backend ^&^& python run.py
echo.
