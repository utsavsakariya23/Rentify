<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ include file="components/header.jsp" %>

        <main class="container my-5 pt-5">
            <div class="row">
                <!-- Sidebar Navigation -->
                <div class="col-md-3 mb-4">
                    <div class="glass-panel p-3 rounded-3 sticky-top" style="top: 100px;">
                        <div class="text-center mb-4">
                            <div class="bg-primary text-white rounded-circle d-flex align-items-center justify-content-center mx-auto mb-2"
                                style="width: 80px; height: 80px; font-size: 2rem;">
                                <i class="fas fa-user"></i>
                            </div>
                            <h5 class="fw-bold mb-0">
                                <%= session.getAttribute("loggedUser") != null ? ((com.carent.model.User)session.getAttribute("loggedUser")).getFullName() : "Guest" %>
                            </h5>
                            <c:choose>
                                <c:when test="${sessionScope.role == 'Admin'}">
                                    <span class="badge bg-info text-dark mt-1"><i class="fas fa-hammer me-1"></i> Administrator</span>
                                </c:when>
                                <c:otherwise>
                                    <small class="text-muted">Member since 2024</small>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <div class="list-group list-group-flush">
                            <a href="#profile" class="list-group-item list-group-item-action active"
                                data-bs-toggle="list">
                                <i class="fas fa-user-circle me-2"></i> My Profile
                            </a>
                            <a href="#documents" class="list-group-item list-group-item-action" data-bs-toggle="list">
                                <i class="fas fa-file-alt me-2"></i> Documents
                                <% com.carent.model.User navUser = (com.carent.model.User) session.getAttribute("loggedUser");
                                   boolean navHasId = navUser != null && navUser.getIdUrl() != null && !navUser.getIdUrl().trim().isEmpty();
                                   boolean navHasLicense = navUser != null && navUser.getLicenseUrl() != null && !navUser.getLicenseUrl().trim().isEmpty();
                                   if (!navHasId || !navHasLicense) { %>
                                <span class="badge bg-warning text-dark rounded-pill float-end">Pending</span>
                                <% } else { %>
                                <span class="badge bg-success rounded-pill float-end"><i class="fas fa-check"></i></span>
                                <% } %>
                            </a>
                            <a href="#bookings" class="list-group-item list-group-item-action" data-bs-toggle="list">
                                <i class="fas fa-calendar-alt me-2"></i> My Bookings
                            </a>
                            <a href="#expenses" class="list-group-item list-group-item-action" data-bs-toggle="list">
                                <i class="fas fa-wallet me-2"></i> My Expenses
                            </a>
                            <a href="#notifications" class="list-group-item list-group-item-action"
                                data-bs-toggle="list">
                                <i class="fas fa-bell me-2"></i> Notifications
                                <c:if test="${not empty userNotifications}">
                                    <span class="badge bg-danger rounded-pill float-end">${userNotifications.size()}</span>
                                </c:if>
                            </a>
                            <a href="${pageContext.request.contextPath}/logout"
                                class="list-group-item list-group-item-action text-danger">
                                <i class="fas fa-sign-out-alt me-2"></i> Logout
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Main Content -->
                <div class="col-md-9">
                    <div class="tab-content">
                        <!-- Profile Section -->
                        <div class="tab-pane fade show active" id="profile">
                            <div class="card card-modern p-4 mb-4">
                                <h4 class="fw-bold mb-4">Profile Details</h4>

                                <% if ("profile_updated".equals(request.getParameter("success"))) { %>
                                <div class="alert alert-success alert-dismissible fade show" role="alert">
                                    <i class="fas fa-check-circle me-2"></i>Profile updated successfully!
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                </div>
                                <% } %>
                                <% if ("profile_failed".equals(request.getParameter("error"))) { %>
                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    <i class="fas fa-exclamation-circle me-2"></i>Failed to update profile. Please try again.
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                </div>
                                <% } %>

                                <% com.carent.model.User profileUser = (com.carent.model.User) session.getAttribute("loggedUser"); %>

                                <form id="updateProfileForm" action="${pageContext.request.contextPath}/update_profile" method="post" class="needs-validation" novalidate>
                                    <div class="row g-3">
                                        <div class="col-md-6">
                                            <label class="form-label small fw-bold">FULL NAME</label>
                                            <input type="text" class="form-control" name="fullName"
                                                value="<%= profileUser != null ? profileUser.getFullName() : "" %>" required minlength="2" maxlength="50" pattern="^[a-zA-Z\s]+$">
                                            <div class="invalid-feedback">Please enter a valid full name.</div>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label small fw-bold">EMAIL <span class="text-muted">(cannot change)</span></label>
                                            <input type="email" class="form-control bg-light" 
                                                value="<%= profileUser != null ? profileUser.getEmail() : "" %>" readonly>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label small fw-bold">PHONE</label>
                                            <input type="tel" class="form-control" name="phone"
                                                value="<%= profileUser != null ? profileUser.getPhone() : "" %>" required pattern="^[0-9]{10}$" maxlength="10"
                                                oninput="this.value = this.value.replace(/[^0-9]/g, '')" placeholder="Enter 10-digit phone number">
                                            <div class="invalid-feedback">Please enter a valid 10-digit phone number.</div>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label small fw-bold">USERNAME <span class="text-muted">(cannot change)</span></label>
                                            <input type="text" class="form-control bg-light"
                                                value="<%= profileUser != null ? profileUser.getUsername() : "" %>" readonly>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label small fw-bold">LICENSE NO</label>
                                            <input type="text" class="form-control" name="licenseNo"
                                                value="<%= profileUser != null ? profileUser.getLicenseNo() : "" %>" minlength="5" maxlength="20">
                                            <div class="invalid-feedback">Please enter a valid license number.</div>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label small fw-bold">ROLE</label>
                                            <input type="text" class="form-control bg-light"
                                                value="<%= profileUser != null ? profileUser.getRole() : "" %>" readonly>
                                        </div>
                                    </div>
                                    <button type="submit" class="btn btn-primary-custom mt-4">
                                        <i class="fas fa-save me-2"></i>Save Changes
                                    </button>
                                </form>
                            </div>

                            <!-- Change Password Card -->
                            <div class="card card-modern p-4">
                                <h4 class="fw-bold mb-4"><i class="fas fa-key text-primary me-2"></i>Change Password</h4>

                                <% if ("password_changed".equals(request.getParameter("success"))) { %>
                                <div class="alert alert-success alert-dismissible fade show" role="alert">
                                    <i class="fas fa-check-circle me-2"></i>Password changed successfully!
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                </div>
                                <% } %>
                                <% if ("wrong_password".equals(request.getParameter("error"))) { %>
                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    <i class="fas fa-exclamation-circle me-2"></i>Current password is incorrect.
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                </div>
                                <% } %>
                                <% if ("password_mismatch".equals(request.getParameter("error"))) { %>
                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    <i class="fas fa-exclamation-circle me-2"></i>New passwords do not match.
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                </div>
                                <% } %>
                                <% if ("password_failed".equals(request.getParameter("error"))) { %>
                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    <i class="fas fa-exclamation-circle me-2"></i>Failed to change password. Please try again.
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                </div>
                                <% } %>

                                <form id="userChangePasswordForm" action="${pageContext.request.contextPath}/change_password" method="post" class="needs-validation" novalidate>
                                    <div class="row g-3">
                                        <div class="col-md-4">
                                            <label class="form-label small fw-bold">CURRENT PASSWORD</label>
                                            <input type="password" class="form-control" name="currentPassword" 
                                                placeholder="Enter current password" required minlength="8">
                                            <div class="invalid-feedback">Current password is required.</div>
                                        </div>
                                        <div class="col-md-4">
                                            <label class="form-label small fw-bold">NEW PASSWORD</label>
                                            <input type="password" class="form-control" name="newPassword" id="newPassword"
                                                placeholder="Enter new password" required minlength="8">
                                            <div class="invalid-feedback">Password must be at least 8 characters.</div>
                                        </div>
                                        <div class="col-md-4">
                                            <label class="form-label small fw-bold">CONFIRM NEW PASSWORD</label>
                                            <input type="password" class="form-control" name="confirmNewPassword" id="confirmNewPassword"
                                                placeholder="Confirm new password" required minlength="8">
                                            <div class="invalid-feedback">Passwords must match and be at least 8 characters.</div>
                                        </div>
                                    </div>
                                    <button type="submit" class="btn btn-outline-primary mt-4">
                                        <i class="fas fa-lock me-2"></i>Update Password
                                    </button>
                                </form>
                            </div>
                        </div>

                        <!-- Documents Section -->
                        <div class="tab-pane fade" id="documents">
                            <div class="card card-modern p-4">
                                <h4 class="fw-bold mb-2">Document Verification</h4>
                                <p class="text-muted small mb-4">Upload your documents to verify your identity. You must complete verification before you can book a vehicle.</p>

                                <%
                                    boolean hasId = profileUser.getIdUrl() != null && !profileUser.getIdUrl().trim().isEmpty();
                                    boolean hasLicense = profileUser.getLicenseUrl() != null && !profileUser.getLicenseUrl().trim().isEmpty();
                                    boolean docsVerified = hasId && hasLicense;
                                %>

                                <c:choose>
                                    <c:when test="<%= !docsVerified %>">
                                        <div class="alert alert-warning d-flex align-items-center" role="alert">
                                            <i class="fas fa-exclamation-triangle me-3 fa-lg"></i>
                                            <div>
                                                <strong>Verification Required!</strong> Please upload your ID and driving license to start booking vehicles.
                                            </div>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="alert alert-success d-flex align-items-center" role="alert">
                                            <i class="fas fa-check-circle me-3 fa-lg"></i>
                                            <div>
                                                <strong>Verified!</strong> Your documents have been uploaded successfully.
                                            </div>
                                        </div>
                                    </c:otherwise>
                                </c:choose>

                                <div id="uploadAlert" class="alert d-none mt-3"></div>

                                <form id="documentUploadForm" enctype="multipart/form-data">
                                    <div class="row g-4">
                                        <!-- ID Document -->
                                        <div class="col-md-6">
                                            <div class="card border h-100">
                                                <div class="card-body text-center p-4">
                                                    <div class="bg-light rounded-circle d-inline-flex align-items-center justify-content-center mb-3"
                                                        style="width:70px;height:70px">
                                                        <i class="fas fa-id-card fa-2x text-primary"></i>
                                                    </div>
                                                    <h6 class="fw-bold">Government ID</h6>
                                                    <p class="text-muted small">Upload your Aadhar Card, PAN Card, or Passport</p>
                                                    
                                                    <% if (hasId) { %>
                                                        <span class="badge bg-success mb-3"><i class="fas fa-check me-1"></i>Uploaded</span>
                                                        <div class="mt-2 text-center">
                                                            <a href="<%= profileUser.getIdUrl() %>" target="_blank" class="btn btn-sm btn-outline-info">View Document</a>
                                                        </div>
                                                    <% } else { %>
                                                        <span class="badge bg-secondary mb-3"><i class="fas fa-clock me-1"></i>Not Uploaded</span>
                                                        <div>
                                                            <input type="file" class="form-control form-control-sm" id="idFile" name="idFile" accept="image/*,.pdf">
                                                        </div>
                                                    <% } %>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Driving License -->
                                        <div class="col-md-6">
                                            <div class="card border h-100">
                                                <div class="card-body text-center p-4">
                                                    <div class="bg-light rounded-circle d-inline-flex align-items-center justify-content-center mb-3"
                                                        style="width:70px;height:70px">
                                                        <i class="far fa-id-badge fa-2x text-primary"></i>
                                                    </div>
                                                    <h6 class="fw-bold">Driving License</h6>
                                                    <p class="text-muted small">Upload front side of your valid driving license</p>
                                                    
                                                    <% if (hasLicense) { %>
                                                        <span class="badge bg-success mb-3"><i class="fas fa-check me-1"></i>Uploaded</span>
                                                        <div class="mt-2 text-center">
                                                            <a href="<%= profileUser.getLicenseUrl() %>" target="_blank" class="btn btn-sm btn-outline-info">View Document</a>
                                                        </div>
                                                    <% } else { %>
                                                        <span class="badge bg-secondary mb-3"><i class="fas fa-clock me-1"></i>Not Uploaded</span>
                                                        <div>
                                                            <input type="file" class="form-control form-control-sm" id="licenseFile" name="licenseFile" accept="image/*,.pdf">
                                                        </div>
                                                    <% } %>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <% if (!docsVerified) { %>
                                    <div class="text-end mt-4">
                                        <button type="button" id="submitDocsBtn" class="btn btn-primary-custom px-4" onclick="uploadDocuments()">
                                            <i class="fas fa-upload me-2"></i>Submit Documents
                                        </button>
                                    </div>
                                    <!-- Progress Indicator -->
                                    <div id="uploadProgressContainer" class="d-none text-center mt-3">
                                        <div class="spinner-border text-primary" role="status" style="width: 3rem; height: 3rem;">
                                            <span class="visually-hidden">Uploading...</span>
                                        </div>
                                        <div id="uploadProgressText" class="mt-2 fw-bold text-primary">0% Uploaded</div>
                                    </div>
                                    <% } %>
                                </form>
                            </div>
                        </div>

                        <!-- Bookings Section -->
                        <div class="tab-pane fade" id="bookings">
                            <div class="card card-modern p-4">
                                <h4 class="fw-bold mb-4">My Bookings</h4>

                                <ul class="nav nav-tabs mb-4">
                                    <li class="nav-item">
                                        <a class="nav-link active" data-bs-toggle="tab" href="#upcoming">Upcoming</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" data-bs-toggle="tab" href="#past">Past</a>
                                    </li>
                                </ul>

                                <div class="tab-content">
                                    <div class="tab-pane fade show active" id="upcoming">
                                        <c:if test="${empty upcomingBookings}">
                                            <div class="text-center py-4">
                                                <i class="fas fa-calendar-times fa-3x text-muted mb-3"></i>
                                                <p class="text-muted">You have no upcoming bookings.</p>
                                                <a href="${pageContext.request.contextPath}/vehicles" class="btn btn-outline-primary mt-2">Browse Cars</a>
                                            </div>
                                        </c:if>
                                        <c:forEach var="booking" items="${upcomingBookings}">
                                        <div class="card mb-3 border bg-light">
                                            <div class="card-body">
                                                <div class="d-flex justify-content-between align-items-center">
                                                    <div>
                                                        <h6 class="fw-bold mb-1">${booking.carBrand} ${booking.carName}</h6>
                                                        <small class="text-muted">Booking #RENT-${booking.bookingId}</small>
                                                    </div>
                                                    <div>
                                                        <c:choose>
                                                            <c:when test="${booking.bookingStatus == 'Pending'}"><span class="badge bg-warning text-dark me-2">Pending</span></c:when>
                                                            <c:when test="${booking.bookingStatus == 'Confirmed'}"><span class="badge bg-success me-2">Confirmed</span></c:when>
                                                            <c:otherwise><span class="badge bg-secondary me-2">${booking.bookingStatus}</span></c:otherwise>
                                                        </c:choose>
                                                        
                                                        <c:choose>
                                                            <c:when test="${booking.paymentStatus == 'Paid'}"><span class="badge bg-primary"><i class="fas fa-check-circle me-1"></i>Paid</span></c:when>
                                                            <c:otherwise><span class="badge bg-secondary">Unpaid</span></c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </div>
                                                <hr>
                                                <div class="row text-center text-md-start">
                                                    <div class="col-md-3">
                                                        <small class="text-muted d-block">Pick-Up</small>
                                                        <strong>${booking.startDate}</strong>
                                                        <div class="small text-muted"><i class="fas fa-map-marker-alt text-success"></i> ${booking.pickupLocation}</div>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <small class="text-muted d-block">Drop-Off</small>
                                                        <strong>${booking.endDate}</strong>
                                                        <div class="small text-muted"><i class="fas fa-map-marker-alt text-danger"></i> ${booking.dropLocation}</div>
                                                    </div>
                                                    <div class="col-md-3 text-md-end">
                                                        <small class="text-muted d-block">Total</small>
                                                        <strong class="text-primary">Rs. ${booking.finalPrice}</strong>
                                                    </div>
                                                    <div class="col-md-3 text-md-end">
                                                        <c:if test="${(booking.bookingStatus == 'Pending' || booking.bookingStatus == 'Confirmed') && booking.paymentStatus == 'Unpaid'}">
                                                            <button class="btn btn-sm btn-outline-success mt-2" onclick="payNow(${booking.bookingId}, '${sessionScope.loggedUser.fullName}', '${sessionScope.loggedUser.email}', '${sessionScope.loggedUser.phone}')"><i class="fas fa-credit-card"></i> Pay Now</button>
                                                        </c:if>
                                                        <c:if test="${booking.bookingStatus == 'Pending' || booking.bookingStatus == 'Confirmed'}">
                                                            <form action="${pageContext.request.contextPath}/cancel_booking" method="post" class="mt-2" onsubmit="return confirm('Cancel this booking?');">
                                                                <input type="hidden" name="bookingId" value="${booking.bookingId}">
                                                                <button class="btn btn-sm btn-outline-danger"><i class="fas fa-times"></i> Cancel</button>
                                                            </form>
                                                        </c:if>
                                                    </div>
                                                </div>
                                                <div class="mt-2 text-muted small">
                                                    Payment Method: <span class="fw-bold">${empty booking.paymentMethod ? 'Cash' : booking.paymentMethod}</span>
                                                    <c:if test="${not empty booking.transactionId}"> | Txn ID: ${booking.transactionId}</c:if>
                                                </div>
                                                <c:if test="${booking.paymentStatus == 'Paid'}">
                                                <div class="mt-2">
                                                    <a href="${pageContext.request.contextPath}/invoice?bookingId=${booking.bookingId}" class="btn btn-sm btn-outline-primary" target="_blank">
                                                        <i class="fas fa-file-invoice me-1"></i>View Invoice
                                                    </a>
                                                </div>
                                                </c:if>
                                            </div>
                                        </div>
                                        </c:forEach>
                                    </div>

                                    <div class="tab-pane fade" id="past">
                                        <c:if test="${empty pastBookings}">
                                            <div class="text-center py-4">
                                                <p class="text-muted">No past bookings found.</p>
                                            </div>
                                        </c:if>
                                        <c:forEach var="booking" items="${pastBookings}">
                                        <div class="card mb-3 border bg-light opacity-75">
                                            <div class="card-body">
                                                <div class="d-flex justify-content-between align-items-center">
                                                    <div>
                                                        <h6 class="fw-bold mb-1">${booking.carBrand} ${booking.carName}</h6>
                                                        <small class="text-muted">Booking #RENT-${booking.bookingId}</small>
                                                    </div>
                                                    <div>
                                                        <c:choose>
                                                            <c:when test="${booking.bookingStatus == 'Completed'}"><span class="badge bg-success me-2">Completed</span></c:when>
                                                            <c:when test="${booking.bookingStatus == 'Cancelled'}"><span class="badge bg-danger me-2">Cancelled</span></c:when>
                                                            <c:otherwise><span class="badge bg-secondary me-2">${booking.bookingStatus}</span></c:otherwise>
                                                        </c:choose>
                                                        <span class="badge bg-secondary">${booking.paymentStatus}</span>
                                                    </div>
                                                </div>
                                                <hr>
                                                <div class="row text-center text-md-start">
                                                    <div class="col-md-4">
                                                        <small class="text-muted d-block">Pick-Up</small>
                                                        <strong>${booking.startDate}</strong>
                                                        <div class="small text-muted"><i class="fas fa-map-marker-alt text-success"></i> ${booking.pickupLocation}</div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <small class="text-muted d-block">Drop-Off</small>
                                                        <strong>${booking.endDate}</strong>
                                                        <div class="small text-muted"><i class="fas fa-map-marker-alt text-danger"></i> ${booking.dropLocation}</div>
                                                    </div>
                                                    <div class="col-md-4 text-md-end">
                                                        <small class="text-muted d-block">Total</small>
                                                        <strong class="text-primary">Rs. ${booking.finalPrice}</strong>
                                                    </div>
                                                </div>
                                                
                                                <c:if test="${requestScope['canReview_' += booking.bookingId]}">
                                                <div class="text-end mt-3">
                                                    <button class="btn btn-sm btn-outline-primary" onclick="openReviewModal('${booking.bookingId}', '${booking.carId}', '${booking.carName}')">
                                                        <i class="fas fa-star me-1"></i> Write Review
                                                    </button>
                                                </div>
                                                </c:if>
                                                <c:if test="${booking.paymentStatus == 'Paid'}">
                                                <div class="text-end mt-2">
                                                    <a href="${pageContext.request.contextPath}/invoice?bookingId=${booking.bookingId}" class="btn btn-sm btn-outline-info" target="_blank">
                                                        <i class="fas fa-file-invoice me-1"></i>View Invoice
                                                    </a>
                                                </div>
                                                </c:if>
                                            </div>
                                        </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Expenses Tracker Section -->
                        <div class="tab-pane fade" id="expenses">
                            <div class="card card-modern p-4">
                                <h4 class="fw-bold mb-4"><i class="fas fa-wallet me-2 text-primary"></i>My Expenses</h4>

                                <!-- Summary Cards -->
                                <div class="row g-3 mb-4">
                                    <div class="col-md-4">
                                        <div class="border rounded p-3 text-center">
                                            <div class="small text-muted fw-bold">TOTAL SPENT</div>
                                            <h4 class="fw-bold text-primary" id="totalSpent">Rs. 0</h4>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="border rounded p-3 text-center">
                                            <div class="small text-muted fw-bold">TOTAL BOOKINGS</div>
                                            <h4 class="fw-bold text-success" id="totalBookingsCount">0</h4>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="border rounded p-3 text-center">
                                            <div class="small text-muted fw-bold">AVG COST / BOOKING</div>
                                            <h4 class="fw-bold text-warning" id="avgCost">Rs. 0</h4>
                                        </div>
                                    </div>
                                </div>

                                <!-- Expense Table -->
                                <div class="table-responsive">
                                    <table class="table table-hover align-middle">
                                        <thead class="table-light text-uppercase small">
                                            <tr><th>Booking</th><th>Car</th><th>Dates</th><th>Amount</th><th>Payment</th><th>Status</th><th>Invoice</th></tr>
                                        </thead>
                                        <tbody id="expenseTableBody">
                                            <c:set var="totalExpenseAmount" value="0" />
                                            <c:set var="totalExpenseCount" value="0" />
                                            <c:forEach var="booking" items="${upcomingBookings}">
                                                <tr>
                                                    <td class="fw-bold">#RENT-${booking.bookingId}</td>
                                                    <td>${booking.carBrand} ${booking.carName}</td>
                                                    <td class="small">${booking.startDate} → ${booking.endDate}</td>
                                                    <td class="fw-bold text-primary">Rs. ${booking.finalPrice}</td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${booking.paymentStatus == 'Paid'}"><span class="badge bg-success">Paid</span></c:when>
                                                            <c:otherwise><span class="badge bg-secondary">Unpaid</span></c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td><span class="badge bg-warning text-dark">${booking.bookingStatus}</span></td>
                                                    <td>
                                                        <c:if test="${booking.paymentStatus == 'Paid'}">
                                                            <a href="${pageContext.request.contextPath}/invoice?bookingId=${booking.bookingId}" target="_blank" class="btn btn-sm btn-outline-primary"><i class="fas fa-file-invoice"></i></a>
                                                        </c:if>
                                                    </td>
                                                </tr>
                                                <c:set var="totalExpenseCount" value="${totalExpenseCount + 1}" />
                                            </c:forEach>
                                            <c:forEach var="booking" items="${pastBookings}">
                                                <tr class="${booking.bookingStatus == 'Cancelled' ? 'text-muted' : ''}">
                                                    <td class="fw-bold">#RENT-${booking.bookingId}</td>
                                                    <td>${booking.carBrand} ${booking.carName}</td>
                                                    <td class="small">${booking.startDate} → ${booking.endDate}</td>
                                                    <td class="fw-bold text-primary">Rs. ${booking.finalPrice}</td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${booking.paymentStatus == 'Paid'}"><span class="badge bg-success">Paid</span></c:when>
                                                            <c:when test="${booking.paymentStatus == 'Refunded'}"><span class="badge bg-info">Refunded</span></c:when>
                                                            <c:otherwise><span class="badge bg-secondary">Unpaid</span></c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${booking.bookingStatus == 'Completed'}"><span class="badge bg-success">Completed</span></c:when>
                                                            <c:when test="${booking.bookingStatus == 'Cancelled'}"><span class="badge bg-danger">Cancelled</span></c:when>
                                                            <c:otherwise><span class="badge bg-secondary">${booking.bookingStatus}</span></c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <c:if test="${booking.paymentStatus == 'Paid'}">
                                                            <a href="${pageContext.request.contextPath}/invoice?bookingId=${booking.bookingId}" target="_blank" class="btn btn-sm btn-outline-primary"><i class="fas fa-file-invoice"></i></a>
                                                        </c:if>
                                                    </td>
                                                </tr>
                                                <c:set var="totalExpenseCount" value="${totalExpenseCount + 1}" />
                                            </c:forEach>
                                            <c:if test="${totalExpenseCount == 0}">
                                                <tr><td colspan="7" class="text-center text-muted py-4">No bookings found yet.</td></tr>
                                            </c:if>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>

                        <!-- Notifications Section -->
                        <div class="tab-pane fade" id="notifications">
                            <div class="card card-modern p-4">
                                <h4 class="fw-bold mb-4">Notifications</h4>
                                <div class="list-group list-group-flush">
                                    <c:choose>
                                        <c:when test="${not empty userNotifications}">
                                            <c:forEach var="notif" items="${userNotifications}">
                                                <a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                                                    <div>
                                                        <i class="fas fa-bell text-primary me-2"></i>
                                                        <strong>Notification</strong>
                                                        <p class="mb-0 small text-muted">${notif.message}</p>
                                                    </div>
                                                    <small class="text-muted">${notif.createdAt}</small>
                                                </a>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="text-center py-4">
                                                <i class="fas fa-bell-slash fa-3x text-muted mb-3"></i>
                                                <p class="text-muted">You have no notifications yet.</p>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
        <script>
            // Password match validation
            const pwdForm = document.getElementById('userChangePasswordForm');
            if (pwdForm) {
                pwdForm.addEventListener('submit', function(e) {
                    const newPwd = document.getElementById('newPassword').value;
                    const cnfPwd = document.getElementById('confirmNewPassword').value;
                    const cnfInput = document.getElementById('confirmNewPassword');
                    if (newPwd !== cnfPwd) {
                        e.preventDefault();
                        e.stopPropagation();
                        cnfInput.setCustomValidity('Passwords do not match');
                    } else {
                        cnfInput.setCustomValidity('');
                    }
                });
            }

            // Profile form: empty field validation
            const profileForm = document.getElementById('updateProfileForm');
            if (profileForm) {
                profileForm.addEventListener('submit', function(e) {
                    let isValid = true;
                    const fields = [
                        { el: profileForm.querySelector('[name="fullName"]'), label: 'Full name is required.' },
                        { el: profileForm.querySelector('[name="phone"]'), label: 'Phone number is required (10 digits).' },
                    ];
                    fields.forEach(function(f) {
                        const val = f.el.value.trim();
                        // Clear previous state
                        f.el.classList.remove('is-invalid');
                        f.el.style.animation = '';
                        if (!val) {
                            isValid = false;
                            f.el.classList.add('is-invalid');
                            f.el.style.animation = 'shake 0.4s ease';
                            // Update the invalid-feedback text
                            const fb = f.el.parentElement.querySelector('.invalid-feedback');
                            if (fb) fb.textContent = f.label;
                            setTimeout(function() { f.el.style.animation = ''; }, 400);
                        }
                    });
                    // Phone: 10 digit check
                    const phoneEl = profileForm.querySelector('[name="phone"]');
                    if (phoneEl.value.trim() && !/^[0-9]{10}$/.test(phoneEl.value.trim())) {
                        isValid = false;
                        phoneEl.classList.add('is-invalid');
                        phoneEl.style.animation = 'shake 0.4s ease';
                        setTimeout(function() { phoneEl.style.animation = ''; }, 400);
                    }
                    if (!isValid) {
                        e.preventDefault();
                        e.stopPropagation();
                    }
                    profileForm.classList.add('was-validated');
                });
            }

            // Expense tracker calculations
            (function() {
                var rows = document.querySelectorAll('#expenseTableBody tr');
                var total = 0, count = 0;
                rows.forEach(function(row) {
                    var amountCell = row.querySelector('td:nth-child(4)');
                    if (amountCell) {
                        var text = amountCell.textContent.replace(/[^0-9.]/g, '');
                        var val = parseFloat(text);
                        if (!isNaN(val) && val > 0) { total += val; count++; }
                    }
                });
                var totalEl = document.getElementById('totalSpent');
                var countEl = document.getElementById('totalBookingsCount');
                var avgEl = document.getElementById('avgCost');
                if (totalEl) totalEl.textContent = 'Rs. ' + total.toLocaleString('en-IN');
                if (countEl) countEl.textContent = count;
                if (avgEl) avgEl.textContent = 'Rs. ' + (count > 0 ? Math.round(total / count).toLocaleString('en-IN') : '0');
            })();

            const ctx = '${pageContext.request.contextPath}';
            
            function payNow(bookingId, name, email, contact) {
                if (typeof showGlobalLoader === 'function') showGlobalLoader();
                fetch(ctx + '/create_razorpay_order_existing', {
                    method: 'POST',
                    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                    body: 'bookingId=' + bookingId
                })
                .then(res => res.json())
                .then(data => {
                    if (typeof hideGlobalLoader === 'function') hideGlobalLoader();
                    if (!data.success) {
                        alert(data.message || 'Failed to initialize payment');
                        return;
                    }
                    var options = {
                        "key": data.keyId,
                        "amount": data.amount,
                        "currency": data.currency,
                        "name": "Carent - Car Rental",
                        "description": "Booking Payment",
                        "order_id": data.orderId,
                        "handler": function (response) {
                            if (typeof showGlobalLoader === 'function') showGlobalLoader();
                            fetch(ctx + '/confirm_existing_payment', {
                                method: 'POST',
                                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                                body: 'bookingId=' + bookingId + '&razorpay_payment_id=' + response.razorpay_payment_id
                            })
                            .then(r => r.json())
                            .then(rData => {
                                if (typeof hideGlobalLoader === 'function') hideGlobalLoader();
                                if(rData.success) {
                                    alert("Payment Successful!");
                                    window.location.reload();
                                } else {
                                    alert(rData.message);
                                }
                            });
                        },
                        "prefill": {
                            "name": name,
                            "email": email,
                            "contact": contact
                        },
                        "theme": {
                            "color": "#0d6efd"
                        }
                    };
                    var rzp = new window.Razorpay(options);
                    rzp.on('payment.failed', function (r){
                        alert('Payment Failed: ' + r.error.description);
                    });
                    rzp.open();
                })
                .catch(err => {
                    console.error(err);
                    if (typeof hideGlobalLoader === 'function') hideGlobalLoader();
                    alert('Error connecting to payment gateway.');
                });
            }

            // Document Upload AJAX
            function uploadDocuments() {
                const idFile = document.getElementById('idFile')?.files[0];
                const licenseFile = document.getElementById('licenseFile')?.files[0];
                const alertDiv = document.getElementById('uploadAlert');
                
                if (!idFile && !licenseFile) {
                    alertDiv.className = 'alert alert-danger mt-3';
                    alertDiv.innerHTML = '<i class="fas fa-exclamation-circle me-2"></i>Please select at least one document to upload.';
                    return;
                }

                const btn = document.getElementById('submitDocsBtn');
                btn.disabled = true;
                btn.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span>Uploading... Please wait';

                const formData = new FormData();
                if (idFile) formData.append('idFile', idFile);
                if (licenseFile) formData.append('licenseFile', licenseFile);

                btn.disabled = true;
                btn.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span>Uploading...';
                document.getElementById('uploadProgressContainer').classList.remove('d-none');
                document.getElementById('uploadProgressText').innerText = '0% Uploaded';

                const xhr = new XMLHttpRequest();
                xhr.open('POST', '${pageContext.request.contextPath}/upload_documents', true);

                xhr.upload.onprogress = function(event) {
                    if (event.lengthComputable) {
                        const percentComplete = Math.round((event.loaded / event.total) * 100);
                        document.getElementById('uploadProgressText').innerText = percentComplete + '% Uploaded';
                    }
                };

                xhr.onload = function() {
                    btn.disabled = false;
                    document.getElementById('uploadProgressContainer').classList.add('d-none');
                    if (xhr.status === 200) {
                        try {
                            const data = JSON.parse(xhr.responseText);
                            if (data.success) {
                                alertDiv.className = 'alert alert-success mt-3';
                                alertDiv.innerHTML = '<i class="fas fa-check-circle me-2"></i>' + data.message;
                                setTimeout(() => window.location.reload(), 1500);
                            } else {
                                btn.innerHTML = '<i class="fas fa-upload me-2"></i>Submit Documents';
                                alertDiv.className = 'alert alert-danger mt-3';
                                alertDiv.innerHTML = '<i class="fas fa-exclamation-circle me-2"></i>' + (data.message || "Upload Failed");
                            }
                        } catch(e) {
                            btn.innerHTML = '<i class="fas fa-upload me-2"></i>Submit Documents';
                            alertDiv.className = 'alert alert-danger mt-3';
                            alertDiv.innerHTML = '<i class="fas fa-exclamation-circle me-2"></i>Error parsing response.';
                        }
                    } else {
                        btn.innerHTML = '<i class="fas fa-upload me-2"></i>Submit Documents';
                        alertDiv.className = 'alert alert-danger mt-3';
                        alertDiv.innerHTML = '<i class="fas fa-exclamation-circle me-2"></i>Upload failed.';
                    }
                };

                xhr.onerror = function() {
                    btn.disabled = false;
                    document.getElementById('uploadProgressContainer').classList.add('d-none');
                    btn.innerHTML = '<i class="fas fa-upload me-2"></i>Submit Documents';
                    alertDiv.className = 'alert alert-danger mt-3';
                    alertDiv.innerHTML = '<i class="fas fa-exclamation-circle me-2"></i>Network error occurred. Please try again.';
                };

                xhr.send(formData);
            }
        </script>
        <script src="${pageContext.request.contextPath}/assets/js/validation.js"></script>
        <%@ include file="components/footer.jsp" %>