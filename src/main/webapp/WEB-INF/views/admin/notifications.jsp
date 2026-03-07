<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ include file="components/adminHeader.jsp" %>

        <main class="container-fluid my-5">
            <div class="row g-4">
                <!-- Review Moderation -->
                <div class="col-lg-6">
                    <div class="card card-modern border-0 h-100">
                        <div class="card-header bg-white border-bottom-0 pt-4 px-4">
                            <h4 class="fw-bold mb-0">Customer Ratings & Reviews</h4>
                        </div>
                        <div class="card-body p-4">
                            <div class="list-group list-group-flush">
                                <!-- Review Item -->
                                <div class="list-group-item border-0 px-0 pb-3">
                                    <div class="d-flex justify-content-between align-items-start">
                                        <div class="d-flex">
                                            <div class="me-3">
                                                <div class="bg-light rounded-circle d-flex align-items-center justify-content-center"
                                                    style="width: 40px; height: 40px;">JD</div>
                                            </div>
                                            <div>
                                                <h6 class="fw-bold mb-1">John Doe <span
                                                        class="badge bg-light text-dark ms-2">Toyota Corolla</span></h6>
                                                <div class="text-warning small mb-1">
                                                    <i class="fas fa-star"></i><i class="fas fa-star"></i><i
                                                        class="fas fa-star"></i><i class="fas fa-star"></i><i
                                                        class="fas fa-star"></i>
                                                </div>
                                                <p class="text-muted small mb-0">Excellent car condition and smooth
                                                    process. Highly recommended!</p>
                                            </div>
                                        </div>
                                        <button class="btn btn-sm btn-outline-danger" title="Remove Review"><i
                                                class="fas fa-trash"></i></button>
                                    </div>
                                </div>
                                <hr class="my-2">
                                <!-- Review Item -->
                                <div class="list-group-item border-0 px-0 pb-3">
                                    <div class="d-flex justify-content-between align-items-start">
                                        <div class="d-flex">
                                            <div class="me-3">
                                                <div class="bg-light rounded-circle d-flex align-items-center justify-content-center"
                                                    style="width: 40px; height: 40px;">SM</div>
                                            </div>
                                            <div>
                                                <h6 class="fw-bold mb-1">Sarah Miller <span
                                                        class="badge bg-light text-dark ms-2">Honda Civic</span></h6>
                                                <div class="text-warning small mb-1">
                                                    <i class="fas fa-star"></i><i class="fas fa-star"></i><i
                                                        class="fas fa-star"></i><i class="far fa-star"></i><i
                                                        class="far fa-star"></i>
                                                </div>
                                                <p class="text-muted small mb-0">Car was okay but the AC wasn't cooling
                                                    enough.</p>
                                            </div>
                                        </div>
                                        <button class="btn btn-sm btn-outline-danger" title="Remove Review"><i
                                                class="fas fa-trash"></i></button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Push Notifications -->
                <div class="col-lg-6">
                    <div class="card card-modern border-0 h-100">
                        <div class="card-header bg-white border-bottom-0 pt-4 px-4">
                            <h4 class="fw-bold mb-0">Push Notifications</h4>
                        </div>
                        <div class="card-body p-4">
                            <form>
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Target Audience</label>
                                    <select class="form-select">
                                        <option value="all">All Customers</option>
                                        <option value="active">Active Rentals Only</option>
                                        <option value="inactive">Inactive (Last 30 Days)</option>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Notification Title</label>
                                    <input type="text" class="form-control" placeholder="e.g. Flash Sale Alert!">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Message</label>
                                    <textarea class="form-control" rows="4"
                                        placeholder="Type your message here..."></textarea>
                                </div>
                                <div class="d-flex justify-content-end">
                                    <button type="button" class="btn btn-primary px-4"><i
                                            class="fas fa-paper-plane me-2"></i>Send Notification</button>
                                </div>
                            </form>

                            <hr class="my-4">
                            <h6 class="fw-bold mb-3">Recent Notifications</h6>
                            <ul class="list-group list-group-flush small">
                                <li class="list-group-item px-0 py-2 d-flex justify-content-between">
                                    <span><i class="fas fa-check-circle text-success me-2"></i>Summer Sale
                                        Announcement</span>
                                    <span class="text-muted">2 days ago</span>
                                </li>
                                <li class="list-group-item px-0 py-2 d-flex justify-content-between">
                                    <span><i class="fas fa-check-circle text-success me-2"></i>System Maintenance
                                        Update</span>
                                    <span class="text-muted">1 week ago</span>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <%@ include file="components/adminFooter.jsp" %>