from fastapi import FastAPI, BackgroundTasks
from pydantic import BaseModel
import random
import time
import requests

app = FastAPI(title="AI Traffic & Routing Microservice")

# Data Models
class RouteRequest(BaseModel):
    ambulance_id: str
    start_lat: float
    start_lng: float
    end_lat: float
    end_lng: float

class LoraTelemetry(BaseModel):
    ambulance_id: int
    lat: float
    lng: float

# --- 1. DNN / Gradient Boosting Placeholder ---
@app.post("/predict_route")
def predict_fastest_route(req: RouteRequest):
    """
    Analyzes historical and live traffic data to predict congestion 
    and calculate the absolute fastest route.
    Using dummy Gradient Boosting logic.
    """
    # Simulate model inference delay
    time.sleep(0.5) 
    
    # Generate mock eta
    base_eta_mins = random.randint(5, 20)
    traffic_multiplier = random.uniform(1.0, 1.5)
    adjusted_eta = int(base_eta_mins * traffic_multiplier)
    
    return {
        "status": "success",
        "predicted_eta_mins": adjusted_eta,
        "route_points": [
            {"lat": req.start_lat, "lng": req.start_lng},
            {"lat": (req.start_lat + req.end_lat)/2, "lng": (req.start_lng + req.end_lng)/2},
            {"lat": req.end_lat, "lng": req.end_lng}
        ],
        "congestion_level": "High" if traffic_multiplier > 1.3 else "Low"
    }

# --- 2. ANPR Camera Simulation ---
@app.post("/anpr/simulate")
def simulate_anpr_detection(plate_number: str, hospital_id: int):
    """
    Simulates Automatic Number Plate Recognition (ANPR) script 
    to detect ambulance plates and open emergency bay barriers.
    """
    # In a real scenario, this would trigger an IoT relay to open barriers
    success = random.choice([True, True, True, False]) # High probability of success
    
    if success:
        return {"plate": plate_number, "hospital_id": hospital_id, "barrier_status": "OPEN", "message": "Authorized Ambulance Detected"}
    else:
        return {"plate": plate_number, "hospital_id": hospital_id, "barrier_status": "CLOSED", "message": "Recognition Failed"}

# --- 3. LoRa Telemetry Ingress ---
SPRING_BOOT_URL = "http://localhost:8080/api/telemetry/lora"

@app.post("/telemetry/lora/ingress")
def lora_ingress(telemetry: LoraTelemetry, background_tasks: BackgroundTasks):
    """
    Ingest GPS data via a LoRa network gateway (fallback for cellular dead zones).
    Forwards this to the Core Backend (Spring Boot).
    """
    def forward_to_backend(data: LoraTelemetry):
        try:
            # Note: We send ambulanceId since Spring Boot expects it
            payload = {"ambulanceId": data.ambulance_id, "lat": data.lat, "lng": data.lng}
            requests.post(SPRING_BOOT_URL, json=payload, timeout=2)
        except Exception as e:
            print(f"Failed to forward telemetry to core backend: {e}")

    background_tasks.add_task(forward_to_backend, telemetry)
    return {"status": "received", "forwarded": True}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
