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
    <title>Menú Organizador | Plataforma Eventos</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* Estilos consistentes con el tema */
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
        <h1 class="page-title">Bienvenido, <span class="username"><%= usuario.getNombre() %></span></h1>
        
        <ul class="menu-list">
            <li class="menu-item">
                <a href="editarDatosOrga.jsp" class="menu-link">
                    <i class="fas fa-user-edit"></i> Editar Datos Personales
                </a>
            </li>
            <li class="menu-item">
                <a href="gestionarEventos.jsp" class="menu-link">
                    <i class="fas fa-calendar-alt"></i> Gestionar Eventos
                </a>
            </li>
            <li class="menu-item">
                <a href="reportes.jsp" class="menu-link">
                    <i class="fas fa-chart-bar"></i> Reportes y Estadísticas
                </a>
            </li>
        </ul>
        
        <div class="btn-group">
            <a href="principalOrganizador.jsp" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i> Volver al Inicio
            </a>
            <a href="${pageContext.request.contextPath}/cerrarSesion" class="btn btn-danger">
                <i class="fas fa-sign-out-alt"></i> Cerrar Sesión
            </a>
        </div>
    </div>

    <script>
        // Control de la barra de navegación al hacer scroll
        document.addEventListener('DOMContentLoaded', function() {
            const navbar = document.getElementById('mainNavbar');
            let lastScroll = 0;
            
            window.addEventListener('scroll', function() {
                const currentScroll = window.pageYOffset;
                
                if (currentScroll <= 0) {
                    navbar.classList.remove('hidden');
                    return;
                }
                
                if (currentScroll > lastScroll && !navbar.classList.contains('hidden')) {
                    navbar.classList.add('hidden');
                } else if (currentScroll < lastScroll && navbar.classList.contains('hidden')) {
                    navbar.classList.remove('hidden');
                }
                
                lastScroll = currentScroll;
            });
        });
    </script>
</body>
</html>
