/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
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
import java.io.IOException;
import java.sql.Connection;

@WebServlet(name = "RegistrarUsuarioServlet", urlPatterns = {"/registrarUsuario"})
public class RegistrarUsuarioServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String nombre = request.getParameter("nombre");
        String correo = request.getParameter("correo");
        String contrasena = request.getParameter("contrasena");
        String rol = request.getParameter("rol");

        // Depuración
        System.out.println("🔍 Nombre: " + nombre);
        System.out.println("🔍 Correo: " + correo);
        System.out.println("🔍 Contraseña: " + contrasena);
        System.out.println("🔍 Rol: " + rol);

        // Validación de contraseña
        if (contrasena == null || contrasena.trim().isEmpty()) {
            System.out.println("❌ Error: La contraseña no puede ser nula o vacía.");
            response.sendRedirect("views/registro.jsp?error=2"); // Redirige con un código de error
            return;
        }

        try (Connection con = Conexion.getConnection()) {
            UsuarioDAO usuarioDAO = new UsuarioDAO(con);
            Usuario nuevoUsuario = new Usuario(0, nombre, correo, contrasena, rol);
            usuarioDAO.insertarUsuario(nuevoUsuario);

            response.sendRedirect("login.html"); // Redirige a la lista de usuarios
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("views/registro.jsp?error=1");
        }
    }
}

