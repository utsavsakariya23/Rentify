<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
    <%@ include file="components/header.jsp" %>

        <main class="container my-5 pt-5">
            <h3 class="fw-bold mb-4"><i class="fas fa-receipt text-primary me-2"></i>My Bookings</h3>

            <c:if test="${not empty param.success}">
                <div class="alert alert-success alert-dismissible fade show">
                    <c:choose>
                        <c:when test="${param.success == 'booked'}">Booking created successfully! You will receive a confirmation email.</c:when>
                        <c:when test="${param.success == 'cancelled'}">Booking cancelled successfully.</c:when>
                        <c:when test="${param.success == 'review_submitted'}">Review submitted successfully!</c:when>
                        <c:otherwise>Operation completed successfully.</c:otherwise>
                    </c:choose>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            <c:if test="${not empty param.error}">
                <div class="alert alert-danger alert-dismissible fade show">${param.error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <c:choose>
                <c:when test="${not empty bookings}">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead class="table-light">
                                <tr>
                                    <th>#</th>
                                    <th>Car</th>
                                    <th>Dates</th>
                                    <th>Locations</th>
                                    <th>Price</th>
                                    <th>Status</th>
                                    <th>Payment</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="b" items="${bookings}">
                                    <tr>
                                        <td>${b.bookingId}</td>
                                        <td>
                                            <strong>${b.carName}</strong>
                                            <div class="text-muted small">${b.carBrand}</div>
                                        </td>
                                        <td>
                                            <div class="small">${b.startDate} to ${b.endDate}</div>
                                            <span class="badge bg-light text-dark">${b.totalDays} day(s)</span>
                                        </td>
                                        <td>
                                            <div class="small"><i class="fas fa-map-marker-alt text-success"></i> ${b.pickupLocation}</div>
                                            <div class="small"><i class="fas fa-map-marker-alt text-danger"></i> ${b.dropLocation}</div>
                                        </td>
                                        <td>
                                            <c:if test="${b.discountAmount.doubleValue() > 0}">
                                                <div class="text-muted small"><s>Rs. <fmt:formatNumber value="${b.totalPrice}" pattern="#,##0" /></s></div>
                                                <div class="text-success small">-Rs. <fmt:formatNumber value="${b.discountAmount}" pattern="#,##0" /></div>
                                            </c:if>
                                            <strong>Rs. <fmt:formatNumber value="${b.finalPrice}" pattern="#,##0" /></strong>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${b.bookingStatus == 'Pending'}"><span class="badge bg-warning text-dark">Pending</span></c:when>
                                                <c:when test="${b.bookingStatus == 'Confirmed'}"><span class="badge bg-primary">Confirmed</span></c:when>
                                                <c:when test="${b.bookingStatus == 'Completed'}"><span class="badge bg-success">Completed</span></c:when>
                                                <c:when test="${b.bookingStatus == 'Cancelled'}"><span class="badge bg-danger">Cancelled</span></c:when>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${b.paymentStatus == 'Paid'}"><span class="badge bg-success">Paid</span></c:when>
                                                <c:when test="${b.paymentStatus == 'Refunded'}"><span class="badge bg-info">Refunded</span></c:when>
                                                <c:otherwise><span class="badge bg-secondary">Unpaid</span></c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:if test="${b.bookingStatus == 'Pending' || b.bookingStatus == 'Confirmed'}">
                                                <form action="${pageContext.request.contextPath}/cancel_booking" method="post" style="display:inline;" onsubmit="return confirm('Cancel this booking?');">
                                                    <input type="hidden" name="bookingId" value="${b.bookingId}">
                                                    <button class="btn btn-sm btn-outline-danger"><i class="fas fa-times"></i> Cancel</button>
                                                </form>
                                            </c:if>
                                            <c:if test="${requestScope['canReview_'.concat(b.bookingId)]}">
                                                <button class="btn btn-sm btn-outline-warning" data-bs-toggle="modal" data-bs-target="#reviewModal${b.bookingId}">
                                                    <i class="fas fa-star"></i> Review
                                                </button>
                                            </c:if>
                                        </td>
                                    </tr>

                                    <!-- Review Modal -->
                                    <c:if test="${requestScope['canReview_'.concat(b.bookingId)]}">
                                    <div class="modal fade" id="reviewModal${b.bookingId}" tabindex="-1">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title">Review ${b.carName}</h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                                </div>
                                                <form action="${pageContext.request.contextPath}/submit_review" method="post">
                                                    <div class="modal-body">
                                                        <input type="hidden" name="bookingId" value="${b.bookingId}">
                                                        <div class="mb-3">
                                                            <label class="form-label fw-bold">Rating</label>
                                                            <div class="star-rating">
                                                                <c:forEach begin="1" end="5" var="star">
                                                                    <input type="radio" name="rating" value="${star}" id="star${star}_${b.bookingId}" ${star == 5 ? 'checked' : ''}>
                                                                    <label for="star${star}_${b.bookingId}" class="fs-4" style="cursor:pointer;">&#9733;</label>
                                                                </c:forEach>
                                                            </div>
                                                        </div>
                                                        <div class="mb-3">
                                                            <label class="form-label fw-bold">Comment</label>
                                                            <textarea class="form-control" name="comment" rows="3" placeholder="Share your experience..."></textarea>
                                                        </div>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                        <button type="submit" class="btn btn-primary">Submit Review</button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                    </c:if>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="text-center py-5">
                        <i class="fas fa-calendar-times fa-3x text-muted mb-3"></i>
                        <h5 class="text-muted">No bookings yet</h5>
                        <p class="text-muted">Browse our fleet and book your first ride!</p>
                        <a href="${pageContext.request.contextPath}/vehicles" class="btn btn-primary-custom">Browse Cars</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </main>

        <style>
            .star-rating input[type="radio"] { display: none; }
            .star-rating label { color: #ddd; transition: color 0.2s; }
            .star-rating input:checked ~ label { color: #ddd; }
            .star-rating input:checked + label,
            .star-rating label:hover,
            .star-rating label:hover ~ label { color: #ffc107; }
        </style>

    <%@ include file="components/footer.jsp" %>
