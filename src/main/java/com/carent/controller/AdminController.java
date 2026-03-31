package com.carent.controller;

import com.carent.model.*;
import com.carent.service.*;
import com.carent.repository.UserDAO;
import com.carent.util.PasswordUtil;

import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.sql.Date;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

public class AdminController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final CarService carService = new CarService();
    private final BookingService bookingService = new BookingService();
    private final CouponService couponService = new CouponService();
    private final ReviewService reviewService = new ReviewService();
    private final NotificationService notificationService = new NotificationService();
    private final UserDAO userDAO = new UserDAO();
    private final CloudinaryService cloudinaryService = new CloudinaryService();
    private final EmailService emailService = new EmailService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check admin
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        User admin = (User) session.getAttribute("loggedUser");
        if (!"Admin".equalsIgnoreCase(admin.getRole())) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        String action = request.getRequestURI();
        if (request.getContextPath() != null && !request.getContextPath().isEmpty()) {
            action = action.substring(request.getContextPath().length());
        }

        switch (action) {
            case "/admin/add_car":
                handleAddCar(request, response);
                break;
            case "/admin/edit_car":
                handleEditCar(request, response);
                break;
            case "/admin/delete_car":
                handleDeleteCar(request, response);
                break;
            case "/admin/update_car_status":
                handleUpdateCarStatus(request, response);
                break;
            case "/admin/confirm_booking":
                handleConfirmBooking(request, response);
                break;
            case "/admin/complete_booking":
                handleCompleteBooking(request, response);
                break;
            case "/admin/cancel_booking":
                handleAdminCancelBooking(request, response);
                break;
            case "/admin/mark_paid":
                handleMarkPaid(request, response);
                break;
            case "/admin/add_coupon":
                handleAddCoupon(request, response);
                break;
            case "/admin/edit_coupon":
                handleEditCoupon(request, response);
                break;
            case "/admin/delete_coupon":
                handleDeleteCoupon(request, response);
                break;
            case "/admin/send_notification":
                handleSendNotification(request, response);
                break;
            case "/admin/reply_message":
                handleReplyMessage(request, response);
                break;
            case "/admin/verify_user":
                handleVerifyUser(request, response);
                break;
            case "/admin/delete_user":
                handleDeleteUser(request, response);
                break;
            case "/admin/delete_review":
                handleDeleteReview(request, response);
                break;
            case "/admin/update_profile":
                handleUpdateProfile(request, response);
                break;
            case "/admin/change_password":
                handleChangePassword(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                break;
        }
    }

    private void handleAddCar(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String name = request.getParameter("name");
        String brand = request.getParameter("brand");
        String priceStr = request.getParameter("pricePerDay");
        String fuelType = request.getParameter("fuelType");
        String transmission = request.getParameter("transmission");
        String imageUrl = request.getParameter("imageUrl");

        // Handle file upload if multipart
        if (request.getContentType() != null && request.getContentType().startsWith("multipart/")) {
            try {
                Part filePart = request.getPart("carImage");
                if (filePart != null && filePart.getSize() > 0) {
                    try (InputStream is = filePart.getInputStream()) {
                        String url = cloudinaryService.uploadImage(is, "cars");
                        if (url != null) imageUrl = url;
                    }
                }
            } catch (Exception e) {
                System.err.println("File upload error: " + e.getMessage());
            }
        }

        Car car = new Car();
        car.setName(name);
        car.setBrand(brand);
        car.setPricePerDay(new BigDecimal(priceStr));
        car.setFuelType(fuelType != null ? fuelType : "Petrol");
        car.setTransmission(transmission != null ? transmission : "Automatic");
        car.setImageUrl(imageUrl != null ? imageUrl : "");
        car.setStatus("Available");

        boolean success = carService.addCar(car);
        response.sendRedirect(request.getContextPath() + "/admin/vehicles?success=" + (success ? "car_added" : "failed"));
    }

    private void handleEditCar(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        int carId = Integer.parseInt(request.getParameter("carId"));
        Car car = carService.getCarById(carId);
        if (car == null) {
            response.sendRedirect(request.getContextPath() + "/admin/vehicles?error=not_found");
            return;
        }

        car.setName(request.getParameter("name"));
        car.setBrand(request.getParameter("brand"));
        car.setPricePerDay(new BigDecimal(request.getParameter("pricePerDay")));
        car.setFuelType(request.getParameter("fuelType"));
        car.setTransmission(request.getParameter("transmission"));
        car.setStatus(request.getParameter("status"));

        String imageUrl = request.getParameter("imageUrl");
        if (imageUrl != null && !imageUrl.trim().isEmpty()) {
            car.setImageUrl(imageUrl);
        }

        if (request.getContentType() != null && request.getContentType().startsWith("multipart/")) {
            try {
                Part filePart = request.getPart("carImage");
                if (filePart != null && filePart.getSize() > 0) {
                    try (InputStream is = filePart.getInputStream()) {
                        String url = cloudinaryService.uploadImage(is, "cars");
                        if (url != null) car.setImageUrl(url);
                    }
                }
            } catch (Exception e) {
                System.err.println("File upload error: " + e.getMessage());
            }
        }

        boolean success = carService.updateCar(car);
        response.sendRedirect(request.getContextPath() + "/admin/vehicles?success=" + (success ? "car_updated" : "failed"));
    }

    private void handleDeleteCar(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int carId = Integer.parseInt(request.getParameter("carId"));
        boolean success = carService.deleteCar(carId);
        response.sendRedirect(request.getContextPath() + "/admin/vehicles?success=" + (success ? "car_deleted" : "failed"));
    }

    private void handleUpdateCarStatus(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int carId = Integer.parseInt(request.getParameter("carId"));
        String status = request.getParameter("status");
        carService.updateCarStatus(carId, status);
        response.sendRedirect(request.getContextPath() + "/admin/vehicles");
    }

    private void handleConfirmBooking(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        bookingService.confirmBooking(bookingId);
        response.sendRedirect(request.getContextPath() + "/admin/rent");
    }

    private void handleCompleteBooking(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        bookingService.completeBooking(bookingId);
        response.sendRedirect(request.getContextPath() + "/admin/rent");
    }

    private void handleAdminCancelBooking(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        bookingService.adminCancelBooking(bookingId);
        response.sendRedirect(request.getContextPath() + "/admin/rent");
    }

    private void handleMarkPaid(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        bookingService.markAsPaid(bookingId);
        response.sendRedirect(request.getContextPath() + "/admin/rent");
    }

    private void handleAddCoupon(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Coupon coupon = new Coupon();
        coupon.setCode(request.getParameter("code"));
        coupon.setDiscountPercentage(new BigDecimal(request.getParameter("discountPercentage")));
        coupon.setExpiryDate(Date.valueOf(request.getParameter("expiryDate")));
        coupon.setActive("on".equals(request.getParameter("isActive")) || "true".equals(request.getParameter("isActive")));
        couponService.addCoupon(coupon);
        response.sendRedirect(request.getContextPath() + "/admin/coupons?success=coupon_added");
    }

    private void handleEditCoupon(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Coupon coupon = new Coupon();
        coupon.setCouponId(Integer.parseInt(request.getParameter("couponId")));
        coupon.setCode(request.getParameter("code"));
        coupon.setDiscountPercentage(new BigDecimal(request.getParameter("discountPercentage")));
        coupon.setExpiryDate(Date.valueOf(request.getParameter("expiryDate")));
        coupon.setActive("on".equals(request.getParameter("isActive")) || "true".equals(request.getParameter("isActive")));
        couponService.updateCoupon(coupon);
        response.sendRedirect(request.getContextPath() + "/admin/coupons?success=coupon_updated");
    }

    private void handleDeleteCoupon(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int couponId = Integer.parseInt(request.getParameter("couponId"));
        couponService.deleteCoupon(couponId);
        response.sendRedirect(request.getContextPath() + "/admin/coupons?success=coupon_deleted");
    }

    private void handleSendNotification(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String message = request.getParameter("message");
        boolean sendEmail = "on".equals(request.getParameter("sendEmail"));
        notificationService.sendNotification(message, sendEmail);
        response.sendRedirect(request.getContextPath() + "/admin/notifications?success=notification_sent");
    }

    private void handleReplyMessage(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int messageId = Integer.parseInt(request.getParameter("messageId"));
        String reply = request.getParameter("reply");

        com.carent.repository.ContactMessageDAO messageDAO = new com.carent.repository.ContactMessageDAO();
        ContactMessage msg = messageDAO.getMessageById(messageId);

        if (msg != null && reply != null && !reply.trim().isEmpty()) {
            messageDAO.replyToMessage(messageId, reply);
            // Send reply email
            emailService.sendContactReply(msg.getEmail(), msg.getName(), msg.getSubject(), reply);
        }
        response.sendRedirect(request.getContextPath() + "/admin/messages?success=reply_sent");
    }

    private void handleVerifyUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        String action = request.getParameter("action");
        boolean verified = "verify".equals(action);
        userDAO.updateVerificationStatus(userId, verified);
        response.sendRedirect(request.getContextPath() + "/admin/customers");
    }

    private void handleDeleteUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        userDAO.deleteUser(userId);
        response.sendRedirect(request.getContextPath() + "/admin/customers");
    }

    private void handleDeleteReview(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int reviewId = Integer.parseInt(request.getParameter("reviewId"));
        reviewService.deleteReview(reviewId);
        response.sendRedirect(request.getContextPath() + "/admin/reviews");
    }

    private void handleUpdateProfile(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        User sessionUser = (User) session.getAttribute("loggedUser");
        if (sessionUser == null) return;

        User user = userDAO.getUserById(sessionUser.getUserId());
        if (user != null) {
            String fullName = request.getParameter("fullName");
            String phone = request.getParameter("phone");

            user.setFullName(fullName);
            user.setPhone(phone);

            if (userDAO.updateUser(user)) {
                session.setAttribute("loggedUser", user);
                response.sendRedirect(request.getContextPath() + "/admin/profile?success=profile_updated");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/profile?error=update_failed");
            }
        }
    }

    private void handleChangePassword(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        User sessionUser = (User) session.getAttribute("loggedUser");
        if (sessionUser == null) {
            response.getWriter().write("{\"success\": false, \"message\": \"Not authenticated.\"}");
            return;
        }

        User user = userDAO.getUserById(sessionUser.getUserId());
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");

        if (!PasswordUtil.verifyPassword(currentPassword, user.getPassword())) {
            response.getWriter().write("{\"success\": false, \"message\": \"Incorrect current password.\"}");
            return;
        }

        String hashedNewPassword = PasswordUtil.hashPassword(newPassword);
        if (userDAO.updatePassword(user.getUserId(), hashedNewPassword)) {
            response.getWriter().write("{\"success\": true, \"message\": \"Password changed successfully.\"}");
        } else {
            response.getWriter().write("{\"success\": false, \"message\": \"An error occurred. Please try again.\"}");
        }
    }
}
