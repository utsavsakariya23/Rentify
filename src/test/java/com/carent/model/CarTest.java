package com.carent.model;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.DisplayName;
import java.math.BigDecimal;
import java.sql.Timestamp;
import static org.junit.jupiter.api.Assertions.*;

/**
 * Unit tests for the Car model class.
 */
@DisplayName("Car Model Tests")
class CarTest {

    @Test
    @DisplayName("Default constructor creates Car with default values")
    void testDefaultConstructor() {
        Car car = new Car();
        assertEquals(0, car.getCarId());
        assertNull(car.getName());
        assertNull(car.getBrand());
        assertNull(car.getStatus());
    }

    @Test
    @DisplayName("Parameterized constructor sets status to Available")
    void testParameterizedConstructor() {
        Car car = new Car("Civic", "Honda", new BigDecimal("5000"), "Petrol", "Automatic", "http://img.url");
        assertEquals("Civic", car.getName());
        assertEquals("Honda", car.getBrand());
        assertEquals(new BigDecimal("5000"), car.getPricePerDay());
        assertEquals("Petrol", car.getFuelType());
        assertEquals("Automatic", car.getTransmission());
        assertEquals("http://img.url", car.getImageUrl());
        assertEquals("Available", car.getStatus());
    }

    @Test
    @DisplayName("All getters and setters function properly")
    void testGettersAndSetters() {
        Car car = new Car();
        car.setCarId(10);
        car.setName("A4");
        car.setBrand("Audi");
        car.setPricePerDay(new BigDecimal("15000"));
        car.setFuelType("Diesel");
        car.setTransmission("Manual");
        car.setImageUrl("img.jpg");
        car.setStatus("Service");
        car.setMileage(50000);
        car.setAverageRating(4.5);
        car.setReviewCount(12);
        car.setTotalBookings(25);

        assertEquals(10, car.getCarId());
        assertEquals("A4", car.getName());
        assertEquals("Audi", car.getBrand());
        assertEquals(new BigDecimal("15000"), car.getPricePerDay());
        assertEquals("Diesel", car.getFuelType());
        assertEquals("Manual", car.getTransmission());
        assertEquals("img.jpg", car.getImageUrl());
        assertEquals("Service", car.getStatus());
        assertEquals(50000, car.getMileage());
        assertEquals(4.5, car.getAverageRating());
        assertEquals(12, car.getReviewCount());
        assertEquals(25, car.getTotalBookings());
    }

    @Test
    @DisplayName("Fleet management date fields work properly")
    void testFleetManagementFields() {
        Car car = new Car();
        java.sql.Date serviceDate = java.sql.Date.valueOf("2026-01-15");
        java.sql.Date nextService = java.sql.Date.valueOf("2026-07-15");
        java.sql.Date insurance = java.sql.Date.valueOf("2026-12-31");

        car.setLastServiceDate(serviceDate);
        car.setNextServiceDate(nextService);
        car.setInsuranceExpiry(insurance);

        assertEquals(serviceDate, car.getLastServiceDate());
        assertEquals(nextService, car.getNextServiceDate());
        assertEquals(insurance, car.getInsuranceExpiry());
    }
}
