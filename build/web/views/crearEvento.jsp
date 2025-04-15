<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Crear Nuevo Evento | Plataforma Eventos</title>
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
        }
        
        .page-title {
            color: #2c3e50;
            text-align: center;
            margin-bottom: 30px;
            font-size: 28px;
            position: relative;
        }
        
        .page-title::after {
            content: '';
            display: block;
            width: 60px;
            height: 4px;
            background: #FFD700;
            margin: 10px auto;
            border-radius: 2px;
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
        
        textarea.form-control {
            min-height: 100px;
            resize: vertical;
        }
        
        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            width: 100%;
            padding: 12px;
            background-color: #2ecc71;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            margin-top: 10px;
        }
        
        .btn:hover {
            background-color: #27ae60;
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
                <i class="fas fa-user-tie"></i> Organizador: <span class="username-nav">
                    <%= session.getAttribute("usuario") != null ? 
                       ((com.upiiticket.model.Usuario)session.getAttribute("usuario")).getNombre() : "Invitado" %>
                </span>
            </div>
            <ul class="nav-list">
                <li class="nav-item"><a href="principalOrganizador.jsp" class="nav-link"><i class="fas fa-home"></i> Inicio</a></li>
                <li class="nav-item"><a href="crearEvento.jsp" class="nav-link active"><i class="fas fa-plus-circle"></i> Crear Evento</a></li>
                <li class="nav-item"><a href="gestionarEventos.jsp" class="nav-link"><i class="fas fa-tasks"></i> Gestionar</a></li>
                <li class="nav-item"><a href="${pageContext.request.contextPath}/cerrarSesion" class="nav-link logout"><i class="fas fa-sign-out-alt"></i> Cerrar Sesión</a></li>
            </ul>
        </div>
    </nav>
    
    <div class="main-container">
        <h1 class="page-title">
            <i class="fas fa-calendar-plus"></i> Crear Nuevo Evento
        </h1>
        
        <form action="../CrearEventoServlet" method="post">
            <div class="form-group">
                <label for="titulo" class="form-label">
                    <i class="fas fa-heading"></i> Título del Evento:
                </label>
                <input type="text" id="titulo" name="titulo" class="form-control" placeholder="Ej: Conferencia de Tecnología" required>
            </div>
            
            <div class="form-group">
                <label for="descripcion" class="form-label">
                    <i class="fas fa-align-left"></i> Descripción:
                </label>
                <textarea id="descripcion" name="descripcion" class="form-control" placeholder="Describe el evento..." required></textarea>
            </div>
            
            <div class="form-group">
                <label for="fecha" class="form-label">
                    <i class="fas fa-calendar-day"></i> Fecha y Hora:
                </label>
                <input type="datetime-local" id="fecha" name="fecha" class="form-control" required>
            </div>
            
            <div class="form-group">
                <label for="lugar" class="form-label">
                    <i class="fas fa-map-marker-alt"></i> Lugar:
                </label>
                <input type="text" id="lugar" name="lugar" class="form-control" placeholder="Ej: Auditorio Principal" required>
            </div>
            
            <div class="form-group">
                <label for="cupo" class="form-label">
                    <i class="fas fa-users"></i> Cupo Total:
                </label>
                <input type="number" id="cupo" name="cupo" class="form-control" placeholder="Ej: 100" min="1" required>
            </div>
            
            <button type="submit" class="btn">
                <i class="fas fa-check"></i> Crear Evento
            </button>
        </form>
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

            // Establecer fecha mínima como hoy
            const fechaInput = document.getElementById('fecha');
            const hoy = new Date();
            const fechaHoy = hoy.toISOString().slice(0, 16);
            fechaInput.min = fechaHoy;
        });
    </script>
</body>
</html>
