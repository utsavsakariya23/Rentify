<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ include file="components/adminHeader.jsp" %>

        <main class="container-fluid">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="fw-bold">Manage Vehicles</h2>
                <div class="d-flex gap-2">
                    <div class="input-group" style="width: 280px;">
                        <input type="text" class="form-control" id="vehicleSearch" placeholder="Search vehicles..."
                            onkeyup="searchTable('vehicleSearch', 'vehicleTableBody')">
                        <button class="btn btn-outline-secondary"><i class="fas fa-search"></i></button>
                    </div>
                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addVehicleModal">
                        <i class="fas fa-plus me-2"></i>Add New Vehicle
                    </button>
                </div>
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
                            <tbody id="vehicleTableBody">
                                <tr>
                                    <td><img src="${pageContext.request.contextPath}/assets/img/toyota_corolla.webp"
                                            width="60" class="rounded"></td>
                                    <td>Corolla 2024</td>
                                    <td>Toyota</td>
                                    <td>Rs. 5,000</td>
                                    <td>Sedan</td>
                                    <td><span class="badge bg-success">Available</span></td>
                                    <td>
                                        <button class="btn btn-sm btn-outline-info me-1" title="View" data-bs-toggle="modal"
                                            data-bs-target="#viewVehicleModal"><i class="fas fa-eye"></i></button>
                                        <button class="btn btn-sm btn-outline-primary me-1" title="Edit" data-bs-toggle="modal"
                                            data-bs-target="#editVehicleModal"><i class="fas fa-edit"></i></button>
                                        <button class="btn btn-sm btn-outline-danger" title="Delete"><i
                                                class="fas fa-trash"></i></button>
                                    </td>
                                </tr>
                                <tr>
                                    <td><img src="${pageContext.request.contextPath}/assets/img/honda_civic.webp"
                                            width="60" class="rounded"></td>
                                    <td>Civic 2024</td>
                                    <td>Honda</td>
                                    <td>Rs. 6,500</td>
                                    <td>Sedan</td>
                                    <td><span class="badge bg-warning text-dark">Rented</span></td>
                                    <td>
                                        <button class="btn btn-sm btn-outline-info me-1" title="View"><i
                                                class="fas fa-eye"></i></button>
                                        <button class="btn btn-sm btn-outline-primary me-1" title="Edit"><i
                                                class="fas fa-edit"></i></button>
                                        <button class="btn btn-sm btn-outline-danger" title="Delete"><i
                                                class="fas fa-trash"></i></button>
                                    </td>
                                </tr>
                                <tr>
                                    <td><img src="${pageContext.request.contextPath}/assets/img/nissan_x_trail.webp"
                                            width="60" class="rounded"></td>
                                    <td>X-Trail 2024</td>
                                    <td>Nissan</td>
                                    <td>Rs. 8,000</td>
                                    <td>SUV</td>
                                    <td><span class="badge bg-success">Available</span></td>
                                    <td>
                                        <button class="btn btn-sm btn-outline-info me-1" title="View"><i
                                                class="fas fa-eye"></i></button>
                                        <button class="btn btn-sm btn-outline-primary me-1" title="Edit"><i
                                                class="fas fa-edit"></i></button>
                                        <button class="btn btn-sm btn-outline-danger" title="Delete"><i
                                                class="fas fa-trash"></i></button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <!-- Pagination -->
                    <nav class="mt-4">
                        <ul class="pagination justify-content-center">
                            <li class="page-item disabled"><a class="page-link" href="#">Previous</a></li>
                            <li class="page-item active"><a class="page-link" href="#">1</a></li>
                            <li class="page-item"><a class="page-link" href="#">2</a></li>
                            <li class="page-item"><a class="page-link" href="#">Next</a></li>
                        </ul>
                    </nav>
                </div>
            </div>
        </main>

        <!-- ===== ADD VEHICLE MODAL ===== -->
        <div class="modal fade" id="addVehicleModal" tabindex="-1">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header bg-primary text-white">
                        <h5 class="modal-title"><i class="fas fa-plus me-2"></i>Add New Vehicle</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <form>
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label">Brand</label>
                                    <input type="text" class="form-control" placeholder="e.g. Toyota">
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Model</label>
                                    <input type="text" class="form-control" placeholder="e.g. Corolla 2024">
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label">Type</label>
                                    <select class="form-select">
                                        <option>Sedan</option>
                                        <option>SUV</option>
                                        <option>Hatchback</option>
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
                                <div class="col-md-4">
                                    <label class="form-label">Price Per Day (Rs.)</label>
                                    <input type="number" class="form-control" placeholder="5000">
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label">Passengers</label>
                                    <input type="number" class="form-control" placeholder="5">
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label">Color</label>
                                    <input type="text" class="form-control" placeholder="e.g. White">
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Image</label>
                                    <input type="file" class="form-control">
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Register Number</label>
                                    <input type="text" class="form-control" placeholder="e.g. GJ-01-AB-1234">
                                </div>
                                <div class="col-12">
                                    <label class="form-label">Description</label>
                                    <textarea class="form-control" rows="3" placeholder="Vehicle description..."></textarea>
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

        <!-- ===== VIEW VEHICLE MODAL ===== -->
        <div class="modal fade" id="viewVehicleModal" tabindex="-1">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header bg-info text-white">
                        <h5 class="modal-title"><i class="fas fa-eye me-2"></i>Vehicle Details</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-5 text-center">
                                <img src="${pageContext.request.contextPath}/assets/img/toyota_corolla.webp"
                                    class="img-fluid rounded shadow-sm mb-3" alt="Vehicle">
                                <span class="badge bg-success fs-6">Available</span>
                            </div>
                            <div class="col-md-7">
                                <h4 class="fw-bold">Toyota Corolla 2024</h4>
                                <hr>
                                <div class="row g-3">
                                    <div class="col-6">
                                        <p class="text-muted small mb-1">BRAND</p>
                                        <p class="fw-bold">Toyota</p>
                                    </div>
                                    <div class="col-6">
                                        <p class="text-muted small mb-1">TYPE</p>
                                        <p class="fw-bold">Sedan</p>
                                    </div>
                                    <div class="col-6">
                                        <p class="text-muted small mb-1">TRANSMISSION</p>
                                        <p class="fw-bold">Auto</p>
                                    </div>
                                    <div class="col-6">
                                        <p class="text-muted small mb-1">FUEL</p>
                                        <p class="fw-bold">Petrol</p>
                                    </div>
                                    <div class="col-6">
                                        <p class="text-muted small mb-1">PRICE / DAY</p>
                                        <p class="fw-bold text-primary">Rs. 5,000</p>
                                    </div>
                                    <div class="col-6">
                                        <p class="text-muted small mb-1">PASSENGERS</p>
                                        <p class="fw-bold">5</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- ===== EDIT VEHICLE MODAL ===== -->
        <div class="modal fade" id="editVehicleModal" tabindex="-1">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header bg-primary text-white">
                        <h5 class="modal-title"><i class="fas fa-edit me-2"></i>Edit Vehicle</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <form>
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label">Brand</label>
                                    <input type="text" class="form-control" value="Toyota">
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Model</label>
                                    <input type="text" class="form-control" value="Corolla 2024">
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label">Type</label>
                                    <select class="form-select">
                                        <option selected>Sedan</option>
                                        <option>SUV</option>
                                        <option>Hatchback</option>
                                        <option>Luxury</option>
                                    </select>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label">Transmission</label>
                                    <select class="form-select">
                                        <option selected>Auto</option>
                                        <option>Manual</option>
                                    </select>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label">Fuel</label>
                                    <select class="form-select">
                                        <option selected>Petrol</option>
                                        <option>Diesel</option>
                                        <option>Electric</option>
                                    </select>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label">Price Per Day (Rs.)</label>
                                    <input type="number" class="form-control" value="5000">
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label">Passengers</label>
                                    <input type="number" class="form-control" value="5">
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label">Status</label>
                                    <select class="form-select">
                                        <option selected>Available</option>
                                        <option>Rented</option>
                                        <option>Maintenance</option>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Change Image</label>
                                    <input type="file" class="form-control">
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Register Number</label>
                                    <input type="text" class="form-control" value="GJ-01-AB-1234">
                                </div>
                                <div class="col-12">
                                    <label class="form-label">Description</label>
                                    <textarea class="form-control" rows="3">Well maintained sedan with smooth driving experience.</textarea>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="button" class="btn btn-primary">Update Vehicle</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Search Script -->
        <script>
        function searchTable(inputId, tbodyId) {
            var filter = document.getElementById(inputId).value.toUpperCase();
            var rows = document.getElementById(tbodyId).getElementsByTagName('tr');
            for (var i = 0; i < rows.length; i++) {
                var text = rows[i].textContent || rows[i].innerText;
                rows[i].style.display = text.toUpperCase().indexOf(filter) > -1 ? '' : 'none';
            }
        }
        </script>

        <%@ include file="components/adminFooter.jsp" %>