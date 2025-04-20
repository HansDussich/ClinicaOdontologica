
package com.clinicaodon.Entity;

import java.io.Serializable;
import java.util.List;

import jakarta.persistence.*;
import java.util.Date;


@Entity
@Table(name = "paciente")
public class Paciente extends Persona {
    

    
    private String  eps;
    
    private String tipo_sangre;
    

    @ManyToOne
@JoinColumn(name = "responsable_id")
private Responsable responsable;

    

    public Paciente() {}

    public Paciente(String eps, String tipo_sangre) {

        this.eps = eps;
        this.tipo_sangre = tipo_sangre;
    }

    public String getEps() {
        return eps;
    }

    public void setEps(String eps) {
        this.eps = eps;
    }

    
    



    public String getTipo_sangre() {
        return tipo_sangre;
    }

    public void setTipo_sangre(String tipo_sangre) {
        this.tipo_sangre = tipo_sangre;
    }

    public Responsable getResponsable() {
    return responsable;
}

public void setResponsable(Responsable responsable) {
    this.responsable = responsable;
}


}