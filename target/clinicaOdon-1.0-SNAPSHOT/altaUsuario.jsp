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
                        <h1 class="mt-4">Alta de Usuario</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item"><a href="index.jsp">Inicio</a></li>
                            <li class="breadcrumb-item"><a href="verUsuarios.jsp">Ver Usuarios</a></li>
                            <li class="breadcrumb-item active">Alta Usuario</li>
                        </ol>

                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-user-plus me-1"></i>
                                Nuevo Usuario
                            </div>
                            <div class="card-body">
                                
                                <form action="SvUsuarios" method="POST" >
                                    <input type="hidden" name="action" value="crear">

                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="nombre_usuario" name="nombre_usuario" type="text" required />
                                                <label for="nombre_usuario">Nombre de Usuario</label>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="contrasena" name="contrasena" type="password" required />
                                                <label for="contrasena">Contraseña</label>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <div class="form-floating mb-3">
                                                <select class="form-select" id="rol" name="rol" required>
                                                    <option value="" disabled selected>Selecciona un rol</option>
                                                    <option value="ADMIN">Admin</option>
                                                    <option value="SECRETARIO">Secretario</option>
                                                    <option value="ODONTOLOGO">Odontólogo</option>
                                                </select>
                                                <label for="rol">Rol</label>
                                            </div>
                                        </div>
                                        
                                        <div id="personaContainer" class="col-md-6" style="display: none;">
    <div class="form-floating mb-3">
        <select class="form-select" id="persona_id" name="persona_id" required>
            <!-- Opciones serán llenadas con JS -->
        </select>
        <label for="persona_id">Selecciona la Persona</label>
    </div>
</div>

                                        

                                    </div>

                                    <!-- Botones fuera del row de inputs -->
                                    <div class="mt-4 mb-0">
                                        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                            <a href="verUsuarios.jsp" class="btn btn-secondary">Cancelar</a>
                                            <button type="submit" class="btn btn-primary">Guardar Usuario</button>
                                        </div>
                                    </div>


                            </div>

                            </form>
                        </div>
                    </div>

                </main>
                <%@include file="Layout/footer.jsp" %>

            </div>
                <a href="altaUsuario.jsp"></a>
        </div>

<script>
document.getElementById("rol").addEventListener("change", function () {
    const rol = this.value;
    const personaContainer = document.getElementById("personaContainer");
    const personaSelect = document.getElementById("persona_id");

    if (rol === "SECRETARIO" || rol === "ODONTOLOGO") {
        fetch("SvUsuarios?tipo=getPersonasPorRol&rol=" + rol)
            .then(response => response.json())
            .then(data => {
                personaSelect.innerHTML = "";
data.forEach(persona => {
    const option = document.createElement("option");
    option.value = persona.id;
    option.textContent = persona.nombre + " " + persona.apellidos;
    personaSelect.appendChild(option);
});

                personaContainer.style.display = "block";
            });
    } else {
        personaContainer.style.display = "none";
        personaSelect.innerHTML = "";
    }
});
</script>



        <!-- Scripts -->
        <%@include file="Layout/script.jsp" %>
    </body>
</html>