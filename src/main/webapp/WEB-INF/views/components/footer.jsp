<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <footer class="footer-custom mt-auto">
        <div class="container">
            <div class="row g-4">
                <div class="col-md-4">
                    <h5 class="text-dark mb-3">Easy Rental</h5>
                    <p class="text-dark">Experience the freedom of the road with our premium fleet. Reliable,
                        affordable, and always ready for your next adventure.</p>
                    <div class="d-flex gap-3">
                        <a href="#" class="text-dark"><i class="fab fa-facebook-f"></i></a>
                        <a href="#" class="text-dark"><i class="fab fa-twitter"></i></a>
                        <a href="#" class="text-dark"><i class="fab fa-instagram"></i></a>
                    </div>
                </div>
                <div class="col-md-2">
                    <h6 class="text-dark mb-3">Quick Links</h6>
                    <ul class="list-unstyled">
                        <li><a href="${pageContext.request.contextPath}/home"
                                class="text-dark text-decoration-none">Home</a></li>
                        <li><a href="${pageContext.request.contextPath}/vehicles"
                                class="text-dark text-decoration-none">Vehicles</a></li>
                        <li><a href="${pageContext.request.contextPath}/about"
                                class="text-dark text-decoration-none">About Us</a></li>
                        <li><a href="${pageContext.request.contextPath}/contact"
                                class="text-dark text-decoration-none">Contact</a></li>
                    </ul>
                </div>
                <div class="col-md-3">
                    <h6 class="text-dark mb-3">Support</h6>
                    <ul class="list-unstyled">
                        <li><a href="#" class="text-dark text-decoration-none">Help Center</a></li>
                        <li><a href="#" class="text-dark text-decoration-none">Terms of Service</a></li>
                        <li><a href="#" class="text-dark text-decoration-none">Privacy Policy</a></li>
                        <li><a href="#" class="text-dark text-decoration-none">FAQs</a></li>
                    </ul>
                </div>
                <div class="col-md-3">
                    <h6 class="text-dark mb-3">Contact Us</h6>
                    <p class="text-dark mb-1"><i class="fas fa-envelope me-2"></i> easyrental@gmail.com</p>
                    <p class="text-dark mb-1"><i class="fas fa-phone me-2"></i> +91 11 234 5678</p>
                    <p class="text-dark"><i class="fas fa-map-marker-alt me-2"></i> Rajkot ,Gujarat</p>
                </div>
            </div>
            <hr class="my-4 border-white-50">
            <div class="row align-items-center">
                <div class="col-md-6 text-center text-md-start">
                    <p class="mb-0 text-white-50">&copy; 2026 Easy Rental. All rights reserved.</p>
                </div>
                <div class="col-md-6 text-center text-md-end">
                    <img src="${pageContext.request.contextPath}/assets/img/payment_methods.png" alt="Payments"
                        style="height: 30px; opacity: 0.8;"> <!-- Placeholder if image missing, alt text handles it -->
                </div>
            </div>
        </div>
    </footer>

    <!-- JS scripts -->
    <script src="${pageContext.request.contextPath}/assets/bootstrap/js/jquery-3.6.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.bundle.js"></script>
    <script src="${pageContext.request.contextPath}/assets/controller/main.js"></script>
    <script src="${pageContext.request.contextPath}/assets/controller/url.js"></script>
    <script>
        // Auth State Management
        function updateAuthState() {
            const user = localStorage.getItem('user');
            if (user) {
                $('.guest-only').hide();
                $('.user-only').show();
            } else {
                $('.guest-only').show();
                $('.user-only').hide();
            }
        }

        function logoutUser() {
            localStorage.removeItem('user');
            updateAuthState();
            window.location.href = '${pageContext.request.contextPath}/home';
        }

        $(document).ready(function () {
            updateAuthState();
        });
    </script>
    </body>

    </html>