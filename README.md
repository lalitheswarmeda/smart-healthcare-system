# Smart Ambulance Routing System

An intelligent, multi-layered emergency response platform designed to minimize transit times during medical emergencies by connecting ambulances with live traffic predictions, hospital bed availability, and automated entry systems.

## Architecture

This project is a monorepo consisting of:
1. **`backend-spring`**: A Spring Boot (Java 17) REST API powering the core data storage (H2 Database) and hospital business logic.
2. **`ai-python-services`**: A FastAPI (Python) microservice simulating DNN/Gradient Boosting traffic prediction and ANPR script integration.
3. **`frontend-flutter`**: A cross-platform Flutter application providing responsive interfaces for both Paramedics on tablets and Hospital Admins on triaging dashboards.

## Prerequisites

- **Java 17+** and **Maven**
- **Python 3.10+**
- **Flutter SDK 3+**

## How to Run Locally

### 1. Start the Spring Boot Backend
The backend runs on port `8080`.
```bash
cd backend-spring
# On Windows
mvnw.cmd spring-boot:run
# On Mac/Linux
./mvnw spring-boot:run
```
*(The system uses an in-memory H2 database initially, accessible at `http://localhost:8080/h2-console` with user `sa` and password `password`)*

### 2. Start the AI Python Microservice
The Python service runs on port `8000`.
```bash
cd ai-python-services
# Create and activate virtual environment
python -m venv venv
# Windows
.\venv\Scripts\activate
# Mac/Linux
source venv/bin/activate

# Install requirements
pip install fastapi uvicorn pandas scikit-learn opencv-python requests pytest

# Run the FastAPI server
uvicorn main:app --reload
```
View the interactive API docs at: `http://localhost:8000/docs`

### 3. Start the Flutter Frontend
The Flutter app features two views.
```bash
cd frontend_flutter

# Fetch dependencies
flutter pub get

# Run on an emulator, Chrome, or physical device
flutter run
```

---

## Simulated Workflows

- **Driver Navigation**: In the Flutter app, select "Ambulance Tablet Navigation". Clicking "Recalculate AI Route" simulates a request to the Python microservice for route optimization.
- **Hospital Dashboard**: Select "Hospital Triage Dashboard". This view auto-refreshes data connecting to the Spring API to track inbound ambulances heading to `City Central Hospital`.
- **ANPR Simulation**: Use the Python `/docs` to simulate a camera detecting an ambulance plate at the hospital entrance bay.
- **LoRa Telemetry Fallback**: Send mock GPS coordinates to the Python `/telemetry/lora/ingress` endpoint, which automatically proxies the data to the Spring Boot Core Backend.
