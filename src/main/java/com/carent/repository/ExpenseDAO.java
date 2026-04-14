package com.carent.repository;

import com.carent.config.DBConnection;
import com.carent.model.Expense;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ExpenseDAO {
    
    public boolean addExpense(Expense expense) {
        String sql = "INSERT INTO expenses (description, amount, expense_date, category) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, expense.getDescription());
            stmt.setBigDecimal(2, expense.getAmount());
            stmt.setDate(3, expense.getExpenseDate());
            stmt.setString(4, expense.getCategory());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteExpense(int expenseId) {
        String sql = "DELETE FROM expenses WHERE expense_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, expenseId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Expense> getRecentExpenses(int limit) {
        List<Expense> expenses = new ArrayList<>();
        String sql = "SELECT * FROM expenses ORDER BY expense_date DESC LIMIT ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, limit);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    expenses.add(extractExpenseFromResultSet(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return expenses;
    }

    public BigDecimal getTotalExpensesByMonthYear(int month, int year) {
        String sql = "SELECT SUM(amount) as total FROM expenses WHERE EXTRACT(MONTH FROM expense_date) = ? AND EXTRACT(YEAR FROM expense_date) = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, month);
            stmt.setInt(2, year);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next() && rs.getBigDecimal("total") != null) {
                    return rs.getBigDecimal("total");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return BigDecimal.ZERO;
    }

    public BigDecimal getTotalExpensesByYear(int year) {
        String sql = "SELECT SUM(amount) as total FROM expenses WHERE EXTRACT(YEAR FROM expense_date) = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, year);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next() && rs.getBigDecimal("total") != null) {
                    return rs.getBigDecimal("total");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return BigDecimal.ZERO;
    }

    private Expense extractExpenseFromResultSet(ResultSet rs) throws SQLException {
        Expense expense = new Expense();
        expense.setExpenseId(rs.getInt("expense_id"));
        expense.setDescription(rs.getString("description"));
        expense.setAmount(rs.getBigDecimal("amount"));
        expense.setExpenseDate(rs.getDate("expense_date"));
        expense.setCategory(rs.getString("category"));
        expense.setCreatedAt(rs.getTimestamp("created_at"));
        return expense;
    }
}
