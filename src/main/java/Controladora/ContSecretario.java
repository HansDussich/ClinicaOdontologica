
package Controladora;

import JPAController.SecretarioJpaController;
import JPAController.exceptions.NonexistentEntityException;
import com.clinicaodon.Entity.Secretario;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ContSecretario {
    
    SecretarioJpaController jpa = new SecretarioJpaController();
    
    public void crearSecretario(Secretario secretario){
        jpa.create(secretario);
    }
    
    public List<Secretario> traerSecretarios(){
        List<Secretario> secretarios = jpa.findSecretarioEntities();
        return secretarios;
    }
    
    public Secretario traerSecretario(Long id){
        return jpa.findSecretario(id);
    }
    
    public void editarSecretario(Secretario secretario){
        try {
            jpa.edit(secretario);
        } catch (Exception ex) {
            Logger.getLogger(ContSecretario.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public void eliminarSecretario(Long id){
        try {
            jpa.destroy(id);
        } catch (NonexistentEntityException ex) {
            Logger.getLogger(ContSecretario.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public Secretario buscarSecretarioPorId(Long id){
        return jpa.findSecretario(id);
    }

    public boolean existeSecretario(String dni) {
        List<Secretario> listaSecretarios = jpa.findSecretarioEntities();
        for (Secretario s : listaSecretarios) {
            if (s.getDni() != null && s.getDni().equals(dni)) {
                return true;
            }
        }
        return false;
    }
}