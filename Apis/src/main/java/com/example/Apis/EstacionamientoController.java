package com.example.Apis;

import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/estacionamientos")

public class EstacionamientoController {
    private final EstacionamientoRepository estacionamientoRepository;

    public EstacionamientoController(EstacionamientoRepository estacionamientoRepository) {
        this.estacionamientoRepository = estacionamientoRepository;
    }

    @GetMapping("/all")
    public List<estacionamientos> getAllEstacionamientos() {
        return estacionamientoRepository.findAll();
    }
    
     @PostMapping("/actualizarCupo")
      public ResponseEntity<String> actualizarCupo(@RequestBody Map<String, Object> body) {
        Integer estacionamientoId = (Integer) body.get("estacionamientoId");
        String accion = (String) body.get("accion"); // Puede ser 'restar' o 'agregar'

        // Buscar el estacionamiento por su ID
        Optional<estacionamientos> estacionamientoOpt = estacionamientoRepository.findById(estacionamientoId);
        if (estacionamientoOpt.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Estacionamiento no encontrado");
        }

        estacionamientos estacionamiento = estacionamientoOpt.get();

        if (accion.equals("restar")) {
            if (estacionamiento.getCuposdisponibles() > 0) {
                estacionamiento.setCuposdisponibles(estacionamiento.getCuposdisponibles() - 1);
                estacionamientoRepository.save(estacionamiento);
                return ResponseEntity.ok("Cupo restado correctamente");
            } else {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("No hay cupos disponibles para restar");
            }
        } else if (accion.equals("agregar")) {
            if (estacionamiento.getCuposdisponibles() < estacionamiento.getCupostotales()) {
                estacionamiento.setCuposdisponibles(estacionamiento.getCuposdisponibles() + 1);
                estacionamientoRepository.save(estacionamiento);
                return ResponseEntity.ok("Cupo agregado correctamente");
            } else {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Ya se han utilizado todos los cupos");
            }
        } else {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Acción no válida");
        }
    }
}
