package com.smartambulance.controller;

import com.smartambulance.entity.ActiveEmergency;
import com.smartambulance.entity.Ambulance;
import com.smartambulance.entity.Hospital;
import com.smartambulance.repository.ActiveEmergencyRepository;
import com.smartambulance.repository.AmbulanceRepository;
import com.smartambulance.repository.HospitalRepository;
import org.springframework.web.bind.annotation.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api")
@CrossOrigin(origins = "*") // Allow Flutter app to connect
public class SystemController {

    @Autowired
    private HospitalRepository hospitalRepo;

    @Autowired
    private AmbulanceRepository ambulanceRepo;

    @Autowired
    private ActiveEmergencyRepository emergencyRepo;

    // 1. Endpoint for updating bed counts
    @PutMapping("/hospitals/{id}/beds")
    public ResponseEntity<Hospital> updateBedCounts(@PathVariable Long id, @RequestBody Map<String, Integer> bedUpdate) {
        return hospitalRepo.findById(id).map(hospital -> {
            if(bedUpdate.containsKey("availableIcuBeds")) {
                hospital.setAvailableIcuBeds(bedUpdate.get("availableIcuBeds"));
            }
            if(bedUpdate.containsKey("availableWardBeds")) {
                hospital.setAvailableWardBeds(bedUpdate.get("availableWardBeds"));
            }
            return ResponseEntity.ok(hospitalRepo.save(hospital));
        }).orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/hospitals")
    public List<Hospital> getHospitals() {
        return hospitalRepo.findAll();
    }

    // 2. Endpoint for LoRa telemetry coords (simulate update)
    @PostMapping("/telemetry/lora")
    public ResponseEntity<Ambulance> updateTelemetry(@RequestBody Map<String, Object> payload) {
        Long ambulanceId = Long.valueOf(payload.get("ambulanceId").toString());
        Double lat = Double.valueOf(payload.get("lat").toString());
        Double lng = Double.valueOf(payload.get("lng").toString());

        return ambulanceRepo.findById(ambulanceId).map(amb -> {
            amb.setCurrentLat(lat);
            amb.setCurrentLng(lng);
            return ResponseEntity.ok(ambulanceRepo.save(amb));
        }).orElse(ResponseEntity.notFound().build());
    }

    // 3. Pushing alerts to hospital dashboard
    @GetMapping("/hospitals/{id}/alerts")
    public List<ActiveEmergency> getHospitalAlerts(@PathVariable Long id) {
        // Simple polling endpoint for dashboard to fetch active emergencies heading to this hospital
        return emergencyRepo.findByTargetHospitalIdAndStatus(id, "IN_TRANSIT");
    }

    @PostMapping("/emergencies")
    public ActiveEmergency createEmergency(@RequestBody ActiveEmergency emergency) {
        emergency.setStatus("IN_TRANSIT");
        return emergencyRepo.save(emergency);
    }
}
