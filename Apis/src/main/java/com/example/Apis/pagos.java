package com.example.Apis;

import java.time.LocalDate;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
@Entity
public class pagos {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idpagos;
    private Integer Tiempo_total;
    private LocalDate fecha_inicio;
    private Integer idTarifa;
    private Integer idViaje;
    
    public pagos() {
    }

    public pagos(Integer idpagos, Integer tiempo_total, LocalDate fecha_inicio, Integer idTarifa, Integer idViaje) {
        this.idpagos = idpagos;
        this.Tiempo_total = tiempo_total;
        this.fecha_inicio = fecha_inicio;
        this.idTarifa = idTarifa;
        this.idViaje = idViaje;
    }

    public Integer getIdpagos() {
        return idpagos;
    }

    public void setIdpagos(Integer idpagos) {
        this.idpagos = idpagos;
    }

    public Integer getTiempo_total() {
        return Tiempo_total;
    }

    public void setTiempo_total(Integer tiempo_total) {
        Tiempo_total = tiempo_total;
    }

    public LocalDate getFecha_inicio() {
        return fecha_inicio;
    }

    public void setFecha_inicio(LocalDate fecha_inicio) {
        this.fecha_inicio = fecha_inicio;
    }

    public Integer getIdTarifa() {
        return idTarifa;
    }

    public void setIdTarifa(Integer idTarifa) {
        this.idTarifa = idTarifa;
    }

    public Integer getIdViaje() {
        return idViaje;
    }

    public void setIdViaje(Integer idViaje) {
        this.idViaje = idViaje;
    }

    
}

