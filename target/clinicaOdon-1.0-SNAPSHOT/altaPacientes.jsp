<%-- 
    Document   : altaPacientes
    Created on : 29/03/2025, 5:07:05 p. m.
    Author     : hans2
--%>

<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%@include file="Layout/head.jsp" %>
    <link rel="stylesheet" href="css/style.css"/>
    <body class="sb-nav-fixed">
        <!-- Incluir navbar -->
        <%@include file="Layout/navbar.jsp" %>
        
        <div id="layoutSidenav">
            <!-- Incluir el layoutSidenav_nav -->
            <%@include file="Layout/layoutSidenav_nav.jsp" %>
            
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">Alta de Pacientes</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item"><a href="index.jsp">Inicio</a></li>
                            <li class="breadcrumb-item active">Alta de Pacientes</li>
                        </ol>
                        
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-user-plus me-1"></i>
                                Formulario de Alta de Paciente
                            </div>
                            <div class="card-body">
                                <!-- Aquí va el formulario de alta de pacientes -->
                                <form action="SvPaciente" method="POST">
                                    <input type="hidden" name="action" value="crear">

                                    <div class="mb-3">
                                        <label for="dni" class="form-label">DNI:</label>
                                        <input type="text" class="form-control" id="dni" name="dni" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="nombre" class="form-label">Nombre:</label>
                                        <input type="text" class="form-control" id="nombre" name="nombre" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="apellido" class="form-label">Apellido:</label>
                                        <input type="text" class="form-control" id="apellidos" name="apellidos" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="telefono" class="form-label">Teléfono:</label>
                                        <input type="tel" class="form-control" id="telefono" name="telefono" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="direccion" class="form-label">Dirección:</label>
                                        <input type="text" class="form-control" id="direccion" name="direccion" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="fechaNac" class="form-label">Fecha de Nacimiento:</label>
                                        <input type="date" class="form-control" id="fechaNac" name="fechaNac" required>
                                    </div>
                                    <div class="mb-3">
    <label for="eps" class="form-label">EPS:</label>
    <select class="form-select" id="eps" name="eps" required>
        <option value="">Seleccione una EPS</option>
        <option value="Sura">Sura</option>
        <option value="Sanitas">Sanitas</option>
        <option value="Nueva EPS">Nueva EPS</option>
        <option value="Coomeva">Coomeva</option>
        <option value="Otra">Otra</option>
    </select>
</div>

<div class="mb-3">
    <label for="tipo_sangre" class="form-label">Tipo de Sangre:</label>
    <select class="form-select" id="tipo_sangre" name="tipo_sangre" required>
        <option value="">Seleccione un tipo de sangre</option>
        <option value="A+">A+</option>
        <option value="A-">A-</option>
        <option value="B+">B+</option>
        <option value="B-">B-</option>
        <option value="AB+">AB+</option>
        <option value="AB-">AB-</option>
        <option value="O+">O+</option>
        <option value="O-">O-</option>
    </select>
</div>
                                    <div class="mb-3">
    <label for="responsableId" class="form-label">Responsable:</label>
    <select class="form-select" id="responsableId" name="responsableId" required>
        <option value="">Seleccione un Responsable</option>
        <%
            List<com.clinicaodon.Entity.Responsable> responsables = 
                (List<com.clinicaodon.Entity.Responsable>) session.getAttribute("listaResponsables");
            if (responsables != null) {
                for (com.clinicaodon.Entity.Responsable r : responsables) {
        %>
                    <option value="<%=r.getId()%>"><%=r.getNombre() + " " + r.getApellidos()%></option>
        <%
                }
            }
        %>
    </select>
</div>


                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-save me-1"></i> Guardar
                                    </button>
                                    <a href="verPacientes.jsp" class="btn btn-secondary">
                                        <i class="fas fa-times me-1"></i> Cancelar
                                    </a>
                                </form>
                            </div>
                        </div>
                    </div>
                </main>
                <%@include file="Layout/footer.jsp" %>
            </div>
        </div>
        
        <!-- Scripts -->
        <%@include file="Layout/script.jsp" %>
    </body>
</html>
