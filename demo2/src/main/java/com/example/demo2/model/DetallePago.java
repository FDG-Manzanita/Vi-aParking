package com.example.demo2.model;

import java.time.LocalDateTime;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "detalle_pago")
public class DetallePago {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idDetalle_pago")
    private Integer idDetallePago;

    @Column(name = "Total", nullable = false)
    private Integer total;

    @Column(name = "descuento")
    private Byte descuento;  // `tinyint` se mapea a `Byte` en Java

    @Column(name = "fecha", columnDefinition = "DATETIME(6)")
    private LocalDateTime fecha;

    // Relación con la tabla Pago
    @ManyToOne
    @JoinColumn(name = "idpagos", referencedColumnName = "idpagos")
    private Pago pago;

    // Getters y Setters
    public Integer getIdDetallePago() {
        return idDetallePago;
    }

    public void setIdDetallePago(Integer idDetallePago) {
        this.idDetallePago = idDetallePago;
    }

    public Integer getTotal() {
        return total;
    }

    public void setTotal(Integer total) {
        this.total = total;
    }

    public Byte getDescuento() {
        return descuento;
    }

    public void setDescuento(Byte descuento) {
        this.descuento = descuento;
    }

    public LocalDateTime getFecha() {
        return fecha;
    }

    public void setFecha(LocalDateTime fecha) {
        this.fecha = fecha;
    }

    public Pago getPago() {
        return pago;
    }

    public void setPago(Pago pago) {
        this.pago = pago;
    }
}
