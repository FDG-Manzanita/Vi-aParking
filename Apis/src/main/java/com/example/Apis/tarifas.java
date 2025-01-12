package com.example.Apis;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
@Entity
public class tarifas {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idTarifas;
    private Integer Precio;
    private Integer minutos;
    private String tipo;
    private Integer Estacionamientos_Id_Estacionamiento;
    private Integer Estacionamientos_Sector_is_sector;
    public tarifas() {
    }
    public tarifas(Integer idTarifas, Integer precio, Integer minutos, String tipo,
            Integer estacionamientos_Id_Estacionamiento, Integer estacionamientos_Sector_is_sector) {
        this.idTarifas = idTarifas;
        Precio = precio;
        this.minutos = minutos;
        this.tipo = tipo;
        Estacionamientos_Id_Estacionamiento = estacionamientos_Id_Estacionamiento;
        Estacionamientos_Sector_is_sector = estacionamientos_Sector_is_sector;
    }
    public Integer getIdTarifas() {
        return idTarifas;
    }
    public void setIdTarifas(Integer idTarifas) {
        this.idTarifas = idTarifas;
    }
    public Integer getPrecio() {
        return Precio;
    }
    public void setPrecio(Integer precio) {
        Precio = precio;
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
    public Integer getEstacionamientos_Id_Estacionamiento() {
        return Estacionamientos_Id_Estacionamiento;
    }
    public void setEstacionamientos_Id_Estacionamiento(Integer estacionamientos_Id_Estacionamiento) {
        Estacionamientos_Id_Estacionamiento = estacionamientos_Id_Estacionamiento;
    }
    public Integer getEstacionamientos_Sector_is_sector() {
        return Estacionamientos_Sector_is_sector;
    }
    public void setEstacionamientos_Sector_is_sector(Integer estacionamientos_Sector_is_sector) {
        Estacionamientos_Sector_is_sector = estacionamientos_Sector_is_sector;
    }
    
    
}
