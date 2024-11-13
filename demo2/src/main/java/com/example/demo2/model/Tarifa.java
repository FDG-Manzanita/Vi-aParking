package com.example.demo2.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "tarifas")
public class Tarifa {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idTarifas;

    @Column(name = "Precio")
    private Integer precio;

    @Column(name = "minutos")
    private Integer minutos;

    @Column(name = "tipo")
    private String tipo;

    // Relación con la tabla Estacionamiento
    @ManyToOne
    @JoinColumn(name = "Estacionamientos_Id_Estacionamiento", referencedColumnName = "Id_Estacionamiento")
    private Estacionamiento estacionamiento;

    // Relación con la tabla Sector (a través de Estacionamiento)
    @ManyToOne
    @JoinColumn(name = "Estacionamientos_Sector_id_sector", referencedColumnName = "id_sector")
    private Sector sector;

    // Getters y Setters
    public Integer getIdTarifa() {
        return idTarifas;
    }

    public void setIdTarifa(Integer idTarifas) {
        this.idTarifas = idTarifas;
    }

    public Integer getPrecio() {
        return precio;
    }

    public void setPrecio(Integer precio) {
        this.precio = precio;
    }

    public Integer getMinutos() {
        return minutos;
    }

    public void setMinutos(Integer minutos) {
        this.minutos = minutos;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public Estacionamiento getEstacionamiento() {
        return estacionamiento;
    }

    public void setEstacionamiento(Estacionamiento estacionamiento) {
        this.estacionamiento = estacionamiento;
    }

    public Sector getSector() {
        return sector;
    }

    public void setSector(Sector sector) {
        this.sector = sector;
    }
}
