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
                                <% if (session.getAttribute("docVerified") == null) { %>
                                <span class="badge bg-warning text-dark rounded-pill float-end">Pending</span>
                                <% } %>
                            </a>
                            <a href="#bookings" class="list-group-item list-group-item-action" data-bs-toggle="list">
                                <i class="fas fa-calendar-alt me-2"></i> My Bookings
                            </a>
                            <a href="#notifications" class="list-group-item list-group-item-action"
                                data-bs-toggle="list">
                                <i class="fas fa-bell me-2"></i> Notifications
                                <span class="badge bg-danger rounded-pill float-end">2</span>
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
                                                value="<%= profileUser != null ? profileUser.getPhone() : "" %>" required pattern="^[0-9]{10}$">
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

                                <div class="alert alert-warning d-flex align-items-center" role="alert">
                                    <i class="fas fa-exclamation-triangle me-3 fa-lg"></i>
                                    <div>
                                        <strong>Verification Required!</strong> Please upload your ID and driving license to start booking vehicles.
                                    </div>
                                </div>

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
                                                <span class="badge bg-secondary mb-3"><i class="fas fa-clock me-1"></i>Not Uploaded</span>
                                                <div>
                                                    <input type="file" class="form-control form-control-sm" id="idFile" accept="image/*,.pdf">
                                                </div>
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
                                                <span class="badge bg-secondary mb-3"><i class="fas fa-clock me-1"></i>Not Uploaded</span>
                                                <div>
                                                    <input type="file" class="form-control form-control-sm" id="licenseFile" accept="image/*,.pdf">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="text-end mt-4">
                                    <button type="button" class="btn btn-primary-custom px-4">
                                        <i class="fas fa-upload me-2"></i>Submit Documents
                                    </button>
                                </div>
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
                                                    <div class="col-md-4">
                                                        <small class="text-muted d-block">Pick-Up</small>
                                                        <strong>${booking.startDate}</strong>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <small class="text-muted d-block">Drop-Off</small>
                                                        <strong>${booking.endDate}</strong>
                                                    </div>
                                                    <div class="col-md-4 text-md-end">
                                                        <small class="text-muted d-block">Total</small>
                                                        <strong class="text-primary">Rs. ${booking.finalPrice}</strong>
                                                    </div>
                                                </div>
                                                <div class="mt-2 text-muted small">
                                                    Payment Method: <span class="fw-bold">${empty booking.paymentMethod ? 'Cash' : booking.paymentMethod}</span>
                                                    <c:if test="${not empty booking.transactionId}"> | Txn ID: ${booking.transactionId}</c:if>
                                                </div>
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
                                                    </div>
                                                    <div class="col-md-4">
                                                        <small class="text-muted d-block">Drop-Off</small>
                                                        <strong>${booking.endDate}</strong>
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
                                            </div>
                                        </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Notifications Section -->
                        <div class="tab-pane fade" id="notifications">
                            <div class="card card-modern p-4">
                                <h4 class="fw-bold mb-4">Notifications</h4>
                                <div class="list-group list-group-flush">
                                    <a href="#"
                                        class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                                        <div>
                                            <i class="fas fa-check-circle text-success me-2"></i>
                                            <strong>Booking Confirmed</strong>
                                            <p class="mb-0 small text-muted">Your booking #RENT-09876 has been confirmed.</p>
                                        </div>
                                        <small class="text-muted">2 days ago</small>
                                    </a>
                                    <a href="#"
                                        class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                                        <div>
                                            <i class="fas fa-tag text-primary me-2"></i>
                                            <strong>New Promo!</strong>
                                            <p class="mb-0 small text-muted">Use code SAVE10 for 10% off your next rental.</p>
                                        </div>
                                        <small class="text-muted">1 week ago</small>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>

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
        </script>
        <script src="${pageContext.request.contextPath}/assets/js/validation.js"></script>
        <%@ include file="components/footer.jsp" %>