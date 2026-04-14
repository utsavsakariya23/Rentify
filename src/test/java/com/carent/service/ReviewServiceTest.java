package com.carent.service;

import com.carent.model.Review;
import com.carent.repository.ReviewDAO;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.mockito.junit.jupiter.MockitoSettings;
import org.mockito.quality.Strictness;

import java.lang.reflect.Field;
import java.util.Arrays;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@MockitoSettings(strictness = Strictness.LENIENT)
@DisplayName("ReviewService Tests")
class ReviewServiceTest {

    @Mock private ReviewDAO reviewDAO;

    private ReviewService reviewService;

    @BeforeEach
    void setUp() throws Exception {
        reviewService = new ReviewService();
        Field f = ReviewService.class.getDeclaredField("reviewDAO");
        f.setAccessible(true); f.set(reviewService, reviewDAO);
    }

    @Test
    @DisplayName("submitReview succeeds when user is eligible")
    void testSubmitReviewSuccess() {
        Review review = new Review();
        review.setUserId(1); review.setBookingId(10); review.setRating(5);
        when(reviewDAO.canUserReview(1, 10)).thenReturn(true);
        when(reviewDAO.insertReview(review)).thenReturn(true);
        assertTrue(reviewService.submitReview(review));
    }

    @Test
    @DisplayName("submitReview fails when user is not eligible")
    void testSubmitReviewNotEligible() {
        Review review = new Review();
        review.setUserId(1); review.setBookingId(10);
        when(reviewDAO.canUserReview(1, 10)).thenReturn(false);
        assertFalse(reviewService.submitReview(review));
        verify(reviewDAO, never()).insertReview(any());
    }

    @Test
    @DisplayName("getReviewsByCarId delegates to DAO")
    void testGetReviewsByCarId() {
        when(reviewDAO.getReviewsByCarId(5)).thenReturn(Arrays.asList(new Review(), new Review()));
        assertEquals(2, reviewService.getReviewsByCarId(5).size());
    }

    @Test
    @DisplayName("getAllReviews delegates to DAO")
    void testGetAllReviews() {
        when(reviewDAO.getAllReviews()).thenReturn(Arrays.asList(new Review()));
        assertEquals(1, reviewService.getAllReviews().size());
    }

    @Test
    @DisplayName("getAverageRating delegates to ReviewDAO")
    void testGetAverageRating() {
        when(reviewDAO.getAverageRating(5)).thenReturn(4.3);
        assertEquals(4.3, reviewService.getAverageRating(5));
    }

    @Test
    @DisplayName("getReviewCount delegates to ReviewDAO")
    void testGetReviewCount() {
        when(reviewDAO.getReviewCount(5)).thenReturn(15);
        assertEquals(15, reviewService.getReviewCount(5));
    }

    @Test
    @DisplayName("canUserReview delegates to ReviewDAO")
    void testCanUserReview() {
        when(reviewDAO.canUserReview(1, 10)).thenReturn(true);
        assertTrue(reviewService.canUserReview(1, 10));
    }

    @Test
    @DisplayName("hasReviewForBooking delegates to ReviewDAO")
    void testHasReviewForBooking() {
        when(reviewDAO.hasReviewForBooking(10)).thenReturn(true);
        assertTrue(reviewService.hasReviewForBooking(10));
    }

    @Test
    @DisplayName("deleteReview delegates to ReviewDAO")
    void testDeleteReview() {
        when(reviewDAO.deleteReview(1)).thenReturn(true);
        assertTrue(reviewService.deleteReview(1));
    }

    @Test
    @DisplayName("updateAdminReply delegates to ReviewDAO")
    void testUpdateAdminReply() {
        when(reviewDAO.updateAdminReply(1, "Thanks!")).thenReturn(true);
        assertTrue(reviewService.updateAdminReply(1, "Thanks!"));
    }

    @Test
    @DisplayName("getReviewById delegates to ReviewDAO")
    void testGetReviewById() {
        Review mock = new Review(); mock.setReviewId(1);
        when(reviewDAO.getReviewById(1)).thenReturn(mock);
        assertEquals(1, reviewService.getReviewById(1).getReviewId());
    }
}
