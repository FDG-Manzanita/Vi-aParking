package com.example.demo2.controller;

import com.example.demo2.Repository.TarifaRepository;
import com.example.demo2.model.Tarifa;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/tarifas")
public class TarifaController {

    @Autowired
    private TarifaRepository tarifaRepository;

    // Obtener todas las tarifas
    @GetMapping
    @CrossOrigin(origins = "*")  // Solo este método permite CORS
    public List<Tarifa> getAllTarifas() {
        return tarifaRepository.findAll();
    }

    // Obtener una tarifa por su ID
    @GetMapping("/{id}")
    public Tarifa getTarifaById(@PathVariable Integer id) {
        return tarifaRepository.findById(id).orElse(null);
    }

    // Crear una nueva tarifa
    @PostMapping
    public Tarifa createTarifa(@RequestBody Tarifa tarifa) {
        return tarifaRepository.save(tarifa);
    }

    // Actualizar una tarifa existente
    @PutMapping("/{id}")
    public Tarifa updateTarifa(@PathVariable Integer id, @RequestBody Tarifa tarifaDetails) {
        Tarifa tarifa = tarifaRepository.findById(id).orElse(null);
        if (tarifa != null) {
            tarifa.setPrecio(tarifaDetails.getPrecio());
            tarifa.setMinutos(tarifaDetails.getMinutos());
            tarifa.setTipo(tarifaDetails.getTipo());
            tarifa.setEstacionamiento(tarifaDetails.getEstacionamiento());
            tarifa.setSector(tarifaDetails.getSector());
            return tarifaRepository.save(tarifa);
        }
        return null;
    }

    // Eliminar una tarifa
    @DeleteMapping("/{id}")
    public void deleteTarifa(@PathVariable Integer id) {
        tarifaRepository.deleteById(id);
    }
}
