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

import com.example.demo2.Repository.EstacionadoRepository;
import com.example.demo2.model.Estacionado;

@RestController
@RequestMapping("/api/estacionados")
@CrossOrigin(origins = "*") // Permitir el acceso desde cualquier origen (CORS)
public class EstacionadoController {

    @Autowired
    private EstacionadoRepository estacionadoRepository;

    // Obtener todos los estacionados
    @GetMapping
    public List<Estacionado> getAllEstacionados() {
        return estacionadoRepository.findAll();
    }

    // Obtener un estacionado por ID
    @GetMapping("/{id}")
    public ResponseEntity<Estacionado> getEstacionadoById(@PathVariable("id") Integer id) {
        Optional<Estacionado> estacionado = estacionadoRepository.findById(id);
        return estacionado
                .map(ResponseEntity::ok)
                .orElseGet(() -> ResponseEntity.status(HttpStatus.NOT_FOUND).build());
    }

    // Obtener estacionados por id de estacionamiento
    @GetMapping("/estacionamiento/{idEstacionamiento}")
    public List<Estacionado> getEstacionadosByEstacionamiento(@PathVariable("idEstacionamiento") Integer idEstacionamiento) {
        return estacionadoRepository.findAll()
                .stream()
                .filter(estacionado -> estacionado.getEstacionamiento().getIdEstacionamiento().equals(idEstacionamiento))
                .toList();
    }

    // Obtener estacionados por id de vehiculo
    @GetMapping("/byVehiculo/{idVehiculo}")
    public List<Estacionado> getEstacionadosByVehiculo(@PathVariable("idVehiculo") Integer idVehiculo) {
        return estacionadoRepository.findAll()
                .stream()
                .filter(estacionado -> estacionado.getVehiculo().getIdVehiculo().equals(idVehiculo))
                .toList();
    }

    // Obtener estacionados por tiempo estacionado mayor a un valor específico
    @GetMapping("/byTiempoEstacionado/{minTiempo}")
    public List<Estacionado> getEstacionadosByTiempoEstacionado(@PathVariable("minTiempo") Integer minTiempo) {
        return estacionadoRepository.findAll()
                .stream()
                .filter(estacionado -> estacionado.getTiempoEstacionado() != null 
                        && estacionado.getTiempoEstacionado() >= minTiempo)
                .toList();
    }

    // Crear un nuevo estacionado
    @PostMapping
    public ResponseEntity<Estacionado> createEstacionado(@RequestBody Estacionado estacionado) {
        Estacionado newEstacionado = estacionadoRepository.save(estacionado);
        return ResponseEntity.status(HttpStatus.CREATED).body(newEstacionado);
    }

    // Actualizar un estacionado existente
    @PutMapping("/{id}")
    public ResponseEntity<Estacionado> updateEstacionado(@PathVariable("id") Integer id,
                                                         @RequestBody Estacionado estacionado) {
        if (!estacionadoRepository.existsById(id)) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }
        estacionado.setIdEstacionados(id);  // Asegura que el ID sea el mismo
        Estacionado updatedEstacionado = estacionadoRepository.save(estacionado);
        return ResponseEntity.ok(updatedEstacionado);
    }

    // Eliminar un estacionado
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteEstacionado(@PathVariable("id") Integer id) {
        if (!estacionadoRepository.existsById(id)) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }
        estacionadoRepository.deleteById(id);
        return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
    }
}