<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="components/adminHeader.jsp" %>

    <main class="container-fluid">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="fw-bold">Rent Requests</h2>
            <div class="d-flex gap-2">
                <div class="input-group" style="width: 280px;">
                    <input type="text" class="form-control" id="rentSearch" placeholder="Search requests..."
                        onkeyup="searchTable('rentSearch', 'rentTableBody')">
                    <button class="btn btn-outline-secondary"><i class="fas fa-search"></i></button>
                </div>
            </div>
        </div>

        <!-- Rent Requests Table -->
        <div class="card card-modern border-0">
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead class="table-light">
                            <tr>
                                <th>Rent ID</th>
                                <th>Customer</th>
                                <th>Vehicle</th>
                                <th>Pick-up Date</th>
                                <th>Return Date</th>
                                <th>Pick-up Place</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody id="rentTableBody">
                            <tr>
                                <td class="fw-bold">#RNT-1001</td>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <div class="bg-light rounded-circle d-flex align-items-center justify-content-center me-2"
                                            style="width:32px;height:32px"><i class="fas fa-user text-secondary"></i></div>
                                        <div>
                                            <div class="fw-bold">John Doe</div>
                                            <div class="small text-muted">john@example.com</div>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <img src="${pageContext.request.contextPath}/assets/img/toyota_corolla.webp" width="40" class="rounded me-2">
                                        <span>Corolla 2024</span>
                                    </div>
                                </td>
                                <td>25 Mar 2026</td>
                                <td>28 Mar 2026</td>
                                <td>Rajkot</td>
                                <td><span class="badge bg-warning text-dark">Pending</span></td>
                                <td>
                                    <button class="btn btn-sm btn-outline-info me-1" title="View" data-bs-toggle="modal"
                                        data-bs-target="#viewRentModal"><i class="fas fa-eye"></i></button>
                                    <button class="btn btn-sm btn-outline-success me-1" title="Accept"><i
                                            class="fas fa-check"></i></button>
                                    <button class="btn btn-sm btn-outline-danger" title="Reject"><i
                                            class="fas fa-times"></i></button>
                                </td>
                            </tr>
                            <tr>
                                <td class="fw-bold">#RNT-1002</td>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <div class="bg-light rounded-circle d-flex align-items-center justify-content-center me-2"
                                            style="width:32px;height:32px"><i class="fas fa-user text-secondary"></i></div>
                                        <div>
                                            <div class="fw-bold">Jane Smith</div>
                                            <div class="small text-muted">jane@example.com</div>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <img src="${pageContext.request.contextPath}/assets/img/honda_civic.webp" width="40" class="rounded me-2">
                                        <span>Civic 2024</span>
                                    </div>
                                </td>
                                <td>20 Mar 2026</td>
                                <td>23 Mar 2026</td>
                                <td>Ahmedabad</td>
                                <td><span class="badge bg-success">Accepted</span></td>
                                <td>
                                    <button class="btn btn-sm btn-outline-info me-1" title="View"><i class="fas fa-eye"></i></button>
                                    <button class="btn btn-sm btn-outline-secondary me-1" title="Return"><i
                                            class="fas fa-undo"></i></button>
                                    <button class="btn btn-sm btn-outline-danger" title="Cancel"><i
                                            class="fas fa-times"></i></button>
                                </td>
                            </tr>
                            <tr>
                                <td class="fw-bold">#RNT-1003</td>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <div class="bg-light rounded-circle d-flex align-items-center justify-content-center me-2"
                                            style="width:32px;height:32px"><i class="fas fa-user text-secondary"></i></div>
                                        <div>
                                            <div class="fw-bold">Ravi Patel</div>
                                            <div class="small text-muted">ravi@example.com</div>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <img src="${pageContext.request.contextPath}/assets/img/nissan_x_trail.webp" width="40" class="rounded me-2">
                                        <span>X-Trail 2024</span>
                                    </div>
                                </td>
                                <td>15 Mar 2026</td>
                                <td>18 Mar 2026</td>
                                <td>Surat</td>
                                <td><span class="badge bg-secondary">Returned</span></td>
                                <td>
                                    <button class="btn btn-sm btn-outline-info me-1" title="View"><i class="fas fa-eye"></i></button>
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

    <!-- ===== VIEW RENT REQUEST MODAL ===== -->
    <div class="modal fade" id="viewRentModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-info text-white">
                    <h5 class="modal-title"><i class="fas fa-eye me-2"></i>Rent Request Details</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <div class="card bg-light border-0 p-3">
                                <h6 class="fw-bold text-primary mb-3"><i class="fas fa-user me-2"></i>Customer Info</h6>
                                <p class="mb-1"><strong>Name:</strong> John Doe</p>
                                <p class="mb-1"><strong>Email:</strong> john@example.com</p>
                                <p class="mb-0"><strong>Phone:</strong> 077 123 4567</p>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="card bg-light border-0 p-3">
                                <h6 class="fw-bold text-primary mb-3"><i class="fas fa-car me-2"></i>Vehicle Info</h6>
                                <p class="mb-1"><strong>Vehicle:</strong> Toyota Corolla 2024</p>
                                <p class="mb-1"><strong>Type:</strong> Sedan</p>
                                <p class="mb-0"><strong>Price/Day:</strong> Rs. 5,000</p>
                            </div>
                        </div>
                        <div class="col-12">
                            <div class="card bg-light border-0 p-3">
                                <h6 class="fw-bold text-primary mb-3"><i class="fas fa-info-circle me-2"></i>Rental Details</h6>
                                <div class="row">
                                    <div class="col-md-3"><p class="mb-1"><strong>Rent ID:</strong> #RNT-1001</p></div>
                                    <div class="col-md-3"><p class="mb-1"><strong>Pick-up:</strong> 25 Mar 2026</p></div>
                                    <div class="col-md-3"><p class="mb-1"><strong>Return:</strong> 28 Mar 2026</p></div>
                                    <div class="col-md-3"><p class="mb-1"><strong>Status:</strong> <span class="badge bg-warning text-dark">Pending</span></p></div>
                                    <div class="col-md-3"><p class="mb-1"><strong>Location:</strong> Rajkot</p></div>
                                    <div class="col-md-3"><p class="mb-1"><strong>Duration:</strong> 3 days</p></div>
                                    <div class="col-md-3"><p class="mb-1"><strong>Total:</strong> Rs. 15,000</p></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer justify-content-between">
                    <div>
                        <button type="button" class="btn btn-success me-2"><i class="fas fa-check me-1"></i>Accept</button>
                        <button type="button" class="btn btn-danger"><i class="fas fa-times me-1"></i>Reject</button>
                    </div>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
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