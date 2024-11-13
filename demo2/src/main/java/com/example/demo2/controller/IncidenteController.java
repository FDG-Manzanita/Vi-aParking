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

import com.example.demo2.Repository.IncidenteRepository;
import com.example.demo2.model.Incidente;

@RestController
@RequestMapping("/api/incidentes")
@CrossOrigin(origins = "*") // Permitir el acceso desde cualquier origen (CORS)
public class IncidenteController {

    @Autowired
    private IncidenteRepository incidenteRepository;

    // Obtener todos los incidentes
    @GetMapping
    public List<Incidente> getAllIncidentes() {
        return incidenteRepository.findAll();
    }

    // Obtener un incidente por ID
    @GetMapping("/{id}")
    public ResponseEntity<Incidente> getIncidenteById(@PathVariable("id") Integer id) {
        Optional<Incidente> incidente = incidenteRepository.findById(id);
        return incidente
                .map(ResponseEntity::ok)
                .orElseGet(() -> ResponseEntity.status(HttpStatus.NOT_FOUND).build());
    }

    // Crear un nuevo incidente
    @PostMapping
    public ResponseEntity<Incidente> createIncidente(@RequestBody Incidente incidente) {
        Incidente newIncidente = incidenteRepository.save(incidente);
        return ResponseEntity.status(HttpStatus.CREATED).body(newIncidente);
    }

    // Actualizar un incidente existente
    @PutMapping("/{id}")
    public ResponseEntity<Incidente> updateIncidente(@PathVariable("id") Integer id, 
                                                     @RequestBody Incidente incidente) {
        if (!incidenteRepository.existsById(id)) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }
        incidente.setIdIncidente(id);  // Asegura que el ID sea el mismo
        Incidente updatedIncidente = incidenteRepository.save(incidente);
        return ResponseEntity.ok(updatedIncidente);
    }

    // Eliminar un incidente
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteIncidente(@PathVariable("id") Integer id) {
        if (!incidenteRepository.existsById(id)) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }
        incidenteRepository.deleteById(id);
        return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
    }
}
