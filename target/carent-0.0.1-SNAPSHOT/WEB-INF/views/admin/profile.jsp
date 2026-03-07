<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ include file="components/adminHeader.jsp" %>

        <main class="container my-5">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="card card-modern border-0 p-5">
                        <div class="text-center mb-5">
                            <div class="bg-dark text-white rounded-circle d-flex align-items-center justify-content-center mx-auto mb-3"
                                style="width: 100px; height: 100px; font-size: 2.5rem;">
                                <i class="fas fa-user-shield"></i>
                            </div>
                            <h3 class="fw-bold">Administrator</h3>
                            <p class="text-muted">Super Admin Access</p>
                        </div>

                        <form>
                            <div class="row g-4">
                                <div class="col-md-6">
                                    <label class="form-label fw-bold small text-muted">FULL NAME</label>
                                    <input type="text" class="form-control bg-light border-0" value="John Admin">
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label fw-bold small text-muted">EMAIL ADDRESS</label>
                                    <input type="email" class="form-control bg-light border-0"
                                        value="admin@easyrental.com">
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label fw-bold small text-muted">PHONE NUMBER</label>
                                    <input type="tel" class="form-control bg-light border-0" value="+94 11 234 5678">
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label fw-bold small text-muted">ROLE</label>
                                    <input type="text" class="form-control bg-light border-0" value="Super Admin"
                                        disabled>
                                </div>
                            </div>

                            <hr class="my-5">

                            <h5 class="fw-bold mb-4">Security Settings</h5>
                            <div class="row g-4 mb-4">
                                <div class="col-md-6">
                                    <label class="form-label fw-bold small text-muted">CURRENT PASSWORD</label>
                                    <input type="password" class="form-control bg-light border-0">
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label fw-bold small text-muted">NEW PASSWORD</label>
                                    <input type="password" class="form-control bg-light border-0">
                                </div>
                            </div>

                            <div class="text-end">
                                <button type="submit" class="btn btn-primary px-4">Update Profile</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </main>

        <%@ include file="components/adminFooter.jsp" %>