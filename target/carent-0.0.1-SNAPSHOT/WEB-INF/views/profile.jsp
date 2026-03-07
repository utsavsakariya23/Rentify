<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ include file="components/header.jsp" %>

        <main class="container my-5 pt-5">
            <div class="row">
                <!-- Sidebar Navigation -->
                <div class="col-md-3 mb-4">
                    <div class="glass-panel p-3 rounded-3 sticky-top" style="top: 100px;">
                        <div class="text-center mb-4">
                            <div class="bg-primary text-white rounded-circle d-flex align-items-center justify-content-center mx-auto mb-2"
                                style="width: 80px; height: 80px; font-size: 2rem;">
                                <i class="fas fa-user"></i>
                            </div>
                            <h5 class="fw-bold mb-0">John Doe</h5>
                            <small class="text-muted">Member since 2024</small>
                        </div>

                        <div class="list-group list-group-flush">
                            <a href="#profile" class="list-group-item list-group-item-action active"
                                data-bs-toggle="list">
                                <i class="fas fa-user-circle me-2"></i> My Profile
                            </a>
                            <a href="#bookings" class="list-group-item list-group-item-action" data-bs-toggle="list">
                                <i class="fas fa-calendar-alt me-2"></i> My Bookings
                            </a>
                            <a href="#notifications" class="list-group-item list-group-item-action"
                                data-bs-toggle="list">
                                <i class="fas fa-bell me-2"></i> Notifications
                                <span class="badge bg-danger rounded-pill float-end">2</span>
                            </a>
                            <a href="#" class="list-group-item list-group-item-action text-danger"
                                onclick="logoutUser()">
                                <i class="fas fa-sign-out-alt me-2"></i> Logout
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Main Content -->
                <div class="col-md-9">
                    <div class="tab-content">
                        <!-- Profile Section -->
                        <div class="tab-pane fade show active" id="profile">
                            <div class="card card-modern p-4">
                                <h4 class="fw-bold mb-4">Profile Details</h4>
                                <form>
                                    <div class="row g-3">
                                        <div class="col-md-6">
                                            <label class="form-label small fw-bold">First Name</label>
                                            <input type="text" class="form-control" value="John">
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label small fw-bold">Last Name</label>
                                            <input type="text" class="form-control" value="Doe">
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label small fw-bold">Email</label>
                                            <input type="email" class="form-control" value="john.doe@example.com"
                                                disabled>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label small fw-bold">Phone</label>
                                            <input type="tel" class="form-control" value="+94 77 123 4567">
                                        </div>
                                        <div class="col-12">
                                            <label class="form-label small fw-bold">Address</label>
                                            <input type="text" class="form-control" value="123, Main Street, Colombo">
                                        </div>
                                    </div>
                                    <button type="submit" class="btn btn-primary-custom mt-4">Save Changes</button>
                                </form>
                            </div>
                        </div>

                        <!-- Bookings Section -->
                        <div class="tab-pane fade" id="bookings">
                            <div class="card card-modern p-4">
                                <h4 class="fw-bold mb-4">My Bookings</h4>

                                <ul class="nav nav-tabs mb-4">
                                    <li class="nav-item">
                                        <a class="nav-link active" data-bs-toggle="tab" href="#upcoming">Upcoming</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" data-bs-toggle="tab" href="#past">Past</a>
                                    </li>
                                </ul>

                                <div class="tab-content">
                                    <div class="tab-pane fade show active" id="upcoming">
                                        <!-- Booking Card 1 -->
                                        <div class="card mb-3 border bg-light">
                                            <div class="card-body">
                                                <div class="d-flex justify-content-between align-items-center">
                                                    <div>
                                                        <h6 class="fw-bold mb-1">Toyota Corolla</h6>
                                                        <small class="text-muted">Booking ID: #RENT-12345</small>
                                                    </div>
                                                    <span class="badge bg-warning text-dark">Pending</span>
                                                </div>
                                                <hr>
                                                <div class="row text-center text-md-start">
                                                    <div class="col-md-4">
                                                        <small class="text-muted d-block">Pick-Up</small>
                                                        <strong>Feb 20, 2026</strong>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <small class="text-muted d-block">Drop-Off</small>
                                                        <strong>Feb 22, 2026</strong>
                                                    </div>
                                                    <div class="col-md-4 text-md-end">
                                                        <small class="text-muted d-block">Total</small>
                                                        <strong class="text-primary">Rs. 10,000</strong>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="tab-pane fade" id="past">
                                        <!-- Booking Card 2 -->
                                        <div class="card mb-3 border bg-light">
                                            <div class="card-body">
                                                <div class="d-flex justify-content-between align-items-center">
                                                    <div>
                                                        <h6 class="fw-bold mb-1">Honda Civic</h6>
                                                        <small class="text-muted">Booking ID: #RENT-09876</small>
                                                    </div>
                                                    <span class="badge bg-success">Completed</span>
                                                </div>
                                                <hr>
                                                <div class="row text-center text-md-start">
                                                    <div class="col-md-4">
                                                        <small class="text-muted d-block">Pick-Up</small>
                                                        <strong>Jan 15, 2026</strong>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <small class="text-muted d-block">Drop-Off</small>
                                                        <strong>Jan 18, 2026</strong>
                                                    </div>
                                                    <div class="col-md-4 text-md-end">
                                                        <small class="text-muted d-block">Total</small>
                                                        <strong class="text-primary">Rs. 19,500</strong>
                                                    </div>
                                                </div>
                                                <div class="text-end mt-2">
                                                    <button class="btn btn-sm btn-outline-secondary">Write
                                                        Review</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Notifications Section -->
                        <div class="tab-pane fade" id="notifications">
                            <div class="card card-modern p-4">
                                <h4 class="fw-bold mb-4">Notifications</h4>
                                <div class="list-group list-group-flush">
                                    <a href="#"
                                        class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                                        <div>
                                            <i class="fas fa-check-circle text-success me-2"></i>
                                            <strong>Booking Confirmed</strong>
                                            <p class="mb-0 small text-muted">Your booking #RENT-09876 has been
                                                confirmed.</p>
                                        </div>
                                        <small class="text-muted">2 days ago</small>
                                    </a>
                                    <a href="#"
                                        class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                                        <div>
                                            <i class="fas fa-tag text-primary me-2"></i>
                                            <strong>New Promo!</strong>
                                            <p class="mb-0 small text-muted">Use code SAVE10 for 10% off your next
                                                rental.</p>
                                        </div>
                                        <small class="text-muted">1 week ago</small>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <%@ include file="components/footer.jsp" %>