
package com.clinicaodon.Servlet;

import Controladora.ContPaciente;
import Controladora.ContResponsable;
import com.clinicaodon.Entity.Paciente;
import com.clinicaodon.Entity.Responsable;
import com.clinicaodon.Entity.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(name = "SvPaciente", urlPatterns = {"/SvPaciente"})
public class SvPaciente extends HttpServlet {

    ContPaciente cont = new ContPaciente();
    ContResponsable res = new ContResponsable();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String idParam = request.getParameter("id");
    if (idParam != null) {
        Long id = Long.valueOf(idParam);
        Paciente pacienteEditar = cont.buscarPacientePorId(id);
        request.getSession().setAttribute("pacienteEditar", pacienteEditar);
    } else {
        request.getSession().removeAttribute("pacienteEditar");
    }

    List<Paciente> listaPacientes = cont.traerPacientes();
    request.getSession().setAttribute("listaPacientes", listaPacientes);

    response.sendRedirect("verPacientes.jsp");
        
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        
        String action = request.getParameter("action");

        switch (action) {
            case "crear":
                crearPaciente(request, response);
                break;
            case "editar":
                editarPaciente(request, response);
                break;
            case "eliminar":
                eliminarPaciente(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Acción no válida");
        }
        
        


            
    }




    private void crearPaciente(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
                String dni = request.getParameter("dni");
                String nombre = request.getParameter("nombre");
                String apellidos = request.getParameter("apellidos");
                String telefono = request.getParameter("telefono");
                String direccion = request.getParameter("direccion");
                String fechaNac = request.getParameter("fechaNac");
                String eps = request.getParameter("eps");
                String tipoSangre = request.getParameter("tipo_sangre");

                String responsableIdStr = request.getParameter("responsableId");

                Responsable responsable = res.buscarResponsablePorId(Long.valueOf(responsableIdStr));

            boolean validacion;

            validacion = cont.existePaciente(dni);

            if (validacion) {
                response.sendRedirect("altaPacientes.jsp");

            } else {
                Paciente pac = new Paciente();
                pac.setDni(dni);
                pac.setNombre(nombre);
                pac.setApellidos(apellidos);
                pac.setTelefono(telefono);
                pac.setDireccion(direccion);
                 try {
                     pac.setFecha_nac(new SimpleDateFormat("yyyy-MM-dd").parse(fechaNac));
                 } catch (ParseException ex) {
                     Logger.getLogger(SvPaciente.class.getName()).log(Level.SEVERE, null, ex);
                 }
                pac.setEps(eps);
                pac.setTipo_sangre(tipoSangre);
                            pac.setResponsable(responsable);


                cont.crearPaciente(pac);
                response.sendRedirect("SvPaciente");


        }
    }

    private void editarPaciente(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            Long id = Long.valueOf(request.getParameter("id"));
            String dni = request.getParameter("dni");
            String nombre = request.getParameter("nombre");
            String apellidos = request.getParameter("apellidos");
            String telefono = request.getParameter("telefono");
            String direccion = request.getParameter("direccion");
            String fechaNac = request.getParameter("fechaNac");
            String eps = request.getParameter("eps");
            String tipoSangre = request.getParameter("tipo_sangre");
            
            SimpleDateFormat formato = new SimpleDateFormat("yyyy-MM-dd");
            Date fechaNaci = formato.parse(fechaNac);
            
            Paciente pac = cont.buscarPacientePorId(id);
            
            if (pac != null) {
                pac.setDni(dni);
                pac.setNombre(nombre);
                pac.setApellidos(apellidos);
                pac.setTelefono(telefono);
                pac.setDireccion(direccion);
                pac.setFecha_nac(fechaNaci);

                pac.setEps(eps);
                pac.setTipo_sangre(tipoSangre);
                
                cont.editarPaciente(pac);
            }
            
            response.sendRedirect("SvPaciente");
        } catch (ParseException ex) {
            Logger.getLogger(SvPaciente.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    private void eliminarPaciente(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Long id =Long.valueOf(request.getParameter("id"));

        cont.eliminarPaciente(id); 
        
        response.sendRedirect("SvPaciente");

    }
}
