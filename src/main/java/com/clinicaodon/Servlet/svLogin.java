package com.clinicaodon.Servlet;

import Controladora.ContUsuario;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "svLogin", urlPatterns = {"/svLogin"})
public class svLogin extends HttpServlet {

    ContUsuario control = new ContUsuario();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getSession().removeAttribute("usuario");
        request.getSession().invalidate();
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String usuario = request.getParameter("usuario");
        String contrasena = request.getParameter("contrasena");

        boolean validacion = false;

        validacion = control.comprobarAcceso(usuario, contrasena);

        if (validacion) {
            HttpSession misesion = request.getSession(true);
            misesion.setAttribute("usuario", usuario);
            response.sendRedirect("index.jsp");
        } else {
            response.sendRedirect("login.jsp");

        }
    }
}
