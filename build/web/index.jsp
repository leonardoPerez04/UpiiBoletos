<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bienvenido a UpiiTicket</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #2c3e50;
            --secondary-color: #FFD700;
            --text-color: #ffffff;
            --light-gray: #f5f5f5;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            background-image: linear-gradient(135deg, rgba(44, 62, 80, 0.9) 0%, rgba(0, 0, 0, 0.9) 100%), url('https://images.unsplash.com/photo-1531058020387-3be344556be6?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80');
            background-size: cover;
            background-position: center;
            color: var(--text-color);
            display: flex;
            flex-direction: column;
            overflow-x: hidden;
        }
        
        .hero {
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            padding: 2rem;
            position: relative;
            z-index: 1;
        }
        
        .logo {
            font-size: 4rem;
            font-weight: bold;
            margin-bottom: 1.5rem;
            color: var(--secondary-color);
            display: flex;
            align-items: center;
            gap: 15px;
            animation: fadeInDown 1s ease;
        }
        
        .logo i {
            font-size: 3.5rem;
        }
        
        h1 {
            font-size: 3rem;
            margin-bottom: 1.5rem;
            background: linear-gradient(to right, var(--secondary-color), #ffffff);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            animation: fadeIn 1.5s ease;
        }
        
        .tagline {
            font-size: 1.5rem;
            max-width: 800px;
            margin: 0 auto 2.5rem;
            line-height: 1.6;
            animation: fadeIn 2s ease;
        }
        
        .btn {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            padding: 15px 40px;
            background-color: var(--secondary-color);
            color: var(--primary-color);
            border: none;
            border-radius: 50px;
            font-size: 1.2rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
            margin-top: 1rem;
            animation: pulse 2s infinite;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
        }
        
        .btn:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.3);
            background-color: #ffea80;
        }
        
        .features {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 2rem;
            margin: 3rem auto;
            max-width: 1200px;
            padding: 0 2rem;
        }
        
        .feature-card {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 2rem;
            width: 300px;
            text-align: center;
            transition: all 0.3s;
            border: 1px solid rgba(255, 255, 255, 0.1);
        }
        
        .feature-card:hover {
            transform: translateY(-10px);
            background: rgba(255, 255, 255, 0.15);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.2);
        }
        
        .feature-icon {
            font-size: 2.5rem;
            color: var(--secondary-color);
            margin-bottom: 1rem;
        }
        
        .feature-title {
            font-size: 1.5rem;
            margin-bottom: 1rem;
            color: var(--secondary-color);
        }
        
        .feature-desc {
            font-size: 1rem;
            line-height: 1.6;
        }
        
        footer {
            text-align: center;
            padding: 2rem;
            background: rgba(0, 0, 0, 0.3);
            margin-top: auto;
        }
        
        .particles {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
        }
        
        /* Animaciones */
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        
        @keyframes fadeInDown {
            from {
                opacity: 0;
                transform: translateY(-50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }
        
        /* Efectos de partículas */
        .particle {
            position: absolute;
            background-color: var(--secondary-color);
            border-radius: 50%;
            opacity: 0.6;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .logo {
                font-size: 2.5rem;
            }
            
            h1 {
                font-size: 2rem;
            }
            
            .tagline {
                font-size: 1.2rem;
            }
            
            .features {
                flex-direction: column;
                align-items: center;
            }
        }
    </style>
</head>
<body>
    <div class="hero">
        <div class="logo">
            <i class="fas fa-ticket-alt"></i> UpiiTicket
        </div>
        
        <h1>Tu solución integral para gestión de eventos</h1>
        
        <p class="tagline">
            Simplificamos la creación, gestión y venta de entradas para tus eventos. 
            Una plataforma todo-en-uno para organizadores y asistentes.
        </p>
        
        <a href="login.html" class="btn">
            <i class="fas fa-sign-in-alt"></i> Acceder a la Plataforma
        </a>
        
        <div class="features">
            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-calendar-check"></i>
                </div>
                <h3 class="feature-title">Eventos Fáciles</h3>
                <p class="feature-desc">
                    Crea y gestiona tus eventos en minutos con nuestra interfaz intuitiva.
                </p>
            </div>
            
            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-qrcode"></i>
                </div>
                <h3 class="feature-title">Entradas Digitales</h3>
                <p class="feature-desc">
                    Tickets QR fáciles de usar y verificar en el lugar del evento.
                </p>
            </div>
            
            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-chart-line"></i>
                </div>
                <h3 class="feature-title">Analíticas en Tiempo Real</h3>
                <p class="feature-desc">
                    Monitorea las ventas y asistencia con nuestras herramientas de análisis.
                </p>
            </div>
        </div>
    </div>
    
    <footer>
        <p>&copy; 2025 UpiiTicket. Todos los derechos reservados.</p>
    </footer>
    
    <div class="particles" id="particles"></div>
    
    <script>
        // Efecto de partículas
        document.addEventListener('DOMContentLoaded', function() {
            const particlesContainer = document.getElementById('particles');
            const particleCount = 30;
            
            for (let i = 0; i < particleCount; i++) {
                const particle = document.createElement('div');
                particle.classList.add('particle');
                
                // Tamaño aleatorio entre 2px y 6px
                const size = Math.random() * 4 + 2;
                particle.style.width = `${size}px`;
                particle.style.height = `${size}px`;
                
                // Posición aleatoria
                particle.style.left = `${Math.random() * 100}%`;
                particle.style.top = `${Math.random() * 100}%`;
                
                // Animación
                const duration = Math.random() * 20 + 10;
                particle.style.animation = `float ${duration}s linear infinite`;
                
                // Dirección de animación aleatoria
                const direction = Math.random() > 0.5 ? 1 : -1;
                particle.style.animationName = `float${direction > 0 ? 'Right' : 'Left'}`;
                
                particlesContainer.appendChild(particle);
            }
            
            // Crear keyframes dinámicamente
            const style = document.createElement('style');
            style.innerHTML = `
                @keyframes floatRight {
                    0% { transform: translate(0, 0) rotate(0deg); opacity: 0.6; }
                    50% { transform: translate(50px, 50px) rotate(180deg); opacity: 0.8; }
                    100% { transform: translate(100px, 0) rotate(360deg); opacity: 0.6; }
                }
                
                @keyframes floatLeft {
                    0% { transform: translate(0, 0) rotate(0deg); opacity: 0.6; }
                    50% { transform: translate(-50px, 50px) rotate(-180deg); opacity: 0.8; }
                    100% { transform: translate(-100px, 0) rotate(-360deg); opacity: 0.6; }
                }
            `;
            document.head.appendChild(style);
        });
    </script>
</body>
</html>