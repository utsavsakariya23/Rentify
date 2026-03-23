<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ include file="components/adminHeader.jsp" %>

        <main class="container-fluid">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="fw-bold">Push Notifications</h2>
            </div>

            <div class="row g-4">
                <!-- Send Notification Form -->
                <div class="col-lg-6">
                    <div class="card card-modern border-0 h-100">
                        <div class="card-header bg-white border-bottom-0 pt-4 px-4">
                            <h5 class="fw-bold mb-0"><i class="fas fa-paper-plane text-primary me-2"></i>Send Notification</h5>
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
                        </div>
                    </div>
                </div>

                <!-- Recent Notifications -->
                <div class="col-lg-6">
                    <div class="card card-modern border-0 h-100">
                        <div class="card-header bg-white border-bottom-0 pt-4 px-4">
                            <h5 class="fw-bold mb-0"><i class="fas fa-bell text-primary me-2"></i>Recent Notifications</h5>
                        </div>
                        <div class="card-body p-4">
                            <div class="list-group list-group-flush">
                                <div class="list-group-item border-0 px-0 py-3">
                                    <div class="d-flex justify-content-between align-items-start">
                                        <div class="d-flex">
                                            <div class="bg-success bg-opacity-10 rounded-circle d-flex align-items-center justify-content-center me-3"
                                                style="width:40px;height:40px">
                                                <i class="fas fa-check-circle text-success"></i>
                                            </div>
                                            <div>
                                                <h6 class="fw-bold mb-1">Summer Sale Announcement</h6>
                                                <p class="text-muted small mb-0">Sent to: All Customers</p>
                                            </div>
                                        </div>
                                        <span class="text-muted small">2 days ago</span>
                                    </div>
                                </div>
                                <hr class="my-1">
                                <div class="list-group-item border-0 px-0 py-3">
                                    <div class="d-flex justify-content-between align-items-start">
                                        <div class="d-flex">
                                            <div class="bg-success bg-opacity-10 rounded-circle d-flex align-items-center justify-content-center me-3"
                                                style="width:40px;height:40px">
                                                <i class="fas fa-check-circle text-success"></i>
                                            </div>
                                            <div>
                                                <h6 class="fw-bold mb-1">System Maintenance Update</h6>
                                                <p class="text-muted small mb-0">Sent to: All Customers</p>
                                            </div>
                                        </div>
                                        <span class="text-muted small">1 week ago</span>
                                    </div>
                                </div>
                                <hr class="my-1">
                                <div class="list-group-item border-0 px-0 py-3">
                                    <div class="d-flex justify-content-between align-items-start">
                                        <div class="d-flex">
                                            <div class="bg-success bg-opacity-10 rounded-circle d-flex align-items-center justify-content-center me-3"
                                                style="width:40px;height:40px">
                                                <i class="fas fa-check-circle text-success"></i>
                                            </div>
                                            <div>
                                                <h6 class="fw-bold mb-1">New Vehicle Added: BMW X5</h6>
                                                <p class="text-muted small mb-0">Sent to: Active Rentals</p>
                                            </div>
                                        </div>
                                        <span class="text-muted small">2 weeks ago</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <%@ include file="components/adminFooter.jsp" %>