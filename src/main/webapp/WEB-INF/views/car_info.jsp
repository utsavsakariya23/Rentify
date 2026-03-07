<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ include file="components/header.jsp" %>

        <main class="container my-5 pt-5">
            <div class="row g-5">
                <!-- Left Column: Gallery & Details -->
                <div class="col-lg-8">
                    <!-- Gallery -->
                    <div class="card card-modern mb-4">
                        <img src="${pageContext.request.contextPath}/assets/img/toyota_corolla.webp"
                            class="img-fluid rounded-top" id="mainImage" alt="Car Main">
                        <div class="d-flex gap-2 p-3">
                            <img src="${pageContext.request.contextPath}/assets/img/toyota_corolla.webp"
                                class="img-thumbnail" style="width: 100px; cursor: pointer;"
                                onclick="changeImage(this)">
                            <img src="${pageContext.request.contextPath}/assets/img/repair-tool.png"
                                class="img-thumbnail" style="width: 100px; cursor: pointer;"
                                onclick="changeImage(this)"> <!-- Placeholder -->
                            <img src="${pageContext.request.contextPath}/assets/img/interest-rate.png"
                                class="img-thumbnail" style="width: 100px; cursor: pointer;"
                                onclick="changeImage(this)"> <!-- Placeholder -->
                        </div>
                    </div>

                    <!-- Specs & Description -->
                    <div class="card card-modern p-4 mb-4">
                        <h3 class="fw-bold">Toyota Corolla (2025)</h3>
                        <div class="d-flex align-items-center mb-3">
                            <div class="text-warning me-2">
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star-half-alt"></i>
                            </div>
                            <span class="text-muted">(120 Reviews)</span>
                        </div>

                        <h5 class="fw-bold mt-3">Vehicle Overview</h5>
                        <p class="text-muted">The Toyota Corolla is a compact car that offers a comfortable ride, good
                            fuel economy, and a long list of standard safety features. Perfect for city driving and long
                            highway trips alike.</p>

                        <h5 class="fw-bold mt-4">Specifications</h5>
                        <div class="row g-3">
                            <div class="col-6 col-md-3">
                                <div class="p-3 bg-light rounded text-center">
                                    <i class="fas fa-gas-pump text-primary mb-2"></i>
                                    <div class="small fw-bold">Petrol</div>
                                </div>
                            </div>
                            <div class="col-6 col-md-3">
                                <div class="p-3 bg-light rounded text-center">
                                    <i class="fas fa-cog text-primary mb-2"></i>
                                    <div class="small fw-bold">Automatic</div>
                                </div>
                            </div>
                            <div class="col-6 col-md-3">
                                <div class="p-3 bg-light rounded text-center">
                                    <i class="fas fa-users text-primary mb-2"></i>
                                    <div class="small fw-bold">5 Seats</div>
                                </div>
                            </div>
                            <div class="col-6 col-md-3">
                                <div class="p-3 bg-light rounded text-center">
                                    <i class="fas fa-tachometer-alt text-primary mb-2"></i>
                                    <div class="small fw-bold">15km/L</div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Reviews Section -->
                    <div class="card card-modern p-4">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <h4 class="fw-bold">Customer Reviews</h4>
                            <button class="btn btn-outline-primary btn-sm">Write a Review</button>
                        </div>

                        <!-- Review 1 -->
                        <div class="d-flex mb-4">
                            <div class="flex-shrink-0">
                                <div class="bg-primary text-white rounded-circle d-flex align-items-center justify-content-center"
                                    style="width: 50px; height: 50px;">
                                    JD
                                </div>
                            </div>
                            <div class="flex-grow-1 ms-3">
                                <h6 class="fw-bold mb-1">John Doe <span class="text-muted small fw-normal">- 2 days
                                        ago</span></h6>
                                <div class="text-warning small mb-2">
                                    <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i
                                        class="fas fa-star"></i><i class="fas fa-star"></i>
                                </div>
                                <p class="text-muted small">Car was in excellent condition. Smooth pickup process.</p>
                            </div>
                        </div>
                        <hr>
                        <!-- Review 2 -->
                        <div class="d-flex mb-4">
                            <div class="flex-shrink-0">
                                <div class="bg-dark text-white rounded-circle d-flex align-items-center justify-content-center"
                                    style="width: 50px; height: 50px;">
                                    SM
                                </div>
                            </div>
                            <div class="flex-grow-1 ms-3">
                                <h6 class="fw-bold mb-1">Sarah Miller <span class="text-muted small fw-normal">- 1 week
                                        ago</span></h6>
                                <div class="text-warning small mb-2">
                                    <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i
                                        class="fas fa-star"></i><i class="far fa-star"></i>
                                </div>
                                <p class="text-muted small">Great car, but the GPS was a bit outdated.</p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Right Column: Booking Form -->
                <div class="col-lg-4">
                    <div class="card card-modern p-4 sticky-top" style="top: 100px;">
                        <h4 class="fw-bold mb-0">Rs. 5,000 <span class="fs-6 text-muted fw-normal">/ day</span></h4>
                        <hr>

                        <form id="bookingForm">
                            <div class="mb-3">
                                <label class="form-label small fw-bold">PICK-UP DATE</label>
                                <input type="date" class="form-control" id="pickupDate" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label small fw-bold">DROP-OFF DATE</label>
                                <input type="date" class="form-control" id="dropoffDate" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label small fw-bold">COUPON CODE</label>
                                <div class="input-group">
                                    <input type="text" class="form-control" id="couponCode" placeholder="Enter code">
                                    <button class="btn btn-outline-secondary" type="button"
                                        onclick="applyCoupon()">Apply</button>
                                </div>
                                <small class="text-success" id="couponMsg" style="display: none;">Coupon applied! 10%
                                    Off</small>
                            </div>

                            <div class="mb-4">
                                <label class="form-label small fw-bold">PAYMENT METHOD</label>
                                <div class="btn-group w-100" role="group">
                                    <input type="radio" class="btn-check" name="paymentMethod" id="payOnline"
                                        autocomplete="off" checked>
                                    <label class="btn btn-outline-primary" for="payOnline"><i
                                            class="fas fa-credit-card me-2"></i>Online</label>

                                    <input type="radio" class="btn-check" name="paymentMethod" id="payCash"
                                        autocomplete="off">
                                    <label class="btn btn-outline-primary" for="payCash"><i
                                            class="fas fa-money-bill-wave me-2"></i>Cash</label>
                                </div>
                            </div>


                            <div class="d-flex justify-content-between mb-2">
                                <span>Rental Fee</span>
                                <span id="rentalFee">Rs. 0</span>
                            </div>
                            <div class="d-flex justify-content-between mb-2">
                                <span>Discount</span>
                                <span class="text-success" id="discountAmt">- Rs. 0</span>
                            </div>
                            <hr>
                            <div class="d-flex justify-content-between mb-4">
                                <h5 class="fw-bold">Total</h5>
                                <h5 class="fw-bold text-primary" id="totalAmt">Rs. 0</h5>
                            </div>

                            <button type="submit" class="btn btn-primary-custom w-100 btn-lg">Book Now</button>
                            <p class="text-center small text-muted mt-3"><i class="fas fa-lock me-1"></i> Secure
                                Transaction</p>
                        </form>
                    </div>
                </div>
            </div>
        </main>

        <script>
            function changeImage(el) {
                document.getElementById('mainImage').src = el.src;
            }

            // Toggle Payment Fields
            const payOnline = document.getElementById('payOnline');
            const payCash = document.getElementById('payCash');
            const onlineFields = document.getElementById('onlinePaymentFields');

            function togglePayment() {
                if (payOnline.checked) {
                    onlineFields.style.display = 'block';
                } else {
                    onlineFields.style.display = 'none';
                }
            }

            payOnline.addEventListener('change', togglePayment);
            payCash.addEventListener('change', togglePayment);

            // Coupon Logic
            function applyCoupon() {
                const code = document.getElementById('couponCode').value;
                const msg = document.getElementById('couponMsg');
                if (code === 'SAVE10') {
                    msg.style.display = 'block';
                    calculateTotal();
                } else {
                    alert('Invalid Coupon (Try SAVE10)');
                    msg.style.display = 'none';
                }
            }

            // Price Calc
            const dailyRate = 5000;
            const pickup = document.getElementById('pickupDate');
            const dropoff = document.getElementById('dropoffDate');

            function calculateTotal() {
                if (pickup.value && dropoff.value) {
                    const start = new Date(pickup.value);
                    const end = new Date(dropoff.value);
                    const diffTime = Math.abs(end - start);
                    const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));

                    if (diffDays > 0) {
                        const fee = diffDays * dailyRate;
                        document.getElementById('rentalFee').innerText = 'Rs. ' + fee;

                        let discount = 0;
                        if (document.getElementById('couponMsg').style.display === 'block') {
                            discount = fee * 0.10;
                        }
                        document.getElementById('discountAmt').innerText = '- Rs. ' + discount;
                        document.getElementById('totalAmt').innerText = 'Rs. ' + (fee - discount);
                    }
                }
            }

            pickup.addEventListener('change', calculateTotal);
            dropoff.addEventListener('change', calculateTotal);

            // Form Submit
            document.getElementById('bookingForm').addEventListener('submit', function (e) {
                e.preventDefault();
                alert('Booking Request Sent Successfully!');
                // Here you would add the AJAX call to save the booking
            });
        </script>

        <%@ include file="components/footer.jsp" %>