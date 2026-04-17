package com.carent.service;

import com.carent.model.Coupon;
import com.carent.repository.CouponDAO;

import java.util.List;

public class CouponService {
    private final CouponDAO couponDAO = new CouponDAO();

    /**
     * Validate coupon: exists + not expired + active.
     */
    public Coupon validateCoupon(String code) {
        if (code == null || code.trim().isEmpty()) return null;
        return couponDAO.validateCoupon(code.trim());
    }

    public List<Coupon> getAllCoupons() {
        return couponDAO.getAllCoupons();
    }

    public List<Coupon> getActiveCoupons() {
        return couponDAO.getActiveCoupons();
    }

    /**
     * Get coupons available for a user (active + not yet used by them).
     */
    public List<Coupon> getAvailableCouponsForUser(int userId) {
        return couponDAO.getAvailableCouponsForUser(userId);
    }

    /**
     * Check if a user has already used a specific coupon.
     */
    public boolean hasUserUsedCoupon(int userId, String couponCode) {
        Coupon coupon = validateCoupon(couponCode);
        if (coupon == null) return false;
        return couponDAO.hasUserUsedCoupon(userId, coupon.getCouponId());
    }

    /**
     * Record coupon usage after successful booking.
     */
    public void recordCouponUsage(int userId, String couponCode) {
        Coupon coupon = validateCoupon(couponCode);
        if (coupon != null) {
            couponDAO.recordCouponUsage(userId, coupon.getCouponId());
        }
    }

    public boolean addCoupon(Coupon coupon) {
        return couponDAO.insertCoupon(coupon);
    }

    public boolean updateCoupon(Coupon coupon) {
        return couponDAO.updateCoupon(coupon);
    }

    public boolean deleteCoupon(int couponId) {
        return couponDAO.deleteCoupon(couponId);
    }

    public Coupon getCouponById(int couponId) {
        return couponDAO.getCouponById(couponId);
    }
}
