package com.example.demo2.controller;

import java.util.List;

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

import com.example.demo2.Repository.VehiculoRepository;
import com.example.demo2.model.Vehiculo;

@RestController
@RequestMapping("/api/vehiculos")
public class VehiculoController {

    @Autowired
    private VehiculoRepository vehiculoRepository;

    // Obtener todos los vehículos
    @GetMapping
    @CrossOrigin(origins = "*")  // Solo este método permite CORS
    public List<Vehiculo> getAllVehiculos() {
        return vehiculoRepository.findAll();
    }

    // Obtener un vehículo por su ID
    @GetMapping("/{id}")
    public ResponseEntity<Vehiculo> getVehiculoById(@PathVariable Integer id) {
        Vehiculo vehiculo = vehiculoRepository.findById(id).orElse(null);
        if (vehiculo != null) {
            return new ResponseEntity<>(vehiculo, HttpStatus.OK);
        }
        return new ResponseEntity<>(HttpStatus.NOT_FOUND); // 404 si no se encuentra el vehículo
    }

    // Crear un nuevo vehículo
    @PostMapping
    @CrossOrigin(origins = "*")
    public ResponseEntity<Vehiculo> createVehiculo(@RequestBody Vehiculo vehiculo) {
        Vehiculo createdVehiculo = vehiculoRepository.save(vehiculo);
        return new ResponseEntity<>(createdVehiculo, HttpStatus.CREATED); // 201 cuando el recurso es creado
    }

    // Actualizar un vehículo
    @PutMapping("/{id}")
    public ResponseEntity<Vehiculo> updateVehiculo(@PathVariable Integer id, @RequestBody Vehiculo vehiculoDetails) {
        Vehiculo vehiculo = vehiculoRepository.findById(id).orElse(null);
        if (vehiculo != null) {
            // Actualiza solo los campos relevantes
            vehiculo.setPatente(vehiculoDetails.getPatente());
            vehiculo.setUsuario(vehiculoDetails.getUsuario());
            Vehiculo updatedVehiculo = vehiculoRepository.save(vehiculo);
            return new ResponseEntity<>(updatedVehiculo, HttpStatus.OK);
        }
        return new ResponseEntity<>(HttpStatus.NOT_FOUND); // 404 si no se encuentra el vehículo
    }

    // Eliminar un vehículo
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteVehiculo(@PathVariable Integer id) {
        if (vehiculoRepository.existsById(id)) {
            vehiculoRepository.deleteById(id);
            return new ResponseEntity<>(HttpStatus.NO_CONTENT); // 204 si se elimina correctamente
        }
        return new ResponseEntity<>(HttpStatus.NOT_FOUND); // 404 si no se encuentra el vehículo
    }
}
