<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ include file="components/adminHeader.jsp" %>

        <main class="container-fluid my-5">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="fw-bold">Customer Management</h2>
                <div class="input-group w-25">
                    <input type="text" class="form-control" placeholder="Search customer...">
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
                            <tbody>
                                <tr>
                                    <td>#USR-5501</td>
                                    <td>John Doe</td>
                                    <td>john@example.com</td>
                                    <td>077 123 4567</td>
                                    <td>951234567V</td>
                                    <td>12 Jan 2024</td>
                                    <td><span class="badge bg-success">Active</span></td>
                                    <td>
                                        <button class="btn btn-sm btn-outline-primary" title="View Details"><i
                                                class="fas fa-eye"></i></button>
                                        <button class="btn btn-sm btn-outline-danger" title="Ban User"><i
                                                class="fas fa-ban"></i></button>
                                    </td>
                                </tr>
                                <tr>
                                    <td>#USR-5502</td>
                                    <td>Jane Smith</td>
                                    <td>jane@example.com</td>
                                    <td>071 987 6543</td>
                                    <td>987654321V</td>
                                    <td>15 Feb 2024</td>
                                    <td><span class="badge bg-success">Active</span></td>
                                    <td>
                                        <button class="btn btn-sm btn-outline-primary" title="View Details"><i
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

        <%@ include file="components/adminFooter.jsp" %>