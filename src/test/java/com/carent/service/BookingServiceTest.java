package com.carent.service;

import com.carent.model.Booking;
import com.carent.model.Car;
import com.carent.model.Coupon;
import com.carent.repository.BookingDAO;
import com.carent.repository.CarDAO;
import com.carent.repository.CouponDAO;

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
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

/**
 * Unit tests for BookingService using Mockito mocks for DAO layer.
 */
@ExtendWith(MockitoExtension.class)
@MockitoSettings(strictness = Strictness.LENIENT)
@DisplayName("BookingService Tests")
class BookingServiceTest {

    @Mock private BookingDAO bookingDAO;
    @Mock private CarDAO carDAO;
    @Mock private CouponDAO couponDAO;

    private BookingService bookingService;
    private Car testCar;

    @BeforeEach
    void setUp() throws Exception {
        bookingService = new BookingService();

        // Inject mocks via reflection (fields are final, initialized inline)
        injectField("bookingDAO", bookingDAO);
        injectField("carDAO", carDAO);
        injectField("couponDAO", couponDAO);

        testCar = new Car("Civic", "Honda", new BigDecimal("5000"), "Petrol", "Automatic", "img.jpg");
        testCar.setCarId(1);
        testCar.setStatus("Available");
    }

    private void injectField(String name, Object value) throws Exception {
        Field f = BookingService.class.getDeclaredField(name);
        f.setAccessible(true);
        f.set(bookingService, value);
    }

    @Test
    @DisplayName("createBooking succeeds with valid inputs and Cash payment")
    void testCreateBookingSuccess() {
        Date start = Date.valueOf("2026-05-01");
        Date end = Date.valueOf("2026-05-04");

        when(carDAO.getCarById(1)).thenReturn(testCar);
        when(carDAO.isCarAvailable(eq(1), any(Date.class), any(Date.class))).thenReturn(true);
        when(bookingDAO.insertBooking(any(Booking.class))).thenReturn(true);

        Booking result = bookingService.createBooking(1, 1, "Station", "Airport",
                start, end, null, "Cash", null);

        assertNotNull(result);
        assertEquals("Pending", result.getBookingStatus());
        assertEquals("Unpaid", result.getPaymentStatus());
        assertEquals(3, result.getTotalDays());
        assertEquals(new BigDecimal("15000"), result.getTotalPrice());
        assertEquals(new BigDecimal("15000"), result.getFinalPrice());
        verify(bookingDAO).insertBooking(any(Booking.class));
    }

    @Test
    @DisplayName("createBooking with Online payment sets Confirmed + Paid status")
    void testCreateBookingOnlinePayment() {
        Date start = Date.valueOf("2026-06-01");
        Date end = Date.valueOf("2026-06-03");

        when(carDAO.getCarById(1)).thenReturn(testCar);
        when(carDAO.isCarAvailable(eq(1), any(Date.class), any(Date.class))).thenReturn(true);
        when(bookingDAO.insertBooking(any(Booking.class))).thenReturn(true);

        Booking result = bookingService.createBooking(1, 1, "A", "B",
                start, end, null, "Online", "TXN_12345");

        assertEquals("Confirmed", result.getBookingStatus());
        assertEquals("Paid", result.getPaymentStatus());
        assertEquals("TXN_12345", result.getTransactionId());
    }

    @Test
    @DisplayName("createBooking throws exception for invalid dates (end before start)")
    void testCreateBookingInvalidDates() {
        Date start = Date.valueOf("2026-05-10");
        Date end = Date.valueOf("2026-05-05");

        assertThrows(IllegalArgumentException.class, () ->
                bookingService.createBooking(1, 1, "A", "B",
                        start, end, null, "Cash", null));
    }

    @Test
    @DisplayName("createBooking throws exception when car not found")
    void testCreateBookingCarNotFound() {
        Date start = Date.valueOf("2026-05-01");
        Date end = Date.valueOf("2026-05-04");

        when(carDAO.getCarById(999)).thenReturn(null);

        assertThrows(IllegalArgumentException.class, () ->
                bookingService.createBooking(1, 999, "A", "B",
                        start, end, null, "Cash", null));
    }

    @Test
    @DisplayName("createBooking throws exception when car is under Service")
    void testCreateBookingCarUnderService() {
        Date start = Date.valueOf("2026-05-01");
        Date end = Date.valueOf("2026-05-04");
        testCar.setStatus("Service");

        when(carDAO.getCarById(1)).thenReturn(testCar);

        assertThrows(IllegalArgumentException.class, () ->
                bookingService.createBooking(1, 1, "A", "B",
                        start, end, null, "Cash", null));
    }

    @Test
    @DisplayName("createBooking throws exception when car is not available for dates")
    void testCreateBookingCarNotAvailable() {
        Date start = Date.valueOf("2026-05-01");
        Date end = Date.valueOf("2026-05-04");

        when(carDAO.getCarById(1)).thenReturn(testCar);
        when(carDAO.isCarAvailable(eq(1), any(Date.class), any(Date.class))).thenReturn(false);

        assertThrows(IllegalArgumentException.class, () ->
                bookingService.createBooking(1, 1, "A", "B",
                        start, end, null, "Cash", null));
    }

    @Test
    @DisplayName("createBooking applies coupon discount correctly")
    void testCreateBookingWithCoupon() {
        Date start = Date.valueOf("2026-05-01");
        Date end = Date.valueOf("2026-05-03"); // 2 days = 10000

        Coupon coupon = new Coupon();
        coupon.setCode("SAVE20");
        coupon.setDiscountPercentage(new BigDecimal("20"));

        when(carDAO.getCarById(1)).thenReturn(testCar);
        when(carDAO.isCarAvailable(eq(1), any(Date.class), any(Date.class))).thenReturn(true);
        when(couponDAO.validateCoupon("SAVE20")).thenReturn(coupon);
        when(bookingDAO.insertBooking(any(Booking.class))).thenReturn(true);

        Booking result = bookingService.createBooking(1, 1, "A", "B",
                start, end, "SAVE20", "Cash", null);

        assertNotNull(result);
        assertEquals(new BigDecimal("10000"), result.getTotalPrice());
        assertEquals(new BigDecimal("2000.00"), result.getDiscountAmount());
        assertEquals(new BigDecimal("8000.00"), result.getFinalPrice());
    }

    @Test
    @DisplayName("createBooking throws RuntimeException when DAO insert fails")
    void testCreateBookingInsertFails() {
        Date start = Date.valueOf("2026-05-01");
        Date end = Date.valueOf("2026-05-04");

        when(carDAO.getCarById(1)).thenReturn(testCar);
        when(carDAO.isCarAvailable(eq(1), any(Date.class), any(Date.class))).thenReturn(true);
        when(bookingDAO.insertBooking(any(Booking.class))).thenReturn(false);

        assertThrows(RuntimeException.class, () ->
                bookingService.createBooking(1, 1, "A", "B",
                        start, end, null, "Cash", null));
    }

    @Test
    @DisplayName("getBookingsByUser delegates to DAO")
    void testGetBookingsByUser() {
        List<Booking> mockList = Arrays.asList(new Booking(), new Booking());
        when(bookingDAO.getBookingsByUser(1)).thenReturn(mockList);

        List<Booking> result = bookingService.getBookingsByUser(1);
        assertEquals(2, result.size());
        verify(bookingDAO).getBookingsByUser(1);
    }

    @Test
    @DisplayName("getAllBookings delegates to DAO")
    void testGetAllBookings() {
        List<Booking> mockList = Arrays.asList(new Booking(), new Booking(), new Booking());
        when(bookingDAO.getAllBookings()).thenReturn(mockList);

        List<Booking> result = bookingService.getAllBookings();
        assertEquals(3, result.size());
    }

    @Test
    @DisplayName("getBookingById delegates to DAO")
    void testGetBookingById() {
        Booking mock = new Booking();
        mock.setBookingId(5);
        when(bookingDAO.getBookingById(5)).thenReturn(mock);

        Booking result = bookingService.getBookingById(5);
        assertNotNull(result);
        assertEquals(5, result.getBookingId());
    }
}
