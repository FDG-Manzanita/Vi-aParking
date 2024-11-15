package com.example.demo2.model;

import java.util.Date;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;

@Entity
@Table(name = "pagos")
public class Pago {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idpagos")
    private Integer idpagos;

    @Column(name = "Tiempo_total")
    private Integer tiempoTotal;

    @Column(name = "fecha_inicio")
    @Temporal(TemporalType.DATE)
    private Date fechaInicio;

    // Relación con la tabla Tarifa
    @ManyToOne
    @JoinColumn(name = "idTarifa", referencedColumnName = "idTarifas")
    private Tarifa tarifa;

    // Relación con la tabla Viaje
    @ManyToOne
    @JoinColumn(name = "idviaje", referencedColumnName = "idViajes")
    private Viaje viaje;

    @ManyToOne
    @JoinColumn(name = "id_estacionamientos", referencedColumnName = "Id_Estacionamiento")
    private Estacionamiento estacionamiento;
    // Getters y Setters

    public Integer getIdPago() {
        return idpagos;
    }

    public void setIdPago(Integer idpagos) {
        this.idpagos = idpagos;
    }

    public Integer getTiempoTotal() {
        return tiempoTotal;
    }

    public void setTiempoTotal(Integer tiempoTotal) {
        this.tiempoTotal = tiempoTotal;
    }

    public Date getFechaInicio() {
        return fechaInicio;
    }

    public void setFechaInicio(Date fechaInicio) {
        this.fechaInicio = fechaInicio;
    }

    public Tarifa getTarifa() {
        return tarifa;
    }

    public void setTarifa(Tarifa tarifa) {
        this.tarifa = tarifa;
    }

    public Viaje getViaje() {
        return viaje;
    }

    public void setViaje(Viaje viaje) {
        this.viaje = viaje;
    }
}
