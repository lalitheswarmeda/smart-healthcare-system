package com.smartambulance.repository;

import com.smartambulance.entity.Ambulance;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AmbulanceRepository extends JpaRepository<Ambulance, Long> {
}
