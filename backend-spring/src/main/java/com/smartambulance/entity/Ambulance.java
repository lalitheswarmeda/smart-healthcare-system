package com.smartambulance.entity;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Data
public class Ambulance {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String plateNumber;
    private String status; // e.g., AVAILABLE, EN_ROUTE, AT_HOSPITAL

    private Double currentLat;
    private Double currentLng;
}
