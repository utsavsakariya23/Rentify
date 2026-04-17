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

                            <% if ("true".equals(request.getParameter("registered"))) { %>
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                <i class="fas fa-check-circle me-2"></i>Registration successful! Please login.
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                            <% } %>

                            <% if ("true".equals(request.getParameter("error"))) { %>
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <i class="fas fa-exclamation-circle me-2"></i>Invalid username or password.
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                            <% } %>

                            <% if ("true".equals(request.getParameter("logout"))) { %>
                            <div class="alert alert-info alert-dismissible fade show" role="alert">
                                <i class="fas fa-info-circle me-2"></i>You have been logged out.
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                            <% } %>

                            <form id="loginForm" action="${pageContext.request.contextPath}/perform_login" method="post">

                                <div class="mb-3">
                                    <label class="form-label small fw-bold text-muted">USERNAME</label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-white border-end-0"><i
                                                class="fas fa-user text-primary"></i></span>
                                        <input type="text" class="form-control border-start-0 ps-0" name="username"
                                            placeholder="Enter username"
                                            value="<%= request.getCookies() != null ? getCookieValue(request.getCookies(), "rememberUser", "") : "" %>">
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label small fw-bold text-muted">PASSWORD</label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-white border-end-0"><i
                                                class="fas fa-lock text-primary"></i></span>
                                        <input type="password" class="form-control border-start-0 border-end-0 ps-0" name="password" id="loginPassword"
                                            placeholder="Enter password">
                                        <button class="btn btn-outline-secondary border-start-0 bg-white" type="button" id="toggleLoginPwd" tabindex="-1" title="Show/Hide Password">
                                            <i class="fas fa-eye text-muted" id="loginPwdIcon"></i>
                                        </button>
                                    </div>
                                </div>

                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" name="rememberMe" id="rememberMe"
                                            <%= request.getCookies() != null && !getCookieValue(request.getCookies(), "rememberUser", "").isEmpty() ? "checked" : "" %>>
                                        <label class="form-check-label small" for="rememberMe">Remember Me</label>
                                    </div>
                                    <a href="#" class="small text-decoration-none text-primary" data-bs-toggle="modal" data-bs-target="#forgotPasswordModal">Forgot Password?</a>
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
        <div class="modal fade" id="forgotPasswordModal" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header bg-primary text-white">
                        <h5 class="modal-title"><i class="fas fa-lock me-2"></i>Reset Password</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div id="fpAlert" class="alert d-none"></div>

                        <!-- Step 1: Enter Email -->
                        <div id="fpStep1">
                            <p class="text-muted small">Enter your registered email address and we'll send you a verification code.</p>
                            <div class="mb-3">
                                <label class="form-label small fw-bold">EMAIL ADDRESS</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-envelope text-primary"></i></span>
                                    <input type="email" class="form-control" id="fpEmail" placeholder="Enter your email" required>
                                </div>
                            </div>
                            <button class="btn btn-primary w-100" id="fpSendOtpBtn" onclick="fpSendOtp()">
                                <i class="fas fa-paper-plane me-1"></i>Send Verification Code
                            </button>
                        </div>

                        <!-- Step 2: Enter OTP -->
                        <div id="fpStep2" class="d-none">
                            <p class="text-muted small">Enter the 6-digit code sent to <strong id="fpEmailDisplay"></strong></p>
                            <div class="mb-3">
                                <label class="form-label small fw-bold">VERIFICATION CODE</label>
                                <input type="text" class="form-control text-center fw-bold fs-4" id="fpOtp" maxlength="6"
                                    placeholder="000000" oninput="this.value=this.value.replace(/[^0-9]/g,'')">
                            </div>
                            <button class="btn btn-primary w-100" id="fpVerifyOtpBtn" onclick="fpVerifyOtp()">
                                <i class="fas fa-check-circle me-1"></i>Verify Code
                            </button>
                            <div class="text-center mt-2">
                                <a href="#" class="small text-muted" onclick="fpSendOtp(); return false;">Resend Code</a>
                            </div>
                        </div>

                        <!-- Step 3: New Password -->
                        <div id="fpStep3" class="d-none">
                            <p class="text-muted small">Enter your new password (minimum 8 characters).</p>
                            <div class="mb-3">
                                <label class="form-label small fw-bold">NEW PASSWORD</label>
                                <div class="input-group">
                                    <input type="password" class="form-control" id="fpNewPassword" placeholder="New password" minlength="8" required>
                                    <button class="btn btn-outline-secondary" type="button" onclick="fpTogglePwd('fpNewPassword', 'fpNewPwdIcon')">
                                        <i class="fas fa-eye" id="fpNewPwdIcon"></i>
                                    </button>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label class="form-label small fw-bold">CONFIRM PASSWORD</label>
                                <div class="input-group">
                                    <input type="password" class="form-control" id="fpConfirmPassword" placeholder="Confirm password" minlength="8" required>
                                    <button class="btn btn-outline-secondary" type="button" onclick="fpTogglePwd('fpConfirmPassword', 'fpConfPwdIcon')">
                                        <i class="fas fa-eye" id="fpConfPwdIcon"></i>
                                    </button>
                                </div>
                            </div>
                            <button class="btn btn-success w-100" id="fpResetBtn" onclick="fpResetPassword()">
                                <i class="fas fa-lock me-1"></i>Reset Password
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="${pageContext.request.contextPath}/assets/js/validation.js"></script>
        <script>
            // Toggle password visibility
            document.getElementById('toggleLoginPwd').addEventListener('click', function() {
                var pwdInput = document.getElementById('loginPassword');
                var icon = document.getElementById('loginPwdIcon');
                if (pwdInput.type === 'password') {
                    pwdInput.type = 'text';
                    icon.classList.remove('fa-eye');
                    icon.classList.add('fa-eye-slash');
                } else {
                    pwdInput.type = 'password';
                    icon.classList.remove('fa-eye-slash');
                    icon.classList.add('fa-eye');
                }
            });

            // Empty field validation
            document.getElementById('loginForm').addEventListener('submit', function(e) {
                var username = this.querySelector('[name="username"]').value.trim();
                var password = document.getElementById('loginPassword').value.trim();
                if (!username || !password) {
                    e.preventDefault();
                    var fields = this.querySelectorAll('input[name="username"], input[name="password"]');
                    fields.forEach(function(f) {
                        if (!f.value.trim()) {
                            f.classList.add('is-invalid');
                            f.style.animation = 'shake 0.4s ease';
                            setTimeout(function() { f.style.animation = ''; }, 400);
                        } else {
                            f.classList.remove('is-invalid');
                        }
                    });
                }
            });

            // ============ Forgot Password JS ============
            var fpEmailVal = '';
            var fpOtpVal = '';
            var fpCtx = '${pageContext.request.contextPath}';

            function fpShowAlert(msg, type) {
                var el = document.getElementById('fpAlert');
                el.className = 'alert alert-' + type;
                el.textContent = msg;
                el.classList.remove('d-none');
            }

            function fpLoading(btnId, loading) {
                var btn = document.getElementById(btnId);
                if (loading) {
                    btn.disabled = true;
                    btn.innerHTML = '<span class="spinner-border spinner-border-sm me-1"></span>Please wait...';
                } else {
                    btn.disabled = false;
                }
            }

            function fpSendOtp() {
                fpEmailVal = document.getElementById('fpEmail').value.trim();
                if (!fpEmailVal || !fpEmailVal.includes('@')) {
                    fpShowAlert('Please enter a valid email address.', 'danger'); return;
                }
                fpLoading('fpSendOtpBtn', true);
                fetch(fpCtx + '/forgot_password', {
                    method: 'POST',
                    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                    body: 'action=send_otp&email=' + encodeURIComponent(fpEmailVal)
                })
                .then(function(r) { return r.json(); })
                .then(function(data) {
                    fpLoading('fpSendOtpBtn', false);
                    document.getElementById('fpSendOtpBtn').innerHTML = '<i class="fas fa-paper-plane me-1"></i>Send Verification Code';
                    if (data.success) {
                        fpShowAlert(data.message, 'success');
                        document.getElementById('fpStep1').classList.add('d-none');
                        document.getElementById('fpStep2').classList.remove('d-none');
                        document.getElementById('fpEmailDisplay').textContent = fpEmailVal;
                    } else {
                        fpShowAlert(data.message, 'danger');
                    }
                })
                .catch(function() {
                    fpLoading('fpSendOtpBtn', false);
                    document.getElementById('fpSendOtpBtn').innerHTML = '<i class="fas fa-paper-plane me-1"></i>Send Verification Code';
                    fpShowAlert('Network error. Please try again.', 'danger');
                });
            }

            function fpVerifyOtp() {
                fpOtpVal = document.getElementById('fpOtp').value.trim();
                if (fpOtpVal.length !== 6) {
                    fpShowAlert('Please enter a valid 6-digit code.', 'danger'); return;
                }
                fpLoading('fpVerifyOtpBtn', true);
                fetch(fpCtx + '/forgot_password', {
                    method: 'POST',
                    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                    body: 'action=verify_otp&email=' + encodeURIComponent(fpEmailVal) + '&otp=' + fpOtpVal
                })
                .then(function(r) { return r.json(); })
                .then(function(data) {
                    fpLoading('fpVerifyOtpBtn', false);
                    document.getElementById('fpVerifyOtpBtn').innerHTML = '<i class="fas fa-check-circle me-1"></i>Verify Code';
                    if (data.success) {
                        fpShowAlert('Verified! Set your new password.', 'success');
                        document.getElementById('fpStep2').classList.add('d-none');
                        document.getElementById('fpStep3').classList.remove('d-none');
                    } else {
                        fpShowAlert(data.message, 'danger');
                    }
                })
                .catch(function() {
                    fpLoading('fpVerifyOtpBtn', false);
                    document.getElementById('fpVerifyOtpBtn').innerHTML = '<i class="fas fa-check-circle me-1"></i>Verify Code';
                    fpShowAlert('Network error. Please try again.', 'danger');
                });
            }

            function fpResetPassword() {
                var newPwd = document.getElementById('fpNewPassword').value;
                var confPwd = document.getElementById('fpConfirmPassword').value;
                if (newPwd.length < 8) { fpShowAlert('Password must be at least 8 characters.', 'danger'); return; }
                if (newPwd !== confPwd) { fpShowAlert('Passwords do not match.', 'danger'); return; }
                fpLoading('fpResetBtn', true);
                fetch(fpCtx + '/forgot_password', {
                    method: 'POST',
                    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                    body: 'action=reset_password&email=' + encodeURIComponent(fpEmailVal) + '&otp=' + fpOtpVal + '&newPassword=' + encodeURIComponent(newPwd)
                })
                .then(function(r) { return r.json(); })
                .then(function(data) {
                    fpLoading('fpResetBtn', false);
                    document.getElementById('fpResetBtn').innerHTML = '<i class="fas fa-lock me-1"></i>Reset Password';
                    if (data.success) {
                        fpShowAlert(data.message, 'success');
                        setTimeout(function() {
                            var modal = bootstrap.Modal.getInstance(document.getElementById('forgotPasswordModal'));
                            if (modal) modal.hide();
                            // Reset steps
                            document.getElementById('fpStep1').classList.remove('d-none');
                            document.getElementById('fpStep2').classList.add('d-none');
                            document.getElementById('fpStep3').classList.add('d-none');
                            document.getElementById('fpAlert').classList.add('d-none');
                        }, 2000);
                    } else {
                        fpShowAlert(data.message, 'danger');
                    }
                })
                .catch(function() {
                    fpLoading('fpResetBtn', false);
                    document.getElementById('fpResetBtn').innerHTML = '<i class="fas fa-lock me-1"></i>Reset Password';
                    fpShowAlert('Network error. Please try again.', 'danger');
                });
            }

            function fpTogglePwd(inputId, iconId) {
                var inp = document.getElementById(inputId);
                var icon = document.getElementById(iconId);
                if (inp.type === 'password') {
                    inp.type = 'text'; icon.classList.replace('fa-eye', 'fa-eye-slash');
                } else {
                    inp.type = 'password'; icon.classList.replace('fa-eye-slash', 'fa-eye');
                }
            }

            // Reset modal steps when closed
            document.getElementById('forgotPasswordModal').addEventListener('hidden.bs.modal', function() {
                document.getElementById('fpStep1').classList.remove('d-none');
                document.getElementById('fpStep2').classList.add('d-none');
                document.getElementById('fpStep3').classList.add('d-none');
                document.getElementById('fpAlert').classList.add('d-none');
                document.getElementById('fpEmail').value = '';
                document.getElementById('fpOtp').value = '';
                document.getElementById('fpNewPassword').value = '';
                document.getElementById('fpConfirmPassword').value = '';
            });
        </script>
        <style>
            @keyframes shake {
                0%,100% { transform: translateX(0); }
                20%,60% { transform: translateX(-6px); }
                40%,80% { transform: translateX(6px); }
            }
        </style>

        <%!
            private String getCookieValue(jakarta.servlet.http.Cookie[] cookies, String name, String defaultVal) {
                if (cookies != null) {
                    for (jakarta.servlet.http.Cookie c : cookies) {
                        if (name.equals(c.getName())) return c.getValue();
                    }
                }
                return defaultVal;
            }
        %>

        <%@ include file="components/footer.jsp" %>