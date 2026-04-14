package com.carent.model;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.DisplayName;
import java.math.BigDecimal;
import java.sql.Date;
import static org.junit.jupiter.api.Assertions.*;

/**
 * Unit tests for the Expense model class.
 */
@DisplayName("Expense Model Tests")
class ExpenseTest {

    @Test
    @DisplayName("Default constructor creates Expense with default values")
    void testDefaultConstructor() {
        Expense expense = new Expense();
        assertEquals(0, expense.getExpenseId());
        assertNull(expense.getCategory());
        assertNull(expense.getAmount());
    }

    @Test
    @DisplayName("All getters and setters work correctly")
    void testGettersAndSetters() {
        Expense expense = new Expense();
        expense.setExpenseId(1);
        expense.setCategory("Fuel");
        expense.setAmount(new BigDecimal("5000"));
        expense.setDescription("Fuel refill for fleet");
        expense.setExpenseDate(Date.valueOf("2026-04-10"));

        assertEquals(1, expense.getExpenseId());
        assertEquals("Fuel", expense.getCategory());
        assertEquals(new BigDecimal("5000"), expense.getAmount());
        assertEquals("Fuel refill for fleet", expense.getDescription());
        assertEquals(Date.valueOf("2026-04-10"), expense.getExpenseDate());
    }
}
