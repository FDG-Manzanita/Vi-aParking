package com.example.demo2.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.example.demo2.Repository.PagoRepository;
import com.example.demo2.model.Pago;
import java.util.List;

@RestController
@RequestMapping("/api/pagos")
public class PagoController {

    @Autowired
    private PagoRepository pagoRepository;

    // Obtener todos los pagos
    @GetMapping
    @CrossOrigin(origins = "*")  // Solo este método permite CORS
    public List<Pago> getAllPagos() {
        return pagoRepository.findAll();
    }

    // Obtener un pago por ID
    @GetMapping("/{id}")
    public Pago getPagoById(@PathVariable Integer id) {
        return pagoRepository.findById(id).orElse(null);
    }

    // Crear un nuevo pago
    @PostMapping
    public Pago createPago(@RequestBody Pago pago) {
        return pagoRepository.save(pago);
    }

    // Actualizar un pago existente
    @PutMapping("/{id}")
    public Pago updatePago(@PathVariable Integer id, @RequestBody Pago pagoDetails) {
        Pago pago = pagoRepository.findById(id).orElse(null);
        if (pago != null) {
            pago.setTiempoTotal(pagoDetails.getTiempoTotal());
            pago.setFechaInicio(pagoDetails.getFechaInicio());
            pago.setTarifa(pagoDetails.getTarifa());
            pago.setViaje(pagoDetails.getViaje());
            return pagoRepository.save(pago);
        }
        return null;
    }

    // Eliminar un pago
    @DeleteMapping("/{id}")
    public void deletePago(@PathVariable Integer id) {
        pagoRepository.deleteById(id);
    }
}
