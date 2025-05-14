@echo off
echo Setting up simplified application...
copy package.simple.json package.json
copy vite.simple.config.ts vite.config.ts
echo Creating simple index.html...
echo ^<!DOCTYPE html^> > index.html
echo ^<html lang="en"^> >> index.html
echo ^<head^> >> index.html
echo   ^<meta charset="UTF-8" /^> >> index.html
echo   ^<meta name="viewport" content="width=device-width, initial-scale=1.0" /^> >> index.html
echo   ^<title^>BetSightly Simple Test^</title^> >> index.html
echo ^</head^> >> index.html
echo ^<body^> >> index.html
echo   ^<div id="root"^>^</div^> >> index.html
echo   ^<script type="module" src="/src/SimpleApp.tsx"^>^</script^> >> index.html
echo ^</body^> >> index.html
echo ^</html^> >> index.html
echo Creating simple main.tsx...
echo import React from 'react' > src\main.tsx
echo import ReactDOM from 'react-dom/client' >> src\main.tsx
echo import SimpleApp from './SimpleApp' >> src\main.tsx
echo import './index.css' >> src\main.tsx
echo. >> src\main.tsx
echo ReactDOM.createRoot(document.getElementById('root')!).render( >> src\main.tsx
echo   ^<React.StrictMode^> >> src\main.tsx
echo     ^<SimpleApp /^> >> src\main.tsx
echo   ^</React.StrictMode^>, >> src\main.tsx
echo ) >> src\main.tsx
echo Creating simple index.css...
echo @tailwind base; > src\index.css
echo @tailwind components; >> src\index.css
echo @tailwind utilities; >> src\index.css
echo. >> src\index.css
echo body { >> src\index.css
echo   margin: 0; >> src\index.css
echo   font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', 'Oxygen', >> src\index.css
echo     'Ubuntu', 'Cantarell', 'Fira Sans', 'Droid Sans', 'Helvetica Neue', >> src\index.css
echo     sans-serif; >> src\index.css
echo   -webkit-font-smoothing: antialiased; >> src\index.css
echo   -moz-osx-font-smoothing: grayscale; >> src\index.css
echo   background-color: #f0f2f5; >> src\index.css
echo } >> src\index.css
echo Creating simple tailwind.config.js...
echo /** @type {import('tailwindcss').Config} */ > tailwind.config.js
echo export default { >> tailwind.config.js
echo   content: [ >> tailwind.config.js
echo     "./index.html", >> tailwind.config.js
echo     "./src/**/*.{js,ts,jsx,tsx}", >> tailwind.config.js
echo   ], >> tailwind.config.js
echo   theme: { >> tailwind.config.js
echo     extend: {}, >> tailwind.config.js
echo   }, >> tailwind.config.js
echo   plugins: [], >> tailwind.config.js
echo } >> tailwind.config.js
echo Creating simple postcss.config.js...
echo export default { > postcss.config.js
echo   plugins: { >> postcss.config.js
echo     tailwindcss: {}, >> postcss.config.js
echo     autoprefixer: {}, >> postcss.config.js
echo   }, >> postcss.config.js
echo } >> postcss.config.js
echo Installing dependencies...
npm install --legacy-peer-deps
echo Starting the application...
npm run dev
