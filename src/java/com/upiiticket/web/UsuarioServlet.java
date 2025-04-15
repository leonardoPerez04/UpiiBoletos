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
import java.util.List;

@WebServlet(name = "UsuarioServlet", urlPatterns = {"/usuarios"})
public class UsuarioServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try (Connection con = Conexion.getConnection()) {
            UsuarioDAO usuarioDAO = new UsuarioDAO(con);
            List<Usuario> usuarios = usuarioDAO.obtenerUsuarios();

            request.setAttribute("usuarios", usuarios);
            request.getRequestDispatcher("/views/usuarios.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

