
package Controladora;

import JPAController.OdontologoJpaController;
import JPAController.exceptions.NonexistentEntityException;
import com.clinicaodon.Entity.Odontologo;
import jakarta.persistence.EntityManager;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;


public class ContOdontologo {
    
    OdontologoJpaController jpa = new OdontologoJpaController();
 
    public void crearOdontologo(Odontologo odontologo) {
        jpa.create(odontologo);
    }
    
    public List<Odontologo> traerOdontologos() {
        List<Odontologo> odontologos = jpa.findOdontologoEntities(); 
        return odontologos;
    }
    
    public Odontologo traerOdontologo(Long id) {
        return jpa.findOdontologo(id);
    }
    
    public void editarOdontologo(Odontologo odontologo) {
        try {
            jpa.edit(odontologo);
        } catch (Exception ex) {
            Logger.getLogger(ContOdontologo.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public boolean existeOdontologo(String dni) {
        List<Odontologo> listaOdontologos = new ArrayList<>();
        listaOdontologos = jpa.findOdontologoEntities();
        for (Odontologo odon : listaOdontologos) {
            if (odon.getDni().equals(dni)) {
                return true;
            }
        }
        return false;
    }
    
    public void eliminarOdontologo(Long id) {
        try {
            jpa.destroy(id);
        } catch (NonexistentEntityException ex) {
            Logger.getLogger(ContOdontologo.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public Odontologo buscarOdontologoPorId(Long id) {
        return jpa.findOdontologo(id);
    }
    
    // Método adicional para buscar por especialidad
    public List<Odontologo> buscarPorEspecialidad(String especialidad) {
        List<Odontologo> resultado = new ArrayList<>();
        List<Odontologo> todos = jpa.findOdontologoEntities();
        
        for (Odontologo odon : todos) {
            if (odon.getEspecialidad().equalsIgnoreCase(especialidad)) {
                resultado.add(odon);
            }
        }
        
        return resultado;
    }
    
    
    public Odontologo buscarOdontologoPorUsuario(String nombreUsuario) {
    EntityManager em = null;
    try {
        em = jpa.getEntityManager();

        // Asume que la entidad Odontologo tiene un atributo `usuario` mapeado con @OneToOne o @ManyToOne
        Odontologo odontologo = em.createQuery(
            "SELECT o FROM Odontologo o WHERE o.usuario.nombreUsuario = :nombreUsuario", 
            Odontologo.class)
            .setParameter("nombreUsuario", nombreUsuario)
            .getSingleResult();

        return odontologo;
    } catch (Exception e) {
        e.printStackTrace();
        return null;
    } finally {
        if (em != null && em.isOpen()) {
            em.close();
        }
    }
}

    
}