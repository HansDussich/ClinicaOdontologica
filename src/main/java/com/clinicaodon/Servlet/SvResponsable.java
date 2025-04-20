
package com.clinicaodon.Servlet;

import Controladora.ContResponsable;
import com.clinicaodon.Entity.Responsable;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.io.PrintWriter;
import java.text.ParseException;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(name = "SvResponsable", urlPatterns = {"/SvResponsable"})
public class SvResponsable extends HttpServlet {

    ContResponsable cont = new ContResponsable();
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

  
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String idParam = request.getParameter("id");
    if (idParam != null) {
        Long id = Long.valueOf(idParam);
        Responsable responsableEditar = cont.buscarResponsablePorId(id);
        request.getSession().setAttribute("responsableEditar", responsableEditar);
    } else {
        request.getSession().removeAttribute("responsableEditar");
    }

    List<Responsable> listaResponsables = cont.traerResponsables();
    request.getSession().setAttribute("listaResponsables", listaResponsables);

    response.sendRedirect("verResponsables.jsp");
        
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        
        String action = request.getParameter("action");

        switch (action) {
            case "crear":
                crearResponsable(request, response);
                break;
            case "editar":
                editarResponsable(request, response);
                break;
            case "eliminar":
                eliminarResponsable(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Acción no válida");
        }
        
        


            
    }




    private void crearResponsable(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
                String dni = request.getParameter("dni");
                String nombre = request.getParameter("nombre");
                String apellidos = request.getParameter("apellidos");
                String telefono = request.getParameter("telefono");
                String direccion = request.getParameter("direccion");
                String fechaNac = request.getParameter("fechaNac");
                String tipoRes = request.getParameter("tipo_responsable");

                
                   boolean validacion;

            validacion = cont.existeResponsable(dni);

            if (validacion) {
                response.sendRedirect("altaResponsables.jsp");

            } else {
                
                                Responsable pac = new Responsable();
                pac.setDni(dni);
                pac.setNombre(nombre);
                pac.setApellidos(apellidos);
                pac.setTelefono(telefono);
                pac.setDireccion(direccion);

        try {
            pac.setFecha_nac(new SimpleDateFormat("yyyy-MM-dd").parse(fechaNac));
        } catch (ParseException ex) {
            Logger.getLogger(SvResponsable.class.getName()).log(Level.SEVERE, null, ex);
        }

                pac.setTipo_responsable(tipoRes);

                cont.crearResponsable(pac);
                response.sendRedirect("SvResponsable");
            }



        
    }

    private void editarResponsable(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            Long id = Long.valueOf(request.getParameter("id"));
            String dni = request.getParameter("dni");
            String nombre = request.getParameter("nombre");
            String apellidos = request.getParameter("apellidos");
            String telefono = request.getParameter("telefono");
            String direccion = request.getParameter("direccion");
            String fechaNac = request.getParameter("fechaNac");
            String tipoRes = request.getParameter("tipo_responsable");
            
            SimpleDateFormat formato = new SimpleDateFormat("yyyy-MM-dd");
            Date fechaNaci = formato.parse(fechaNac);
            
            Responsable pac = cont.buscarResponsablePorId(id);
            
            if (pac != null) {
                pac.setDni(dni);
                pac.setNombre(nombre);
                pac.setApellidos(apellidos);
                pac.setTelefono(telefono);
                pac.setDireccion(direccion);
                pac.setFecha_nac(fechaNaci);

                pac.setTipo_responsable(tipoRes);
                
                cont.editarResponsable(pac);
            }
            
            response.sendRedirect("SvResponsable");
        } catch (ParseException ex) {
            Logger.getLogger(SvResponsable.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    private void eliminarResponsable(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Long id =Long.valueOf(request.getParameter("id"));

        cont.eliminarResponsable(id); 
        
        response.sendRedirect("SvResponsable");

    }

}
