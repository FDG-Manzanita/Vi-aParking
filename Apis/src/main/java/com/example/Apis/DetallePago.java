package com.example.Apis;

import java.util.Date;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;


@Entity
@Table(name = "detalle_pago")

public class DetallePago {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idDetalle_pago;
    private Integer Total;
    private boolean descuento;
    private Date fecha;
    private Integer idpagos;

    public DetallePago() {
    }
    
    public DetallePago(Integer idDetalle_pago, Integer total, boolean descuento, Date fecha, Integer idpagos) {
        this.idDetalle_pago = idDetalle_pago;
        this.Total = total;
        this.descuento = descuento;
        this.fecha = fecha;
        this.idpagos = idpagos;
    }

    public Integer getIdDetalle_pago() {
        return idDetalle_pago;
    }

    public void setIdDetalle_pago(Integer idDetalle_pago) {
        this.idDetalle_pago = idDetalle_pago;
    }

    
    public Integer getTotal() {
        return Total;
    }
    public void setTotal(Integer total) {
        this.Total = total;
    }
    public boolean isDescuento() {
        return descuento;
    }
    public void setDescuento(boolean descuento) {
        this.descuento = descuento;
    }
    public Date getFecha() {
        return fecha;
    }
    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

   

    public Integer getIdpagos() {
        return idpagos;
    }

    public void setIdpagos(Integer idpagos) {
        this.idpagos = idpagos;
    }

    
}
