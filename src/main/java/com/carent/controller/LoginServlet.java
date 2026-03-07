package com.carent.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/auth/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String role = request.getParameter("role"); // "Admin" or "Customer"

        if (username != null && !username.isEmpty()) {
            if ("Customer".equalsIgnoreCase(role)) {
                // Static Customer Check
                String password = request.getParameter("password");
                if ("user".equalsIgnoreCase(username) && "1234".equals(password)) {
                    HttpSession session = request.getSession();
                    session.setAttribute("user", username);
                    session.setAttribute("role", role);
                    // Redirect to home
                    response.sendRedirect(request.getContextPath() + "/home");
                } else {
                    // Invalid customer credentials
                    response.sendRedirect(request.getContextPath() + "/login?error=invalid");
                }
            } else if ("Admin".equalsIgnoreCase(role)) {
                // Static Admin Check (keeping it open or simple as previously requested/implied)
                // For simplicity assuming admin/admin or just enforcing role selection
                if ("admin".equalsIgnoreCase(username)) { 
                    HttpSession session = request.getSession();
                    session.setAttribute("user", username);
                    session.setAttribute("role", role);
                    response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                } else {
                    response.sendRedirect(request.getContextPath() + "/login?error=invalid_admin");
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/login?error=role");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/login?error=empty");
        }
    }
}
