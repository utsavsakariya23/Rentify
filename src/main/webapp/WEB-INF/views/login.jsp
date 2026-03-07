<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ include file="components/header.jsp" %>

        <main class="d-flex align-items-center" style="min-height: 80vh; padding-top: 80px; background-color: #f8f9fa;">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-md-5 col-lg-4">
                        <div class="card card-modern border-0 p-4 shadow-lg">
                            <div class="text-center mb-4">
                                <h3 class="fw-bold text-dark">Welcome Back</h3>
                                <p class="text-muted small">Please login to your account</p>
                            </div>

                            <form action="${pageContext.request.contextPath}/perform_login" method="post">
                                <div class="mb-3">
                                    <label class="form-label small fw-bold text-muted">USERNAME</label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-white border-end-0"><i
                                                class="fas fa-user text-primary"></i></span>
                                        <input type="text" class="form-control border-start-0 ps-0" name="username"
                                            placeholder="Enter username" required>
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label small fw-bold text-muted">PASSWORD</label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-white border-end-0"><i
                                                class="fas fa-lock text-primary"></i></span>
                                        <input type="password" class="form-control border-start-0 ps-0" name="password"
                                            placeholder="Enter password">
                                    </div>
                                    <div class="text-end mt-2">
                                        <a href="#" class="small text-decoration-none text-primary"
                                            data-bs-toggle="modal" data-bs-target="#forgotPasswordModal">Forgot
                                            Password?</a>
                                    </div>
                                </div>

                                <button type="submit" class="btn btn-primary-custom w-100 py-2 mb-3 shadow">LOG
                                    IN</button>

                                <div class="text-center">
                                    <span class="text-muted small">Don't have an account?</span>
                                    <a href="${pageContext.request.contextPath}/register"
                                        class="fw-bold text-decoration-none ms-1">Register Now</a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <!-- Forgot Password Modal -->
        <div class="modal fade" id="forgotPasswordModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title fw-bold">Reset Password</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <p class="text-muted small">Enter your email address to receive a password reset link.</p>
                        <div class="mb-3">
                            <label class="form-label">Email Address</label>
                            <input type="email" class="form-control" placeholder="user@example.com">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
                        <button type="button" class="btn btn-primary-custom">Send Link</button>
                    </div>
                </div>
            </div>
        </div>

        <%@ include file="components/footer.jsp" %>