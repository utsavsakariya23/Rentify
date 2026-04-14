package com.carent.model;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.DisplayName;
import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Timestamp;
import static org.junit.jupiter.api.Assertions.*;

/**
 * Unit tests for the Booking model class.
 */
@DisplayName("Booking Model Tests")
class BookingTest {

    @Test
    @DisplayName("Default constructor creates Booking with default values")
    void testDefaultConstructor() {
        Booking booking = new Booking();
        assertEquals(0, booking.getBookingId());
        assertEquals(0, booking.getUserId());
        assertEquals(0, booking.getCarId());
        assertNull(booking.getBookingStatus());
        assertNull(booking.getPaymentStatus());
    }

    @Test
    @DisplayName("All getters and setters function properly")
    void testGettersAndSetters() {
        Booking booking = new Booking();
        booking.setBookingId(100);
        booking.setUserId(5);
        booking.setCarId(3);
        booking.setPickupLocation("Rajkot Station");
        booking.setDropLocation("Rajkot Airport");
        Date start = Date.valueOf("2026-05-01");
        Date end = Date.valueOf("2026-05-05");
        booking.setStartDate(start);
        booking.setEndDate(end);
        booking.setTotalDays(4);
        booking.setTotalPrice(new BigDecimal("20000"));
        booking.setDiscountAmount(new BigDecimal("2000"));
        booking.setFinalPrice(new BigDecimal("18000"));
        booking.setBookingStatus("Confirmed");
        booking.setPaymentStatus("Paid");
        booking.setPaymentMethod("Online");
        booking.setTransactionId("TXN_ABC123");
        Timestamp now = new Timestamp(System.currentTimeMillis());
        booking.setCreatedAt(now);

        assertEquals(100, booking.getBookingId());
        assertEquals(5, booking.getUserId());
        assertEquals(3, booking.getCarId());
        assertEquals("Rajkot Station", booking.getPickupLocation());
        assertEquals("Rajkot Airport", booking.getDropLocation());
        assertEquals(start, booking.getStartDate());
        assertEquals(end, booking.getEndDate());
        assertEquals(4, booking.getTotalDays());
        assertEquals(new BigDecimal("20000"), booking.getTotalPrice());
        assertEquals(new BigDecimal("2000"), booking.getDiscountAmount());
        assertEquals(new BigDecimal("18000"), booking.getFinalPrice());
        assertEquals("Confirmed", booking.getBookingStatus());
        assertEquals("Paid", booking.getPaymentStatus());
        assertEquals("Online", booking.getPaymentMethod());
        assertEquals("TXN_ABC123", booking.getTransactionId());
        assertEquals(now, booking.getCreatedAt());
    }

    @Test
    @DisplayName("Transient display fields work correctly")
    void testTransientFields() {
        Booking booking = new Booking();
        booking.setUserName("Hardip");
        booking.setCarName("Defender Octa");
        booking.setCarBrand("Defender");
        booking.setUserEmail("hardip@test.com");

        assertEquals("Hardip", booking.getUserName());
        assertEquals("Defender Octa", booking.getCarName());
        assertEquals("Defender", booking.getCarBrand());
        assertEquals("hardip@test.com", booking.getUserEmail());
    }
}
