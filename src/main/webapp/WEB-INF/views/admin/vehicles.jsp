<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ include file="components/adminHeader.jsp" %>

        <main class="container-fluid my-5">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="fw-bold">Manage Vehicles</h2>
                <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addVehicleModal">
                    <i class="fas fa-plus me-2"></i>Add New Vehicle
                </button>
            </div>

            <!-- Vehicles Table -->
            <div class="card card-modern border-0">
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead class="table-light">
                                <tr>
                                    <th>Image</th>
                                    <th>Model</th>
                                    <th>Brand</th>
                                    <th>Price/Day</th>
                                    <th>Type</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><img src="${pageContext.request.contextPath}/assets/img/toyota_corolla.webp"
                                            width="60" class="rounded"></td>
                                    <td>Corolla 2024</td>
                                    <td>Toyota</td>
                                    <td>Rs. 5,000</td>
                                    <td>Sedan</td>
                                    <td><span class="badge bg-success">Available</span></td>
                                    <td>
                                        <button class="btn btn-sm btn-outline-primary me-1"><i
                                                class="fas fa-edit"></i></button>
                                        <button class="btn btn-sm btn-outline-danger"><i
                                                class="fas fa-trash"></i></button>
                                    </td>
                                </tr>
                                <!-- More rows... -->
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </main>

        <!-- Add Vehicle Modal -->
        <div class="modal fade" id="addVehicleModal" tabindex="-1">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Add New Vehicle</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <form>
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label">Brand</label>
                                    <input type="text" class="form-control">
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Model</label>
                                    <input type="text" class="form-control">
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label">Type</label>
                                    <select class="form-select">
                                        <option>Sedan</option>
                                        <option>SUV</option>
                                        <option>Luxury</option>
                                    </select>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label">Transmission</label>
                                    <select class="form-select">
                                        <option>Auto</option>
                                        <option>Manual</option>
                                    </select>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label">Fuel</label>
                                    <select class="form-select">
                                        <option>Petrol</option>
                                        <option>Diesel</option>
                                        <option>Electric</option>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Price Per Day</label>
                                    <input type="number" class="form-control">
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Image</label>
                                    <input type="file" class="form-control">
                                </div>
                                <div class="col-12">
                                    <label class="form-label">Description</label>
                                    <textarea class="form-control" rows="3"></textarea>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary">Save Vehicle</button>
                    </div>
                </div>
            </div>
        </div>

        <%@ include file="components/adminFooter.jsp" %>