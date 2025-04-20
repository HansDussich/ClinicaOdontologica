<%@page import="com.clinicaodon.Entity.Usuario"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Usuario usuarioEditar = (Usuario) session.getAttribute("usuarioEditar");
    boolean enModoEdicion = usuarioEditar != null;
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
                    <h1 class="mt-4">Lista de Usuarios</h1>
                    <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item"><a href="index.jsp">Inicio</a></li>
                        <li class="breadcrumb-item active">Ver Usuarios</li>
                    </ol>

                    <% if (enModoEdicion) { %>
                    <!-- Formulario de edición -->
                    <div class="card mb-4 border-warning">
                        <div class="card-header bg-warning text-dark">
                            <i class="fas fa-edit me-1"></i> Editar Usuario
                        </div>
                        <div class="card-body">
                            <form action="SvUsuarios" method="POST">
                                <input type="hidden" name="action" value="editar">
                                <input type="hidden" name="id" value="<%= usuarioEditar.getId_usuario() %>">

                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <div class="form-floating mb-3">
                                            <input class="form-control" id="nombre_usuario" name="nombre_usuario" type="text" value="<%= usuarioEditar.getNombre_usuario() %>" required />
                                            <label for="nombre_usuario">Nombre de Usuario</label>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-floating mb-3">
                                            <input class="form-control" id="contrasena" name="contrasena" type="password" value="<%= usuarioEditar.getContraseña() %>" required />
                                            <label for="contrasena">Contraseña</label>
                                        </div>
                                    </div>
                                </div>

                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <div class="form-floating mb-3">
                                            <input class="form-control" id="rol" name="rol" type="text" value="<%= usuarioEditar.getRol() %>" required />
                                            <label for="rol">Rol</label>
                                        </div>
                                    </div>
                                </div>

                                <div class="mt-4 mb-0 d-flex justify-content-end">
                                    <a href="SvUsuarios" class="btn btn-secondary me-2">Cancelar</a>
                                    <button type="submit" class="btn btn-warning text-white">Guardar Cambios</button>
                                </div>
                            </form>
                        </div>
                    </div>
                    <% } %>

                    <!-- Tabla de usuarios -->
                    <div class="card mb-4">
                        <div class="card-header">
                            <i class="fas fa-table me-1"></i>
                            Usuarios Registrados
                            <div class="float-end">
                                <a href="altaUsuario.jsp" class="btn btn-primary btn-sm">
                                    <i class="fas fa-plus"></i> Nuevo Usuario
                                </a>
                            </div>
                        </div>
                        <div class="card-body">
                            <table id="datatablesSimple" class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Nombre Usuario</th>
                                        <th>Rol</th>
                                        <th width="10%">Acciones</th>
                                    </tr>
                                </thead>
                                <tfoot>
                                    <tr>
                                        <th>ID</th>
                                        <th>Nombre Usuario</th>
                                        <th>Rol</th>
                                        <th>Acciones</th>
                                    </tr>
                                </tfoot>
                                <%
                                    List<Usuario> listaUsuarios = (List) request.getSession().getAttribute("listaUsuarios");
                                %>
                                <tbody>
                                    <% for (Usuario usu : listaUsuarios) { %>
                                    <tr>
                                        <td><%= usu.getId_usuario() %></td>
                                        <td><%= usu.getNombre_usuario() %></td>
                                        <td><%= usu.getRol() %></td>
                                        <td>
                                            <!-- Eliminar -->
                                            <form action="SvUsuarios" method="POST" style="display:inline;">
                                                <input type="hidden" name="action" value="eliminar">
                                                <input type="hidden" name="id" value="<%= usu.getId_usuario() %>">
                                                <button type="submit" class="btn btn-danger btn-sm">
                                                    <i class="fas fa-trash-alt"></i>
                                                </button>
                                            </form>
                                            <!-- Editar -->
                                            <form action="SvUsuarios" method="GET" style="display:inline;">
                                                <input type="hidden" name="id" value="<%= usu.getId_usuario() %>">
                                                <button type="submit" class="btn btn-primary btn-sm">
                                                    <i class="fas fa-edit"></i>
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </main>

            <%@include file="Layout/footer.jsp" %>
        </div>
    </div>

     <%@include file="Layout/script.jsp" %>

        

</body>
</html>
