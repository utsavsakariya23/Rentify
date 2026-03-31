<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
    <%@ include file="components/adminHeader.jsp" %>

        <main class="container-fluid my-5">
            <h2 class="fw-bold mb-4">Rent Requests / Bookings</h2>
            <div class="card card-modern border-0 p-4">
                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead class="table-light">
                            <tr><th>ID</th><th>Customer</th><th>Car</th><th>Pickup</th><th>Drop</th><th>Dates</th><th>Days</th><th>Price</th><th>Status</th><th>Payment</th><th>Actions</th></tr>
                        </thead>
                        <tbody>
                            <c:forEach var="b" items="${bookings}">
                                <tr>
                                    <td>#${b.bookingId}</td>
                                    <td>${b.userName}</td>
                                    <td>${b.carName}</td>
                                    <td>${b.pickupLocation}</td>
                                    <td>${b.dropLocation}</td>
                                    <td class="small">${b.startDate}<br>to ${b.endDate}</td>
                                    <td>${b.totalDays}</td>
                                    <td>Rs. <fmt:formatNumber value="${b.finalPrice}" pattern="#,##0" /></td>
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
                                        <c:if test="${b.bookingStatus == 'Pending'}">
                                            <form action="${pageContext.request.contextPath}/admin/confirm_booking" method="post" style="display:inline;"><input type="hidden" name="bookingId" value="${b.bookingId}"><button class="btn btn-sm btn-success" title="Confirm"><i class="fas fa-check"></i></button></form>
                                            <form action="${pageContext.request.contextPath}/admin/cancel_booking" method="post" style="display:inline;"><input type="hidden" name="bookingId" value="${b.bookingId}"><button class="btn btn-sm btn-danger" title="Cancel"><i class="fas fa-times"></i></button></form>
                                        </c:if>
                                        <c:if test="${b.bookingStatus == 'Confirmed'}">
                                            <form action="${pageContext.request.contextPath}/admin/complete_booking" method="post" style="display:inline;"><input type="hidden" name="bookingId" value="${b.bookingId}"><button class="btn btn-sm btn-outline-success">Complete</button></form>
                                        </c:if>
                                        <c:if test="${b.paymentStatus == 'Unpaid' && (b.bookingStatus == 'Confirmed' || b.bookingStatus == 'Completed')}">
                                            <form action="${pageContext.request.contextPath}/admin/mark_paid" method="post" style="display:inline;"><input type="hidden" name="bookingId" value="${b.bookingId}"><button class="btn btn-sm btn-outline-warning">Mark Paid</button></form>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty bookings}"><tr><td colspan="11" class="text-center text-muted py-4">No bookings found</td></tr></c:if>
                        </tbody>
                    </table>
                </div>
                <c:if test="${totalPages > 1}">
                    <nav class="mt-3"><ul class="pagination justify-content-center">
                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <li class="page-item ${currentPage == i ? 'active' : ''}"><a class="page-link" href="${pageContext.request.contextPath}/admin/rent?page=${i}">${i}</a></li>
                        </c:forEach>
                    </ul></nav>
                </c:if>
            </div>
        </main>
        <%@ include file="components/adminFooter.jsp" %>