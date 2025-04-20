<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                        <h1 class="mt-4">Alta de Secretarios</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item"><a href="index.jsp">Inicio</a></li>
                            <li class="breadcrumb-item active">Alta de Secretarios</li>
                        </ol>
                        
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-user-plus me-1"></i>
                                Formulario de Alta de Secretario
                            </div>
                            <div class="card-body">
                                <form action="SvSecretario" method="POST">
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
                                        <label for="apellidos" class="form-label">Apellidos:</label>
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
                                        <label for="sector" class="form-label">Sector</label>
                                        <input type="text" class="form-control" id="sector" name="sector" required>
                                    </div>

                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-save me-1"></i> Guardar
                                    </button>
                                    <a href="verSecretarios.jsp" class="btn btn-secondary">
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
        
        <%@include file="Layout/script.jsp" %>
    </body>
</html>
