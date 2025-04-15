<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.upiiticket.model.Usuario" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    HttpSession sesion = request.getSession(false);
    if (sesion == null || sesion.getAttribute("usuario") == null) {
        response.sendRedirect("../login.html");
        return;
    }
    Usuario usuario = (Usuario) sesion.getAttribute("usuario");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Datos Personales</title>
    <link rel="stylesheet" href="../css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            padding-top: 70px;
            background-color: #f5f5f5;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .main-container {
            max-width: 600px;
            margin: 30px auto;
            padding: 30px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }
        
        .page-title {
            color: #2c3e50;
            text-align: center;
            margin-bottom: 30px;
            font-size: 28px;
        }
        
        .username {
            color: #FFD700;
            font-weight: 600;
        }
        
        .menu-list {
            list-style: none;
            padding: 0;
            margin: 30px 0;
        }
        
        .menu-item {
            margin-bottom: 15px;
        }
                .menu-link {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            padding: 12px 20px;
            background-color: #2c3e50;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            font-weight: 500;
            transition: all 0.3s;
        }
        
        .menu-link:hover {
            background-color: #1a252f;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        
        .menu-link i {
            font-size: 16px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-label {
            display: block;
            margin-bottom: 8px;
            color: #2c3e50;
            font-weight: 500;
        }
        
        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
            transition: all 0.3s;
        }
        
        .form-control:focus {
            border-color: #FFD700;
            outline: none;
            box-shadow: 0 0 0 3px rgba(255, 215, 0, 0.2);
        }
        
        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            width: 100%;
            padding: 12px;
            background-color: #FFD700;
            color: #2c3e50;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            margin-top: 10px;
        }
        
        .btn:hover {
            background-color: #e6c200;
            transform: translateY(-2px);
        }
        
        .btn i {
            font-size: 14px;
        }
        
        .btn-secondary {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            width: 100%;
            padding: 12px;
            background-color: #95a5a6;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            margin-top: 15px;
            text-decoration: none;
        }
        
        .btn-secondary:hover {
            background-color: #7f8c8d;
            transform: translateY(-2px);
        }
        
        .error-message {
            color: #e74c3c;
            padding: 10px;
            margin-top: 15px;
            border-radius: 4px;
            background-color: #fadbd8;
            text-align: center;
            display: none;
        }
        
        /* Estilos para la barra de navegación */
        .navbar {
            background: rgba(40, 40, 40, 0.95);
            padding: 10px 0;
            width: 100%;
            position: fixed;
            top: 0;
            left: 0;
            z-index: 1000;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
            backdrop-filter: blur(5px);
            transition: transform 0.3s ease-in-out;
        }
        
        .navbar.hidden {
            transform: translateY(-100%);
        }
                body {
            padding-top: 70px;
            background-color: #f5f5f5;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .main-container {
            max-width: 600px;
            margin: 30px auto;
            padding: 30px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        
        .page-title {
            color: #2c3e50;
            margin-bottom: 30px;
            font-size: 28px;
        }
        
        .username {
            color: #FFD700;
            font-weight: 600;
        }
        
        .menu-list {
            list-style: none;
            padding: 0;
            margin: 30px 0;
        }
        
        .menu-item {
            margin-bottom: 15px;
        }
        
        .menu-link {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            padding: 12px 20px;
            background-color: #2c3e50;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            font-weight: 500;
            transition: all 0.3s;
        }
        
        .menu-link:hover {
            background-color: #1a252f;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        
        .menu-link i {
            font-size: 16px;
        }
        
        .btn-group {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-top: 30px;
        }
        
        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            font-size: 15px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
        }
        
        .btn-secondary {
            background-color: #95a5a6;
            color: white;
        }
        
        .btn-secondary:hover {
            background-color: #7f8c8d;
            transform: translateY(-2px);
        }
        
        .btn-danger {
            background-color: #e74c3c;
            color: white;
        }
        
        .btn-danger:hover {
            background-color: #c0392b;
            transform: translateY(-2px);
        }
        
        /* Barra de navegación */
        .navbar {
            background: rgba(40, 40, 40, 0.95);
            padding: 10px 0;
            width: 100%;
            position: fixed;
            top: 0;
            left: 0;
            z-index: 1000;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
            backdrop-filter: blur(5px);
            transition: transform 0.3s ease-in-out;
        }
        
        .navbar-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .user-welcome {
            color: #f0f0f0;
            font-size: 16px;
            font-weight: 500;
        }
        
        .username-nav {
            color: #FFD700;
            font-weight: 600;
        }
        
        .nav-list {
            list-style-type: none;
            margin: 0;
            padding: 0;
            display: flex;
            gap: 15px;
            align-items: center;
        }
        
        .nav-item {
            margin: 0;
        }
        
        .nav-link {
            color: #f0f0f0;
            text-decoration: none;
            font-size: 15px;
            padding: 8px 15px;
            border-radius: 4px;
            transition: all 0.2s ease;
            display: flex;
            align-items: center;
            font-weight: 500;
            gap: 8px;
        }
        
        .nav-link:hover {
            background: rgba(255, 215, 0, 0.15);
            color: #FFD700;
        }
        
        .logout {
            background: rgba(255, 80, 80, 0.2);
            border: 1px solid rgba(255, 80, 80, 0.4);
        }
        
        .logout:hover {
            background: rgba(255, 80, 80, 0.3);
        }
        
        .navbar.hidden {
            transform: translateY(-100%);
        }
    </style>
</head>
<body>
        <!-- Barra de navegación -->
    <nav class="navbar" id="mainNavbar">
        <div class="navbar-container">
            <div class="user-welcome">
                <i class="fas fa-user-tie"></i> Organizador: <span class="username-nav"><%= usuario.getNombre() %></span>
            </div>
            <ul class="nav-list">
                <li class="nav-item"><a href="principalOrganizador.jsp" class="nav-link"><i class="fas fa-home"></i> Inicio</a></li>
                <li class="nav-item"><a href="crearEvento.jsp" class="nav-link"><i class="fas fa-plus-circle"></i> Crear Evento</a></li>
                <li class="nav-item"><a href="menuOrganizador.jsp" class="nav-link"><i class="fas fa-cog"></i> Configuración</a></li>
                <li class="nav-item"><a href="${pageContext.request.contextPath}/cerrarSesion" class="nav-link logout"><i class="fas fa-sign-out-alt"></i> Cerrar Sesión</a></li>
            </ul>
        </div>
    </nav>
    
    <div class="main-container">
        <h1 class="page-title">
            <i class="fas fa-user-edit"></i> Editar Datos Personales
        </h1>
        
        <form action="../ActualizarUsuario" method="post">
            <input type="hidden" name="id" value="<%= usuario.getId() %>">
            
            <div class="form-group">
                <label for="nombre" class="form-label">
                    <i class="fas fa-user"></i> Nombre:
                </label>
                <input type="text" id="nombre" name="nombre" value="<%= usuario.getNombre() %>" 
                       class="form-control" required>
            </div>
            
            <div class="form-group">
                <label for="correo" class="form-label">
                    <i class="fas fa-envelope"></i> Correo Electrónico:
                </label>
                <input type="email" id="correo" name="correo" value="<%= usuario.getCorreo() %>" 
                       class="form-control" required>
            </div>
            
            <div class="form-group">
                <label for="contrasena" class="form-label">
                    <i class="fas fa-lock"></i> Nueva Contraseña (dejar en blanco para no cambiar):
                </label>
                <input type="password" id="contrasena" name="contrasena" 
                       class="form-control" placeholder="••••••••">
            </div>
            
            <button type="submit" class="btn">
                <i class="fas fa-save"></i> Guardar Cambios
            </button>
        </form>
        
        <div id="error-message" class="error-message"></div>
        
        <button onclick="window.history.back()" class="btn-secondary">
            <i class="fas fa-arrow-left"></i> Volver
        </button>
    </div>

    <script>
        // Control de la barra de navegación al hacer scroll
        document.addEventListener('DOMContentLoaded', function() {
            const navbar = document.querySelector('.navbar');
            let lastScroll = 0;
            
            window.addEventListener('scroll', function() {
                const currentScroll = window.pageYOffset;
                
                if (currentScroll <= 0) {
                    // Estamos en la parte superior de la página
                    navbar.classList.remove('hidden');
                    return;
                }
                
                if (currentScroll > lastScroll && !navbar.classList.contains('hidden')) {
                    // Scroll hacia abajo - ocultar barra
                    navbar.classList.add('hidden');
                } else if (currentScroll < lastScroll && navbar.classList.contains('hidden')) {
                    // Scroll hacia arriba - mostrar barra
                    navbar.classList.remove('hidden');
                }
                
                lastScroll = currentScroll;
            });

            // Mostrar mensaje de error si existe en la URL
            const urlParams = new URLSearchParams(window.location.search);
            const error = urlParams.get('error');
            const errorMessage = document.getElementById('error-message');
            
            if (error) {
                errorMessage.style.display = 'block';
                switch(error) {
                    case '1':
                        errorMessage.textContent = 'Error: El correo ya está registrado';
                        break;
                    case '2':
                        errorMessage.textContent = 'Error: No se pudieron actualizar los datos';
                        break;
                    default:
                        errorMessage.textContent = 'Error desconocido al actualizar los datos';
                }
            }
        });
    </script>
</body>
</html>
