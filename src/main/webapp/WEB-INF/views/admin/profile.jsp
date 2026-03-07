<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <title>Admin Profile - Easy Rental</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.min.css">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/modern-global.css">
        </head>

        <body class="bg-light">

            <%@ include file="components/adminHeader.jsp" %>

                <div class="container mt-4">
                    <div class="row justify-content-center">
                        <div class="col-md-8">
                            <div class="card border-0 shadow-sm">
                                <div class="card-header bg-white py-3">
                                    <h5 class="mb-0 fw-bold"><i class="fas fa-user-circle text-primary me-2"></i>Admin
                                        Profile</h5>
                                </div>
                                <div class="card-body p-4">
                                    <div class="text-center mb-4">
                                        <div class="display-1 text-secondary mb-3"><i class="fas fa-user-circle"></i>
                                        </div>
                                        <h3 class="fw-bold">Admin User</h3>
                                        <span class="badge bg-primary">Administrator</span>
                                    </div>

                                    <div class="row g-3">
                                        <div class="col-md-6">
                                            <label class="form-label text-muted small">USERNAME</label>
                                            <input type="text" class="form-control" value="${sessionScope.user}"
                                                readonly>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label text-muted small">EMAIL</label>
                                            <input type="text" class="form-control" value="admin@easyrental.com"
                                                readonly>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label text-muted small">ROLE</label>
                                            <input type="text" class="form-control" value="Super Admin" readonly>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label text-muted small">JOINED DATE</label>
                                            <input type="text" class="form-control" value="Jan 01, 2024" readonly>
                                        </div>
                                    </div>

                                    <div class="d-flex justify-content-end mt-4">
                                        <button class="btn btn-outline-primary me-2" data-bs-toggle="modal"
                                            data-bs-target="#editProfileModal">
                                            <i class="fas fa-edit me-1"></i> Edit Profile
                                        </button>
                                        <button class="btn btn-primary-custom" data-bs-toggle="modal"
                                            data-bs-target="#changePasswordModal">
                                            <i class="fas fa-key me-1"></i> Change Password
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Change Password Modal -->
                <div class="modal fade" id="changePasswordModal" tabindex="-1">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Change Password</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>
                            <div class="modal-body">
                                <form>
                                    <div class="mb-3">
                                        <label class="form-label">Current Password</label>
                                        <input type="password" class="form-control">
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">New Password</label>
                                        <input type="password" class="form-control">
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Confirm New Password</label>
                                        <input type="password" class="form-control">
                                    </div>
                                </form>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
                                <button type="button" class="btn btn-primary-custom">Update Password</button>
                            </div>
                        </div>
                    </div>
                </div>

                <script src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>