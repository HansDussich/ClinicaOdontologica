
package com.clinicaodon.Entity;

import java.io.Serializable;
import jakarta.persistence.*;
import java.util.Date;


@Entity
@Table(name = "secretario")
@PrimaryKeyJoinColumn(name = "id_secretario")
public class Secretario extends Persona implements Serializable {
    
    @Column(name = "id_secretario")
    private int id_secretario;
    private String sector;
    
    @OneToOne
    @JoinColumn(name = "usuario_id", referencedColumnName = "id_usuario")
    private Usuario usuario;

    public Secretario() {}

    public Secretario(int id_secretario, String sector, Usuario usuario) {
        this.id_secretario = id_secretario;
        this.sector = sector;
        this.usuario = usuario;
    }



    // Getters y Setters (mismos que en tu implementación original)
    public int getId_secretario() {
        return id_secretario;
    }

    public void setId_secretario(int id_secretario) {
        this.id_secretario = id_secretario;
    }

    public String getSector() {
        return sector;
    }

    public void setSector(String sector) {
        this.sector = sector;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }
}