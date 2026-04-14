package com.carent.model;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.DisplayName;
import java.sql.Timestamp;
import static org.junit.jupiter.api.Assertions.*;

/**
 * Unit tests for the User model class.
 */
@DisplayName("User Model Tests")
class UserTest {

    @Test
    @DisplayName("Default constructor creates User with default values")
    void testDefaultConstructor() {
        User user = new User();
        assertEquals(0, user.getUserId());
        assertNull(user.getFullName());
        assertNull(user.getEmail());
        assertNull(user.getUsername());
        assertNull(user.getRole());
        assertFalse(user.isVerified());
    }

    @Test
    @DisplayName("Parameterized constructor sets role to Customer")
    void testParameterizedConstructor() {
        User user = new User("Utsav Sakariya", "utsav@test.com", "9876543210", "utsav", "Pass@123", "GJ03-1234");
        assertEquals("Utsav Sakariya", user.getFullName());
        assertEquals("utsav@test.com", user.getEmail());
        assertEquals("9876543210", user.getPhone());
        assertEquals("utsav", user.getUsername());
        assertEquals("Pass@123", user.getPassword());
        assertEquals("GJ03-1234", user.getLicenseNo());
        assertEquals("Customer", user.getRole());
        assertFalse(user.isVerified());
    }

    @Test
    @DisplayName("Getters and setters work correctly")
    void testGettersAndSetters() {
        User user = new User();
        user.setUserId(1);
        user.setFullName("Test User");
        user.setEmail("test@example.com");
        user.setPhone("1234567890");
        user.setUsername("testuser");
        user.setPassword("hashed_password");
        user.setLicenseNo("GJ-01-0001");
        user.setRole("Admin");
        user.setVerified(true);
        Timestamp now = new Timestamp(System.currentTimeMillis());
        user.setCreatedAt(now);
        user.setIdUrl("https://id.url");
        user.setLicenseUrl("https://license.url");

        assertEquals(1, user.getUserId());
        assertEquals("Test User", user.getFullName());
        assertEquals("test@example.com", user.getEmail());
        assertEquals("1234567890", user.getPhone());
        assertEquals("testuser", user.getUsername());
        assertEquals("hashed_password", user.getPassword());
        assertEquals("GJ-01-0001", user.getLicenseNo());
        assertEquals("Admin", user.getRole());
        assertTrue(user.isVerified());
        assertEquals(now, user.getCreatedAt());
        assertEquals("https://id.url", user.getIdUrl());
        assertEquals("https://license.url", user.getLicenseUrl());
    }

    @Test
    @DisplayName("toString returns formatted string")
    void testToString() {
        User user = new User();
        user.setUserId(42);
        user.setUsername("admin");
        user.setRole("Admin");
        user.setVerified(true);
        String result = user.toString();
        assertTrue(result.contains("42"));
        assertTrue(result.contains("admin"));
        assertTrue(result.contains("Admin"));
        assertTrue(result.contains("true"));
    }
}
