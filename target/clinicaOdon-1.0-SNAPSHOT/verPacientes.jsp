<%@page import="com.clinicaodon.Entity.Responsable"%>
<%@page import="com.clinicaodon.Entity.Paciente"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Paciente pacienteEditar = (Paciente) session.getAttribute("pacienteEditar");
    boolean enModoEdicion = pacienteEditar != null;
%>

<!DOCTYPE html>
<html>
    <%@include file="Layout/head.jsp" %>
    <link rel="stylesheet" href="css/style.css"/>
    <body class="sb-nav-fixed">
        <%@include file="Layout/navbar.jsp" %>

        <div id="layoutSidenav">
            <%@include file="Layout/layoutSidenav_nav.jsp" %>

            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">Lista de Pacientes</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item"><a href="../index.jsp">Inicio</a></li>
                            <li class="breadcrumb-item active">Ver Pacientes</li>
                        </ol>

                        
                        <div class="card mb-4">
                            <div class="card-header d-flex justify-content-between align-items-center">
                                <span><i class="fas fa-table me-1"></i> Pacientes Registrados</span>
                                <a href="altaPacientes.jsp" class="btn btn-primary btn-sm">
                                    <i class="fas fa-plus"></i> Nuevo Paciente
                                </a>
                            </div>
                            <div class="card-body">
                                <table id="datatablesSimple" class="table table-striped table-hover">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>DNI</th>
                                            <th>Nombre</th>
                                            <th>Apellidos</th>
                                            <th>Teléfono</th>
                                            <th>Dirección</th>
                                            <th>Fecha Nac.</th>
                                            <th>Tipo Sangre</th>
                                            <th>Acciones</th>
                                        </tr>
                                    </thead>
                                    <tfoot>
                                        <tr>
                                            <th>ID</th>
                                            <th>DNI</th>
                                            <th>Nombre</th>
                                            <th>Apellidos</th>
                                            <th>Teléfono</th>
                                            <th>Dirección</th>
                                            <th>Fecha Nac.</th>
                                            <th>Tipo Sangre</th>
                                            <th>Acciones</th>
                                        </tr>
                                    </tfoot>
                                    <tbody>
                                        <%
                                            List<Paciente> listaPacientes = (List) request.getSession().getAttribute("listaPacientes");
                                            if (listaPacientes != null) {
                                                for (Paciente pac : listaPacientes) {
                                        %>
                                        <tr>
                                            <td><%= pac.getId() %></td>
                                            <td><%= pac.getDni() %></td>
                                            <td><%= pac.getNombre() %></td>
                                            <td><%= pac.getApellidos() %></td>
                                            <td><%= pac.getTelefono() %></td>
                                            <td><%= pac.getDireccion() %></td>
                                            <td><%= pac.getFecha_nac() %> </td>
                                            <td><%= pac.getTipo_sangre() %></td>
                                            <td>
                                                <form action="SvPaciente" method="POST" class="d-inline">
                                                    <input type="hidden" name="action" value="eliminar">
                                                    <input type="hidden" name="id" value="<%= pac.getId() %>">
                                                    <button type="submit" class="btn btn-danger btn-sm" title="Eliminar">
                                                        <i class="fas fa-trash-alt"></i>
                                                    </button>
                                                </form>
                                                <form action="SvPaciente" method="GET" class="d-inline">
                                                    <input type="hidden" name="id" value="<%= pac.getId() %>">
                                                    <button type="submit" class="btn btn-primary btn-sm" title="Editar">
                                                        <i class="fas fa-edit"></i>
                                                    </button>
                                                </form>
                                            </td>
                                        </tr>
                                        <% 
                                                }
                                            } else { 
                                        %>
                                        <tr>
                                            <td colspan="9" class="text-center">No hay pacientes registrados.</td>
                                        </tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                                    
                                    <% if (enModoEdicion) { %>
                        <div class="card mb-4 border-warning shadow">
                            <div class="card-header bg-warning text-white">
                                <i class="fas fa-edit me-1"></i> Editar Paciente
                            </div>
                            <div class="card-body">
                                <form action="SvPaciente" method="POST">
                                    <input type="hidden" name="action" value="editar">
                                    <input type="hidden" name="id" value="<%= pacienteEditar.getId() %>">

                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="dni" name="dni" type="text" value="<%= pacienteEditar.getDni() %>" required />
                                                <label for="dni">DNI</label>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="nombre" name="nombre" type="text" value="<%= pacienteEditar.getNombre() %>" required />
                                                <label for="nombre">Nombre</label>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="apellidos" name="apellidos" type="text" value="<%= pacienteEditar.getApellidos() %>" required />
                                                <label for="apellidos">Apellidos</label>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="telefono" name="telefono" type="text" value="<%= pacienteEditar.getTelefono() %>" required />
                                                <label for="telefono">Teléfono</label>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="direccion" name="direccion" type="text" value="<%= pacienteEditar.getDireccion() %>" required />
                                                <label for="direccion">Dirección</label>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="fechaNac" name="fechaNac" type="date" 
                                                       value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(pacienteEditar.getFecha_nac()) %>" />
                                                <label for="fecha_nac">Fecha de Nacimiento</label>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row mb-3">
    <div class="col-md-6">
<div class="form-floating mb-3">
    <select class="form-select" id="eps" name="eps">
        <!-- Comparamos el valor de la EPS y seleccionamos la opción correspondiente -->
        <option value="SURA" <%= pacienteEditar.getEps().equals("SURA") ? "selected" : "" %>>SURA</option>
        <option value="Sanitas" <%= pacienteEditar.getEps().equals("Sanitas") ? "selected" : "" %>>Sanitas</option>
        <option value="Compensar" <%= pacienteEditar.getEps().equals("Compensar") ? "selected" : "" %>>Compensar</option>
        <option value="Nueva EPS" <%= pacienteEditar.getEps().equals("Nueva EPS") ? "selected" : "" %>>Nueva EPS</option>
        <option value="Coomeva" <%= pacienteEditar.getEps().equals("Coomeva") ? "selected" : "" %>>Coomeva</option>
        <option value="Salud Total" <%= pacienteEditar.getEps().equals("Salud Total") ? "selected" : "" %>>Salud Total</option>
        <option value="No aplica" <%= pacienteEditar.getEps().equals("No aplica") ? "selected" : "" %>>No aplica</option>
    </select>
    <label for="eps">EPS:</label>
</div>

    </div>

    <div class="col-md-6">
        <div class="form-floating mb-3">
            <select class="form-select" id="tipo_sangre" name="tipo_sangre" required>
                <%
                    String[] tiposSangre = { "O+", "O-", "A+", "A-", "B+", "B-", "AB+", "AB-" };
                    String tipoActual = pacienteEditar.getTipo_sangre();
                    for (String tipo : tiposSangre) {
                %>
                    <option value="<%= tipo %>" <%= tipo.equals(tipoActual) ? "selected" : "" %>><%= tipo %></option>
                <% } %>
            </select>
            <label for="tipo_sangre">Tipo de Sangre</label>
        </div>
    </div>
</div>
<div class="col-md-6">
    <div class="form-floating mb-3">
        <select class="form-select" id="responsableId" name="responsableId" required>
            <%
                List<Responsable> listaResponsables = (List<Responsable>) session.getAttribute("listaResponsables");
                if (listaResponsables != null) {
                    for (Responsable resp : listaResponsables) {
                        String selected = (pacienteEditar.getResponsable() != null &&
                                           pacienteEditar.getResponsable().getId() == resp.getId()) ? "selected" : "";
            %>
                        <option value="<%= resp.getId() %>" <%= selected %>><%= resp.getNombre() %> <%= resp.getApellidos() %></option>
            <%
                    }
                } else {
            %>
                <option value="">No hay responsables disponibles</option>
            <% } %>
        </select>
        <label for="responsableId">Responsable</label>
    </div>
</div>


                                    <div class="mt-4 mb-0 d-flex justify-content-end">
                                        <a href="SvPaciente" class="btn btn-secondary me-2">Cancelar</a>
                                        <button type="submit" class="btn btn-warning text-white">Guardar Cambios</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <% } %>

                    </div>
                </main>
                <%@include file="Layout/footer.jsp" %>
            </div>
        </div>

        <%@include file="Layout/script.jsp" %>
    </body>
</html>
