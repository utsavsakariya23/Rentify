package com.carent.controller;

import com.carent.model.User;
import com.carent.repository.UserDAO;
import com.carent.util.PasswordUtil;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.lang.reflect.Field;
import java.lang.reflect.Method;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

/**
 * Unit tests for PageController's login handling.
 * Uses Mockito to mock HttpServletRequest/Response (since this is NOT Spring MVC).
 * Tests cover: successful login, failed login, AJAX login, rememberMe cookies,
 * admin vs customer redirects, and empty field handling.
 */
@ExtendWith(MockitoExtension.class)
@DisplayName("PageController Login Tests")
class PageControllerLoginTest {

    @Mock private HttpServletRequest request;
    @Mock private HttpServletResponse response;
    @Mock private HttpSession session;
    @Mock private UserDAO userDAO;

    private PageController controller;
    private StringWriter responseWriter;
    private PrintWriter printWriter;

    @BeforeEach
    void setUp() throws Exception {
        controller = new PageController();

        // Inject mocked UserDAO via reflection
        Field userDAOField = PageController.class.getDeclaredField("userDAO");
        userDAOField.setAccessible(true);
        userDAOField.set(controller, userDAO);

        // Set up response writer for AJAX tests
        responseWriter = new StringWriter();
        printWriter = new PrintWriter(responseWriter);
    }

    private void setupLoginRequest(String username, String password, String rememberMe, boolean isAjax) {
        when(request.getParameter("username")).thenReturn(username);
        when(request.getParameter("password")).thenReturn(password);
        when(request.getParameter("rememberMe")).thenReturn(rememberMe);
        if (isAjax) {
            when(request.getHeader("X-Requested-With")).thenReturn("XMLHttpRequest");
        } else {
            when(request.getHeader("X-Requested-With")).thenReturn(null);
        }
    }

    private User createTestUser(String username, String role) {
        User user = new User();
        user.setUserId(1);
        user.setUsername(username);
        user.setPassword(PasswordUtil.hashPassword("Utsav@123"));
        user.setRole(role);
        user.setEmail("test@test.com");
        return user;
    }

    // ===== Invoke private handleLogin via reflection =====
    private void invokeHandleLogin() throws Exception {
        Method method = PageController.class.getDeclaredMethod("handleLogin",
                HttpServletRequest.class, HttpServletResponse.class);
        method.setAccessible(true);
        method.invoke(controller, request, response);
    }

    // ===== TEST: Successful Customer Login =====
    @Test
    @DisplayName("Successful login as Customer redirects to /home")
    void testLoginSuccess_CustomerRedirectsToHome() throws Exception {
        User user = createTestUser("hardip", "Customer");
        setupLoginRequest("hardip", "Utsav@123", null, false);
        when(userDAO.getUserByUsernameAndPassword("hardip", "Utsav@123")).thenReturn(user);
        when(request.getSession(true)).thenReturn(session);
        when(request.getContextPath()).thenReturn("/carent");

        invokeHandleLogin();

        verify(session).setAttribute("loggedUser", user);
        verify(session).setAttribute("user", "hardip");
        verify(session).setAttribute("role", "Customer");
        verify(session).setMaxInactiveInterval(30 * 60);
        verify(response).sendRedirect("/carent/home");
    }

    // ===== TEST: Successful Admin Login =====
    @Test
    @DisplayName("Successful login as Admin redirects to /admin/dashboard")
    void testLoginSuccess_AdminRedirectsToAdminDashboard() throws Exception {
        User user = createTestUser("admin", "Admin");
        setupLoginRequest("admin", "Utsav@123", null, false);
        when(userDAO.getUserByUsernameAndPassword("admin", "Utsav@123")).thenReturn(user);
        when(request.getSession(true)).thenReturn(session);
        when(request.getContextPath()).thenReturn("/carent");

        invokeHandleLogin();

        verify(response).sendRedirect("/carent/admin/dashboard");
    }

    // ===== TEST: Failed Login — Invalid Credentials =====
    @Test
    @DisplayName("Failed login with invalid credentials redirects to /login?error=true")
    void testLoginFailure_InvalidCredentials() throws Exception {
        setupLoginRequest("wronguser", "wrongpass", null, false);
        when(userDAO.getUserByUsernameAndPassword("wronguser", "wrongpass")).thenReturn(null);
        when(request.getContextPath()).thenReturn("/carent");

        invokeHandleLogin();

        verify(response).sendRedirect("/carent/login?error=true");
        verify(session, never()).setAttribute(anyString(), any());
    }

    // ===== TEST: Failed Login — Empty Fields =====
    @Test
    @DisplayName("Login with empty username redirects to /login?error=true")
    void testLoginFailure_EmptyUsername() throws Exception {
        setupLoginRequest("", "password", null, false);
        when(request.getContextPath()).thenReturn("/carent");

        invokeHandleLogin();

        verify(response).sendRedirect("/carent/login?error=true");
    }

    @Test
    @DisplayName("Login with null username redirects to /login?error=true")
    void testLoginFailure_NullUsername() throws Exception {
        setupLoginRequest(null, "password", null, false);
        when(request.getContextPath()).thenReturn("/carent");

        invokeHandleLogin();

        verify(response).sendRedirect("/carent/login?error=true");
    }

    // ===== TEST: AJAX Login Success =====
    @Test
    @DisplayName("AJAX login success returns JSON with success:true and redirectUrl")
    void testLoginSuccess_AjaxReturnsJson() throws Exception {
        User user = createTestUser("utsav", "Customer");
        setupLoginRequest("utsav", "Utsav@123", null, true);
        when(userDAO.getUserByUsernameAndPassword("utsav", "Utsav@123")).thenReturn(user);
        when(request.getSession(true)).thenReturn(session);
        when(request.getContextPath()).thenReturn("/carent");
        when(response.getWriter()).thenReturn(printWriter);

        invokeHandleLogin();

        verify(response).setContentType("application/json");
        String jsonOutput = responseWriter.toString();
        assertTrue(jsonOutput.contains("\"success\": true"));
        assertTrue(jsonOutput.contains("/carent/home"));
    }

    // ===== TEST: AJAX Login Failure =====
    @Test
    @DisplayName("AJAX login failure returns JSON with success:false")
    void testLoginFailure_AjaxReturnsJson() throws Exception {
        setupLoginRequest("wrong", "wrong", null, true);
        when(userDAO.getUserByUsernameAndPassword("wrong", "wrong")).thenReturn(null);
        when(response.getWriter()).thenReturn(printWriter);

        invokeHandleLogin();

        verify(response).setContentType("application/json");
        String jsonOutput = responseWriter.toString();
        assertTrue(jsonOutput.contains("\"success\": false"));
        assertTrue(jsonOutput.contains("Invalid username or password"));
    }

    // ===== TEST: RememberMe Cookie Set =====
    @Test
    @DisplayName("Login with rememberMe=on sets cookie with 30-day max age")
    void testLoginSuccess_RememberMeCookieSet() throws Exception {
        User user = createTestUser("hardip", "Customer");
        setupLoginRequest("hardip", "Utsav@123", "on", false);
        when(userDAO.getUserByUsernameAndPassword("hardip", "Utsav@123")).thenReturn(user);
        when(request.getSession(true)).thenReturn(session);
        when(request.getContextPath()).thenReturn("/carent");

        invokeHandleLogin();

        verify(response).addCookie(argThat(cookie ->
                "rememberUser".equals(cookie.getName()) &&
                "hardip".equals(cookie.getValue()) &&
                cookie.getMaxAge() == 30 * 24 * 60 * 60
        ));
    }

    // ===== TEST: RememberMe Cookie Cleared =====
    @Test
    @DisplayName("Login without rememberMe clears the cookie")
    void testLoginSuccess_RememberMeCookieCleared() throws Exception {
        User user = createTestUser("hardip", "Customer");
        setupLoginRequest("hardip", "Utsav@123", null, false);
        when(userDAO.getUserByUsernameAndPassword("hardip", "Utsav@123")).thenReturn(user);
        when(request.getSession(true)).thenReturn(session);
        when(request.getContextPath()).thenReturn("/carent");

        invokeHandleLogin();

        verify(response).addCookie(argThat(cookie ->
                "rememberUser".equals(cookie.getName()) &&
                "".equals(cookie.getValue()) &&
                cookie.getMaxAge() == 0
        ));
    }

    // ===== TEST: AJAX Empty Fields =====
    @Test
    @DisplayName("AJAX login with empty fields returns error JSON")
    void testLoginFailure_AjaxEmptyFields() throws Exception {
        setupLoginRequest("", "", null, true);
        when(response.getWriter()).thenReturn(printWriter);

        invokeHandleLogin();

        String jsonOutput = responseWriter.toString();
        assertTrue(jsonOutput.contains("\"success\": false"));
        assertTrue(jsonOutput.contains("required"));
    }
}
