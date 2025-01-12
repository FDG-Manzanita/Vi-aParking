package com.example.Apis;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

@Entity
public class Estacionados {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idEstacionados;
    private Integer Id_estacionamiento;
    private Integer ID_vehiculos;
    private Integer ID_pagos;
    public Estacionados() {
    }
    public Estacionados(Integer idEstacionados, Integer id_estacionamiento, Integer iD_vehiculos, Integer iD_pagos) {
        this.idEstacionados = idEstacionados;
        Id_estacionamiento = id_estacionamiento;
        ID_vehiculos = iD_vehiculos;
        ID_pagos = iD_pagos;
    }
    public Integer getIdEstacionados() {
        return idEstacionados;
    }
    public void setIdEstacionados(Integer idEstacionados) {
        this.idEstacionados = idEstacionados;
    }
    public Integer getId_estacionamiento() {
        return Id_estacionamiento;
    }
    public void setId_estacionamiento(Integer id_estacionamiento) {
        Id_estacionamiento = id_estacionamiento;
    }
    public Integer getID_vehiculos() {
        return ID_vehiculos;
    }
    public void setID_vehiculos(Integer iD_vehiculos) {
        ID_vehiculos = iD_vehiculos;
    }
    public Integer getID_pagos() {
        return ID_pagos;
    }
    public void setID_pagos(Integer iD_pagos) {
        ID_pagos = iD_pagos;
    }

    
}
