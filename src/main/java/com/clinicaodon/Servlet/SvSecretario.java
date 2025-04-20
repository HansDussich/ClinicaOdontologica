/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.clinicaodon.Servlet;

import Controladora.ContSecretario;
import com.clinicaodon.Entity.Secretario;
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


@WebServlet(name = "SvSecretario", urlPatterns = {"/SvSecretario"})
public class SvSecretario extends HttpServlet {

    ContSecretario cont = new ContSecretario();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String idParam = request.getParameter("id");
        if (idParam != null) {
            Long id = Long.valueOf(idParam);
            Secretario secretarioEditar = cont.buscarSecretarioPorId(id);
            request.getSession().setAttribute("secretarioEditar", secretarioEditar);
        } else {
            request.getSession().removeAttribute("secretarioEditar");
        }

        List<Secretario> listaSecretarios = cont.traerSecretarios();
        request.getSession().setAttribute("listaSecretarios", listaSecretarios);

        response.sendRedirect("verSecretarios.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        switch (action) {
            case "crear":
                crearSecretario(request, response);
                break;
            case "editar":
                editarSecretario(request, response);
                break;
            case "eliminar":
                eliminarSecretario(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Acción no válida");
        }
    }

    private void crearSecretario(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String dni = request.getParameter("dni");
        String nombre = request.getParameter("nombre");
        String apellidos = request.getParameter("apellidos");
        String telefono = request.getParameter("telefono");
        String direccion = request.getParameter("direccion");
        String fechaNac = request.getParameter("fechaNac");
        String sector = request.getParameter("sector");

        boolean existe = cont.existeSecretario(dni);

        if (existe) {
            response.sendRedirect("altaSecretarios.jsp");
        } else {
            Secretario secretario = new Secretario();
            secretario.setDni(dni);
            secretario.setNombre(nombre);
            secretario.setApellidos(apellidos);
            secretario.setTelefono(telefono);
            secretario.setDireccion(direccion);

            try {
                secretario.setFecha_nac(new SimpleDateFormat("yyyy-MM-dd").parse(fechaNac));
            } catch (ParseException ex) {
                Logger.getLogger(SvSecretario.class.getName()).log(Level.SEVERE, null, ex);
            }

            secretario.setSector(sector);

            // Si hay lógica para asignar un usuario relacionado, agrégala aquí
            // secretario.setUsuario(usuario);

            cont.crearSecretario(secretario);
            response.sendRedirect("SvSecretario");
        }
    }

    private void editarSecretario(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            Long id = Long.valueOf(request.getParameter("id"));
            String dni = request.getParameter("dni");
            String nombre = request.getParameter("nombre");
            String apellidos = request.getParameter("apellidos");
            String telefono = request.getParameter("telefono");
            String direccion = request.getParameter("direccion");
            String fechaNac = request.getParameter("fechaNac");
            String sector = request.getParameter("sector");

            Date fechaNacimiento = new SimpleDateFormat("yyyy-MM-dd").parse(fechaNac);

            Secretario secretario = cont.buscarSecretarioPorId(id);

            if (secretario != null) {
                secretario.setDni(dni);
                secretario.setNombre(nombre);
                secretario.setApellidos(apellidos);
                secretario.setTelefono(telefono);
                secretario.setDireccion(direccion);
                secretario.setFecha_nac(fechaNacimiento);
                secretario.setSector(sector);

                cont.editarSecretario(secretario);
            }

            response.sendRedirect("SvSecretario");
        } catch (ParseException ex) {
            Logger.getLogger(SvSecretario.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private void eliminarSecretario(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Long id = Long.valueOf(request.getParameter("id"));

        cont.eliminarSecretario(id);

        response.sendRedirect("SvSecretario");
    }
}