package com.carent.controller;

import com.carent.model.User;
import com.carent.model.Car;
import com.carent.service.CarService;
import com.carent.repository.UserDAO;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.lang.reflect.Field;
import java.util.Arrays;

import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

/**
 * Unit tests for PageController's doGet route dispatching.
 * Verifies that each URL route forwards to the correct JSP view
 * and that protected routes enforce authentication.
 */
@ExtendWith(MockitoExtension.class)
@DisplayName("PageController Routing Tests")
class PageControllerRoutingTest {

    @Mock private HttpServletRequest request;
    @Mock private HttpServletResponse response;
    @Mock private HttpSession session;
    @Mock private RequestDispatcher dispatcher;
    @Mock private CarService carService;
    @Mock private UserDAO userDAO;

    private PageController controller;

    @BeforeEach
    void setUp() throws Exception {
        controller = new PageController();

        // Inject mocks via reflection
        Field carServiceField = PageController.class.getDeclaredField("carService");
        carServiceField.setAccessible(true);
        carServiceField.set(controller, carService);

        Field userDAOField = PageController.class.getDeclaredField("userDAO");
        userDAOField.setAccessible(true);
        userDAOField.set(controller, userDAO);
    }

    private void setupRoute(String path) {
        when(request.getRequestURI()).thenReturn("/carent" + path);
        when(request.getContextPath()).thenReturn("/carent");
    }

    // ===== PUBLIC ROUTES =====

    @Test
    @DisplayName("/home route forwards to home.jsp")
    void testHomeRoute() throws Exception {
        setupRoute("/home");
        when(request.getRequestDispatcher("/WEB-INF/views/home.jsp")).thenReturn(dispatcher);

        controller.doGet(request, response);

        verify(request).getRequestDispatcher("/WEB-INF/views/home.jsp");
        verify(dispatcher).forward(request, response);
    }

    @Test
    @DisplayName("/login route forwards to login.jsp")
    void testLoginRoute() throws Exception {
        setupRoute("/login");
        when(request.getRequestDispatcher("/WEB-INF/views/login.jsp")).thenReturn(dispatcher);

        controller.doGet(request, response);

        verify(request).getRequestDispatcher("/WEB-INF/views/login.jsp");
        verify(dispatcher).forward(request, response);
    }

    @Test
    @DisplayName("/register route forwards to register.jsp")
    void testRegisterRoute() throws Exception {
        setupRoute("/register");
        when(request.getRequestDispatcher("/WEB-INF/views/register.jsp")).thenReturn(dispatcher);

        controller.doGet(request, response);

        verify(request).getRequestDispatcher("/WEB-INF/views/register.jsp");
        verify(dispatcher).forward(request, response);
    }

    @Test
    @DisplayName("/about route forwards to about.jsp")
    void testAboutRoute() throws Exception {
        setupRoute("/about");
        when(request.getRequestDispatcher("/WEB-INF/views/about.jsp")).thenReturn(dispatcher);

        controller.doGet(request, response);

        verify(request).getRequestDispatcher("/WEB-INF/views/about.jsp");
        verify(dispatcher).forward(request, response);
    }

    @Test
    @DisplayName("/contact route forwards to contact.jsp")
    void testContactRoute() throws Exception {
        setupRoute("/contact");
        when(request.getRequestDispatcher("/WEB-INF/views/contact.jsp")).thenReturn(dispatcher);

        controller.doGet(request, response);

        verify(request).getRequestDispatcher("/WEB-INF/views/contact.jsp");
        verify(dispatcher).forward(request, response);
    }

    // ===== PROTECTED ROUTES =====

    @Test
    @DisplayName("/admin route without session redirects to login")
    void testAdminRouteNoSession() throws Exception {
        setupRoute("/admin/dashboard");
        when(request.getSession(false)).thenReturn(null);

        controller.doGet(request, response);

        verify(response).sendRedirect("/carent/login?error=true");
    }

    @Test
    @DisplayName("/admin route without loggedUser in session redirects to login")
    void testAdminRouteNoLoggedUser() throws Exception {
        setupRoute("/admin/dashboard");
        when(request.getSession(false)).thenReturn(session);
        when(session.getAttribute("loggedUser")).thenReturn(null);

        controller.doGet(request, response);

        verify(response).sendRedirect("/carent/login?error=true");
    }

    @Test
    @DisplayName("/admin route with non-admin user redirects to home")
    void testAdminRouteNonAdmin() throws Exception {
        setupRoute("/admin/dashboard");
        User customer = new User();
        customer.setRole("Customer");
        when(request.getSession(false)).thenReturn(session);
        when(session.getAttribute("loggedUser")).thenReturn(customer);

        controller.doGet(request, response);

        verify(response).sendRedirect("/carent/home");
    }

    @Test
    @DisplayName("/profile route without session redirects to login")
    void testProfileRouteNoSession() throws Exception {
        setupRoute("/profile");
        when(request.getSession(false)).thenReturn(null);

        controller.doGet(request, response);

        verify(response).sendRedirect("/carent/login?error=true");
    }

    @Test
    @DisplayName("Trailing slash is normalized (/home/ treated as /home)")
    void testTrailingSlashNormalization() throws Exception {
        when(request.getRequestURI()).thenReturn("/carent/home/");
        when(request.getContextPath()).thenReturn("/carent");
        when(request.getRequestDispatcher("/WEB-INF/views/home.jsp")).thenReturn(dispatcher);

        controller.doGet(request, response);

        verify(request).getRequestDispatcher("/WEB-INF/views/home.jsp");
    }
}
