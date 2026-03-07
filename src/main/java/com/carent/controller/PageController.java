package com.carent.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

// @jakarta.servlet.annotation.WebServlet(urlPatterns = {"", "/", "/home", "/vehicles", "/car_info", "/about", "/contact", "/login", "/register", "/profile", "/logout", "/perform_login", "/admin/*"})
public class PageController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    public void init() throws ServletException {
        System.out.println("--- PageController INITIALIZED ---");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getRequestURI();
        if (request.getContextPath() != null && !request.getContextPath().isEmpty()) {
            action = action.substring(request.getContextPath().length());
        }

        // Normalize path: Remove trailing slash if present (except for root "/")
        if (action.length() > 1 && action.endsWith("/")) {
            action = action.substring(0, action.length() - 1);
        }

        // Handle root path
        if (action.equals("") || action.equals("/")) {
            request.getRequestDispatcher("/WEB-INF/views/home.jsp").forward(request, response);
            return;
        }

        switch (action) {
            case "/home":
                request.getRequestDispatcher("/WEB-INF/views/home.jsp").forward(request, response);
                break;
            case "/vehicles":
                request.getRequestDispatcher("/WEB-INF/views/vehicles.jsp").forward(request, response);
                break;
            case "/contact":
                request.getRequestDispatcher("/WEB-INF/views/contact.jsp").forward(request, response);
                break;
            case "/about":
                request.getRequestDispatcher("/WEB-INF/views/about.jsp").forward(request, response);
                break;
            case "/login":
                request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
                break;
            case "/register":
                request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
                break;
            case "/car_info":
                request.getRequestDispatcher("/WEB-INF/views/car_info.jsp").forward(request, response);
                break;
            case "/profile":
                request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
                break;
            case "/logout":
                request.getSession().invalidate();
                response.sendRedirect(request.getContextPath() + "/home");
                break;
                
            // Admin Routes
            case "/admin/dashboard":
                request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(request, response);
                break;
            case "/admin/vehicles":
                request.getRequestDispatcher("/WEB-INF/views/admin/vehicles.jsp").forward(request, response);
                break;
            case "/admin/rent":
                request.getRequestDispatcher("/WEB-INF/views/admin/rentrequest.jsp").forward(request, response);
                break;
            case "/admin/customers":
                request.getRequestDispatcher("/WEB-INF/views/admin/customers.jsp").forward(request, response);
                break;
            case "/admin/coupons":
                request.getRequestDispatcher("/WEB-INF/views/admin/coupons.jsp").forward(request, response);
                break;
            case "/admin/messages":
                request.getRequestDispatcher("/WEB-INF/views/admin/messages.jsp").forward(request, response);
                break;
            case "/admin/notifications":
                request.getRequestDispatcher("/WEB-INF/views/admin/notifications.jsp").forward(request, response);
                break;
            case "/admin/profile":
                request.getRequestDispatcher("/WEB-INF/views/admin/profile.jsp").forward(request, response);
                break;
                
            default:
                // Handle admin sub-paths
                if (action.startsWith("/admin")) {
                    request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(request, response);
                } else {
                    request.getRequestDispatcher("/WEB-INF/views/home.jsp").forward(request, response);
                }
                break;
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getRequestURI();
        if (request.getContextPath() != null && !request.getContextPath().isEmpty()) {
            action = action.substring(request.getContextPath().length());
        }
        
        if (action.equals("/perform_login")) {
            String username = request.getParameter("username");
            String role = request.getParameter("role");
            
            if (username != null && !username.isEmpty()) {
                if ("Customer".equalsIgnoreCase(role)) {
                    String password = request.getParameter("password");
                    if ("user".equalsIgnoreCase(username) && "1234".equals(password)) {
                        request.getSession().setAttribute("user", username);
                        request.getSession().setAttribute("role", role);
                        response.sendRedirect(request.getContextPath() + "/home");
                        return;
                    }
                } else if ("Admin".equalsIgnoreCase(role)) {
                     if ("admin".equalsIgnoreCase(username)) { 
                        request.getSession().setAttribute("user", username);
                        request.getSession().setAttribute("role", role);
                        response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                        return;
                    }
                }
            }
            response.sendRedirect(request.getContextPath() + "/login?error=true");
        } else {
            doGet(request, response);
        }
    }
}
