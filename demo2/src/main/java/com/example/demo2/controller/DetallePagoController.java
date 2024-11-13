package com.example.demo2.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.example.demo2.Repository.DetallePagoRepository;
import com.example.demo2.model.DetallePago;

@RestController
@RequestMapping("/api/detalle-pagos")
@CrossOrigin(origins = "*") // Permite el acceso desde cualquier origen (CORS)
public class DetallePagoController {

    @Autowired
    private DetallePagoRepository detallePagoRepository;

    // Obtener todos los detalles de pago
    @GetMapping
    public List<DetallePago> getAllDetallePagos() {
        return detallePagoRepository.findAll();
    }

    // Obtener un detalle de pago por ID
    @GetMapping("/{id}")
    public DetallePago getDetallePagoById(@PathVariable Integer id) {
        return detallePagoRepository.findById(id).orElse(null);
    }

    // Crear un nuevo detalle de pago
    @PostMapping
    public DetallePago createDetallePago(@RequestBody DetallePago detallePago) {
        return detallePagoRepository.save(detallePago);
    }

    // Actualizar un detalle de pago existente
    @PutMapping("/{id}")
    public DetallePago updateDetallePago(@PathVariable Integer id, @RequestBody DetallePago detallePagoDetails) {
        DetallePago detallePago = detallePagoRepository.findById(id).orElse(null);
        if (detallePago != null) {
            detallePago.setTotal(detallePagoDetails.getTotal());
            detallePago.setDescuento(detallePagoDetails.getDescuento());
            detallePago.setFecha(detallePagoDetails.getFecha());
            detallePago.setPago(detallePagoDetails.getPago());
            return detallePagoRepository.save(detallePago);
        }
        return null;
    }

    // Eliminar un detalle de pago
    @DeleteMapping("/{id}")
    public void deleteDetallePago(@PathVariable Integer id) {
        detallePagoRepository.deleteById(id);
    }
}
