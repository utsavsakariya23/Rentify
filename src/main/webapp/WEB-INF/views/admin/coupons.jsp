<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
    <%@ include file="components/adminHeader.jsp" %>

        <main class="container-fluid my-5">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="fw-bold">Manage Coupons</h2>
                <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addCouponModal"><i class="fas fa-plus me-2"></i>Add Coupon</button>
            </div>

            <c:if test="${not empty param.success}">
                <div class="alert alert-success alert-dismissible fade show">${param.success}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>
            </c:if>

            <div class="card card-modern border-0 p-4">
                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead class="table-light">
                            <tr><th>ID</th><th>Code</th><th>Discount %</th><th>Expiry Date</th><th>Status</th><th>Suggested</th><th>Actions</th></tr>
                        </thead>
                        <tbody>
                            <c:forEach var="c" items="${coupons}">
                                <tr>
                                    <td>${c.couponId}</td>
                                    <td><code class="fw-bold">${c.code}</code></td>
                                    <td>${c.discountPercentage}%</td>
                                    <td>${c.expiryDate}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${c.active}"><span class="badge bg-success">Active</span></c:when>
                                            <c:otherwise><span class="badge bg-secondary">Inactive</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${c.suggested}"><span class="badge bg-info"><i class="fas fa-star me-1"></i>Yes</span></c:when>
                                            <c:otherwise><span class="badge bg-light text-muted">No</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <button class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#editCouponModal${c.couponId}"><i class="fas fa-edit"></i></button>
                                        <c:if test="${c.active}">
                                            <button class="btn btn-sm btn-outline-success" data-bs-toggle="modal" data-bs-target="#sendCouponModal${c.couponId}" title="Send coupon notification">
                                                <i class="fas fa-paper-plane"></i>
                                            </button>
                                        </c:if>
                                        <form action="${pageContext.request.contextPath}/admin/delete_coupon" method="post" style="display:inline;" onsubmit="return confirm('Delete this coupon?');">
                                            <input type="hidden" name="couponId" value="${c.couponId}">
                                            <button class="btn btn-sm btn-outline-danger"><i class="fas fa-trash"></i></button>
                                        </form>
                                    </td>
                                </tr>

                            </c:forEach>
                            <c:if test="${empty coupons}"><tr><td colspan="7" class="text-center text-muted py-4">No coupons found</td></tr></c:if>
                        </tbody>
                    </table>
                </div>

            </div>

        </main>

        <!-- Edit Modals (outside main container to prevent z-index issues) -->
        <c:forEach var="c" items="${coupons}">
            <div class="modal fade" id="editCouponModal${c.couponId}" tabindex="-1">
                <div class="modal-dialog"><div class="modal-content">
                    <div class="modal-header"><h5 class="modal-title">Edit Coupon</h5><button type="button" class="btn-close" data-bs-dismiss="modal"></button></div>
                    <form action="${pageContext.request.contextPath}/admin/edit_coupon" method="post">
                        <div class="modal-body">
                            <input type="hidden" name="couponId" value="${c.couponId}">
                            <div class="mb-3"><label class="form-label">Code</label><input type="text" class="form-control" name="code" value="${c.code}" required></div>
                            <div class="mb-3"><label class="form-label">Discount %</label><input type="number" class="form-control" name="discountPercentage" value="${c.discountPercentage}" step="0.01" min="1" max="100" required></div>
                            <div class="mb-3"><label class="form-label">Expiry Date</label><input type="date" class="form-control" name="expiryDate" value="${c.expiryDate}" required></div>
                            <div class="form-check mb-2"><input class="form-check-input" type="checkbox" name="isActive" id="editActive${c.couponId}" ${c.active ? 'checked' : ''}><label class="form-check-label" for="editActive${c.couponId}">Active</label></div>
                            <div class="form-check"><input class="form-check-input" type="checkbox" name="isSuggested" id="editSuggested${c.couponId}" ${c.suggested ? 'checked' : ''}><label class="form-check-label" for="editSuggested${c.couponId}"><i class="fas fa-star text-info me-1"></i>Suggest to Users on Booking Page</label></div>
                        </div>
                        <div class="modal-footer"><button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button><button type="submit" class="btn btn-primary">Save</button></div>
                    </form>
                </div></div>
            </div>

            <!-- Send Coupon Notification Modal -->
            <div class="modal fade" id="sendCouponModal${c.couponId}" tabindex="-1">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header bg-success text-white">
                            <h5 class="modal-title"><i class="fas fa-paper-plane me-2"></i>Send Coupon Notification</h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                        </div>
                        <form action="${pageContext.request.contextPath}/admin/send_coupon_notification" method="post">
                            <input type="hidden" name="couponCode" value="${c.code}">
                            <input type="hidden" name="discount" value="${c.discountPercentage}">
                            <input type="hidden" name="expiryDate" value="${c.expiryDate}">
                            <div class="modal-body">
                                <div class="alert alert-info">
                                    <i class="fas fa-info-circle me-2"></i>
                                    This will send a notification about coupon <strong>${c.code}</strong> (${c.discountPercentage}% off) to selected users.
                                </div>
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Send To</label>
                                    <select name="audienceType" class="form-select">
                                        <option value="all">📢 All Users</option>
                                        <option value="frequent">⭐ Frequent Users (3+ bookings)</option>
                                        <option value="infrequent">🆕 Non-Frequent Users (&lt; 3 bookings)</option>
                                    </select>
                                </div>
                                <div class="form-check mb-3">
                                    <input class="form-check-input" type="checkbox" name="sendEmail" id="sendEmail${c.couponId}" checked>
                                    <label class="form-check-label" for="sendEmail${c.couponId}">
                                        <i class="fas fa-envelope me-1"></i>Also send via Email
                                    </label>
                                </div>
                                <div class="p-3 bg-light rounded">
                                    <small class="text-muted fw-bold">Preview:</small>
                                    <p class="mb-0 mt-1">🎉 Special Offer! Use coupon <strong>${c.code}</strong> for <strong>${c.discountPercentage}%</strong> off your next booking! Valid until <strong>${c.expiryDate}</strong>. Book now!</p>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                <button type="submit" class="btn btn-success"><i class="fas fa-paper-plane me-1"></i>Send Notification</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </c:forEach>

        <!-- Add Coupon Modal -->
        <div class="modal fade" id="addCouponModal" tabindex="-1">
            <div class="modal-dialog"><div class="modal-content">
                <div class="modal-header"><h5 class="modal-title">Add Coupon</h5><button type="button" class="btn-close" data-bs-dismiss="modal"></button></div>
                <form action="${pageContext.request.contextPath}/admin/add_coupon" method="post" class="needs-validation" novalidate>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label">Code</label>
                            <input type="text" class="form-control" name="code" placeholder="e.g. SAVE20" pattern="^[A-Z0-9]{3,15}$" required>
                            <div class="invalid-feedback">Code must be 3-15 uppercase alphanumeric characters.</div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Discount %</label>
                            <input type="number" class="form-control" name="discountPercentage" step="0.01" min="1" max="100" required>
                            <div class="invalid-feedback">Discount must be between 1 and 100.</div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Expiry Date</label>
                            <input type="date" class="form-control" name="expiryDate" id="addCouponDate" required>
                            <div class="invalid-feedback">Please select a valid expiry date.</div>
                        </div>
                        <div class="form-check mb-2">
                            <input class="form-check-input" type="checkbox" name="isActive" id="addCouponActive" checked>
                            <label class="form-check-label" for="addCouponActive">Active</label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" name="isSuggested" id="addCouponSuggested">
                            <label class="form-check-label" for="addCouponSuggested"><i class="fas fa-star text-info me-1"></i>Suggest to Users on Booking Page</label>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">Add Coupon</button>
                    </div>
                </form>
            </div></div>
        </div>

        <script>
            // Set min expiry date to today
            document.getElementById('addCouponDate').setAttribute('min', new Date().toISOString().split('T')[0]);

            (function () {
                'use strict'
                var forms = document.querySelectorAll('.needs-validation')
                Array.prototype.slice.call(forms)
                    .forEach(function (form) {
                        form.addEventListener('submit', function (event) {
                            if (!form.checkValidity()) {
                                event.preventDefault()
                                event.stopPropagation()
                            }
                            form.classList.add('was-validated')
                        }, false)
                    })
            })()
        </script>
        <%@ include file="components/adminFooter.jsp" %>