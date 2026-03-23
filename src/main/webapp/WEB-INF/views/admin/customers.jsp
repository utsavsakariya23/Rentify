<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ include file="components/adminHeader.jsp" %>

        <main class="container-fluid">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="fw-bold">Customer Management</h2>
                <div class="input-group" style="width: 280px;">
                    <input type="text" class="form-control" id="customerSearch" placeholder="Search customer..."
                        onkeyup="searchTable('customerSearch', 'customerTableBody')">
                    <button class="btn btn-outline-secondary"><i class="fas fa-search"></i></button>
                </div>
            </div>

            <div class="card card-modern border-0">
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead class="table-light">
                                <tr>
                                    <th>User ID</th>
                                    <th>Name</th>
                                    <th>Email</th>
                                    <th>Phone</th>
                                    <th>NIC/License</th>
                                    <th>Date Joined</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody id="customerTableBody">
                                <tr>
                                    <td class="fw-bold">#USR-5501</td>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <div class="bg-light rounded-circle d-flex align-items-center justify-content-center me-2"
                                                style="width:32px;height:32px"><i class="fas fa-user text-primary"></i></div>
                                            <span>John Doe</span>
                                        </div>
                                    </td>
                                    <td>john@example.com</td>
                                    <td>077 123 4567</td>
                                    <td>951234567V</td>
                                    <td>12 Jan 2024</td>
                                    <td><span class="badge bg-success">Active</span></td>
                                    <td>
                                        <button class="btn btn-sm btn-outline-info me-1" title="View Details"
                                            data-bs-toggle="modal" data-bs-target="#viewCustomerModal1"><i
                                                class="fas fa-eye"></i></button>
                                        <button class="btn btn-sm btn-outline-danger" title="Ban User"><i
                                                class="fas fa-ban"></i></button>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="fw-bold">#USR-5502</td>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <div class="bg-light rounded-circle d-flex align-items-center justify-content-center me-2"
                                                style="width:32px;height:32px"><i class="fas fa-user text-secondary"></i></div>
                                            <span>Jane Smith</span>
                                        </div>
                                    </td>
                                    <td>jane@example.com</td>
                                    <td>071 987 6543</td>
                                    <td>987654321V</td>
                                    <td>15 Feb 2024</td>
                                    <td><span class="badge bg-success">Active</span></td>
                                    <td>
                                        <button class="btn btn-sm btn-outline-info me-1" title="View Details"
                                            data-bs-toggle="modal" data-bs-target="#viewCustomerModal2"><i
                                                class="fas fa-eye"></i></button>
                                        <button class="btn btn-sm btn-outline-danger" title="Ban User"><i
                                                class="fas fa-ban"></i></button>
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

        <!-- ===== VIEW CUSTOMER MODAL 1 ===== -->
        <div class="modal fade" id="viewCustomerModal1" tabindex="-1">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header bg-info text-white">
                        <h5 class="modal-title"><i class="fas fa-user me-2"></i>Customer Details</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="text-center mb-4">
                            <div class="d-inline-flex align-items-center justify-content-center bg-light rounded-circle mb-3"
                                style="width:80px;height:80px">
                                <i class="fas fa-user fa-2x text-primary"></i>
                            </div>
                            <h4 class="fw-bold">John Doe</h4>
                            <span class="badge bg-success">Active</span>
                        </div>
                        <div class="row g-3">
                            <div class="col-md-6">
                                <div class="card bg-light border-0 p-3">
                                    <h6 class="fw-bold text-primary mb-3"><i class="fas fa-id-card me-2"></i>Personal Info</h6>
                                    <p class="mb-1"><strong>User ID:</strong> #USR-5501</p>
                                    <p class="mb-1"><strong>Email:</strong> john@example.com</p>
                                    <p class="mb-1"><strong>Phone:</strong> 077 123 4567</p>
                                    <p class="mb-0"><strong>NIC/License:</strong> 951234567V</p>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="card bg-light border-0 p-3">
                                    <h6 class="fw-bold text-primary mb-3"><i class="fas fa-chart-bar me-2"></i>Activity</h6>
                                    <p class="mb-1"><strong>Joined:</strong> 12 Jan 2024</p>
                                    <p class="mb-1"><strong>Total Rentals:</strong> 5</p>
                                    <p class="mb-1"><strong>Total Spent:</strong> Rs. 45,000</p>
                                    <p class="mb-0"><strong>Last Rental:</strong> 20 Mar 2026</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-outline-danger"><i class="fas fa-ban me-1"></i>Ban User</button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- ===== VIEW CUSTOMER MODAL 2 ===== -->
        <div class="modal fade" id="viewCustomerModal2" tabindex="-1">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header bg-info text-white">
                        <h5 class="modal-title"><i class="fas fa-user me-2"></i>Customer Details</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="text-center mb-4">
                            <div class="d-inline-flex align-items-center justify-content-center bg-light rounded-circle mb-3"
                                style="width:80px;height:80px">
                                <i class="fas fa-user fa-2x text-secondary"></i>
                            </div>
                            <h4 class="fw-bold">Jane Smith</h4>
                            <span class="badge bg-success">Active</span>
                        </div>
                        <div class="row g-3">
                            <div class="col-md-6">
                                <div class="card bg-light border-0 p-3">
                                    <h6 class="fw-bold text-primary mb-3"><i class="fas fa-id-card me-2"></i>Personal Info</h6>
                                    <p class="mb-1"><strong>User ID:</strong> #USR-5502</p>
                                    <p class="mb-1"><strong>Email:</strong> jane@example.com</p>
                                    <p class="mb-1"><strong>Phone:</strong> 071 987 6543</p>
                                    <p class="mb-0"><strong>NIC/License:</strong> 987654321V</p>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="card bg-light border-0 p-3">
                                    <h6 class="fw-bold text-primary mb-3"><i class="fas fa-chart-bar me-2"></i>Activity</h6>
                                    <p class="mb-1"><strong>Joined:</strong> 15 Feb 2024</p>
                                    <p class="mb-1"><strong>Total Rentals:</strong> 3</p>
                                    <p class="mb-1"><strong>Total Spent:</strong> Rs. 28,500</p>
                                    <p class="mb-0"><strong>Last Rental:</strong> 10 Mar 2026</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-outline-danger"><i class="fas fa-ban me-1"></i>Ban User</button>
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