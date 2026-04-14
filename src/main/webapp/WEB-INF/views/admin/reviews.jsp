<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
    <%@ include file="components/adminHeader.jsp" %>

        <main class="container-fluid my-5">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="fw-bold mb-0">Customer Reviews</h2>
            </div>
            
            <!-- Filter Bar -->
            <div class="card border-0 p-3 mb-3">
                <form method="get" action="${pageContext.request.contextPath}/admin/reviews" class="row g-2 align-items-end">
                    <div class="col-md-4">
                        <label class="form-label small fw-bold text-muted">SEARCH BY CAR NAME OR ID</label>
                        <input type="text" name="searchCar" class="form-control" placeholder="e.g. Swift or 102" value="${param.searchCar}">
                    </div>
                    <div class="col-md-2">
                        <button type="submit" class="btn btn-primary w-100"><i class="fas fa-filter me-1"></i>Filter</button>
                    </div>
                    <div class="col-md-2">
                        <a href="${pageContext.request.contextPath}/admin/reviews" class="btn btn-outline-secondary w-100">Reset</a>
                    </div>
                </form>
            </div>

            <div class="card card-modern border-0 p-4">
                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead class="table-light">
                            <tr><th>ID</th><th>Customer</th><th>Car</th><th>Rating</th><th>Comment / Reply</th><th>Date</th><th>Actions</th></tr>
                        </thead>
                        <tbody>
                            <c:forEach var="r" items="${reviews}">
                                <tr>
                                    <td>${r.reviewId}</td>
                                    <td class="fw-bold">${r.userName}</td>
                                    <td>${r.carName}</td>
                                    <td>
                                        <c:forEach begin="1" end="5" var="star">
                                            <i class="fas fa-star ${star <= r.rating ? 'text-warning' : 'text-muted'}"></i>
                                        </c:forEach>
                                        <span class="ms-1 small">(${r.rating})</span>
                                    </td>
                                    <td style="max-width:300px;">
                                        <div class="text-truncate" title="${r.comment}">${r.comment}</div>
                                        <c:if test="${not empty r.adminReply}">
                                            <div class="small mt-1 px-2 py-1 rounded bg-light border-start border-3 border-primary">
                                                <strong>Agency:</strong> ${r.adminReply}
                                            </div>
                                        </c:if>
                                    </td>
                                    <td class="small"><fmt:formatDate value="${r.createdAt}" pattern="dd MMM yyyy" /></td>
                                    <td>
                                        <div class="d-flex gap-2">
                                            <button class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#replyModal${r.reviewId}">
                                                <i class="fas fa-reply"></i>
                                            </button>
                                            <form action="${pageContext.request.contextPath}/admin/delete_review" method="post" style="display:inline;" onsubmit="return confirm('Delete this review?');">
                                                <input type="hidden" name="reviewId" value="${r.reviewId}">
                                                <button class="btn btn-sm btn-outline-danger"><i class="fas fa-trash"></i></button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>

                                <!-- Reply Modal -->
                                <div class="modal fade" id="replyModal${r.reviewId}" tabindex="-1">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title">Reply to ${r.userName}</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                            </div>
                                            <form action="${pageContext.request.contextPath}/admin/reply_review" method="post">
                                                <div class="modal-body">
                                                    <input type="hidden" name="reviewId" value="${r.reviewId}">
                                                    <div class="mb-3">
                                                        <label class="form-label text-muted small">Customer's Review:</label>
                                                        <div class="p-2 bg-light rounded fst-italic">"${r.comment}"</div>
                                                    </div>
                                                    <div class="mb-3">
                                                        <label class="form-label fw-bold">Your Reply</label>
                                                        <textarea name="replyText" class="form-control" rows="3" required>${r.adminReply}</textarea>
                                                    </div>
                                                    <div class="form-check">
                                                        <input class="form-check-input" type="checkbox" name="notifyUser" id="notifyUser${r.reviewId}" checked>
                                                        <label class="form-check-label" for="notifyUser${r.reviewId}">
                                                            Notify user via email
                                                        </label>
                                                    </div>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                    <button type="submit" class="btn btn-primary">Send Reply</button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                            <c:if test="${empty reviews}"><tr><td colspan="7" class="text-center text-muted py-4">No reviews found</td></tr></c:if>
                        </tbody>
                    </table>
                </div>
                <c:if test="${totalPages > 1}">
                    <nav class="mt-3"><ul class="pagination justify-content-center">
                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <li class="page-item ${currentPage == i ? 'active' : ''}">
                                <a class="page-link" href="${pageContext.request.contextPath}/admin/reviews?page=${i}&searchCar=${param.searchCar}">${i}</a>
                            </li>
                        </c:forEach>
                    </ul></nav>
                </c:if>
            </div>
        </main>
        <%@ include file="components/adminFooter.jsp" %>
