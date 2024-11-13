package com.example.demo2.Repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.demo2.model.Estacionado;

public interface EstacionadoRepository extends JpaRepository<Estacionado, Integer> {}