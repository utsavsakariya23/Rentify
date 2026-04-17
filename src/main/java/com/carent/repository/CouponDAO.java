package com.carent.repository;

import com.carent.config.DBConnection;
import com.carent.model.Coupon;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CouponDAO {

    // Auto-migrate: create coupon_usage table + is_suggested column
    static {
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement()) {
            stmt.execute("CREATE TABLE IF NOT EXISTS coupon_usage (" +
                    "usage_id SERIAL PRIMARY KEY, " +
                    "coupon_id INT NOT NULL REFERENCES coupons(coupon_id) ON DELETE CASCADE, " +
                    "user_id INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE, " +
                    "used_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, " +
                    "UNIQUE(coupon_id, user_id)" +
                    ")");
            stmt.execute("ALTER TABLE coupons ADD COLUMN IF NOT EXISTS is_suggested BOOLEAN DEFAULT FALSE");
        } catch (Exception e) {
            System.err.println("CouponDAO migration: " + e.getMessage());
        }
    }

    public Coupon validateCoupon(String code) {
        String sql = "SELECT * FROM coupons WHERE UPPER(code) = UPPER(?) AND is_active = TRUE AND expiry_date >= CURRENT_DATE";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, code);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapResultSetToCoupon(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Coupon> getAllCoupons() {
        List<Coupon> coupons = new ArrayList<>();
        String sql = "SELECT * FROM coupons ORDER BY coupon_id DESC";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                coupons.add(mapResultSetToCoupon(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return coupons;
    }

    /**
     * Get all active, non-expired coupons.
     */
    public List<Coupon> getActiveCoupons() {
        List<Coupon> coupons = new ArrayList<>();
        String sql = "SELECT * FROM coupons WHERE is_active = TRUE AND expiry_date >= CURRENT_DATE ORDER BY discount_percentage DESC";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                coupons.add(mapResultSetToCoupon(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return coupons;
    }

    /**
     * Get active coupons marked as suggested that a specific user has NOT yet used.
     */
    public List<Coupon> getAvailableCouponsForUser(int userId) {
        List<Coupon> coupons = new ArrayList<>();
        String sql = "SELECT c.* FROM coupons c " +
                "WHERE c.is_active = TRUE AND c.expiry_date >= CURRENT_DATE " +
                "AND c.is_suggested = TRUE " +
                "AND c.coupon_id NOT IN (SELECT cu.coupon_id FROM coupon_usage cu WHERE cu.user_id = ?) " +
                "ORDER BY c.discount_percentage DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    coupons.add(mapResultSetToCoupon(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return coupons;
    }

    /**
     * Check if a user has already used a specific coupon.
     */
    public boolean hasUserUsedCoupon(int userId, int couponId) {
        String sql = "SELECT COUNT(*) FROM coupon_usage WHERE user_id = ? AND coupon_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, couponId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Record that a user has used a coupon.
     */
    public boolean recordCouponUsage(int userId, int couponId) {
        String sql = "INSERT INTO coupon_usage (coupon_id, user_id) VALUES (?, ?) ON CONFLICT DO NOTHING";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, couponId);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean insertCoupon(Coupon coupon) {
        String sql = "INSERT INTO coupons (code, discount_percentage, expiry_date, is_active, is_suggested) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, coupon.getCode().toUpperCase());
            ps.setBigDecimal(2, coupon.getDiscountPercentage());
            ps.setDate(3, coupon.getExpiryDate());
            ps.setBoolean(4, coupon.isActive());
            ps.setBoolean(5, coupon.isSuggested());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateCoupon(Coupon coupon) {
        String sql = "UPDATE coupons SET code = ?, discount_percentage = ?, expiry_date = ?, is_active = ?, is_suggested = ? WHERE coupon_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, coupon.getCode().toUpperCase());
            ps.setBigDecimal(2, coupon.getDiscountPercentage());
            ps.setDate(3, coupon.getExpiryDate());
            ps.setBoolean(4, coupon.isActive());
            ps.setBoolean(5, coupon.isSuggested());
            ps.setInt(6, coupon.getCouponId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteCoupon(int couponId) {
        String sql = "DELETE FROM coupons WHERE coupon_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, couponId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Coupon getCouponById(int couponId) {
        String sql = "SELECT * FROM coupons WHERE coupon_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, couponId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapResultSetToCoupon(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    private Coupon mapResultSetToCoupon(ResultSet rs) throws SQLException {
        Coupon c = new Coupon();
        c.setCouponId(rs.getInt("coupon_id"));
        c.setCode(rs.getString("code"));
        c.setDiscountPercentage(rs.getBigDecimal("discount_percentage"));
        c.setExpiryDate(rs.getDate("expiry_date"));
        c.setActive(rs.getBoolean("is_active"));
        try { c.setSuggested(rs.getBoolean("is_suggested")); } catch (SQLException ignored) {}
        return c;
    }
}
