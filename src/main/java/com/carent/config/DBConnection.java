package com.carent.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Database connection utility for PostgreSQL.
 * 
 * Change DB_PASSWORD to match your pgAdmin4 / PostgreSQL password.
 */
public class DBConnection {

    private static final String DB_URL = "jdbc:postgresql://localhost:5432/carent_db";
    private static final String DB_USER = "postgres";
    private static final String DB_PASSWORD = "postgres"; // <-- Change this to your PostgreSQL password

    static {
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("PostgreSQL JDBC Driver not found!", e);
        }
    }

    /**
     * Returns a new connection to the carent_db database.
     */
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }
}
