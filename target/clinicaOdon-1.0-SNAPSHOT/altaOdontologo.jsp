<%@page import="com.clinicaodon.Entity.Horario"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    List<Horario> listaHorarios = (List) request.getSession().getAttribute("listaHorarios");
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
                    <h1 class="mt-4">Nuevo Odontólogo</h1>
                    <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item"><a href="index.jsp">Inicio</a></li>
                        <li class="breadcrumb-item"><a href="SvOdontologo">Odontólogos</a></li>
                        <li class="breadcrumb-item active">Nuevo Odontólogo</li>
                    </ol>
                    
                    <div class="card mb-4">
                        <div class="card-header">
                            <i class="fas fa-user-plus me-1"></i>
                            Formulario de Registro
                        </div>
                        <div class="card-body">
                            <form action="SvOdontologo" method="POST">
                                <input type="hidden" name="action" value="crear">
                                
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <div class="form-floating mb-3">
                                            <input class="form-control" id="dni" name="dni" type="text" placeholder="DNI" required />
                                            <label for="dni">DNI</label>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-floating mb-3">
                                            <input class="form-control" id="especialidad" name="especialidad" type="text" placeholder="Especialidad" required />
                                            <label for="especialidad">Especialidad</label>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <div class="form-floating mb-3">
                                            <input class="form-control" id="nombre" name="nombre" type="text" placeholder="Nombre" required />
                                            <label for="nombre">Nombre</label>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-floating mb-3">
                                            <input class="form-control" id="apellidos" name="apellidos" type="text" placeholder="Apellidos" required />
                                            <label for="apellidos">Apellidos</label>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <div class="form-floating mb-3">
                                            <input class="form-control" id="telefono" name="telefono" type="text" placeholder="Teléfono" />
                                            <label for="telefono">Teléfono</label>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-floating mb-3">
                                            <input class="form-control" id="direccion" name="direccion" type="text" placeholder="Dirección" />
                                            <label for="direccion">Dirección</label>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <div class="form-floating mb-3">
                                            <input class="form-control" id="fecha_nac" name="fecha_nac" type="date" />
                                            <label for="fecha_nac">Fecha de Nacimiento</label>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-floating mb-3">
                                            <select class="form-select" id="horario_id" name="horario_id">
                                                <option value="">Seleccione un horario</option>
                                                <% if (listaHorarios != null) { 
                                                    for (Horario horario : listaHorarios) { %>
                                                    <option value="<%= horario.getId_horario() %>">
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
                                        <button type="submit" class="btn btn-primary btn-block">Registrar Odontólogo</button>
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