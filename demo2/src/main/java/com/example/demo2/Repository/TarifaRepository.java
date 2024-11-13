package com.example.demo2.Repository;


import com.example.demo2.model.Tarifa;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TarifaRepository extends JpaRepository<Tarifa, Integer> {
}
