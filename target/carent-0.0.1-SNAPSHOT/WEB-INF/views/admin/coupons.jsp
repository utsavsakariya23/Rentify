<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ include file="components/adminHeader.jsp" %>

        <main class="container-fluid my-5">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="fw-bold">Manage Coupons</h2>
                <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addCouponModal">
                    <i class="fas fa-plus me-2"></i>Create Coupon
                </button>
            </div>

            <div class="row g-4">
                <div class="col-md-4">
                    <div
                        class="card card-modern border-0 h-100 bg-primary text-white position-relative overflow-hidden">
                        <div class="card-body p-4">
                            <div class="d-flex justify-content-between align-items-start">
                                <div>
                                    <h3 class="fw-bold mb-0">SAVE10</h3>
                                    <p class="mb-0 opacity-75">10% Discount</p>
                                </div>
                                <span class="badge bg-white text-primary">Active</span>
                            </div>
                            <hr class="bg-white opacity-50">
                            <p class="mb-1 small opacity-75">Valid Until: <span class="fw-bold">31 Dec 2026</span></p>
                            <p class="mb-3 small opacity-75">Used: 45 times</p>
                            <button class="btn btn-sm btn-light text-primary w-100 fw-bold">Edit Coupon</button>
                        </div>
                        <div class="position-absolute" style="bottom: -20px; right: -20px; opacity: 0.1;">
                            <i class="fas fa-ticket-alt fa-8x"></i>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card card-modern border-0 h-100 bg-white">
                        <div class="card-body p-4">
                            <div class="d-flex justify-content-between align-items-start">
                                <div>
                                    <h3 class="fw-bold mb-0 text-dark">WELCOME500</h3>
                                    <p class="text-muted mb-0">Flat Rs. 500 Off</p>
                                </div>
                                <span class="badge bg-secondary">Expired</span>
                            </div>
                            <hr>
                            <p class="mb-1 small text-muted">Valid Until: <span class="fw-bold">31 Jan 2026</span></p>
                            <p class="mb-3 small text-muted">Used: 120 times</p>
                            <button class="btn btn-sm btn-outline-secondary w-100">View Details</button>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <!-- Add Coupon Modal -->
        <div class="modal fade" id="addCouponModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Create New Coupon</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <form>
                            <div class="mb-3">
                                <label class="form-label">Coupon Code</label>
                                <input type="text" class="form-control" placeholder="e.g. SUMMER2026">
                            </div>
                            <div class="row g-2 mb-3">
                                <div class="col-6">
                                    <label class="form-label">Discount Value</label>
                                    <input type="number" class="form-control" placeholder="10">
                                </div>
                                <div class="col-6">
                                    <label class="form-label">Type</label>
                                    <select class="form-select">
                                        <option value="percent">Percentage (%)</option>
                                        <option value="flat">Flat Amount (Rs)</option>
                                    </select>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Valid Until</label>
                                <input type="date" class="form-control">
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Min Spend Amount (Optional)</label>
                                <input type="number" class="form-control" placeholder="Rs. 5000">
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Usage Limit (Optional)</label>
                                <input type="number" class="form-control" placeholder="Total uses allowed">
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="button" class="btn btn-primary">Create Coupon</button>
                    </div>
                </div>
            </div>
        </div>

        <%@ include file="components/adminFooter.jsp" %>