<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ include file="components/adminHeader.jsp" %>

        <main class="container-fluid my-5">
            <div class="row">
                <!-- Sidebar could go here if not in header -->

                <div class="col-12">
                    <h2 class="fw-bold mb-4">Dashboard Overview</h2>

                    <!-- KPI Cards -->
                    <div class="row g-4 mb-5">
                        <div class="col-md-3">
                            <div class="card card-modern border-0 p-3 h-100 bg-primary text-white">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h6 class="text-white-50 text-uppercase fw-bold">Total Rentals</h6>
                                        <h2 class="fw-bold mb-0">1,245</h2>
                                    </div>
                                    <i class="fas fa-chart-line fa-3x opacity-50"></i>
                                </div>
                                <small class="text-white-50 mt-3 d-block"><i class="fas fa-arrow-up me-1"></i> 12%
                                    increase</small>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card card-modern border-0 p-3 h-100 bg-white">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h6 class="text-muted text-uppercase fw-bold">Active Bookings</h6>
                                        <h2 class="fw-bold mb-0 text-dark">45</h2>
                                    </div>
                                    <i class="fas fa-calendar-check fa-3x text-success opacity-50"></i>
                                </div>
                                <small class="text-success mt-3 d-block">5 pending approval</small>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card card-modern border-0 p-3 h-100 bg-white">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h6 class="text-muted text-uppercase fw-bold">Total Revenue</h6>
                                        <h2 class="fw-bold mb-0 text-dark">Rs. 4.2M</h2>
                                    </div>
                                    <i class="fas fa-coins fa-3x text-warning opacity-50"></i>
                                </div>
                                <small class="text-muted mt-3 d-block">This month</small>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card card-modern border-0 p-3 h-100 bg-white">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h6 class="text-muted text-uppercase fw-bold">Fleet Status</h6>
                                        <h2 class="fw-bold mb-0 text-dark">18/25</h2>
                                    </div>
                                    <i class="fas fa-car fa-3x text-info opacity-50"></i>
                                </div>
                                <small class="text-muted mt-3 d-block">7 cars rented out</small>
                            </div>
                        </div>
                    </div>

                    <div class="row g-4 mb-4">
                        <!-- Recent Activity Table -->
                        <div class="col-lg-8">
                            <div class="card card-modern border-0 p-4 h-100">
                                <h5 class="fw-bold mb-4">Recent Bookings</h5>
                                <div class="table-responsive">
                                    <table class="table table-hover align-middle">
                                        <thead class="table-light">
                                            <tr>
                                                <th>ID</th>
                                                <th>Customer</th>
                                                <th>Car</th>
                                                <th>Dates</th>
                                                <th>Status</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>#REN-1023</td>
                                                <td>John Doe</td>
                                                <td>Toyota Corolla</td>
                                                <td>Feb 20 - Feb 22</td>
                                                <td><span class="badge bg-warning text-dark">Pending</span></td>
                                                <td>
                                                    <button class="btn btn-sm btn-success"><i
                                                            class="fas fa-check"></i></button>
                                                    <button class="btn btn-sm btn-danger"><i
                                                            class="fas fa-times"></i></button>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>#REN-1022</td>
                                                <td>Jane Smith</td>
                                                <td>Honda Civic</td>
                                                <td>Feb 18 - Feb 25</td>
                                                <td><span class="badge bg-success">Active</span></td>
                                                <td>
                                                    <button class="btn btn-sm btn-outline-secondary">Details</button>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>#REN-1021</td>
                                                <td>Mike Ross</td>
                                                <td>Nissan X-Trail</td>
                                                <td>Feb 15 - Feb 17</td>
                                                <td><span class="badge bg-secondary">Completed</span></td>
                                                <td>
                                                    <button class="btn btn-sm btn-outline-secondary">Details</button>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>

                        <!-- Simple Chart / Stats -->
                        <div class="col-lg-4">
                            <div class="card card-modern border-0 p-4 h-100">
                                <h5 class="fw-bold mb-4">Popular Cars</h5>
                                <ul class="list-group list-group-flush">
                                    <li
                                        class="list-group-item d-flex justify-content-between align-items-center border-0 px-0">
                                        <div>
                                            <span class="fw-bold">Toyota Corolla</span>
                                            <div class="progress mt-1" style="width: 150px; height: 6px;">
                                                <div class="progress-bar bg-primary" style="width: 85%"></div>
                                            </div>
                                        </div>
                                        <span class="badge bg-primary rounded-pill">85%</span>
                                    </li>
                                    <li
                                        class="list-group-item d-flex justify-content-between align-items-center border-0 px-0">
                                        <div>
                                            <span class="fw-bold">Honda Civic</span>
                                            <div class="progress mt-1" style="width: 150px; height: 6px;">
                                                <div class="progress-bar bg-success" style="width: 70%"></div>
                                            </div>
                                        </div>
                                        <span class="badge bg-success rounded-pill">70%</span>
                                    </li>
                                    <li
                                        class="list-group-item d-flex justify-content-between align-items-center border-0 px-0">
                                        <div>
                                            <span class="fw-bold">Suzuki Swift</span>
                                            <div class="progress mt-1" style="width: 150px; height: 6px;">
                                                <div class="progress-bar bg-warning" style="width: 45%"></div>
                                            </div>
                                        </div>
                                        <span class="badge bg-warning rounded-pill">45%</span>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <%@ include file="components/adminFooter.jsp" %>