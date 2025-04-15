/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.upiiticket.web;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 *
 * @author lpere
 */
@WebServlet(name = "CerrarSesionServlet", urlPatterns = {"/cerrarSesion"})
public class CerrarSesionServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false); // Obtiene la sesión SIN crear una nueva
        if (session != null) {
            session.invalidate(); // Cierra la sesión
            System.out.println("✅ Sesión cerrada correctamente.");
        }

        // Redirigir al login
        response.sendRedirect("login.html");
    }
}

