package com.example.Apis;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface EstacionamientoRepository extends JpaRepository<estacionamientos, Integer> {

    //Optional<estacionamientos> findById(Integer Id_Estacionamiento);
}
