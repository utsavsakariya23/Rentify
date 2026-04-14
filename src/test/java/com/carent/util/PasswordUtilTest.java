package com.carent.util;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.DisplayName;
import static org.junit.jupiter.api.Assertions.*;

/**
 * Unit tests for PasswordUtil (SHA-256 hashing & verification).
 */
@DisplayName("PasswordUtil Tests")
class PasswordUtilTest {

    @Test
    @DisplayName("hashPassword produces non-null, non-empty SHA-256 hex string")
    void testHashPasswordNotEmpty() {
        String hash = PasswordUtil.hashPassword("TestPassword123");
        assertNotNull(hash);
        assertFalse(hash.isEmpty());
        // SHA-256 output is always 64 hex characters
        assertEquals(64, hash.length());
    }

    @Test
    @DisplayName("hashPassword produces consistent hash for the same input")
    void testHashPasswordConsistency() {
        String hash1 = PasswordUtil.hashPassword("SamePassword");
        String hash2 = PasswordUtil.hashPassword("SamePassword");
        assertEquals(hash1, hash2);
    }

    @Test
    @DisplayName("Different passwords produce different hashes")
    void testDifferentPasswordsDifferentHashes() {
        String hash1 = PasswordUtil.hashPassword("Password1");
        String hash2 = PasswordUtil.hashPassword("Password2");
        assertNotEquals(hash1, hash2);
    }

    @Test
    @DisplayName("verifyPassword returns true for correct password")
    void testVerifyPasswordCorrect() {
        String password = "Utsav@123";
        String hash = PasswordUtil.hashPassword(password);
        assertTrue(PasswordUtil.verifyPassword(password, hash));
    }

    @Test
    @DisplayName("verifyPassword returns false for incorrect password")
    void testVerifyPasswordIncorrect() {
        String hash = PasswordUtil.hashPassword("CorrectPassword");
        assertFalse(PasswordUtil.verifyPassword("WrongPassword", hash));
    }

    @Test
    @DisplayName("Hash output only contains valid hexadecimal characters")
    void testHashOutputIsHexadecimal() {
        String hash = PasswordUtil.hashPassword("test");
        assertTrue(hash.matches("[0-9a-f]{64}"));
    }

    @Test
    @DisplayName("Empty password can be hashed without exception")
    void testHashEmptyPassword() {
        assertDoesNotThrow(() -> PasswordUtil.hashPassword(""));
        String hash = PasswordUtil.hashPassword("");
        assertEquals(64, hash.length());
    }
}
