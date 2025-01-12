package com.example.Apis;

import org.springframework.data.jpa.repository.JpaRepository;

public interface EstacionadoRepository extends JpaRepository<Estacionados, Long> {
    // Si necesitas consultas personalizadas, puedes agregarlas aquí.
}
