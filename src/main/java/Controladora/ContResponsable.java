/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controladora;

import JPAController.ResponsableJpaController;
import JPAController.exceptions.NonexistentEntityException;
import com.clinicaodon.Entity.Responsable;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author hans2
 */
public class ContResponsable {
    
    
     ResponsableJpaController jpa = new ResponsableJpaController();
    
    public void crearResponsable(Responsable responsable){
        jpa.create(responsable);
    }
    
    public List<Responsable> traerResponsables(){
        List<Responsable> responsable = jpa.findResponsableEntities();
        return responsable;
    }
    
    public Responsable traerResponsable(Long id){
        return jpa.findResponsable(id);
    }
    
    public void editarResponsable(Responsable responsable){
        
         try {
             jpa.edit(responsable);
         } catch (Exception ex) {
             Logger.getLogger(ContResponsable.class.getName()).log(Level.SEVERE, null, ex);
         }

    }
    
    public void eliminarResponsable(Long id){
         try {
             jpa.destroy(id);
         } catch (NonexistentEntityException ex) {
             Logger.getLogger(ContResponsable.class.getName()).log(Level.SEVERE, null, ex);
         }

    }
    
    
         public Responsable buscarResponsablePorId(Long id){
        return jpa.findResponsable(id);
    }
         
         
             public boolean existeResponsable(String dni) {
    List<Responsable> listaPacientes = jpa.findResponsableEntities();
    for (Responsable pac : listaPacientes) {
        if (pac.getDni() != null && pac.getDni().equals(dni)) {
    return true;
}

    }
    return false;
}
         
}
