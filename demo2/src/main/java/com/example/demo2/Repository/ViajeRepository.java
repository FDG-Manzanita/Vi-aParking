package com.example.demo2.Repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.demo2.model.Viaje;

public interface ViajeRepository extends JpaRepository<Viaje, Integer> {}
