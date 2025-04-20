<%-- 
    Document   : validarSesion
    Created on : 29/03/2025, 2:37:27 p. m.
    Author     : hans2
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession misesion = request.getSession();
    String usuario = (String) request.getSession().getAttribute("usuario");
    
    if(usuario == null ){
    response.sendRedirect("login.jsp");
    }
%>