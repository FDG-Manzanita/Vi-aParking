package com.example.Apis;
import java.util.Date;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;

@Entity
public class viajes {
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        private Integer idViajes;
        private String destino;
        private String Origen;
        private Date fecha;
        private boolean estado;
        private Integer UsuarioID;
    
        @ManyToOne
        @JoinColumn(name = "sector_id")
        private sector sector;
        // Constructor
        public viajes() {
        }
        public viajes(Integer idViajes, String destino, String origen, Date fecha, boolean estado, Integer usuarioID,
                sector sector) {
            this.idViajes = idViajes;
            this.destino = destino;
            this.Origen = origen;
            this.fecha = fecha;
            this.estado = estado;
            this.UsuarioID = usuarioID;
            this.sector = sector;
        }
        public Integer getIdViajes() {
            return idViajes;
        }
        public void setIdViajes(Integer idViajes) {
            this.idViajes = idViajes;
        }
        public String getDestino() {
            return destino;
        }
        public void setDestino(String destino) {
            this.destino = destino;
        }
        public String getOrigen() {
            return Origen;
        }
        public void setOrigen(String origen) {
            Origen = origen;
        }
        public Date getFecha() {
            return fecha;
        }
        public void setFecha(Date fecha) {
            this.fecha = fecha;
        }
        public boolean isEstado() {
            return estado;
        }
        public void setEstado(boolean estado) {
            this.estado = estado;
        }
        public Integer getUsuarioID() {
            return UsuarioID;
        }
        public void setUsuarioID(Integer usuarioID) {
            UsuarioID = usuarioID;
        }
        public sector getSector() {
            return sector;
        }
        public void setSector(sector sector) {
            this.sector = sector;
        }

        
        
    }
    
