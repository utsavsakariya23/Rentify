package com.carent.service;

import com.carent.model.Coupon;
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
import java.util.Arrays;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@MockitoSettings(strictness = Strictness.LENIENT)
@DisplayName("CouponService Tests")
class CouponServiceTest {

    @Mock private CouponDAO couponDAO;

    private CouponService couponService;

    @BeforeEach
    void setUp() throws Exception {
        couponService = new CouponService();
        Field f = CouponService.class.getDeclaredField("couponDAO");
        f.setAccessible(true); f.set(couponService, couponDAO);
    }

    @Test
    @DisplayName("validateCoupon returns coupon for valid code")
    void testValidateCouponValid() {
        Coupon coupon = new Coupon();
        coupon.setCode("SAVE20");
        coupon.setDiscountPercentage(new BigDecimal("20"));
        when(couponDAO.validateCoupon("SAVE20")).thenReturn(coupon);

        Coupon result = couponService.validateCoupon("SAVE20");
        assertNotNull(result);
        assertEquals("SAVE20", result.getCode());
    }

    @Test
    @DisplayName("validateCoupon returns null for null code")
    void testValidateCouponNull() {
        assertNull(couponService.validateCoupon(null));
    }

    @Test
    @DisplayName("validateCoupon returns null for empty code")
    void testValidateCouponEmpty() {
        assertNull(couponService.validateCoupon("   "));
    }

    @Test
    @DisplayName("validateCoupon trims whitespace")
    void testValidateCouponTrimsWhitespace() {
        when(couponDAO.validateCoupon("SAVE20")).thenReturn(new Coupon());
        couponService.validateCoupon("  SAVE20  ");
        verify(couponDAO).validateCoupon("SAVE20");
    }

    @Test
    @DisplayName("getAllCoupons delegates to DAO")
    void testGetAllCoupons() {
        when(couponDAO.getAllCoupons()).thenReturn(Arrays.asList(new Coupon(), new Coupon()));
        assertEquals(2, couponService.getAllCoupons().size());
    }

    @Test
    @DisplayName("addCoupon delegates to DAO")
    void testAddCoupon() {
        Coupon coupon = new Coupon();
        coupon.setCode("NEW10");
        when(couponDAO.insertCoupon(coupon)).thenReturn(true);
        assertTrue(couponService.addCoupon(coupon));
    }

    @Test
    @DisplayName("deleteCoupon delegates to DAO")
    void testDeleteCoupon() {
        when(couponDAO.deleteCoupon(1)).thenReturn(true);
        assertTrue(couponService.deleteCoupon(1));
    }

    @Test
    @DisplayName("getCouponById delegates to DAO")
    void testGetCouponById() {
        Coupon c = new Coupon();
        c.setCouponId(1);
        when(couponDAO.getCouponById(1)).thenReturn(c);
        assertEquals(1, couponService.getCouponById(1).getCouponId());
    }
}
