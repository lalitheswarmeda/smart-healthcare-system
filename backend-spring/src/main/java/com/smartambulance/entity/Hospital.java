package com.smartambulance.entity;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Data
public class Hospital {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;
    private Double locationLat;
    private Double locationLng;

    private Integer totalIcuBeds;
    private Integer availableIcuBeds;
    private Integer totalWardBeds;
    private Integer availableWardBeds;
}
