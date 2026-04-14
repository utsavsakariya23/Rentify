package com.carent.service;

import com.carent.model.Notification;
import com.carent.repository.NotificationDAO;
import com.carent.repository.UserDAO;

import java.util.List;

public class NotificationService {
    private final NotificationDAO notificationDAO = new NotificationDAO();
    private final UserDAO userDAO = new UserDAO();

    public boolean sendNotification(String message, boolean sendEmail, String audienceType) {
        boolean saved = false;
        List<com.carent.model.User> targetUsers;
        List<String> targetEmails = null;

        if ("frequent".equals(audienceType)) {
            targetUsers = userDAO.getBookersByFrequency(true, 3);
            if (sendEmail) targetEmails = userDAO.getBookerEmailsByFrequency(true, 3);
        } else if ("infrequent".equals(audienceType)) {
            targetUsers = userDAO.getBookersByFrequency(false, 3);
            if (sendEmail) targetEmails = userDAO.getBookerEmailsByFrequency(false, 3);
        } else {
            // default: all customers
            targetUsers = userDAO.getAllUsers();
            if (sendEmail) targetEmails = userDAO.getAllCustomerEmails();
        }

        for (com.carent.model.User u : targetUsers) {
            saved = notificationDAO.insertNotification(u.getUserId(), message) || saved;
        }

        if (saved && sendEmail && targetEmails != null && !targetEmails.isEmpty()) {
            EmailService emailService = new EmailService();
            emailService.sendBulkEmailAsync(targetEmails, "Carent Notification", message);
        }
        return saved;
    }

    public List<Notification> getAllNotifications() {
        return notificationDAO.getAllNotifications();
    }

    public List<Notification> getNotificationsByUserId(int userId) {
        return notificationDAO.getNotificationsByUserId(userId);
    }

    public List<Notification> getLatestNotifications(int limit) {
        return notificationDAO.getLatestNotifications(limit);
    }

    public List<Notification> getNotificationsWithPagination(int page, int pageSize) {
        int offset = (page - 1) * pageSize;
        return notificationDAO.getNotificationsWithPagination(offset, pageSize);
    }

    public int getNotificationCount() {
        return notificationDAO.getNotificationCount();
    }

    public boolean deleteNotification(int notificationId) {
        return notificationDAO.deleteNotification(notificationId);
    }
}
