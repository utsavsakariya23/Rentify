package com.carent.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.carent.model.User;
import com.carent.repository.UserDAO;

// Configured via web.xml mappings
public class PageController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO = new UserDAO();

    @Override
    public void init() throws ServletException {
        System.out.println("--- PageController INITIALIZED ---");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getRequestURI();
        if (request.getContextPath() != null && !request.getContextPath().isEmpty()) {
            action = action.substring(request.getContextPath().length());
        }

        // Normalize path
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
                // If already logged in, redirect
                if (request.getSession(false) != null && request.getSession(false).getAttribute("loggedUser") != null) {
                    User u = (User) request.getSession(false).getAttribute("loggedUser");
                    if ("Admin".equalsIgnoreCase(u.getRole())) {
                        response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                    } else {
                        response.sendRedirect(request.getContextPath() + "/home");
                    }
                    return;
                }
                request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
                break;
            case "/register":
                request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
                break;
            case "/car_info":
                request.getRequestDispatcher("/WEB-INF/views/car_info.jsp").forward(request, response);
                break;
            case "/profile":
                // Require login
                if (request.getSession(false) == null || request.getSession(false).getAttribute("loggedUser") == null) {
                    response.sendRedirect(request.getContextPath() + "/login?error=true");
                    return;
                }
                request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
                break;
            case "/logout":
                HttpSession sess = request.getSession(false);
                if (sess != null) {
                    sess.invalidate();
                }
                // Clear remember-me cookie
                Cookie clearCookie = new Cookie("rememberUser", "");
                clearCookie.setMaxAge(0);
                clearCookie.setPath("/");
                response.addCookie(clearCookie);
                response.sendRedirect(request.getContextPath() + "/login?logout=true");
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
            case "/admin/reviews":
                request.getRequestDispatcher("/WEB-INF/views/admin/reviews.jsp").forward(request, response);
                break;

            default:
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
            handleLogin(request, response);
        } else if (action.equals("/perform_register")) {
            handleRegister(request, response);
        } else if (action.equals("/update_profile")) {
            handleUpdateProfile(request, response);
        } else if (action.equals("/change_password")) {
            handleChangePassword(request, response);
        } else if (action.equals("/validate_unique")) {
            handleValidateUnique(request, response);
        } else {
            doGet(request, response);
        }
    }

    private void handleValidateUnique(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String field = request.getParameter("field");
        String value = request.getParameter("value");

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        boolean taken = false;
        if (value != null && !value.trim().isEmpty()) {
            value = value.trim();
            if ("username".equals(field)) {
                taken = userDAO.isUsernameTaken(value);
            } else if ("email".equals(field)) {
                taken = userDAO.isEmailTaken(value);
            } else if ("licenseNo".equals(field)) {
                taken = userDAO.isLicenseNoTaken(value);
            }
        }

        response.getWriter().write("{\"taken\": " + taken + "}");
    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String rememberMe = request.getParameter("rememberMe");

        if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/login?error=true");
            return;
        }

        User user = userDAO.getUserByUsernameAndPassword(username.trim(), password);

        if (user != null) {
            HttpSession session = request.getSession(true);
            session.setAttribute("loggedUser", user);
            session.setAttribute("user", user.getUsername());
            session.setAttribute("role", user.getRole());
            session.setMaxInactiveInterval(30 * 60);

            if ("on".equals(rememberMe)) {
                Cookie cookie = new Cookie("rememberUser", user.getUsername());
                cookie.setMaxAge(30 * 24 * 60 * 60);
                cookie.setPath("/");
                response.addCookie(cookie);
            } else {
                Cookie cookie = new Cookie("rememberUser", "");
                cookie.setMaxAge(0);
                cookie.setPath("/");
                response.addCookie(cookie);
            }

            if ("Admin".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            } else {
                response.sendRedirect(request.getContextPath() + "/home");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/login?error=true");
        }
    }

    private void handleRegister(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String licenseNo = request.getParameter("licenseNo");

        // Server-side validation
        if (fullName == null || fullName.trim().isEmpty()
                || email == null || email.trim().isEmpty()
                || username == null || username.trim().isEmpty()
                || password == null || password.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/register?error=empty");
            return;
        }

        if (!password.equals(confirmPassword)) {
            response.sendRedirect(request.getContextPath() + "/register?error=mismatch");
            return;
        }

        // Check username duplicate
        if (userDAO.isUsernameTaken(username.trim())) {
            response.sendRedirect(request.getContextPath() + "/register?error=username_taken");
            return;
        }

        // Check email duplicate
        if (userDAO.isEmailTaken(email.trim())) {
            response.sendRedirect(request.getContextPath() + "/register?error=email_taken");
            return;
        }

        // Hash the password before storing
        String hashedPassword = com.carent.util.PasswordUtil.hashPassword(password);

        // Create user with Customer role and hashed password
        User user = new User(fullName.trim(), email.trim(),
                phone != null ? phone.trim() : "",
                username.trim(), hashedPassword,
                licenseNo != null ? licenseNo.trim() : "");

        String dbError = userDAO.insertUser(user);
        System.out.println("--- Register attempt: " + username + " => " + (dbError == null ? "SUCCESS" : "FAILED: " + dbError));

        if (dbError == null) {
            response.sendRedirect(request.getContextPath() + "/login?registered=true");
        } else {
            response.sendRedirect(request.getContextPath() + "/register?error=failed&detail=" +
                    java.net.URLEncoder.encode(dbError, "UTF-8"));
        }
    }

    private void handleUpdateProfile(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login?error=true");
            return;
        }

        User currentUser = (User) session.getAttribute("loggedUser");
        
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String licenseNo = request.getParameter("licenseNo");

        if (fullName == null || fullName.trim().isEmpty() || phone == null || phone.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/profile?error=profile_failed");
            return;
        }

        // Update object
        currentUser.setFullName(fullName.trim());
        currentUser.setPhone(phone.trim());
        if (licenseNo != null) currentUser.setLicenseNo(licenseNo.trim());

        // Update DB
        boolean success = userDAO.updateUser(currentUser);

        if (success) {
            session.setAttribute("loggedUser", currentUser); // Refresh session
            response.sendRedirect(request.getContextPath() + "/profile?success=profile_updated");
        } else {
            response.sendRedirect(request.getContextPath() + "/profile?error=profile_failed");
        }
    }

    private void handleChangePassword(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login?error=true");
            return;
        }

        User currentUser = (User) session.getAttribute("loggedUser");

        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmNewPassword = request.getParameter("confirmNewPassword");

        if (currentPassword == null || newPassword == null || confirmNewPassword == null ||
            currentPassword.trim().isEmpty() || newPassword.trim().isEmpty() || confirmNewPassword.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/profile?error=password_failed");
            return;
        }

        if (!newPassword.equals(confirmNewPassword)) {
            response.sendRedirect(request.getContextPath() + "/profile?error=password_mismatch");
            return;
        }

        // Verify current password hash
        if (!com.carent.util.PasswordUtil.verifyPassword(currentPassword, currentUser.getPassword())) {
            response.sendRedirect(request.getContextPath() + "/profile?error=wrong_password");
            return;
        }

        // Generate new hash
        String newHash = com.carent.util.PasswordUtil.hashPassword(newPassword);

        // Update DB
        boolean success = userDAO.updatePassword(currentUser.getUserId(), newHash);

        if (success) {
            // Update session so it doesn't break out of sync
            currentUser.setPassword(newHash);
            session.setAttribute("loggedUser", currentUser);
            response.sendRedirect(request.getContextPath() + "/profile?success=password_changed");
        } else {
            response.sendRedirect(request.getContextPath() + "/profile?error=password_failed");
        }
    }
}
