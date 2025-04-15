<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro de Usuario | Plataforma Eventos</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #2c3e50;
            --secondary-color: #FFD700;
            --error-color: #e74c3c;
            --success-color: #2ecc71;
            --text-color: #333;
            --light-gray: #f5f5f5;
            --white: #ffffff;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--light-gray);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background-image: linear-gradient(135deg, rgba(44, 62, 80, 0.8) 0%, rgba(0, 0, 0, 0.8) 100%), url('https://images.unsplash.com/photo-1511578314322-379afb476865?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80');
            background-size: cover;
            background-position: center;
        }
        
        .register-container {
            width: 100%;
            max-width: 500px;
            padding: 40px;
            background-color: rgba(255, 255, 255, 0.95);
            border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            transform: translateY(0);
            transition: all 0.3s ease;
            color: var(--primary-color);
        }
        
        .register-container:hover {
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.3);
            transform: translateY(-5px);
        }
        
        .title {
            text-align: center;
            margin-bottom: 30px;
            font-size: 28px;
            color: var(--primary-color);
            position: relative;
        }
        
        .title::after {
            content: '';
            display: block;
            width: 60px;
            height: 4px;
            background: var(--secondary-color);
            margin: 10px auto;
            border-radius: 2px;
        }
        
        .form-group {
            position: relative;
            margin-bottom: 25px;
        }
        
        .form-group i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--primary-color);
            font-size: 16px;
        }
        
        .form-control {
            width: 100%;
            padding: 15px 15px 15px 45px;
            border: 2px solid #e1e1e1;
            border-radius: 6px;
            font-size: 16px;
            transition: all 0.3s;
            background-color: var(--light-gray);
        }
        
        .form-control:focus {
            border-color: var(--secondary-color);
            outline: none;
            box-shadow: 0 0 0 3px rgba(255, 215, 0, 0.2);
            background-color: var(--white);
        }
        
        .form-select {
            width: 100%;
            padding: 15px 15px 15px 45px;
            border: 2px solid #e1e1e1;
            border-radius: 6px;
            font-size: 16px;
            background-color: var(--light-gray);
            appearance: none;
            background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='currentColor' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
            background-repeat: no-repeat;
            background-position: right 15px center;
            background-size: 1em;
        }
        
        .form-select:focus {
            border-color: var(--secondary-color);
            outline: none;
            box-shadow: 0 0 0 3px rgba(255, 215, 0, 0.2);
            background-color: var(--white);
        }
        
        .btn {
            width: 100%;
            padding: 15px;
            background-color: var(--primary-color);
            color: var(--white);
            border: none;
            border-radius: 6px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            margin-top: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }
        
        .btn:hover {
            background-color: #1a252f;
            transform: translateY(-2px);
        }
        
        .extra-links {
            margin-top: 25px;
            text-align: center;
        }
        
        .extra-links a {
            color: var(--primary-color);
            text-decoration: none;
            font-size: 14px;
            transition: all 0.3s;
            display: inline-block;
        }
        
        .extra-links a:hover {
            color: var(--secondary-color);
            transform: translateX(5px);
        }
        
        .error-message {
            color: var(--error-color);
            padding: 12px;
            margin-bottom: 20px;
            border-radius: 6px;
            background-color: #fadbd8;
            text-align: center;
            font-size: 14px;
            font-weight: 500;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }
        
        .logo {
            text-align: center;
            margin-bottom: 20px;
            font-size: 24px;
            font-weight: bold;
            color: var(--secondary-color);
        }
        
        @media (max-width: 480px) {
            .register-container {
                padding: 30px 20px;
                margin: 20px;
            }
        }
    </style>
</head>
<body>
    <div class="register-container">
        <div class="logo">
            <i class="fas fa-ticket-alt"></i> UpiiTicket
        </div>
        <h1 class="title">Crear Cuenta</h1>
        
        <%-- Mostrar mensaje de error si existe --%>
        <% String error = request.getParameter("error");
           if ("1".equals(error)) { %>
            <div class="error-message">
                <i class="fas fa-exclamation-circle"></i> Error al registrar usuario. Intente con otro correo.
            </div>
        <% } else if ("2".equals(error)) { %>
            <div class="error-message">
                <i class="fas fa-exclamation-circle"></i> La contraseña no puede estar vacía.
            </div>
        <% } %>
        
        <form action="${pageContext.request.contextPath}/registrarUsuario" method="post">
            <div class="form-group">
                <i class="fas fa-user"></i>
                <input type="text" name="nombre" class="form-control" placeholder="Nombre completo" required>
            </div>
            
            <div class="form-group">
                <i class="fas fa-envelope"></i>
                <input type="email" name="correo" class="form-control" placeholder="Correo electrónico" required>
            </div>
            
            <div class="form-group">
                <i class="fas fa-lock"></i>
                <input type="password" name="contrasena" class="form-control" placeholder="Contraseña" required>
            </div>
            
            <div class="form-group">
                <i class="fas fa-user-tag"></i>
                <select name="rol" class="form-select" required>
                    <option value="" disabled selected>Selecciona un rol</option>
                    <option value="Organizador">Organizador</option>
                    <option value="Asistente">Asistente</option>
                </select>
            </div>
            
            <button type="submit" class="btn">
                <i class="fas fa-user-plus"></i> Registrarse
            </button>
        </form>
        
        <div class="extra-links">
            <a href="${pageContext.request.contextPath}/login.html">
                <i class="fas fa-sign-in-alt"></i> ¿Ya tienes cuenta? Inicia sesión
            </a>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Agitar el formulario si hay errores
            if (document.querySelector('.error-message')) {
                document.querySelector('.register-container').animate([
                    { transform: 'translateX(0)' },
                    { transform: 'translateX(-10px)' },
                    { transform: 'translateX(10px)' },
                    { transform: 'translateX(0)' }
                ], {
                    duration: 300,
                    iterations: 2
                });
            }
            
            // Validación de contraseña en tiempo real
            const passwordInput = document.querySelector('input[name="contrasena"]');
            if (passwordInput) {
                passwordInput.addEventListener('input', function() {
                    if (this.value.length > 0 && this.value.length < 6) {
                        this.style.borderColor = 'var(--error-color)';
                    } else {
                        this.style.borderColor = '';
                    }
                });
            }
        });
    </script>
</body>
</html>



