package com.carent.model;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.DisplayName;
import java.sql.Timestamp;
import static org.junit.jupiter.api.Assertions.*;

/**
 * Unit tests for the Review model class.
 */
@DisplayName("Review Model Tests")
class ReviewTest {

    @Test
    @DisplayName("Default constructor creates Review with default values")
    void testDefaultConstructor() {
        Review review = new Review();
        assertEquals(0, review.getReviewId());
        assertEquals(0, review.getRating());
        assertNull(review.getComment());
        assertNull(review.getAdminReply());
    }

    @Test
    @DisplayName("All getters and setters function properly")
    void testGettersAndSetters() {
        Review review = new Review();
        review.setReviewId(1);
        review.setBookingId(10);
        review.setUserId(5);
        review.setCarId(3);
        review.setRating(5);
        review.setComment("Excellent car, smooth ride!");
        review.setAdminReply("Thank you for your feedback!");
        Timestamp now = new Timestamp(System.currentTimeMillis());
        review.setCreatedAt(now);
        review.setUserName("Utsav");
        review.setCarName("Honda Civic");

        assertEquals(1, review.getReviewId());
        assertEquals(10, review.getBookingId());
        assertEquals(5, review.getUserId());
        assertEquals(3, review.getCarId());
        assertEquals(5, review.getRating());
        assertEquals("Excellent car, smooth ride!", review.getComment());
        assertEquals("Thank you for your feedback!", review.getAdminReply());
        assertEquals(now, review.getCreatedAt());
        assertEquals("Utsav", review.getUserName());
        assertEquals("Honda Civic", review.getCarName());
    }
}
