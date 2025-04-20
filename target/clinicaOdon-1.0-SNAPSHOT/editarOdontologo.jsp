<%@page import="com.clinicaodon.Entity.Odontologo"%>
<%@page import="com.clinicaodon.Entity.Horario"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Odontologo odontologoEditar = (Odontologo) session.getAttribute("odontologoEditar");
    List<Horario> listaHorarios = (List) request.getSession().getAttribute("listaHorarios");
    
    if (odontologoEditar == null) {
        response.sendRedirect("SvOdontologo");
        return;
    }
%>

<!DOCTYPE html>
<html>
<%@ include file="Layout/head.jsp" %>
<link rel="stylesheet" href="css/style.css"/>
<body class="sb-nav-fixed">
    <%@ include file="Layout/navbar.jsp" %>
    <div id="layoutSidenav">
        <%@ include file="Layout/layoutSidenav_nav.jsp" %>
        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid px-4">
                    <h1 class="mt-4">Editar Odontólogo</h1>
                    <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item"><a href="index.jsp">Inicio</a></li>
                        <li class="breadcrumb-item"><a href="SvOdontologo">Odontólogos</a></li>
                        <li class="breadcrumb-item active">Editar Odontólogo</li>
                    </ol>
                    
                    <div class="card mb-4">
                        <div class="card-header">
                            <i class="fas fa-user-edit me-1"></i>
                            Formulario de Edición
                        </div>
                        <div class="card-body">
                            <form action="SvOdontologo" method="POST">
                                <input type="hidden" name="action" value="editar">
                                <input type="hidden" name="id" value="<%= odontologoEditar.getId() %>">
                                
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <div class="form-floating mb-3">
                                            <input class="form-control" id="dni" name="dni" type="text" value="<%= odontologoEditar.getDni() %>" required />
                                            <label for="dni">DNI</label>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-floating mb-3">
                                            <input class="form-control" id="especialidad" name="especialidad" type="text" value="<%= odontologoEditar.getEspecialidad() %>" required />
                                            <label for="especialidad">Especialidad</label>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <div class="form-floating mb-3">
                                            <input class="form-control" id="nombre" name="nombre" type="text" value="<%= odontologoEditar.getNombre() %>" required />
                                            <label for="nombre">Nombre</label>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-floating mb-3">
                                            <input class="form-control" id="apellidos" name="apellidos" type="text" value="<%= odontologoEditar.getApellidos() %>" required />
                                            <label for="apellidos">Apellidos</label>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <div class="form-floating mb-3">
                                            <input class="form-control" id="telefono" name="telefono" type="text" value="<%= odontologoEditar.getTelefono() %>" />
                                            <label for="telefono">Teléfono</label>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-floating mb-3">
                                            <input class="form-control" id="direccion" name="direccion" type="text" value="<%= odontologoEditar.getDireccion() %>" />
                                            <label for="direccion">Dirección</label>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <div class="form-floating mb-3">
                                                <input class="form-control" id="fecha_nac" name="fecha_nac" type="date" 
                                                       value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(odontologoEditar.getFecha_nac()) %>" />
                                                <label for="fecha_nac">Fecha de Nacimiento</label>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-floating mb-3">
                                            <select class="form-select" id="horario_id" name="horario_id">
                                                <option value="">Seleccione un horario</option>
                                                <% if (listaHorarios != null) { 
                                                    for (Horario horario : listaHorarios) { 
                                                        boolean selected = odontologoEditar.getHorario() != null && 
                                                                        odontologoEditar.getHorario().getId_horario() == horario.getId_horario(); 
                                                %>
                                                    <option value="<%= horario.getId_horario() %>" 
                                                            <%= selected ? "selected" : "" %>>
                                                        <%= horario.getHorario_inicio() %> - <%= horario.getHorario_fin() %>
                                                    </option>
                                                <% } 
                                                } %>
                                            </select>
                                            <label for="horario_id">Horario</label>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="mt-4 mb-0">
                                    <div class="d-grid">
                                        <button type="submit" class="btn btn-primary btn-block">Guardar Cambios</button>
                                    </div>
                                </div>
                                
                                <div class="mt-2 mb-0">
                                    <div class="d-grid">
                                        <a href="SvOdontologo" class="btn btn-secondary btn-block">Cancelar</a>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </main>
            <%@ include file="Layout/footer.jsp" %>
        </div>
    </div>
    <%@ include file="Layout/script.jsp" %>
</body>
</html>