package com.carent.model;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.DisplayName;
import java.math.BigDecimal;
import java.sql.Date;
import static org.junit.jupiter.api.Assertions.*;

/**
 * Unit tests for the Coupon model class.
 */
@DisplayName("Coupon Model Tests")
class CouponTest {

    @Test
    @DisplayName("Default constructor creates Coupon with default values")
    void testDefaultConstructor() {
        Coupon coupon = new Coupon();
        assertEquals(0, coupon.getCouponId());
        assertNull(coupon.getCode());
        assertNull(coupon.getDiscountPercentage());
        assertFalse(coupon.isActive());
    }

    @Test
    @DisplayName("All getters and setters work correctly")
    void testGettersAndSetters() {
        Coupon coupon = new Coupon();
        coupon.setCouponId(1);
        coupon.setCode("SAVE20");
        coupon.setDiscountPercentage(new BigDecimal("20.00"));
        coupon.setExpiryDate(Date.valueOf("2026-12-31"));
        coupon.setActive(true);

        assertEquals(1, coupon.getCouponId());
        assertEquals("SAVE20", coupon.getCode());
        assertEquals(new BigDecimal("20.00"), coupon.getDiscountPercentage());
        assertEquals(Date.valueOf("2026-12-31"), coupon.getExpiryDate());
        assertTrue(coupon.isActive());
    }
}
