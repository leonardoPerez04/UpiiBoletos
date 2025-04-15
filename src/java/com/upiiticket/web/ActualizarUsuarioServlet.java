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
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;

/**
 *
 * @author lpere
 */
@WebServlet(name = "ActualizarUsuario", urlPatterns = {"/ActualizarUsuario"})
public class ActualizarUsuarioServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        String nombre = request.getParameter("nombre");
        String correo = request.getParameter("correo");
        String contrasena = request.getParameter("contrasena");

        try (Connection con = Conexion.getConnection()) {
            UsuarioDAO usuarioDAO = new UsuarioDAO((java.sql.Connection) con);
            Usuario usuarioActualizado = usuarioDAO.actualizarUsuario(id, nombre, correo, contrasena);
            
            if (usuarioActualizado != null) {
                HttpSession session = request.getSession();
                session.setAttribute("usuario", usuarioActualizado);
                if (usuarioActualizado.getRol()== "ORGANIZADOR"){
                    response.sendRedirect("views/principalOrganizador.jsp");
                }
                else{
                    response.sendRedirect("views/principalAsistente.jsp");
                }
            } else {
                response.sendRedirect("views/editarDatos.jsp?error=1");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("views/editarDatos.jsp?error=2");
        }
    }
}

