<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="components/adminHeader.jsp" %>

<main class="container my-5" onload="loadRentRequest()">
    <section>
        <div class="container">
            <form id="driverForm">
                <div class="row">
                    <div class="col-md-4">
                        <div class="form-group mb-3">
                            <label for="rentRequestDriver" class="fw-bold">Driver</label>
                            <input type="text" class="form-control" id="rentRequestDriver" name="driver"
                                   placeholder="Driver ID" required>
                        </div>
                        <div class="form-group mb-3">
                            <label for="rentRequestCarRegNo" class="fw-bold">Car Reg no</label>
                            <input type="text" class="form-control" id="rentRequestCarRegNo" name="driver"
                                   placeholder="Car Register No" required>
                        </div>

                    </div>
                    <div class="col-md-4">
                        <div class="form-group mb-3">
                            <label for="rentRequestCustomer" class="fw-bold">Customer Id</label>
                            <input type="text" class="form-control" id="rentRequestCustomer" name="customer"
                                   placeholder="Customer ID" required>
                        </div>
                        <div class="form-group mb-3">
                            <label for="loosDamage" class="fw-bold">Loss Damage</label>
                            <input type="text" class="form-control" id="loosDamage" name="rentRequestRentId"
                                   placeholder="Loss Damage" required>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group mb-3">
                            <label for="rentRequestRentId" class="fw-bold">Rent Id</label>
                            <input type="text" class="form-control" id="rentRequestRentId" name="rentRequestRentId"
                                   placeholder="Rent ID" required>
                        </div>
                    </div>
                </div>
                <button type="button" class="btn btn-primary fw-bold" id="acceptRentRequest">Accept</button>
                <button type="button" class="btn btn-danger fw-bold" id="driverDelete">Reject</button>
                <button type="button" class="btn btn-secondary fw-bold" id="driverUpdate">Return</button>
                <button type="button" class="btn btn-warning fw-bold" id="updateRent">Update</button>
            </form>
        </div>
    </section>

    <section id="rentRequestTable" class="mt-4">
        <div class="container">
            <h2>Rent Information</h2>
            <table class="table table-bordered" id="requestTable">
                <thead>
                <tr>
                    <th>Rent ID</th>
                    <th>Car ID</th>
                    <th>Customer ID</th>
                    <th>Driver ID</th>
                    <th>Pick Date</th>
                    <th>Pick Place</th>
                    <th>Return Time</th>
                    <th>Return place</th>
                    <th>Status</th>
                    <th>Date</th>
                </tr>
                </thead>
                <tbody id="rentRequestTableBody">
                <!-- Filled dynamically -->
                </tbody>
            </table>
        </div>
    </section>
</main>

<script src="${pageContext.request.contextPath}/assets/controller/rentRequest.js"></script>

<%@ include file="components/adminFooter.jsp" %>