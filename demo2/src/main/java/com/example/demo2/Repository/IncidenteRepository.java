package com.example.demo2.Repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.demo2.model.Incidente;

public interface IncidenteRepository extends JpaRepository<Incidente, Integer> {}
