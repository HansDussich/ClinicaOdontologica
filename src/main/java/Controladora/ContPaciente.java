/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controladora;

import JPAController.PacienteJpaController;
import JPAController.exceptions.NonexistentEntityException;
import com.clinicaodon.Entity.Paciente;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author hans2
 */
public class ContPaciente {
    
    PacienteJpaController jpa = new PacienteJpaController();
    
    public void crearPaciente(Paciente paciente){
        jpa.create(paciente);
    }
    
    public List<Paciente> traerPacientes(){
        List<Paciente> pacientes = jpa.findPacienteEntities();
        return pacientes;
    }
    
    public Paciente traerPaciente(Long id){
        return jpa.findPaciente(id);
    }
    
    public void editarPaciente(Paciente paciente){
        try {
            jpa.edit(paciente);
        } catch (Exception ex) {
            Logger.getLogger(ContPaciente.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public void eliminarPaciente(Long id){
        try {   
            jpa.destroy(id);
        } catch (NonexistentEntityException ex) {
            Logger.getLogger(ContPaciente.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    
         public Paciente buscarPacientePorId(Long id){
        return jpa.findPaciente(id);
    }
         
         
    public boolean existePaciente(String dni) {
    List<Paciente> listaPacientes = jpa.findPacienteEntities();
    for (Paciente pac : listaPacientes) {
        if (pac.getDni() != null && pac.getDni().equals(dni)) {
    return true;
}

    }
    return false;
}

     
}
