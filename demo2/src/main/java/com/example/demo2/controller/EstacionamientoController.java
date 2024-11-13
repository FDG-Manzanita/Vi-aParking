package com.example.demo2.controller;


import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo2.Repository.EstacionamientoRepository;
import com.example.demo2.model.Estacionamiento;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;

@RestController
@RequestMapping("/api/estacionamientos")
@CrossOrigin(origins = "*")  // Permitir CORS para todas las solicitudes
public class EstacionamientoController {

    @Autowired
    private EstacionamientoRepository estacionamientoRepository;

    // Obtener todos los estacionamientos
    @GetMapping
    public List<Estacionamiento> getAllEstacionamientos() {
        return estacionamientoRepository.findAll();
    }
    @PersistenceContext
    private EntityManager entityManager;

    @GetMapping("/sector/{id_sector}")
    public List<Estacionamiento> getEstacionamientosBySector(@PathVariable Integer id_sector) {
        String query = "SELECT e FROM Estacionamiento e WHERE e.sector.id = :id_sector";
        TypedQuery<Estacionamiento> typedQuery = entityManager.createQuery(query, Estacionamiento.class);
        typedQuery.setParameter("id_sector", id_sector);
        return typedQuery.getResultList();
    }
    // Obtener un estacionamiento por ID
    @GetMapping("/{id}")
    public ResponseEntity<Estacionamiento> getEstacionamientoById(@PathVariable("id") Integer id) {
        Optional<Estacionamiento> estacionamiento = estacionamientoRepository.findById(id);
        return estacionamiento
                .map(ResponseEntity::ok)
                .orElseGet(() -> ResponseEntity.status(HttpStatus.NOT_FOUND).build());
    }

    // Crear un nuevo estacionamiento
    @PostMapping
    public ResponseEntity<Estacionamiento> createEstacionamiento(@RequestBody Estacionamiento estacionamiento) {
        Estacionamiento newEstacionamiento = estacionamientoRepository.save(estacionamiento);
        return ResponseEntity.status(HttpStatus.CREATED).body(newEstacionamiento);
    }

    // Actualizar un estacionamiento existente
    @PutMapping("/{id}")
    public ResponseEntity<Estacionamiento> updateEstacionamiento(@PathVariable("id") Integer id, 
                                                                 @RequestBody Estacionamiento estacionamiento) {
        if (!estacionamientoRepository.existsById(id)) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }
        estacionamiento.setIdEstacionamiento(id);
        Estacionamiento updatedEstacionamiento = estacionamientoRepository.save(estacionamiento);
        return ResponseEntity.ok(updatedEstacionamiento);
    }

    // Eliminar un estacionamiento
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteEstacionamiento(@PathVariable("id") Integer id) {
        if (!estacionamientoRepository.existsById(id)) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }
        estacionamientoRepository.deleteById(id);
        return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
    }
}
