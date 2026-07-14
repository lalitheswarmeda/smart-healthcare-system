MedQueuePro: Advanced Multi-Layered Hospital Token Tracking & Appointment Aggregator
MedQueuePro is a state-of-the-art, multi-layered web application built with a React + TypeScript (Vite) frontend, a Java 17 + Spring Boot backend, and PostgreSQL / H2 database support. It mirrors a modern aggregator platform (like DoorDash or Zomato):

Hospitals act as the accredited vendor facilities.
Specializations & Doctors act as the menu items categorized cleanly under wings (Cardiology, Pediatrics, Neurology, etc.).
Live Tokens & Appointments act as orders being tracked in real time from #4 Booked -> #2 Checked In -> #1 Serving Now inside cabin -> Completed.

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

▸   Architected a multi-tenant healthcare aggregator utilizing PostGIS spatial queries, enabling seamless location-based hospital discovery and doctor booking for non-local patients.
▸   Engineered a low-latency live token-tracking engine with WebSockets and Redis, broadcasting real-time queue updates and dynamic ETA calculations to clients without heavy HTTP polling.
▸   Designed a secure, normalized PostgreSQL schema with strict facility indexing to isolate concurrent hospital data and ensure data integrity across the multi-layered REST API gateway.
▸   Streamlined outpatient management by bridging hospital reception portals directly with patient devices, effectively reducing physical waiting room congestion and appointment bottlenecks.
