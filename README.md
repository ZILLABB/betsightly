# BetSightly

![BetSightly Logo](https://via.placeholder.com/200x60?text=BetSightly)

BetSightly is a comprehensive sports prediction platform that provides high-quality betting predictions organized by odds categories (2 odds, 5 odds, 10 odds). The platform uses advanced statistical models and AI to generate accurate predictions and offers features like rollover tracking, punter performance analysis, and game code management.

## 🌟 Features

- **Categorized Predictions**: Predictions organized by odds categories (2 odds, 5 odds, 10 odds)
- **Rollover Challenge**: Track 10-day rollover challenges with daily predictions
- **Punter Profiles**: Follow professional punters and their predictions
- **Game Code Management**: Easily copy and manage game codes
- **Performance Statistics**: Comprehensive statistics and visualization
- **Advanced Statistical Models**: Poisson, Dixon-Coles, and ensemble methods
- **Social Media Integration**: Automated collection from Twitter and Telegram
- **Responsive Design**: Mobile-first design with dark/light mode
- **Admin Interface**: Comprehensive management tools and monitoring

## 🚀 Tech Stack

### Frontend

- React with TypeScript
- Tailwind CSS for styling
- Vite as build tool
- Lucide React for icons
- React Router for navigation

### Backend

- Python 3.9+
- FastAPI framework
- PostgreSQL for database
- Redis for caching
- Pandas/NumPy for data processing
- SciPy for statistical models

### DevOps

- Docker and Kubernetes for containerization
- GitHub Actions for CI/CD
- Prometheus and Grafana for monitoring

## 📋 Prerequisites

- Node.js 16+
- Python 3.9+
- Docker and Docker Compose (optional)
- Git

## 🛠️ Installation

### Option 1: Local Development

1. **Clone the repository**

   ```bash
   git clone https://github.com/yourusername/betsightly.git
   cd betsightly
   ```

2. **Frontend Setup**

   ```bash
   npm install
   ```

3. **Backend Setup**

   ```bash
   cd backend
   python -m venv venv
   .\venv\Scripts\activate  # Windows
   # OR
   source venv/bin/activate  # Linux/Mac
   pip install -r requirements.txt
   ```

4. **Start Development Servers**

   ```bash
   # From the project root
   .\dev.bat  # Windows
   # OR
   ./dev.sh   # Linux/Mac
   ```

   This will start both the frontend and backend servers:

   - Frontend: http://localhost:5179
   - Backend: http://localhost:8000
   - API Documentation: http://localhost:8000/docs

### Option 2: Docker Compose

1. **Clone the repository**

   ```bash
   git clone https://github.com/yourusername/betsightly.git
   cd betsightly
   ```

2. **Start with Docker Compose**

   ```bash
   docker-compose up -d
   ```

   This will start all services:

   - Frontend: http://localhost:3000
   - Backend: http://localhost:8000
   - API Documentation: http://localhost:8000/docs
   - Prometheus: http://localhost:9090
   - Grafana: http://localhost:3001 (admin/admin)

## 📚 Documentation

- **API Documentation**: Available at http://localhost:8000/docs when the backend is running
- **Frontend Components**: Documented in the source code
- **Backend Services**: Detailed documentation in the `backend/app/routers/README_*.md` files

## 🧪 Testing

BetSightly has comprehensive test coverage for both frontend and backend components. We use Jest for frontend testing and pytest for backend testing.

### Running All Tests

The easiest way to run all tests is to use the provided test runner script:

```bash
# Windows
.\run_tests.ps1

# Linux/Mac
./run_tests.sh
```

This will run all frontend and backend tests and generate coverage reports.

### Frontend Tests

Frontend tests use Jest and React Testing Library to test components, hooks, and utilities:

```bash
# Run all frontend tests
npm test

# Run tests with coverage
npm test -- --coverage

# Run tests in watch mode during development
npm test -- --watch

# Run a specific test file
npm test -- src/components/common/__tests__/ErrorBoundary.test.tsx
```

### Backend Tests

Backend tests use pytest and are organized into unit, integration, and API tests:

```bash
cd backend

# Run all backend tests
pytest

# Run tests with coverage
pytest --cov=app

# Run specific test categories
pytest tests/unit/
pytest tests/integration/
pytest tests/api/

# Run a specific test file
pytest tests/unit/services/test_base_api_client.py
```

### Test Structure

- **Frontend Tests**: Located in `__tests__` directories alongside the components they test
- **Backend Tests**: Organized in the `backend/tests` directory:
  - `tests/unit/`: Unit tests for individual components
  - `tests/integration/`: Tests for component interactions
  - `tests/api/`: Tests for API endpoints

### Continuous Integration

Tests are automatically run in our CI/CD pipeline on every pull request and push to main branches.

## 🚢 Deployment

The project includes a CI/CD pipeline using GitHub Actions that:

1. Runs tests for both frontend and backend
2. Builds Docker images
3. Deploys to staging (on develop branch) or production (on main branch)

For manual deployment, use the Kubernetes manifests in the `kubernetes/` directory.

## 📊 Monitoring

The project includes Prometheus and Grafana for monitoring:

- **Prometheus**: http://localhost:9090
- **Grafana**: http://localhost:3001 (admin/admin)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 📧 Contact

Project Link: [https://github.com/yourusername/betsightly](https://github.com/yourusername/betsightly)

---

_Last Updated: July 2024_
