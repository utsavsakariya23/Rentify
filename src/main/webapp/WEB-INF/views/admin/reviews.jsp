<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ include file="components/adminHeader.jsp" %>

        <main class="container-fluid">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="fw-bold">Reviews & Ratings</h2>
                <div class="input-group" style="width: 280px;">
                    <input type="text" class="form-control" id="reviewSearch" placeholder="Search reviews..."
                        onkeyup="searchTable('reviewSearch', 'reviewTableBody')">
                    <button class="btn btn-outline-secondary"><i class="fas fa-search"></i></button>
                </div>
            </div>

            <!-- Stats Cards -->
            <div class="row g-3 mb-4">
                <div class="col-md-3">
                    <div class="card card-modern border-0 p-3">
                        <div class="d-flex align-items-center">
                            <div class="bg-warning bg-opacity-10 rounded-circle d-flex align-items-center justify-content-center me-3"
                                style="width:48px;height:48px">
                                <i class="fas fa-star text-warning fa-lg"></i>
                            </div>
                            <div>
                                <div class="text-muted small">Average Rating</div>
                                <div class="fw-bold fs-5">4.3 / 5</div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card card-modern border-0 p-3">
                        <div class="d-flex align-items-center">
                            <div class="bg-primary bg-opacity-10 rounded-circle d-flex align-items-center justify-content-center me-3"
                                style="width:48px;height:48px">
                                <i class="fas fa-comments text-primary fa-lg"></i>
                            </div>
                            <div>
                                <div class="text-muted small">Total Reviews</div>
                                <div class="fw-bold fs-5">47</div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card card-modern border-0 p-3">
                        <div class="d-flex align-items-center">
                            <div class="bg-success bg-opacity-10 rounded-circle d-flex align-items-center justify-content-center me-3"
                                style="width:48px;height:48px">
                                <i class="fas fa-thumbs-up text-success fa-lg"></i>
                            </div>
                            <div>
                                <div class="text-muted small">5-Star Reviews</div>
                                <div class="fw-bold fs-5">28</div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card card-modern border-0 p-3">
                        <div class="d-flex align-items-center">
                            <div class="bg-danger bg-opacity-10 rounded-circle d-flex align-items-center justify-content-center me-3"
                                style="width:48px;height:48px">
                                <i class="fas fa-exclamation-triangle text-danger fa-lg"></i>
                            </div>
                            <div>
                                <div class="text-muted small">Low Ratings (1-2)</div>
                                <div class="fw-bold fs-5">3</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Reviews Table -->
            <div class="card card-modern border-0">
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead class="table-light">
                                <tr>
                                    <th>Customer</th>
                                    <th>Vehicle</th>
                                    <th>Rating</th>
                                    <th>Review</th>
                                    <th>Date</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody id="reviewTableBody">
                                <tr>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <div class="bg-light rounded-circle d-flex align-items-center justify-content-center me-2"
                                                style="width:32px;height:32px;font-size:12px;font-weight:bold">JD</div>
                                            <div>
                                                <div class="fw-bold">John Doe</div>
                                                <div class="small text-muted">john@example.com</div>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <span class="badge bg-light text-dark border">Toyota Corolla</span>
                                    </td>
                                    <td>
                                        <div class="text-warning">
                                            <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i>
                                        </div>
                                        <span class="small text-muted">5.0</span>
                                    </td>
                                    <td class="text-muted small" style="max-width:250px">Excellent car condition and smooth process. Highly recommended!</td>
                                    <td class="text-muted small">22 Mar 2026</td>
                                    <td>
                                        <button class="btn btn-sm btn-outline-info me-1" title="View" data-bs-toggle="modal"
                                            data-bs-target="#viewReviewModal"><i class="fas fa-eye"></i></button>
                                        <button class="btn btn-sm btn-outline-danger" title="Delete"><i class="fas fa-trash"></i></button>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <div class="bg-light rounded-circle d-flex align-items-center justify-content-center me-2"
                                                style="width:32px;height:32px;font-size:12px;font-weight:bold">SM</div>
                                            <div>
                                                <div class="fw-bold">Sarah Miller</div>
                                                <div class="small text-muted">sarah@example.com</div>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <span class="badge bg-light text-dark border">Honda Civic</span>
                                    </td>
                                    <td>
                                        <div class="text-warning">
                                            <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i>
                                        </div>
                                        <span class="small text-muted">3.0</span>
                                    </td>
                                    <td class="text-muted small" style="max-width:250px">Car was okay but the AC wasn't cooling enough.</td>
                                    <td class="text-muted small">20 Mar 2026</td>
                                    <td>
                                        <button class="btn btn-sm btn-outline-info me-1" title="View"><i class="fas fa-eye"></i></button>
                                        <button class="btn btn-sm btn-outline-danger" title="Delete"><i class="fas fa-trash"></i></button>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <div class="bg-light rounded-circle d-flex align-items-center justify-content-center me-2"
                                                style="width:32px;height:32px;font-size:12px;font-weight:bold">RP</div>
                                            <div>
                                                <div class="fw-bold">Ravi Patel</div>
                                                <div class="small text-muted">ravi@example.com</div>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <span class="badge bg-light text-dark border">Nissan X-Trail</span>
                                    </td>
                                    <td>
                                        <div class="text-warning">
                                            <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="far fa-star"></i>
                                        </div>
                                        <span class="small text-muted">4.0</span>
                                    </td>
                                    <td class="text-muted small" style="max-width:250px">Great SUV for family trips. Spacious and comfortable. Minor delay at pickup.</td>
                                    <td class="text-muted small">18 Mar 2026</td>
                                    <td>
                                        <button class="btn btn-sm btn-outline-info me-1" title="View"><i class="fas fa-eye"></i></button>
                                        <button class="btn btn-sm btn-outline-danger" title="Delete"><i class="fas fa-trash"></i></button>
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

        <!-- ===== VIEW REVIEW MODAL ===== -->
        <div class="modal fade" id="viewReviewModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header bg-info text-white">
                        <h5 class="modal-title"><i class="fas fa-star me-2"></i>Review Details</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="text-center mb-3">
                            <div class="bg-light rounded-circle d-inline-flex align-items-center justify-content-center mb-2"
                                style="width:60px;height:60px;font-size:18px;font-weight:bold">JD</div>
                            <h5 class="fw-bold mb-0">John Doe</h5>
                            <span class="text-muted small">john@example.com</span>
                        </div>
                        <div class="card bg-light border-0 p-3 mb-3">
                            <p class="mb-1"><strong>Vehicle:</strong> Toyota Corolla 2024</p>
                            <p class="mb-1"><strong>Date:</strong> 22 Mar 2026</p>
                            <p class="mb-0"><strong>Rating:</strong>
                                <span class="text-warning ms-1">
                                    <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i>
                                </span> (5.0)
                            </p>
                        </div>
                        <h6 class="fw-bold">Review</h6>
                        <p class="text-secondary">Excellent car condition and smooth process. The vehicle was clean and ready on time. Highly recommended for anyone looking for a reliable rental service!</p>
                    </div>
                    <div class="modal-footer justify-content-between">
                        <button type="button" class="btn btn-outline-danger"><i class="fas fa-trash me-1"></i>Delete Review</button>
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
