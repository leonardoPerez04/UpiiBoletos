<%@page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.DriverManager"%>
<%@page import="com.upiiticket.dao.Conexion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String error = request.getParameter("error");
    if ("1".equals(error)) {
%>
    <p style="color: red;">Error: Debes ingresar todos los datos.</p>
<%
    } else if ("2".equals(error)) {
%>
    <p style="color: red;">Ya tienes un código registrado para este evento.</p>
<%
    } else if ("3".equals(error)) {
%>
    <p style="color: red;">Error al procesar la solicitud. Intenta nuevamente.</p>
<%
    }

    String success = request.getParameter("success");
    if ("1".equals(success)) {
%>
    <p style="color: green;">¡Código generado exitosamente!</p>
<%
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Solicitar Código de Acceso</title>
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
            padding: 50px;
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
        
        .form-select {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
            background-color: white;
            appearance: none;
            background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='currentColor' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
            background-repeat: no-repeat;
            background-position: right 10px center;
            background-size: 1em;
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
        <h1 class="page-title">
            <i class="fas fa-ticket-alt"></i> Solicitar Código de Acceso
        </h1>
        
        <form action="../GenerarCodigoServlet" method="post">
            <div class="form-group">
                <label for="correo" class="form-label">
                    <i class="fas fa-envelope"></i> Correo Electrónico:
                </label>
                <input type="email" id="correo" name="correo" class="form-control" 
                       placeholder="Ingresa tu correo" required>
            </div>
            
            <div class="form-group">
                <label for="id_evento" class="form-label">
                    <i class="fas fa-calendar-alt"></i> Selecciona el Evento:
                </label>
                <select id="id_evento" name="id_evento" class="form-select" required>
                    <option value="">-- Selecciona un evento --</option>
                    <%
                        Connection con = Conexion.getConnection();
                        String sql = "SELECT id_evento, titulo FROM Eventos ORDER BY titulo";
                        PreparedStatement ps = con.prepareStatement(sql);
                        ResultSet rs = ps.executeQuery();
                        while (rs.next()) {
                    %>
                        <option value="<%= rs.getInt("id_evento") %>"><%= rs.getString("titulo") %></option>
                    <%
                        }
                        con.close();
                    %>
                </select>
            </div>
            
            <button type="submit" class="btn">
                <i class="fas fa-paper-plane"></i> Solicitar Código
            </button>
        </form>
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
