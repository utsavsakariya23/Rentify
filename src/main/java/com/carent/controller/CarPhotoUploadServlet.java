package com.carent.controller;

import com.carent.model.User;
import com.carent.service.CloudinaryService;

import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.io.PrintWriter;

/**
 * Handles car photo uploads for admin — uploads to Cloudinary and returns the URL.
 */
@WebServlet("/admin/upload_car_photo")
@MultipartConfig(maxFileSize = 5 * 1024 * 1024) // 5MB max
public class CarPhotoUploadServlet extends HttpServlet {

    private final CloudinaryService cloudinaryService = new CloudinaryService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("application/json; charset=UTF-8");
        PrintWriter out = resp.getWriter();

        // Security: admin only
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("loggedUser") == null) {
            resp.setStatus(401);
            out.print("{\"success\": false, \"message\": \"Unauthorized\"}");
            return;
        }
        User user = (User) session.getAttribute("loggedUser");
        if (!"Admin".equalsIgnoreCase(user.getRole())) {
            resp.setStatus(403);
            out.print("{\"success\": false, \"message\": \"Forbidden\"}");
            return;
        }

        try {
            Part filePart = req.getPart("carPhoto");
            if (filePart == null || filePart.getSize() == 0) {
                out.print("{\"success\": false, \"message\": \"No file selected\"}");
                return;
            }

            // Validate it's an image
            String contentType = filePart.getContentType();
            if (contentType == null || !contentType.startsWith("image/")) {
                out.print("{\"success\": false, \"message\": \"Only image files are allowed\"}");
                return;
            }

            // Upload to Cloudinary
            String url = cloudinaryService.uploadImage(filePart.getInputStream(), "cars");
            if (url != null) {
                out.print("{\"success\": true, \"url\": \"" + url.replace("\"", "\\\"") + "\"}");
            } else {
                out.print("{\"success\": false, \"message\": \"Upload failed. Please try again.\"}");
            }
        } catch (Exception e) {
            System.err.println("Car photo upload error: " + e.getMessage());
            out.print("{\"success\": false, \"message\": \"Upload error: " + e.getMessage().replace("\"", "'") + "\"}");
        }
    }
}
