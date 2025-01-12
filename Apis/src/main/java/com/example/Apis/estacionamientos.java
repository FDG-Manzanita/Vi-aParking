package com.example.Apis;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

@Entity

public class estacionamientos {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int Id_Estacionamiento;
    private String nombre;
    private int Cupostotales;
    private int Cuposdisponibles;
    private String estado;
    private double latitud;
    private double longitud;
    @Column(name = "sector_id_sector", nullable = true)
    private int sector_id;
    public estacionamientos() {
    }
    public estacionamientos(int id_Estacionamiento, String nombre, int cupostotales, int cuposdisponibles,
            String estado, double latitud, double longitud, int sector_id) {
        this.Id_Estacionamiento = id_Estacionamiento;
        this.nombre = nombre;
        this.Cupostotales = cupostotales;
        this.Cuposdisponibles = cuposdisponibles;
        this.estado = estado;
        this.latitud = latitud;
        this.longitud = longitud;
        this.sector_id = sector_id;
    }
    public int getId_Estacionamiento() {
        return Id_Estacionamiento;
    }
    public void setId_Estacionamiento(int id_Estacionamiento) {
        Id_Estacionamiento = id_Estacionamiento;
    }
    public String getNombre() {
        return nombre;
    }
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    public int getCupostotales() {
        return Cupostotales;
    }
    public void setCupostotales(int cupostotales) {
        Cupostotales = cupostotales;
    }
    public int getCuposdisponibles() {
        return Cuposdisponibles;
    }
    public void setCuposdisponibles(int cuposdisponibles) {
        Cuposdisponibles = cuposdisponibles;
    }
    public String getEstado() {
        return estado;
    }
    public void setEstado(String estado) {
        this.estado = estado;
    }
    public double getLatitud() {
        return latitud;
    }
    public void setLatitud(double latitud) {
        this.latitud = latitud;
    }
    public double getLongitud() {
        return longitud;
    }
    public void setLongitud(double longitud) {
        this.longitud = longitud;
    }

    public int getSector_id() {
        return sector_id;
    }

    public void setSector_id(int sector_id) {
        this.sector_id = sector_id;
    }

    
    

        
}
