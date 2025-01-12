package com.example.Apis;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

@Entity
public class sector {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id_sector;
    private String nombre;
    private String direccion;

    

    
    public sector() {
    }

    public sector(Integer id_sector, String nombre, String direccion) {
        this.id_sector = id_sector;
        this.nombre = nombre;
        this.direccion = direccion;
        
    }

    public Integer getId_sector() {
        return id_sector;
    }

    public void setId_sector(Integer id_sector) {
        this.id_sector = id_sector;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

}
