package com.carent.controller;

import com.carent.model.User;
import com.carent.repository.UserDAO;
import com.carent.service.EmailService;
import com.carent.util.PasswordUtil;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Random;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Handles the forgot-password flow:
 * 1. User enters email → OTP sent to email
 * 2. User enters OTP → validated
 * 3. User sets new password → saved
 */
@WebServlet("/forgot_password")
public class ForgotPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final UserDAO userDAO = new UserDAO();
    private final EmailService emailService = new EmailService();

    // In-memory OTP store: email → {otp, expiryTime}
    private static final ConcurrentHashMap<String, String[]> otpStore = new ConcurrentHashMap<>();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        String action = request.getParameter("action");

        switch (action != null ? action : "") {
            case "send_otp": {
                String email = request.getParameter("email");
                if (email == null || email.trim().isEmpty()) {
                    out.write("{\"success\": false, \"message\": \"Email is required.\"}");
                    return;
                }
                email = email.trim().toLowerCase();
                User user = userDAO.getUserByEmail(email);
                if (user == null) {
                    out.write("{\"success\": false, \"message\": \"No account found with this email.\"}");
                    return;
                }
                // Generate 6-digit OTP
                String otp = String.format("%06d", new Random().nextInt(999999));
                long expiry = System.currentTimeMillis() + 5 * 60 * 1000; // 5 minutes
                otpStore.put(email, new String[]{otp, String.valueOf(expiry)});

                // Send OTP email
                emailService.sendOTPEmail(email, otp);
                out.write("{\"success\": true, \"message\": \"OTP sent to your email.\"}");
                break;
            }
            case "verify_otp": {
                String email = request.getParameter("email");
                String otp = request.getParameter("otp");
                if (email == null || otp == null) {
                    out.write("{\"success\": false, \"message\": \"Email and OTP are required.\"}");
                    return;
                }
                email = email.trim().toLowerCase();
                String[] stored = otpStore.get(email);
                if (stored == null) {
                    out.write("{\"success\": false, \"message\": \"OTP expired or not found. Please request again.\"}");
                    return;
                }
                long expiry = Long.parseLong(stored[1]);
                if (System.currentTimeMillis() > expiry) {
                    otpStore.remove(email);
                    out.write("{\"success\": false, \"message\": \"OTP has expired. Please request a new one.\"}");
                    return;
                }
                if (!stored[0].equals(otp.trim())) {
                    out.write("{\"success\": false, \"message\": \"Invalid OTP. Please try again.\"}");
                    return;
                }
                out.write("{\"success\": true, \"message\": \"OTP verified successfully.\"}");
                break;
            }
            case "reset_password": {
                String email = request.getParameter("email");
                String otp = request.getParameter("otp");
                String newPassword = request.getParameter("newPassword");

                if (email == null || otp == null || newPassword == null || newPassword.length() < 8) {
                    out.write("{\"success\": false, \"message\": \"All fields required. Password must be at least 8 characters.\"}");
                    return;
                }
                email = email.trim().toLowerCase();

                // Re-verify OTP
                String[] stored = otpStore.get(email);
                if (stored == null || !stored[0].equals(otp.trim())) {
                    out.write("{\"success\": false, \"message\": \"Invalid or expired OTP.\"}");
                    return;
                }

                User user = userDAO.getUserByEmail(email);
                if (user == null) {
                    out.write("{\"success\": false, \"message\": \"User not found.\"}");
                    return;
                }

                String hashedPassword = PasswordUtil.hashPassword(newPassword);
                boolean updated = userDAO.updatePassword(user.getUserId(), hashedPassword);

                if (updated) {
                    otpStore.remove(email); // Clear used OTP
                    out.write("{\"success\": true, \"message\": \"Password reset successfully! You can now login.\"}");
                } else {
                    out.write("{\"success\": false, \"message\": \"Failed to reset password. Please try again.\"}");
                }
                break;
            }
            default:
                out.write("{\"success\": false, \"message\": \"Invalid action.\"}");
        }
    }
}
