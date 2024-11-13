package com.example.demo2.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.example.demo2.Repository.ViajeRepository;
import com.example.demo2.model.Viaje;
import java.util.List;

@RestController
@RequestMapping("/api/viajes")
public class ViajeController {

    @Autowired
    private ViajeRepository viajeRepository;

    // Obtener todos los viajes
    @GetMapping
    @CrossOrigin(origins = "*")  // Permite CORS solo en este método
    public List<Viaje> getAllViajes() {
        return viajeRepository.findAll();
    }

    // Obtener un viaje por su ID
    @GetMapping("/{id}")
    public Viaje getViajeById(@PathVariable Integer id) {
        return viajeRepository.findById(id).orElse(null);
    }

    // Crear un nuevo viaje
    @PostMapping
    public Viaje createViaje(@RequestBody Viaje viaje) {
        return viajeRepository.save(viaje);
    }

    // Actualizar un viaje existente
    @PutMapping("/{id}")
    public Viaje updateViaje(@PathVariable Integer id, @RequestBody Viaje viajeDetails) {
        Viaje viaje = viajeRepository.findById(id).orElse(null);
        if (viaje != null) {
            viaje.setDestino(viajeDetails.getDestino());
            viaje.setOrigen(viajeDetails.getOrigen());
            viaje.setFecha(viajeDetails.getFecha());
            viaje.setEstado(viajeDetails.isEstado());
            viaje.setUsuario(viajeDetails.getUsuario());
            return viajeRepository.save(viaje);
        }
        return null;
    }

    // Eliminar un viaje
    @DeleteMapping("/{id}")
    public void deleteViaje(@PathVariable Integer id) {
        viajeRepository.deleteById(id);
    }
}
