<!-- ========== ADMIN SIDEBAR ========== -->
<aside class="admin-sidebar" id="adminSidebar">

    <!-- Brand / Logo -->
    <div class="sidebar-brand">
        <i class="fas fa-car-side" style="font-size: 1.6rem; color: var(--sidebar-accent);"></i>
        <div class="brand-text"><span>RENTIFY</span></div>
    </div>

    <!-- Navigation -->
    <nav class="sidebar-nav">
        <div class="nav-label">Main</div>
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard" data-title="Dashboard">
                    <i class="fas fa-tachometer-alt"></i>
                    <span>Dashboard</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/vehicles" data-title="Vehicles">
                    <i class="fas fa-car"></i>
                    <span>Vehicles</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/rent" data-title="Requests">
                    <i class="fas fa-list-alt"></i>
                    <span>Requests</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/customers" data-title="Customers">
                    <i class="fas fa-users"></i>
                    <span>Customers</span>
                </a>
            </li>
        </ul>

        <div class="nav-label">Management</div>
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/coupons" data-title="Coupons">
                    <i class="fas fa-tags"></i>
                    <span>Coupons</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/messages" data-title="Messages">
                    <i class="fas fa-envelope"></i>
                    <span>Messages</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/reviews" data-title="Reviews">
                    <i class="fas fa-star"></i>
                    <span>Reviews</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/notifications" data-title="Notifications">
                    <i class="fas fa-bell"></i>
                    <span>Notifications</span>
                </a>
            </li>
        </ul>

        <div class="nav-label">Account</div>
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/profile" data-title="Profile">
                    <i class="fas fa-user-circle"></i>
                    <span>Profile</span>
                </a>
            </li>
        </ul>
    </nav>

    <!-- Footer Navigation -->
    <div class="sidebar-footer d-flex flex-column gap-2">
        <a href="${pageContext.request.contextPath}/home" class="btn-logout" style="background: rgba(255, 255, 255, 0.1); color: inherit;">
            <i class="fas fa-globe"></i>
            <span>Back to Website</span>
        </a>
        <a href="${pageContext.request.contextPath}/logout" class="btn-logout">
            <i class="fas fa-sign-out-alt"></i>
            <span>Logout</span>
        </a>
    </div>

</aside>