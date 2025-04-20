
package com.clinicaodon.Entity;

import java.io.Serializable;
import jakarta.persistence.*;
import java.util.Date;
import java.util.List;



@Entity
@Table(name = "responsable")
@PrimaryKeyJoinColumn(name = "id_responsable")
public class Responsable extends Persona implements Serializable {
    
    @Column(name = "id_responsable")
    private int id_responsable;
    private String tipo_responsable;

    public Responsable() {}

    public Responsable(int id_responsable, String tipo_responsable) {
        this.id_responsable = id_responsable;
        this.tipo_responsable = tipo_responsable;
    }


    
        @OneToMany(mappedBy = "responsable", cascade = CascadeType.ALL)
    private List<Paciente> pacientes;
    
    
    
    
    // Getters y Setters (mismos que en tu implementación original)
    public int getId_responsable() {
        return id_responsable;
    }

    public void setId_responsable(int id_responsable) {
        this.id_responsable = id_responsable;
    }

    public String getTipo_responsable() {
        return tipo_responsable;
    }

    public void setTipo_responsable(String tipo_responsable) {
        this.tipo_responsable = tipo_responsable;
    }
}