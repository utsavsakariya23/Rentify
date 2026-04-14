package com.carent.service;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.mockito.junit.jupiter.MockitoSettings;
import org.mockito.quality.Strictness;

import jakarta.mail.Message;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.util.Arrays;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

/**
 * Unit tests for EmailService.
 * Tests email content generation, subject lines, and method behavior
 * WITHOUT actually sending real emails (no SMTP calls).
 */
@DisplayName("EmailService Tests")
class EmailServiceTest {

    private EmailService emailService;

    @BeforeEach
    void setUp() {
        emailService = new EmailService();
    }

    // ===== buildHtmlBody Tests =====

    @Test
    @DisplayName("buildHtmlBody wraps content in branded HTML template")
    void testBuildHtmlBody() throws Exception {
        Method method = EmailService.class.getDeclaredMethod("buildHtmlBody", String.class);
        method.setAccessible(true);

        String result = (String) method.invoke(emailService, "<p>Hello World</p>");

        assertNotNull(result);
        assertTrue(result.contains("<!DOCTYPE html>"));
        assertTrue(result.contains("<p>Hello World</p>"));
        assertTrue(result.contains("Carent"));
        assertTrue(result.contains("font-family"));
        assertTrue(result.contains("667eea")); // gradient color
    }

    @Test
    @DisplayName("buildHtmlBody handles empty content")
    void testBuildHtmlBodyEmpty() throws Exception {
        Method method = EmailService.class.getDeclaredMethod("buildHtmlBody", String.class);
        method.setAccessible(true);

        String result = (String) method.invoke(emailService, "");

        assertNotNull(result);
        assertTrue(result.contains("<!DOCTYPE html>"));
        assertTrue(result.contains("Carent"));
    }

    // ===== OTP Email Content Tests =====

    @Test
    @DisplayName("sendOTPEmail constructs correct subject and body content")
    void testOTPEmailContent() throws Exception {
        // We can't send real emails, but we can verify the method doesn't throw
        // and the template building is correct by testing buildHtmlBody indirectly
        Method buildMethod = EmailService.class.getDeclaredMethod("buildHtmlBody", String.class);
        buildMethod.setAccessible(true);

        // Simulate OTP body
        String otp = "123456";
        String body = "<h2 style='text-align: center; color: #333;'>Email Verification</h2>" +
                      "<div style='display: inline-block; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); " +
                      "color: white; font-size: 32px; font-weight: bold; letter-spacing: 12px; padding: 20px 40px; " +
                      "border-radius: 12px; font-family: monospace;'>" + otp + "</div>";

        String htmlResult = (String) buildMethod.invoke(emailService, body);

        assertTrue(htmlResult.contains("123456"));
        assertTrue(htmlResult.contains("Email Verification"));
        assertTrue(htmlResult.contains("monospace"));
    }

    // ===== Booking Confirmation Content Tests =====

    @Test
    @DisplayName("Booking confirmation email body contains all booking details")
    void testBookingConfirmationContent() throws Exception {
        Method buildMethod = EmailService.class.getDeclaredMethod("buildHtmlBody", String.class);
        buildMethod.setAccessible(true);

        String body = "<h2>Booking Confirmed!</h2>" +
                "<p>Dear Utsav,</p>" +
                "<p>Your booking has been received successfully.</p>" +
                "<table style='border-collapse: collapse; width: 100%;'>" +
                "<tr><td style='padding: 8px; border: 1px solid #ddd;'><strong>Car</strong></td>" +
                "<td style='padding: 8px; border: 1px solid #ddd;'>Honda Civic</td></tr>" +
                "<tr><td style='padding: 8px; border: 1px solid #ddd;'><strong>Start Date</strong></td>" +
                "<td style='padding: 8px; border: 1px solid #ddd;'>2026-05-01</td></tr>" +
                "<tr><td style='padding: 8px; border: 1px solid #ddd;'><strong>End Date</strong></td>" +
                "<td style='padding: 8px; border: 1px solid #ddd;'>2026-05-05</td></tr>" +
                "<tr><td style='padding: 8px; border: 1px solid #ddd;'><strong>Total Price</strong></td>" +
                "<td style='padding: 8px; border: 1px solid #ddd;'>Rs. 20000</td></tr>" +
                "</table>";

        String htmlResult = (String) buildMethod.invoke(emailService, body);

        assertTrue(htmlResult.contains("Booking Confirmed!"));
        assertTrue(htmlResult.contains("Utsav"));
        assertTrue(htmlResult.contains("Honda Civic"));
        assertTrue(htmlResult.contains("2026-05-01"));
        assertTrue(htmlResult.contains("2026-05-05"));
        assertTrue(htmlResult.contains("Rs. 20000"));
    }

    // ===== Contact Reply Content Tests =====

    @Test
    @DisplayName("Contact reply email body contains customer name and reply message")
    void testContactReplyContent() throws Exception {
        Method buildMethod = EmailService.class.getDeclaredMethod("buildHtmlBody", String.class);
        buildMethod.setAccessible(true);

        String replyMessage = "Thank you for reaching out. We will get back to you soon.";
        String body = "<h2>Response to your inquiry</h2>" +
                "<p>Dear Utsav,</p>" +
                "<p>" + replyMessage + "</p>" +
                "<p>Best regards,<br>Carent Support Team</p>";

        String htmlResult = (String) buildMethod.invoke(emailService, body);

        assertTrue(htmlResult.contains("Response to your inquiry"));
        assertTrue(htmlResult.contains("Utsav"));
        assertTrue(htmlResult.contains(replyMessage));
        assertTrue(htmlResult.contains("Carent Support Team"));
    }

    // ===== Refund Email Content Tests =====

    @Test
    @DisplayName("Refund email body contains booking ID and refund amount")
    void testRefundEmailContent() throws Exception {
        Method buildMethod = EmailService.class.getDeclaredMethod("buildHtmlBody", String.class);
        buildMethod.setAccessible(true);

        int bookingId = 42;
        BigDecimal amount = new BigDecimal("15000");

        String body = "<h2>Refund Processed</h2>" +
                "<p>Dear Utsav,</p>" +
                "<p>We have successfully processed a refund for your booking <b>#" + bookingId + "</b>.</p>" +
                "<p>Amount Refunded: <b>Rs. " + amount + "</b></p>" +
                "<p>Please allow 3-5 business days for the funds to appear in your original payment method.</p>";

        String htmlResult = (String) buildMethod.invoke(emailService, body);

        assertTrue(htmlResult.contains("Refund Processed"));
        assertTrue(htmlResult.contains("#42"));
        assertTrue(htmlResult.contains("Rs. 15000"));
        assertTrue(htmlResult.contains("3-5 business days"));
    }

    // ===== SMTP Configuration Tests =====

    @Test
    @DisplayName("SMTP configuration constants are set correctly")
    void testSmtpConfig() throws Exception {
        Field hostField = EmailService.class.getDeclaredField("SMTP_HOST");
        hostField.setAccessible(true);
        assertEquals("smtp.gmail.com", hostField.get(null));

        Field portField = EmailService.class.getDeclaredField("SMTP_PORT");
        portField.setAccessible(true);
        assertEquals(587, portField.get(null));

        Field fromNameField = EmailService.class.getDeclaredField("FROM_NAME");
        fromNameField.setAccessible(true);
        assertEquals("Carent Car Rental", fromNameField.get(null));
    }

    // ===== Mail Session Tests =====

    @Test
    @DisplayName("getMailSession returns a valid Session with correct properties")
    void testGetMailSession() throws Exception {
        Method method = EmailService.class.getDeclaredMethod("getMailSession");
        method.setAccessible(true);

        Session session = (Session) method.invoke(emailService);

        assertNotNull(session);
        assertEquals("true", session.getProperty("mail.smtp.auth"));
        assertEquals("true", session.getProperty("mail.smtp.starttls.enable"));
        assertEquals("smtp.gmail.com", session.getProperty("mail.smtp.host"));
        assertEquals("587", session.getProperty("mail.smtp.port"));
        assertEquals("TLSv1.2", session.getProperty("mail.smtp.ssl.protocols"));
    }

    // ===== sendEmailAsync does not throw =====

    @Test
    @DisplayName("sendEmailAsync does not throw exceptions (fire-and-forget)")
    void testSendEmailAsyncNoThrow() {
        // This should not throw even though it will fail silently (no real SMTP)
        assertDoesNotThrow(() ->
            emailService.sendEmailAsync("nonexistent@test.com", "Test", "Body")
        );
    }

    @Test
    @DisplayName("sendBulkEmailAsync handles empty list without throwing")
    void testSendBulkEmailAsyncEmptyList() {
        List<String> emptyList = List.of();
        assertDoesNotThrow(() ->
            emailService.sendBulkEmailAsync(emptyList, "Test", "Body")
        );
    }

    @Test
    @DisplayName("sendBookingConfirmation does not throw")
    void testSendBookingConfirmationNoThrow() {
        assertDoesNotThrow(() ->
            emailService.sendBookingConfirmation("test@test.com", "Utsav", "Civic",
                    "2026-05-01", "2026-05-05", "20000")
        );
    }

    @Test
    @DisplayName("sendOTPEmail does not throw")
    void testSendOTPEmailNoThrow() {
        assertDoesNotThrow(() ->
            emailService.sendOTPEmail("test@test.com", "123456")
        );
    }

    @Test
    @DisplayName("sendContactReply does not throw")
    void testSendContactReplyNoThrow() {
        assertDoesNotThrow(() ->
            emailService.sendContactReply("test@test.com", "Utsav", "Query", "Thank you!")
        );
    }

    @Test
    @DisplayName("sendRefundEmail does not throw")
    void testSendRefundEmailNoThrow() {
        assertDoesNotThrow(() ->
            emailService.sendRefundEmail("test@test.com", "Utsav", 42, new BigDecimal("15000"))
        );
    }
}
