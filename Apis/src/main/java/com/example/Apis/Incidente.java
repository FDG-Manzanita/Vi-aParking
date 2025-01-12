package com.example.Apis;
import java.time.LocalDate;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

@Entity
public class Incidente {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idIncidente;

    private String Tipo;

    private LocalDate fecha;

    @Column(name = "estacionamientos_Id_Estacionamiento")
    private Integer estacionamientosIdEstacionamiento;

    @Column(name = "estacionamientos_Sector_id_sector")
    private Integer estacionamientosSectorIdSector;

    private String descripcion;

    

    // Getters y Setters

    public Incidente(Integer idIncidente, String tipo, LocalDate fecha, Integer estacionamientosIdEstacionamiento,
            Integer estacionamientosSectorIdSector, String descripcion) {
        this.idIncidente = idIncidente;
        Tipo = tipo;
        this.fecha = fecha;
        this.estacionamientosIdEstacionamiento = estacionamientosIdEstacionamiento;
        this.estacionamientosSectorIdSector = estacionamientosSectorIdSector;
        this.descripcion = descripcion;
    }

    public Incidente() {
    }

    public Integer getIdIncidente() {
        return idIncidente;
    }

    public void setIdIncidente(Integer idIncidente) {
        this.idIncidente = idIncidente;
    }

    public String getTipo() {
        return Tipo;
    }

    public void setTipo(String tipo) {
        this.Tipo = tipo;
    }

    public LocalDate getFecha() {
        return fecha;
    }

    public void setFecha(LocalDate fecha) {
        this.fecha = fecha;
    }

    public Integer getEstacionamientosIdEstacionamiento() {
        return estacionamientosIdEstacionamiento;
    }

    public void setEstacionamientosIdEstacionamiento(Integer estacionamientosIdEstacionamiento) {
        this.estacionamientosIdEstacionamiento = estacionamientosIdEstacionamiento;
    }

    public Integer getEstacionamientosSectorIdSector() {
        return estacionamientosSectorIdSector;
    }

    public void setEstacionamientosSectorIdSector(Integer estacionamientosSectorIdSector) {
        this.estacionamientosSectorIdSector = estacionamientosSectorIdSector;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }
}