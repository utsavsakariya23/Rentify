package com.carent.service;

import com.carent.model.Car;
import com.carent.repository.CarDAO;
import com.carent.repository.ReviewDAO;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.mockito.junit.jupiter.MockitoSettings;
import org.mockito.quality.Strictness;

import java.lang.reflect.Field;
import java.math.BigDecimal;
import java.sql.Date;
import java.util.Arrays;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@MockitoSettings(strictness = Strictness.LENIENT)
@DisplayName("CarService Tests")
class CarServiceTest {

    @Mock private CarDAO carDAO;
    @Mock private ReviewDAO reviewDAO;

    private CarService carService;

    @BeforeEach
    void setUp() throws Exception {
        carService = new CarService();
        Field f1 = CarService.class.getDeclaredField("carDAO");
        f1.setAccessible(true); f1.set(carService, carDAO);
        Field f2 = CarService.class.getDeclaredField("reviewDAO");
        f2.setAccessible(true); f2.set(carService, reviewDAO);
    }

    @Test
    @DisplayName("getAllCars returns list from DAO")
    void testGetAllCars() {
        when(carDAO.getAllCars()).thenReturn(Arrays.asList(new Car(), new Car()));
        assertEquals(2, carService.getAllCars().size());
    }

    @Test
    @DisplayName("getAvailableCars enriches cars with ratings")
    void testGetAvailableCars() {
        Car car1 = new Car("Civic", "Honda", new BigDecimal("5000"), "Petrol", "Auto", "img");
        car1.setCarId(1);
        when(carDAO.getAvailableCars()).thenReturn(Arrays.asList(car1));
        when(reviewDAO.getAverageRating(1)).thenReturn(4.5);
        when(reviewDAO.getReviewCount(1)).thenReturn(10);

        List<Car> result = carService.getAvailableCars();
        assertEquals(1, result.size());
        assertEquals(4.5, result.get(0).getAverageRating());
        assertEquals(10, result.get(0).getReviewCount());
    }

    @Test
    @DisplayName("getCarById returns car enriched with ratings")
    void testGetCarByIdFound() {
        Car car = new Car("Civic", "Honda", new BigDecimal("5000"), "Petrol", "Auto", "img");
        car.setCarId(1);
        when(carDAO.getCarById(1)).thenReturn(car);
        when(reviewDAO.getAverageRating(1)).thenReturn(4.2);
        when(reviewDAO.getReviewCount(1)).thenReturn(8);

        Car result = carService.getCarById(1);
        assertNotNull(result);
        assertEquals("Civic", result.getName());
        assertEquals(4.2, result.getAverageRating());
    }

    @Test
    @DisplayName("getCarById returns null when car not found")
    void testGetCarByIdNotFound() {
        when(carDAO.getCarById(999)).thenReturn(null);
        assertNull(carService.getCarById(999));
    }

    @Test
    @DisplayName("addCar delegates to DAO")
    void testAddCar() {
        Car car = new Car("X", "B", new BigDecimal("8000"), "Petrol", "Manual", "img");
        when(carDAO.insertCar(car)).thenReturn(true);
        assertTrue(carService.addCar(car));
    }

    @Test
    @DisplayName("updateCar delegates to DAO")
    void testUpdateCar() {
        Car car = new Car(); car.setCarId(1);
        when(carDAO.updateCar(car)).thenReturn(true);
        assertTrue(carService.updateCar(car));
    }

    @Test
    @DisplayName("deleteCar delegates to DAO")
    void testDeleteCar() {
        when(carDAO.deleteCar(1)).thenReturn(true);
        assertTrue(carService.deleteCar(1));
    }

    @Test
    @DisplayName("updateCarStatus delegates to DAO")
    void testUpdateCarStatus() {
        when(carDAO.updateCarStatus(1, "Service")).thenReturn(true);
        assertTrue(carService.updateCarStatus(1, "Service"));
    }

    @Test
    @DisplayName("isCarAvailable checks status and DAO availability")
    void testIsCarAvailable() {
        Car car = new Car(); car.setCarId(1); car.setStatus("Available");
        Date start = Date.valueOf("2026-05-01"), end = Date.valueOf("2026-05-05");
        when(carDAO.getCarById(1)).thenReturn(car);
        when(carDAO.isCarAvailable(1, start, end)).thenReturn(true);
        assertTrue(carService.isCarAvailable(1, start, end));
    }

    @Test
    @DisplayName("isCarAvailable returns false for Service status")
    void testIsCarAvailableUnderService() {
        Car car = new Car(); car.setCarId(1); car.setStatus("Service");
        when(carDAO.getCarById(1)).thenReturn(car);
        assertFalse(carService.isCarAvailable(1, Date.valueOf("2026-05-01"), Date.valueOf("2026-05-05")));
    }

    @Test
    @DisplayName("getCarCount delegates to DAO")
    void testGetCarCount() {
        when(carDAO.getCarCount()).thenReturn(15);
        assertEquals(15, carService.getCarCount());
    }

    @Test
    @DisplayName("getActiveCarCount delegates to DAO")
    void testGetActiveCarCount() {
        when(carDAO.getActiveCarCount()).thenReturn(12);
        assertEquals(12, carService.getActiveCarCount());
    }
}
