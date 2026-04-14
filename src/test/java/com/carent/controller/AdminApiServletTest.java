package com.carent.controller;

import com.carent.model.Car;
import com.carent.model.User;
import com.carent.repository.BookingDAO;
import com.carent.repository.CarDAO;
import com.carent.repository.UserDAO;
import com.carent.repository.ContactMessageDAO;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.mockito.junit.jupiter.MockitoSettings;
import org.mockito.quality.Strictness;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.lang.reflect.Field;
import java.math.BigDecimal;
import java.util.Arrays;
import java.util.Collections;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@MockitoSettings(strictness = Strictness.LENIENT)
@DisplayName("AdminApiServlet Tests")
class AdminApiServletTest {

    @Mock private HttpServletRequest request;
    @Mock private HttpServletResponse response;
    @Mock private HttpSession session;
    @Mock private CarDAO carDAO;
    @Mock private UserDAO userDAO;
    @Mock private BookingDAO bookingDAO;
    @Mock private ContactMessageDAO msgDAO;

    private AdminApiServlet servlet;
    private StringWriter responseWriter;
    private PrintWriter printWriter;

    @BeforeEach
    void setUp() throws Exception {
        servlet = new AdminApiServlet();
        responseWriter = new StringWriter();
        printWriter = new PrintWriter(responseWriter);

        // Inject mocks via reflection (fields are final)
        setField("carDAO", carDAO);
        setField("userDAO", userDAO);
        setField("bookingDAO", bookingDAO);
        setField("msgDAO", msgDAO);
    }

    private void setField(String name, Object value) throws Exception {
        Field f = AdminApiServlet.class.getDeclaredField(name);
        f.setAccessible(true);
        f.set(servlet, value);
    }

    private User createAdminUser() {
        User admin = new User();
        admin.setUserId(1); admin.setUsername("admin"); admin.setRole("Admin");
        return admin;
    }

    // ===== SECURITY TESTS =====

    @Test
    @DisplayName("Request without session returns 401")
    void testUnauthorized_NoSession() throws Exception {
        when(request.getSession(false)).thenReturn(null);
        servlet.doGet(request, response);
        verify(response).setStatus(401);
    }

    @Test
    @DisplayName("Request without loggedUser returns 401")
    void testUnauthorized_NoLoggedUser() throws Exception {
        when(request.getSession(false)).thenReturn(session);
        when(session.getAttribute("loggedUser")).thenReturn(null);
        servlet.doGet(request, response);
        verify(response).setStatus(401);
    }

    @Test
    @DisplayName("Non-admin user returns 403")
    void testForbidden_NonAdmin() throws Exception {
        User customer = new User(); customer.setRole("Customer");
        when(request.getSession(false)).thenReturn(session);
        when(session.getAttribute("loggedUser")).thenReturn(customer);
        servlet.doGet(request, response);
        verify(response).setStatus(403);
    }

    // ===== SEARCH VEHICLES =====

    @Test
    @DisplayName("search_vehicles returns JSON array of cars")
    void testSearchVehicles() throws Exception {
        when(request.getSession(false)).thenReturn(session);
        when(session.getAttribute("loggedUser")).thenReturn(createAdminUser());
        when(request.getServletPath()).thenReturn("/admin/api/search_vehicles");
        when(request.getParameter("q")).thenReturn("Honda");
        when(response.getWriter()).thenReturn(printWriter);

        Car car = new Car("Civic", "Honda", new BigDecimal("5000"), "Petrol", "Auto", "img.jpg");
        car.setCarId(1);
        when(carDAO.searchCarsAdmin("Honda")).thenReturn(Arrays.asList(car));

        servlet.doGet(request, response);

        String json = responseWriter.toString();
        assertTrue(json.startsWith("["));
        assertTrue(json.contains("\"Civic\""));
        assertTrue(json.contains("\"Honda\""));
    }

    @Test
    @DisplayName("search_vehicles with no results returns empty array")
    void testSearchVehiclesEmpty() throws Exception {
        when(request.getSession(false)).thenReturn(session);
        when(session.getAttribute("loggedUser")).thenReturn(createAdminUser());
        when(request.getServletPath()).thenReturn("/admin/api/search_vehicles");
        when(request.getParameter("q")).thenReturn("Nonexistent");
        when(response.getWriter()).thenReturn(printWriter);
        when(carDAO.searchCarsAdmin("Nonexistent")).thenReturn(Collections.emptyList());

        servlet.doGet(request, response);
        assertEquals("[]", responseWriter.toString());
    }

    // ===== SEARCH CUSTOMERS =====

    @Test
    @DisplayName("search_customers returns JSON array of users")
    void testSearchCustomers() throws Exception {
        when(request.getSession(false)).thenReturn(session);
        when(session.getAttribute("loggedUser")).thenReturn(createAdminUser());
        when(request.getServletPath()).thenReturn("/admin/api/search_customers");
        when(request.getParameter("q")).thenReturn("utsav");
        when(response.getWriter()).thenReturn(printWriter);

        User customer = new User("Utsav", "utsav@test.com", "1234567890", "utsav", "hash", "GJ03");
        customer.setUserId(2);
        when(userDAO.searchCustomers("utsav")).thenReturn(Arrays.asList(customer));

        servlet.doGet(request, response);

        String json = responseWriter.toString();
        assertTrue(json.contains("\"utsav\""));
        assertTrue(json.contains("\"Utsav\""));
    }

    // ===== UNREAD COUNT =====

    @Test
    @DisplayName("unread_count returns JSON with count")
    void testUnreadCount() throws Exception {
        when(request.getSession(false)).thenReturn(session);
        when(session.getAttribute("loggedUser")).thenReturn(createAdminUser());
        when(request.getServletPath()).thenReturn("/admin/api/unread_count");
        when(response.getWriter()).thenReturn(printWriter);
        when(msgDAO.getUnreadCount()).thenReturn(5);

        servlet.doGet(request, response);
        assertEquals("{\"count\":5}", responseWriter.toString());
    }

    // ===== UNKNOWN PATH =====

    @Test
    @DisplayName("Unknown path returns 404")
    void testUnknownPath() throws Exception {
        when(request.getSession(false)).thenReturn(session);
        when(session.getAttribute("loggedUser")).thenReturn(createAdminUser());
        when(request.getServletPath()).thenReturn("/admin/api/unknown");
        when(response.getWriter()).thenReturn(printWriter);

        servlet.doGet(request, response);
        verify(response).setStatus(404);
    }
}
