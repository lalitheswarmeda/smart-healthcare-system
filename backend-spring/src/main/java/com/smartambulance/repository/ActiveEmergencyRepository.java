package com.smartambulance.repository;

import com.smartambulance.entity.ActiveEmergency;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ActiveEmergencyRepository extends JpaRepository<ActiveEmergency, Long> {
    List<ActiveEmergency> findByTargetHospitalIdAndStatus(Long hospitalId, String status);
}
