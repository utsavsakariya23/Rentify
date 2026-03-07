<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ include file="components/adminHeader.jsp" %>

        <main class="container-fluid my-5">
            <h2 class="fw-bold mb-4">Rent Requests</h2>

            <div class="card card-modern border-0">
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead class="table-light">
                                <tr>
                                    <th>Request ID</th>
                                    <th>Customer</th>
                                    <th>Vehicle</th>
                                    <th>Pick-Up</th>
                                    <th>Drop-Off</th>
                                    <th>Total</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>#REN-2001</td>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <div class="bg-primary text-white rounded-circle d-flex align-items-center justify-content-center me-2"
                                                style="width: 30px; height: 30px;">J</div>
                                            John Doe
                                        </div>
                                    </td>
                                    <td>Toyota Corolla (2024)</td>
                                    <td>20 Feb 2026</td>
                                    <td>22 Feb 2026</td>
                                    <td class="fw-bold">Rs. 10,000</td>
                                    <td><span class="badge bg-warning text-dark">Pending</span></td>
                                    <td>
                                        <button class="btn btn-sm btn-success me-1" title="Approve"><i
                                                class="fas fa-check"></i></button>
                                        <button class="btn btn-sm btn-danger" title="Reject"><i
                                                class="fas fa-times"></i></button>
                                    </td>
                                </tr>
                                <tr>
                                    <td>#REN-2000</td>
                                    <td>Sarah Smith</td>
                                    <td>Honda Civic</td>
                                    <td>15 Feb 2026</td>
                                    <td>18 Feb 2026</td>
                                    <td class="fw-bold">Rs. 19,500</td>
                                    <td><span class="badge bg-success">Approved</span></td>
                                    <td>
                                        <button class="btn btn-sm btn-secondary" disabled>Approved</button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </main>

        <%@ include file="components/adminFooter.jsp" %>