<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es">
    <!-- Resto del código sin duplicados -->
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Acceso a Dentalia</title>
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <style>
            body {
                background: linear-gradient(to right, #00c6ff, #0072ff);
                height: 100vh;
                display: flex;
                justify-content: center;
                align-items: center;
            }
            .card {
                background: rgba(255, 255, 255, 0.9);
                box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
                border-radius: 15px;
            }
            .btn-primary {
                background-color: #0072ff;
                border: none;
                transition: 0.3s;
            }
            .btn-primary:hover {
                background-color: #0056d2;
            }
            .form-control {
                border-radius: 10px;
            }
            .card-header h3 {
                font-weight: bold;
                color: #0072ff;
            }
            a.small {
                color: #0072ff;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-5">
                    <div class="card shadow-lg border-0 rounded-lg mt-5 p-4">
                        <div class="card-header text-center">
                            <h3>Acceso a Dentalia</h3>
                        </div>
                        <div class="card-body">
                            

                            <form action="svLogin" method="POST">
                                <div class="form-floating mb-3">
                                    <input class="form-control" id="usuario" name="usuario" type="text" placeholder="Nombre de usuario" required>
                                    <label for="usuario">Nombre de usuario</label>
                                </div>
                                <div class="form-floating mb-3">
                                    <input class="form-control" id="contrasena" name="contrasena" type="password" placeholder="Contraseña" required>
                                    <label for="contrasena">Contraseña</label>
                                </div>
                                <div class="d-flex align-items-center justify-content-between mt-4 mb-0">
                                    <a class="small" href="password.html">¿Has olvidado tu contraseña?</a>
                                    <button class="btn btn-primary px-4 py-2" type="submit">Ingresar</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>

