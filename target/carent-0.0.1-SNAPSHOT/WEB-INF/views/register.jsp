<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ include file="components/header.jsp" %>

        <main class="d-flex align-items-center" style="min-height: 80vh; padding-top: 80px; background-color: #f8f9fa;">
            <div class="container my-5">
                <div class="row justify-content-center">
                    <div class="col-lg-8">
                        <div class="card card-modern border-0 p-5 shadow-lg">
                            <div class="text-center mb-5">
                                <h3 class="fw-bold text-dark">Create Account</h3>
                                <p class="text-muted">Join us today and start your journey</p>
                            </div>

                            <form id="registerForm">
                                <div class="row g-4">
                                    <!-- Personal Details -->
                                    <div class="col-md-6">
                                        <h6 class="text-primary fw-bold text-uppercase mb-3">Personal Details</h6>

                                        <div class="mb-3">
                                            <label class="form-label small fw-bold">FULL NAME</label>
                                            <input type="text" class="form-control bg-light border-0"
                                                placeholder="John Doe">
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label small fw-bold">EMAIL ADDRESS</label>
                                            <input type="email" class="form-control bg-light border-0"
                                                placeholder="john@example.com">
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label small fw-bold">PHONE NUMBER</label>
                                            <input type="tel" class="form-control bg-light border-0"
                                                placeholder="+94 77 123 4567">
                                        </div>
                                    </div>

                                    <!-- Account & Identification -->
                                    <div class="col-md-6">
                                        <h6 class="text-primary fw-bold text-uppercase mb-3">Account Setup</h6>

                                        <div class="mb-3">
                                            <label class="form-label small fw-bold">USERNAME</label>
                                            <input type="text" class="form-control bg-light border-0"
                                                placeholder="Choose username">
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label small fw-bold">PASSWORD</label>
                                            <input type="password" class="form-control bg-light border-0"
                                                placeholder="Create password">
                                        </div>

                                        <div class="mb-3">
                                            <label class="form-label small fw-bold">NIC / PASSPORT / LICENSE NO</label>
                                            <input type="text" class="form-control bg-light border-0"
                                                placeholder="Identity Number">
                                        </div>
                                    </div>

                                    <!-- Documents Upload -->
                                    <div class="col-12 mt-4">
                                        <h6 class="text-primary fw-bold text-uppercase mb-3">Verification Documents</h6>
                                        <div class="row g-3">
                                            <div class="col-md-4">
                                                <div class="border rounded p-3 text-center bg-light">
                                                    <i class="fas fa-id-card fa-2x text-muted mb-2"></i>
                                                    <label class="d-block small fw-bold mb-1">ID Front</label>
                                                    <input type="file" class="form-control form-control-sm">
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="border rounded p-3 text-center bg-light">
                                                    <i class="fas fa-id-card fa-2x text-muted mb-2"></i>
                                                    <label class="d-block small fw-bold mb-1">ID Back</label>
                                                    <input type="file" class="form-control form-control-sm">
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="border rounded p-3 text-center bg-light">
                                                    <i class="far fa-id-badge fa-2x text-muted mb-2"></i>
                                                    <label class="d-block small fw-bold mb-1">Driving License</label>
                                                    <input type="file" class="form-control form-control-sm">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="mt-5 text-end">
                                    <button type="submit"
                                        class="btn btn-primary-custom px-5 py-3 btn-lg fw-bold shadow">Register
                                        Account</button>
                                </div>

                                <div class="text-center mt-4">
                                    <span class="text-muted small">Already have an account?</span>
                                    <a href="${pageContext.request.contextPath}/login"
                                        class="fw-bold text-decoration-none ms-1">Login Here</a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <%@ include file="components/footer.jsp" %>