package com.carent.repository;

import com.carent.config.DBConnection;
import com.carent.model.Booking;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {

    public boolean insertBooking(Booking booking) {
        String sql = "INSERT INTO bookings (user_id, car_id, pickup_location, drop_location, start_date, end_date, " +
                     "total_days, total_price, discount_amount, final_price, booking_status, payment_method, transaction_id, payment_status) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, booking.getUserId());
            ps.setInt(2, booking.getCarId());
            ps.setString(3, booking.getPickupLocation());
            ps.setString(4, booking.getDropLocation());
            ps.setDate(5, booking.getStartDate());
            ps.setDate(6, booking.getEndDate());
            ps.setInt(7, booking.getTotalDays());
            ps.setBigDecimal(8, booking.getTotalPrice());
            ps.setBigDecimal(9, booking.getDiscountAmount() != null ? booking.getDiscountAmount() : BigDecimal.ZERO);
            ps.setBigDecimal(10, booking.getFinalPrice());
            ps.setString(11, booking.getBookingStatus() != null ? booking.getBookingStatus() : "Pending");
            ps.setString(12, booking.getPaymentMethod() != null ? booking.getPaymentMethod() : "Cash");
            ps.setString(13, booking.getTransactionId());
            ps.setString(14, booking.getPaymentStatus() != null ? booking.getPaymentStatus() : "Unpaid");
            int rows = ps.executeUpdate();
            if (rows > 0) {
                try (ResultSet keys = ps.getGeneratedKeys()) {
                    if (keys.next()) {
                        booking.setBookingId(keys.getInt(1));
                    }
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Booking> getBookingsByUser(int userId) {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT b.*, u.full_name AS user_name, u.email AS user_email, c.name AS car_name, c.brand AS car_brand " +
                     "FROM bookings b " +
                     "JOIN users u ON b.user_id = u.user_id " +
                     "JOIN cars c ON b.car_id = c.car_id " +
                     "WHERE b.user_id = ? ORDER BY b.created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    bookings.add(mapResultSetToBooking(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookings;
    }

    public List<Booking> getAllBookings() {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT b.*, u.full_name AS user_name, u.email AS user_email, c.name AS car_name, c.brand AS car_brand " +
                     "FROM bookings b " +
                     "JOIN users u ON b.user_id = u.user_id " +
                     "JOIN cars c ON b.car_id = c.car_id " +
                     "ORDER BY b.created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                bookings.add(mapResultSetToBooking(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookings;
    }

    public List<Booking> getBookingsWithPagination(int offset, int limit) {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT b.*, u.full_name AS user_name, u.email AS user_email, c.name AS car_name, c.brand AS car_brand " +
                     "FROM bookings b " +
                     "JOIN users u ON b.user_id = u.user_id " +
                     "JOIN cars c ON b.car_id = c.car_id " +
                     "ORDER BY b.created_at DESC LIMIT ? OFFSET ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, limit);
            ps.setInt(2, offset);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    bookings.add(mapResultSetToBooking(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookings;
    }

    public Booking getBookingById(int bookingId) {
        String sql = "SELECT b.*, u.full_name AS user_name, u.email AS user_email, c.name AS car_name, c.brand AS car_brand " +
                     "FROM bookings b " +
                     "JOIN users u ON b.user_id = u.user_id " +
                     "JOIN cars c ON b.car_id = c.car_id " +
                     "WHERE b.booking_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapResultSetToBooking(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateBookingStatus(int bookingId, String status) {
        String sql = "UPDATE bookings SET booking_status = ? WHERE booking_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, bookingId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updatePaymentStatus(int bookingId, String status) {
        String sql = "UPDATE bookings SET payment_status = ? WHERE booking_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, bookingId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean cancelBooking(int bookingId) {
        return updateBookingStatus(bookingId, "Cancelled");
    }

    public int getBookingCount() {
        String sql = "SELECT COUNT(*) FROM bookings";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int getActiveBookingCount() {
        String sql = "SELECT COUNT(*) FROM bookings WHERE booking_status IN ('Pending', 'Confirmed')";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int getPendingBookingCount() {
        String sql = "SELECT COUNT(*) FROM bookings WHERE booking_status = 'Pending'";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public BigDecimal getTotalRevenue() {
        String sql = "SELECT COALESCE(SUM(final_price), 0) FROM bookings WHERE booking_status IN ('Confirmed', 'Completed') AND payment_status = 'Paid'";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) return rs.getBigDecimal(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return BigDecimal.ZERO;
    }

    public List<Booking> getRecentBookings(int limit) {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT b.*, u.full_name AS user_name, u.email AS user_email, c.name AS car_name, c.brand AS car_brand " +
                     "FROM bookings b " +
                     "JOIN users u ON b.user_id = u.user_id " +
                     "JOIN cars c ON b.car_id = c.car_id " +
                     "ORDER BY b.created_at DESC LIMIT ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    bookings.add(mapResultSetToBooking(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookings;
    }

    private Booking mapResultSetToBooking(ResultSet rs) throws SQLException {
        Booking b = new Booking();
        b.setBookingId(rs.getInt("booking_id"));
        b.setUserId(rs.getInt("user_id"));
        b.setCarId(rs.getInt("car_id"));
        b.setPickupLocation(rs.getString("pickup_location"));
        b.setDropLocation(rs.getString("drop_location"));
        b.setStartDate(rs.getDate("start_date"));
        b.setEndDate(rs.getDate("end_date"));
        b.setTotalDays(rs.getInt("total_days"));
        b.setTotalPrice(rs.getBigDecimal("total_price"));
        b.setDiscountAmount(rs.getBigDecimal("discount_amount"));
        b.setFinalPrice(rs.getBigDecimal("final_price"));
        b.setBookingStatus(rs.getString("booking_status"));
        b.setPaymentMethod(rs.getString("payment_method"));
        b.setTransactionId(rs.getString("transaction_id"));
        b.setPaymentStatus(rs.getString("payment_status"));
        b.setCreatedAt(rs.getTimestamp("created_at"));
        try { b.setUserName(rs.getString("user_name")); } catch (SQLException ignored) {}
        try { b.setUserEmail(rs.getString("user_email")); } catch (SQLException ignored) {}
        try { b.setCarName(rs.getString("car_name")); } catch (SQLException ignored) {}
        try { b.setCarBrand(rs.getString("car_brand")); } catch (SQLException ignored) {}
        return b;
    }
}
