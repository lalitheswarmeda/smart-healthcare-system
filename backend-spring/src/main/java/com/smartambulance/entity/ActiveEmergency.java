package com.smartambulance.entity;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDateTime;

@Entity
@Data
public class ActiveEmergency {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "ambulance_id")
    private Ambulance ambulance;

    @ManyToOne
    @JoinColumn(name = "target_hospital_id")
    private Hospital targetHospital;

    private String patientVitals; // Can be JSON string or simple text for now
    private Integer estimatedArrivalTimeMins;
    private String status; // e.g., ASSIGNED, IN_TRANSIT, COMPLETED
    
    private LocalDateTime dispatchTime;
}
