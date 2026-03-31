<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ include file="components/adminHeader.jsp" %>

<main class="container-fluid my-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="fw-bold mb-0">Payments Management</h2>
        <div class="badge bg-primary fs-6 p-2"><i class="fas fa-wallet me-2"></i>Total Payments Configured</div>
    </div>

    <div class="card card-modern border-0 p-4 shadow-sm">
        <div class="table-responsive">
            <table class="table table-hover align-middle mb-0">
                <thead class="table-light text-uppercase small text-muted">
                    <tr>
                        <th>Booking ID</th>
                        <th>Customer</th>
                        <th>Amount</th>
                        <th>Payment Method</th>
                        <th>Transaction ID</th>
                        <th>Payment Status</th>
                        <th>Booking Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="p" items="${payments}">
                        <tr>
                            <td class="fw-bold text-primary">#RENT-${p.bookingId}</td>
                            <td>
                                <div class="d-flex align-items-center">
                                    <div class="bg-light rounded-circle d-flex align-items-center justify-content-center me-2" style="width: 32px; height: 32px;">
                                        <i class="fas fa-user text-secondary"></i>
                                    </div>
                                    <span class="fw-semibold">${p.userName}</span>
                                </div>
                            </td>
                            <td class="fw-bold">Rs. <fmt:formatNumber value="${p.finalPrice}" pattern="#,##0" /></td>
                            <td>
                                <c:choose>
                                    <c:when test="${p.paymentMethod == 'Online'}">
                                        <span class="badge bg-info text-dark"><i class="fas fa-credit-card me-1"></i>Razorpay</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-secondary"><i class="fas fa-money-bill-wave me-1"></i>Cash</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty p.transactionId}">
                                        <code class="text-muted">${p.transactionId}</code>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-muted fst-italic">N/A</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${p.paymentStatus == 'Paid'}"><span class="badge bg-success rounded-pill px-3 py-2"><i class="fas fa-check-circle me-1"></i>Paid</span></c:when>
                                    <c:when test="${p.paymentStatus == 'Refunded'}"><span class="badge bg-danger rounded-pill px-3 py-2"><i class="fas fa-undo me-1"></i>Refunded</span></c:when>
                                    <c:otherwise><span class="badge bg-warning text-dark rounded-pill px-3 py-2"><i class="fas fa-clock me-1"></i>Unpaid</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${p.bookingStatus == 'Pending'}"><span class="text-warning fw-bold"><i class="fas fa-hourglass-half me-1"></i>Pending</span></c:when>
                                    <c:when test="${p.bookingStatus == 'Confirmed'}"><span class="text-primary fw-bold"><i class="fas fa-thumbs-up me-1"></i>Confirmed</span></c:when>
                                    <c:when test="${p.bookingStatus == 'Completed'}"><span class="text-success fw-bold"><i class="fas fa-flag-checkered me-1"></i>Completed</span></c:when>
                                    <c:when test="${p.bookingStatus == 'Cancelled'}"><span class="text-danger fw-bold"><i class="fas fa-ban me-1"></i>Cancelled</span></c:when>
                                    <c:otherwise><span class="text-secondary fw-bold">${p.bookingStatus}</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:if test="${p.paymentStatus == 'Unpaid' && p.bookingStatus != 'Cancelled'}">
                                    <form action="${pageContext.request.contextPath}/admin/mark_paid" method="post" class="d-inline" onsubmit="return confirm('Mark this booking as paid?');">
                                        <input type="hidden" name="bookingId" value="${p.bookingId}">
                                        <button class="btn btn-sm btn-outline-success fw-bold">
                                            <i class="fas fa-check-double me-1"></i> Mark Paid
                                        </button>
                                    </form>
                                </c:if>
                                <c:if test="${p.paymentStatus == 'Paid'}">
                                    <button class="btn btn-sm btn-light text-success fw-bold border" disabled>
                                        <i class="fas fa-check me-1"></i> Settled
                                    </button>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>

                    <c:if test="${empty payments}">
                        <tr>
                            <td colspan="8" class="text-center text-muted py-5">
                                <i class="fas fa-wallet fa-3x text-light mb-3"></i>
                                <h5>No Payments Found</h5>
                                <p>There are currently no payment records to display.</p>
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>

        <c:if test="${totalPages > 1}">
            <nav class="mt-4">
                <ul class="pagination justify-content-center">
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                            <a class="page-link shadow-none" href="${pageContext.request.contextPath}/admin/payments?page=${i}">${i}</a>
                        </li>
                    </c:forEach>
                </ul>
            </nav>
        </c:if>
    </div>
</main>

<%@ include file="components/adminFooter.jsp" %>
