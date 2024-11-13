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
@Table(name = "Estacionados")
public class Estacionado {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idEstacionados")
    private Integer idEstacionados;

    @ManyToOne
    @JoinColumn(name = "id_estacionamiento", referencedColumnName = "Id_Estacionamiento")
    private Estacionamiento estacionamiento;

    @ManyToOne
    @JoinColumn(name = "ID_vehiculo", referencedColumnName = "idVehiculo")
    private Vehiculo vehiculo;
@Column(name= "tiempo_estacionado")
private Integer tiempoestacionado;


    // Getters and Setters
    public Integer getIdEstacionados() {
        return idEstacionados;
    }

    public void setIdEstacionados(Integer idEstacionados) {
        this.idEstacionados = idEstacionados;
    }

    public Estacionamiento getEstacionamiento() {
        return estacionamiento;
    }

    public void setEstacionamiento(Estacionamiento estacionamiento) {
        this.estacionamiento = estacionamiento;
    }

    public Vehiculo getVehiculo() {
        return vehiculo;
    }

    public void setVehiculo(Vehiculo vehiculo) {
        this.vehiculo = vehiculo;
    }
    public Integer getTiempoEstacionado() {
        return tiempoestacionado;
    }

    // Setter para tiempoestacionado
    public void setTiempoEstacionado(Integer tiempoestacionado) {
        this.tiempoestacionado = tiempoestacionado;
    }
}