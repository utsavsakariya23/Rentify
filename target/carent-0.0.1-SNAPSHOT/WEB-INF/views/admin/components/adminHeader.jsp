<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <title>Admin - Easy Rental</title>

        <link rel="icon" href="${pageContext.request.contextPath}/assets/img/icon.png" type="image/x-icon">

        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/modern-global.css">
        <!-- Use Global CSS -->

        <style>
            .admin-nav .nav-link {
                color: #333 !important;
                /* Dark text */
                font-size: 0.9rem;
                font-weight: 500;
            }

            .admin-nav .nav-link:hover,
            .admin-nav .nav-link.active {
                color: var(--primary-color) !important;
                background: rgba(0, 0, 0, 0.05);
                /* Light hover effect */
                border-radius: 5px;
            }
        </style>
    </head>

    <body class="bg-light">
        <nav class="navbar navbar-expand-lg navbar-custom shadow-sm sticky-top">
            <div class="container-fluid">
                <a class="navbar-brand fw-bold text-dark" href="${pageContext.request.contextPath}/admin/dashboard">
                    <i class="fas fa-user-shield me-2 text-primary"></i>Admin Panel
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#adminNav">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="adminNav">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0 admin-nav">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard"><i
                                    class="fas fa-tachometer-alt me-1"></i> Dashboard</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/vehicles"><i
                                    class="fas fa-car me-1"></i> Vehicles</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/rent"><i
                                    class="fas fa-list-alt me-1"></i> Requests</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/customers"><i
                                    class="fas fa-users me-1"></i> Customers</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/coupons"><i
                                    class="fas fa-tags me-1"></i> Coupons</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/notifications"><i
                                    class="fas fa-bell me-1"></i> Notifications</a>
                        </li>
                    </ul>
                    <div class="d-flex align-items-center">
                        <a href="${pageContext.request.contextPath}/admin/profile"
                            class="text-dark text-decoration-none me-3 small">
                            <i class="fas fa-user-circle fa-lg"></i> Admin
                        </a>
                        <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-dark btn-sm"><i
                                class="fas fa-sign-out-alt me-1"></i> Exit</a>
                    </div>
                </div>
            </div>
        </nav>