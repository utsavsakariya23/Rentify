/**
 * RENTIFY — Form Validation Library
 * Provides inline error messages with red borders.
 * Prevents form submission when invalid.
 * Auto-attaches to all project forms.
 */
(function () {
    'use strict';

    // ── Helpers ──────────────────────────────────────────────

    function showError(input, msg) {
        clearError(input);
        input.classList.add('is-invalid');
        input.style.borderColor = '#dc3545';
        input.style.boxShadow = '0 0 0 0.2rem rgba(220,53,69,.25)';
        var div = document.createElement('div');
        div.className = 'invalid-feedback';
        div.style.display = 'block';
        div.style.color = '#dc3545';
        div.style.fontSize = '0.85em';
        div.style.marginTop = '4px';
        div.textContent = msg;
        // Append after the input or after input-group
        var parent = input.closest('.input-group') || input.parentNode;
        parent.parentNode.insertBefore(div, parent.nextSibling);
    }

    function clearError(input) {
        input.classList.remove('is-invalid');
        input.style.borderColor = '';
        input.style.boxShadow = '';
        var parent = input.closest('.input-group') || input.parentNode;
        var next = parent.nextSibling;
        while (next && next.classList && next.classList.contains('invalid-feedback')) {
            next.remove();
            next = parent.nextSibling;
        }
    }

    function clearAllErrors(form) {
        var invalids = form.querySelectorAll('.is-invalid');
        for (var i = 0; i < invalids.length; i++) { clearError(invalids[i]); }
        var feedbacks = form.querySelectorAll('.invalid-feedback');
        for (var j = 0; j < feedbacks.length; j++) { feedbacks[j].remove(); }
    }

    function focusFirst(form) {
        var el = form.querySelector('.is-invalid');
        if (el) el.focus();
    }

    // ── Validators ──────────────────────────────────────────

    function isEmpty(val) { return !val || val.trim().length === 0; }
    function minLen(val, n) { return val.trim().length >= n; }
    function isValidEmail(val) { return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(val.trim()); }
    function isValidPhone(val) { return /^[0-9+\-\s()]{7,15}$/.test(val.trim()); }

    function getVal(form, name) {
        var el = form.querySelector('[name="' + name + '"]');
        return el ? el.value : '';
    }
    function getEl(form, name) {
        return form.querySelector('[name="' + name + '"]');
    }

    // ── Register Form ───────────────────────────────────────

    function validateRegister(form) {
        clearAllErrors(form);
        var valid = true;
        var f;

        f = getEl(form, 'fullName');
        if (f && isEmpty(f.value)) { showError(f, 'Full name is required.'); valid = false; }
        else if (f && !minLen(f.value, 2)) { showError(f, 'Full name must be at least 2 characters.'); valid = false; }

        f = getEl(form, 'email');
        if (f && isEmpty(f.value)) { showError(f, 'Email address is required.'); valid = false; }
        else if (f && !isValidEmail(f.value)) { showError(f, 'Please enter a valid email address.'); valid = false; }
        else if (f && f.getAttribute('data-invalid-unique') === 'true') { showError(f, 'This email is already registered.'); valid = false; }

        f = getEl(form, 'phone');
        if (f && isEmpty(f.value)) { showError(f, 'Phone number is required.'); valid = false; }
        else if (f && !isValidPhone(f.value)) { showError(f, 'Please enter a valid phone number (7-15 digits).'); valid = false; }

        f = getEl(form, 'username');
        if (f && isEmpty(f.value)) { showError(f, 'Username is required.'); valid = false; }
        else if (f && !minLen(f.value, 3)) { showError(f, 'Username must be at least 3 characters.'); valid = false; }
        else if (f && f.getAttribute('data-invalid-unique') === 'true') { showError(f, 'This username is already taken.'); valid = false; }

        f = getEl(form, 'password');
        if (f && isEmpty(f.value)) { showError(f, 'Password is required.'); valid = false; }
        else if (f && !minLen(f.value, 4)) { showError(f, 'Password must be at least 4 characters.'); valid = false; }

        var cp = getEl(form, 'confirmPassword');
        if (cp && isEmpty(cp.value)) { showError(cp, 'Please confirm your password.'); valid = false; }
        else if (cp && f && cp.value !== f.value) { showError(cp, 'Passwords do not match.'); valid = false; }

        f = getEl(form, 'licenseNo');
        if (f && isEmpty(f.value)) { showError(f, 'License number is required.'); valid = false; }
        else if (f && f.getAttribute('data-invalid-unique') === 'true') { showError(f, 'This license number is already registered.'); valid = false; }

        return valid;
    }

    // ── Login Form ──────────────────────────────────────────

    function validateLogin(form) {
        clearAllErrors(form);
        var valid = true;
        var f;

        f = getEl(form, 'username');
        if (f && isEmpty(f.value)) { showError(f, 'Username is required.'); valid = false; }

        f = getEl(form, 'password');
        if (f && isEmpty(f.value)) { showError(f, 'Password is required.'); valid = false; }
        else if (f && !minLen(f.value, 4)) { showError(f, 'Password must be at least 4 characters.'); valid = false; }

        return valid;
    }

    // ── Add Vehicle Form ────────────────────────────────────

    function validateAddVehicle(form) {
        clearAllErrors(form);
        var valid = true;
        var f;

        f = getEl(form, 'brand');
        if (f && isEmpty(f.value)) { showError(f, 'Vehicle brand is required.'); valid = false; }

        f = getEl(form, 'model');
        if (f && isEmpty(f.value)) { showError(f, 'Vehicle model is required.'); valid = false; }

        f = getEl(form, 'price');
        if (f && isEmpty(f.value)) { showError(f, 'Price per day is required.'); valid = false; }
        else if (f && (isNaN(f.value) || Number(f.value) <= 0)) { showError(f, 'Price must be a positive number.'); valid = false; }

        f = getEl(form, 'passengers');
        if (f && isEmpty(f.value)) { showError(f, 'Number of passengers is required.'); valid = false; }
        else if (f && (isNaN(f.value) || Number(f.value) <= 0)) { showError(f, 'Passengers must be a positive number.'); valid = false; }

        f = getEl(form, 'regNumber');
        if (f && isEmpty(f.value)) { showError(f, 'Registration number is required.'); valid = false; }

        return valid;
    }

    // ── Add Coupon Form ─────────────────────────────────────

    function validateAddCoupon(form) {
        clearAllErrors(form);
        var valid = true;
        var f;

        f = getEl(form, 'couponCode');
        if (f && isEmpty(f.value)) { showError(f, 'Coupon code is required.'); valid = false; }
        else if (f && !minLen(f.value, 3)) { showError(f, 'Coupon code must be at least 3 characters.'); valid = false; }

        f = getEl(form, 'discountValue');
        if (f && isEmpty(f.value)) { showError(f, 'Discount value is required.'); valid = false; }
        else if (f && (isNaN(f.value) || Number(f.value) <= 0)) { showError(f, 'Discount must be a positive number.'); valid = false; }

        f = getEl(form, 'validUntil');
        if (f && isEmpty(f.value)) { showError(f, 'Expiry date is required.'); valid = false; }

        return valid;
    }

    // ── Send Notification Form ──────────────────────────────

    function validateNotification(form) {
        clearAllErrors(form);
        var valid = true;
        var f;

        f = getEl(form, 'notifTitle');
        if (f && isEmpty(f.value)) { showError(f, 'Notification title is required.'); valid = false; }

        f = getEl(form, 'notifMessage');
        if (f && isEmpty(f.value)) { showError(f, 'Message cannot be empty.'); valid = false; }
        else if (f && !minLen(f.value, 10)) { showError(f, 'Message must be at least 10 characters.'); valid = false; }

        return valid;
    }

    // ── Reply Form (Messages) ───────────────────────────────

    function validateReply(form) {
        clearAllErrors(form);
        var valid = true;
        var f;

        f = getEl(form, 'replyMessage');
        if (f && isEmpty(f.value)) { showError(f, 'Reply message cannot be empty.'); valid = false; }
        else if (f && !minLen(f.value, 5)) { showError(f, 'Reply must be at least 5 characters.'); valid = false; }

        return valid;
    }

    // ── Change Password Form ────────────────────────────────

    function validateChangePassword(form) {
        clearAllErrors(form);
        var valid = true;
        var f;

        f = getEl(form, 'currentPassword');
        if (f && isEmpty(f.value)) { showError(f, 'Current password is required.'); valid = false; }

        f = getEl(form, 'newPassword');
        if (f && isEmpty(f.value)) { showError(f, 'New password is required.'); valid = false; }
        else if (f && !minLen(f.value, 4)) { showError(f, 'New password must be at least 4 characters.'); valid = false; }

        var cp = getEl(form, 'confirmNewPassword');
        if (cp && isEmpty(cp.value)) { showError(cp, 'Please confirm new password.'); valid = false; }
        else if (cp && f && cp.value !== f.value) { showError(cp, 'Passwords do not match.'); valid = false; }

        return valid;
    }

    // ── Generic Required Validation (for .needs-validation) ─

    function validateGeneric(form) {
        clearAllErrors(form);
        var valid = true;
        var requiredFields = form.querySelectorAll('[required]');
        for (var i = 0; i < requiredFields.length; i++) {
            var input = requiredFields[i];
            if (isEmpty(input.value)) {
                // Try to get label text
                var label = input.closest('.mb-3, .col-md-6, .col-md-12, .col-12');
                var labelEl = label ? label.querySelector('.form-label, label') : null;
                var labelText = labelEl ? labelEl.textContent.trim() : 'This field';
                showError(input, labelText + ' is required.');
                valid = false;
            }
        }
        // Validate email type inputs
        var emailFields = form.querySelectorAll('input[type="email"]');
        for (var j = 0; j < emailFields.length; j++) {
            if (!isEmpty(emailFields[j].value) && !isValidEmail(emailFields[j].value)) {
                showError(emailFields[j], 'Please enter a valid email address.');
                valid = false;
            }
        }
        return valid;
    }

    // ── Auto-Attach Setup ───────────────────────────────────

    function attachValidation(formId, validatorFn) {
        var form = document.getElementById(formId);
        if (form) {
            form.setAttribute('novalidate', 'true');
            form.addEventListener('submit', function (e) {
                if (!validatorFn(form)) {
                    e.preventDefault();
                    e.stopPropagation();
                    focusFirst(form);
                }
            });
        }
    }

    // ── Real-time AJAX Validation ───────────────────────────

    function checkUnique(inputEl, fieldName, errorMsg) {
        if (!inputEl || isEmpty(inputEl.value)) return;
        var val = inputEl.value.trim();
        
        // Skip DB check if client-side validation is obviously failing
        if (fieldName === 'email' && !isValidEmail(val)) return;
        if (fieldName === 'username' && !minLen(val, 3)) return;

        // Context path handling for URLs
        var basePath = window.location.pathname.substring(0, window.location.pathname.indexOf('/', 1));
        if (basePath === '') basePath = '/carent'; // fallback

        var xhr = new XMLHttpRequest();
        xhr.open('GET', basePath + '/validate_unique?field=' + fieldName + '&value=' + encodeURIComponent(val), true);
        xhr.onload = function() {
            if (xhr.status === 200) {
                try {
                    var res = JSON.parse(xhr.responseText);
                    if (res.taken) {
                        showError(inputEl, errorMsg);
                        inputEl.setAttribute('data-invalid-unique', 'true');
                    } else {
                        inputEl.removeAttribute('data-invalid-unique');
                        if (inputEl.classList.contains('is-invalid')) {
                            clearError(inputEl);
                        }
                    }
                } catch(e) {}
            }
        };
        xhr.send();
    }

    function setupRealtimeValidation() {
        var form = document.getElementById('registerForm');
        if (!form) return;

        var userEl = getEl(form, 'username');
        if (userEl) {
            userEl.addEventListener('blur', function() {
                checkUnique(userEl, 'username', 'This username is already taken. Please choose another.');
            });
        }

        var emailEl = getEl(form, 'email');
        if (emailEl) {
            emailEl.addEventListener('blur', function() {
                checkUnique(emailEl, 'email', 'This email is already registered. Try logging in.');
            });
        }

        var licEl = getEl(form, 'licenseNo');
        if (licEl) {
            licEl.addEventListener('blur', function() {
                checkUnique(licEl, 'licenseNo', 'This license number is already registered.');
            });
        }
    }

    // ── Init on DOM Ready ───────────────────────────────────

    document.addEventListener('DOMContentLoaded', function () {

        // User forms
        attachValidation('registerForm', validateRegister);
        attachValidation('loginForm', validateLogin);

        // Setup real-time AJAX unique validations
        setupRealtimeValidation();

        // Admin forms
        attachValidation('addVehicleForm', validateAddVehicle);
        attachValidation('editVehicleForm', validateAddVehicle);  // Same fields
        attachValidation('addCouponForm', validateAddCoupon);
        attachValidation('sendNotificationForm', validateNotification);
        attachValidation('replyForm1', validateReply);
        attachValidation('changePasswordForm', validateChangePassword);

        // Generic: any form with .needs-validation class (user profile, etc.)
        var genericForms = document.querySelectorAll('form.needs-validation');
        for (var k = 0; k < genericForms.length; k++) {
            (function (form) {
                form.setAttribute('novalidate', 'true');
                form.addEventListener('submit', function (e) {
                    if (!validateGeneric(form)) {
                        e.preventDefault();
                        e.stopPropagation();
                        focusFirst(form);
                    }
                });
            })(genericForms[k]);
        }

        // Live: clear error on input
        document.addEventListener('input', function (e) {
            if (e.target && e.target.classList && e.target.classList.contains('is-invalid')) {
                clearError(e.target);
            }
        });
    });

})();
