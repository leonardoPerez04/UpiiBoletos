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
    <title>Menú Asistente</title>
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
    </style>
</head>
<body>
    <jsp:include page="navbar.jsp" />
    
    <div class="main-container">
        <h1 class="page-title">Bienvenido, <span class="username"><%= usuario.getNombre() %></span></h1>
        
        <ul class="menu-list">
            <li class="menu-item">
                <a href="editarDatos.jsp" class="menu-link">
                    <i class="fas fa-user-edit"></i> Editar Datos Personales
                </a>
            </li>
            <li class="menu-item">
                <a href="misCodigos.jsp" class="menu-link">
                    <i class="fas fa-ticket-alt"></i> Mis Códigos de Preventa
                </a>
            </li>
            <li class="menu-item">
                <a href="principalAsistente.jsp" class="menu-link">
                    <i class="fas fa-calendar-check"></i> Eventos Disponibles
                </a>
            </li>
        </ul>
        
        <div class="btn-group">
            <button onclick="window.history.back()" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i> Volver
            </button>
            <a href="${pageContext.request.contextPath}/cerrarSesion" class="btn btn-danger">
                <i class="fas fa-sign-out-alt"></i> Cerrar Sesión
            </a>
        </div>
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
        });
    </script>
</body>
</html>
