<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ include file="components/header.jsp" %>

        <main class="d-flex align-items-center" style="min-height: 80vh; padding-top: 80px; background-color: #f8f9fa;">
            <div class="container my-5">
                <div class="row justify-content-center">
                    <div class="col-lg-7">
                        <div class="card card-modern border-0 p-5 shadow-lg">
                            <div class="text-center mb-5">
                                <h3 class="fw-bold text-dark">Create Account</h3>
                                <p class="text-muted">Join us today and start your journey</p>
                            </div>

                            <% if (request.getParameter("error") != null) { %>
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <i class="fas fa-exclamation-circle me-2"></i>
                                <% String regError = request.getParameter("error");
                                   if ("exists".equals(regError)) { %>
                                    Username or email already exists. Please try different ones.
                                <% } else if ("username_taken".equals(regError)) { %>
                                    This username is already taken. Please choose a different one.
                                <% } else if ("email_taken".equals(regError)) { %>
                                    This email is already registered. Please use a different email.
                                <% } else if ("mismatch".equals(regError)) { %>
                                    Passwords do not match. Please try again.
                                <% } else if ("empty".equals(regError)) { %>
                                    Please fill in all required fields.
                                <% } else { %>
                                    Registration failed: 
                                    <strong><%= request.getParameter("detail") != null ? request.getParameter("detail") : "Unknown error. Check Tomcat console." %></strong>
                                <% } %>
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                            <% } %>

                            <form id="registerForm" action="${pageContext.request.contextPath}/perform_register" method="post">
                                <div class="row g-4">
                                    <!-- Personal Details -->
                                    <div class="col-md-6">
                                        <h6 class="text-primary fw-bold text-uppercase mb-3">Personal Details</h6>

                                        <div class="mb-3">
                                            <label class="form-label small fw-bold">FULL NAME</label>
                                            <input type="text" class="form-control bg-light border-0" name="fullName"
                                                placeholder="Enter your Name" required>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label small fw-bold">EMAIL ADDRESS</label>
                                            <input type="email" class="form-control bg-light border-0" name="email"
                                                placeholder="Enter your Email" required>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label small fw-bold">PHONE NUMBER</label>
                                            <input type="tel" class="form-control bg-light border-0" name="phone"
                                                placeholder="Enter your Phone" required>
                                        </div>
                                    </div>

                                    <!-- Account Setup -->
                                    <div class="col-md-6">
                                        <h6 class="text-primary fw-bold text-uppercase mb-3">Account Setup</h6>

                                        <div class="mb-3">
                                            <label class="form-label small fw-bold">USERNAME</label>
                                            <input type="text" class="form-control bg-light border-0" name="username"
                                                placeholder="Choose username" required>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label small fw-bold">PASSWORD</label>
                                            <input type="password" class="form-control bg-light border-0" name="password"
                                                placeholder="Create password" required>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label small fw-bold">CONFIRM PASSWORD</label>
                                            <input type="password" class="form-control bg-light border-0" name="confirmPassword"
                                                placeholder="Confirm password" required>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label small fw-bold">LICENSE NO</label>
                                            <input type="text" class="form-control bg-light border-0" name="licenseNo"
                                                placeholder="Driving License Number" required>
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

        <script src="${pageContext.request.contextPath}/assets/js/validation.js"></script>
        <%@ include file="components/footer.jsp" %>