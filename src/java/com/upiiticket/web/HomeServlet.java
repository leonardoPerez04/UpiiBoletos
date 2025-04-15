/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.upiiticket.web;

import com.upiiticket.dao.Conexion;
import com.upiiticket.dao.UsuarioDAO;
import com.upiiticket.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;

@WebServlet(name = "HomeServlet", urlPatterns = {"/home"})
public class HomeServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String correo = request.getParameter("correo");
        String contrasena = request.getParameter("contrasena");

        // Conexión a la base de datos
        Connection con = Conexion.getConnection();
        UsuarioDAO usuarioDAO = new UsuarioDAO(con);
        Usuario usuario = usuarioDAO.validarUsuario(correo, contrasena);

        if (usuario != null) {
            // Guardar usuario en la sesión
            HttpSession session = request.getSession();
            session.setAttribute("usuario", usuario);

            // Verificar el rol del usuario
            if ("ORGANIZADOR".equals(usuario.getRol())) {
                response.sendRedirect("views/principalOrganizador.jsp"); // Página para organizadores
            } else {
                response.sendRedirect("views/principalAsistente.jsp"); // Página para asistentes
            }
        } else {
            // Si las credenciales son incorrectas, regresar con un error
            response.sendRedirect("login.html?error=1");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("login.html"); // Si alguien entra sin POST, lo redirige al login
    }
}


