<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
    <%@ include file="components/header.jsp" %>
    <!-- Leaflet CSS -->
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" integrity="sha256-p4NxAoJBhIIN+hmNHrzRCf9tD/miZyoHS5obTRR9BMY=" crossorigin=""/>
    <style>
        #rajkotMap { height: 300px; width: 100%; border-radius: 8px; margin-bottom: 1rem; border: 1px solid #dee2e6; }
    </style>

        <main class="container my-5 pt-5">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="card card-modern border-0 shadow-sm">
                        <div class="card-body p-4 p-md-5">
                            <h3 class="fw-bold mb-4"><i class="fas fa-calendar-check text-primary me-2"></i>Book a Car</h3>

                            <c:if test="${not empty param.error}">
                                <div class="alert alert-danger">${param.error}</div>
                            </c:if>

                            <c:if test="${car != null}">
                                <!-- Car Summary -->
                                <div class="d-flex align-items-center mb-4 p-3 rounded-3" style="background: #f8f9fa;">
                                    <c:choose>
                                        <c:when test="${not empty car.imageUrl}">
                                            <img src="${car.imageUrl}" alt="${car.name}" class="rounded" style="width: 120px; height: 80px; object-fit: cover;">
                                        </c:when>
                                        <c:otherwise>
                                            <div class="rounded d-flex align-items-center justify-content-center" style="width: 120px; height: 80px; background: #e9ecef;">
                                                <i class="fas fa-car fa-2x text-muted"></i>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                    <div class="ms-3">
                                        <h5 class="fw-bold mb-1">${car.name}</h5>
                                        <p class="text-muted mb-0">${car.brand} &bull; ${car.transmission} &bull; ${car.fuelType}</p>
                                        <span class="text-primary fw-bold">Rs. <fmt:formatNumber value="${car.pricePerDay}" pattern="#,##0" /> /day</span>
                                    </div>
                                </div>

                                <form action="${pageContext.request.contextPath}/book_car" method="post" id="bookingForm" class="needs-validation" novalidate>
                                    <input type="hidden" name="carId" value="${car.carId}">

                                    <div class="row g-3">
                                        <div class="col-md-6">
                                            <label class="form-label fw-bold">Pickup Date</label>
                                            <input type="date" class="form-control" name="startDate" id="startDate" required
                                                   min="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>">
                                            <div class="invalid-feedback">Please select a valid pickup date.</div>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label fw-bold">Return Date</label>
                                            <input type="date" class="form-control" name="endDate" id="endDate" required>
                                            <div class="invalid-feedback">Please select a valid return date.</div>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label fw-bold">Pickup Location (Rajkot Only)</label>
                                            <div class="input-group">
                                                <input type="text" class="form-control" name="pickupLocation" id="pickupLocation" placeholder="Select on map" readonly required>
                                                <button class="btn btn-outline-secondary" type="button" onclick="setSelectionMode('pickup')"><i class="fas fa-map-marker-alt text-success"></i></button>
                                            </div>
                                            <div class="invalid-feedback">Please select a pickup location from the map.</div>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label fw-bold">Drop Location (Rajkot Only)</label>
                                            <div class="input-group">
                                                <input type="text" class="form-control" name="dropLocation" id="dropLocation" placeholder="Select on map" readonly required>
                                                <button class="btn btn-outline-secondary" type="button" onclick="setSelectionMode('drop')"><i class="fas fa-map-marker-alt text-danger"></i></button>
                                            </div>
                                            <div class="invalid-feedback">Please select a drop location from the map.</div>
                                        </div>
                                        
                                        <!-- Map Selection Area -->
                                        <div class="col-12">
                                            <p class="small text-muted mb-1" id="mapInstructions">Click the map icon above to select locations.</p>
                                            <div id="rajkotMap"></div>
                                        </div>
                                        <div class="col-12">
                                            <label class="form-label fw-bold">Coupon Code (Optional)</label>
                                            <div class="input-group">
                                                <input type="text" class="form-control" name="couponCode" id="couponCode" placeholder="Enter coupon code">
                                                <button type="button" class="btn btn-outline-primary" onclick="applyCoupon()">Apply</button>
                                            </div>
                                            <div id="couponMessage" class="mt-1"></div>
                                        </div>
                                        <div class="col-12 mt-3">
                                            <label class="form-label fw-bold">Payment Method</label>
                                            <div class="d-flex gap-3 mt-2">
                                                <div class="form-check">
                                                    <input class="form-check-input" type="radio" name="paymentMethod" id="payCash" value="Cash" checked>
                                                    <label class="form-check-label" for="payCash">
                                                        <i class="fas fa-money-bill-wave text-success me-1"></i> Cash on Pickup
                                                    </label>
                                                </div>
                                                <div class="form-check">
                                                    <input class="form-check-input" type="radio" name="paymentMethod" id="payOnline" value="Online">
                                                    <label class="form-check-label" for="payOnline">
                                                        <i class="fas fa-credit-card text-primary me-1"></i> Pay Online (Razorpay)
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Price Summary -->
                                    <div class="mt-4 p-3 rounded-3" style="background: #f0f4ff;" id="priceSummary" style="display: none;">
                                        <h6 class="fw-bold mb-3">Price Breakdown</h6>
                                        <div class="d-flex justify-content-between mb-2">
                                            <span>Duration</span>
                                            <span id="totalDays">-</span>
                                        </div>
                                        <div class="d-flex justify-content-between mb-2">
                                            <span>Subtotal</span>
                                            <span id="totalPrice">-</span>
                                        </div>
                                        <div class="d-flex justify-content-between mb-2 text-success">
                                            <span>Discount</span>
                                            <span id="discountAmount">Rs. 0</span>
                                        </div>
                                        <hr>
                                        <div class="d-flex justify-content-between fw-bold fs-5">
                                            <span>Total</span>
                                            <span class="text-primary" id="finalPrice">-</span>
                                        </div>
                                    </div>

                                    <button type="submit" class="btn btn-primary-custom w-100 mt-4 py-2 fw-bold">
                                        <i class="fas fa-check-circle me-2"></i>Confirm Booking
                                    </button>
                                </form>
                            </c:if>

                            <c:if test="${car == null}">
                                <div class="text-center py-5">
                                    <i class="fas fa-car fa-3x text-muted mb-3"></i>
                                    <p class="text-muted">No car selected. Please choose a car first.</p>
                                    <a href="${pageContext.request.contextPath}/vehicles" class="btn btn-primary-custom">Browse Cars</a>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
        <script>
            const ctx = '${pageContext.request.contextPath}';
            const carId = '${car.carId}';

            document.getElementById('startDate')?.addEventListener('change', function() {
                // Ensure end date cannot be before start date
                const start = this.value;
                const endInput = document.getElementById('endDate');
                endInput.min = start;
                calculatePrice();
            });
            document.getElementById('endDate')?.addEventListener('change', calculatePrice);

            function calculatePrice() {
                const startDate = document.getElementById('startDate').value;
                const endDate = document.getElementById('endDate').value;
                const couponCode = document.getElementById('couponCode').value;

                if (!startDate || !endDate) return;

                if (new Date(endDate) < new Date(startDate)) {
                    showToast('Return date cannot be before pickup date.', 'error');
                    document.getElementById('endDate').value = startDate;
                    return;
                }

                fetch(ctx + '/calculate_price', {
                    method: 'POST',
                    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                    body: 'carId=' + carId + '&startDate=' + startDate + '&endDate=' + endDate + '&couponCode=' + encodeURIComponent(couponCode)
                })
                .then(r => r.json())
                .then(data => {
                    if (data.success) {
                        document.getElementById('priceSummary').style.display = 'block';
                        document.getElementById('totalDays').textContent = data.totalDays + ' day(s)';
                        document.getElementById('totalPrice').textContent = 'Rs. ' + Number(data.totalPrice).toLocaleString();
                        document.getElementById('discountAmount').textContent = '- Rs. ' + Number(data.discount).toLocaleString();
                        document.getElementById('finalPrice').textContent = 'Rs. ' + Number(data.finalPrice).toLocaleString();
                    }
                })
                .catch(err => console.error(err));
            }

            function applyCoupon() {
                const code = document.getElementById('couponCode').value;
                if (!code) return;

                fetch(ctx + '/validate_coupon', {
                    method: 'POST',
                    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                    body: 'code=' + encodeURIComponent(code)
                })
                .then(r => r.json())
                .then(data => {
                    const msgDiv = document.getElementById('couponMessage');
                    if (data.valid) {
                        msgDiv.innerHTML = '<small class="text-success"><i class="fas fa-check-circle"></i> Coupon applied! ' + data.discount + '% off</small>';
                        calculatePrice();
                    } else {
                        msgDiv.innerHTML = '<small class="text-danger"><i class="fas fa-times-circle"></i> ' + data.message + '</small>';
                    }
                })
                .catch(err => console.error(err));
            }

            // Handle Booking Submission over AJAX
            const bookingForm = document.getElementById('bookingForm');
            if (bookingForm) {
                bookingForm.addEventListener('submit', function(e) {
                    e.preventDefault();
                    
                    if (!this.checkValidity()) {
                        e.stopPropagation();
                        this.classList.add('was-validated');
                        return;
                    }
                    this.classList.add('was-validated');
                    
                    const startDate = document.getElementById('startDate').value;
                    const endDate = document.getElementById('endDate').value;
                    if (new Date(endDate) < new Date(startDate)) {
                        showToast('Return date cannot be before pickup date.', 'error');
                        return;
                    }

                    if (typeof showGlobalLoader === 'function') showGlobalLoader();
                    
                    const formData = new FormData(this);
                    const paymentMethod = formData.get('paymentMethod');
                    
                    const submitFinalBooking = (extraData) => {
                        const submitData = new URLSearchParams(formData);
                        if (extraData) {
                            for (const [key, value] of Object.entries(extraData)) {
                                submitData.append(key, value);
                            }
                        }
                        
                        fetch(ctx + '/book_car', {
                            method: 'POST',
                            body: submitData
                        })
                        .then(response => response.json())
                        .then(data => {
                            if (typeof hideGlobalLoader === 'function') hideGlobalLoader();
                            if (data.success) {
                                showSuccessModal(
                                    'Booking Confirmed!', 
                                    data.message || 'Your booking has been successfully confirmed.',
                                    function() {
                                        window.location.href = data.redirect || ctx + '/profile#bookings';
                                    }
                                );
                            } else {
                                showToast(data.message || 'Failed to confirm booking', 'error');
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            if (typeof hideGlobalLoader === 'function') hideGlobalLoader();
                            showToast('An unexpected error occurred.', 'error');
                        });
                    };

                    if (paymentMethod === 'Online') {
                        // Create Razorpay Order first
                        fetch(ctx + '/create_razorpay_order', {
                            method: 'POST',
                            body: new URLSearchParams(formData)
                        })
                        .then(res => res.json())
                        .then(orderData => {
                            if (typeof hideGlobalLoader === 'function') hideGlobalLoader();
                            if (!orderData.success) {
                                showToast(orderData.message || 'Failed to initialize payment', 'error');
                                return;
                            }
                            
                            var options = {
                                "key": orderData.keyId,
                                "amount": orderData.amount,
                                "currency": orderData.currency,
                                "name": "Carent - Car Rental",
                                "description": "Booking Payment",
                                "order_id": orderData.orderId,
                                "handler": function (response) {
                                    if (typeof showGlobalLoader === 'function') showGlobalLoader();
                                    submitFinalBooking({
                                        razorpay_payment_id: response.razorpay_payment_id,
                                        razorpay_order_id: response.razorpay_order_id,
                                        razorpay_signature: response.razorpay_signature
                                    });
                                },
                                "prefill": {
                                    "name": "${sessionScope.loggedUser.fullName}",
                                    "email": "${sessionScope.loggedUser.email}",
                                    "contact": "${sessionScope.loggedUser.phone}"
                                },
                                "theme": {
                                    "color": "#0d6efd"
                                }
                            };
                            
                            if (typeof window.Razorpay === 'undefined') {
                                showToast('Razorpay SDK failed to load.', 'error');
                                return;
                            }
                            var rzp1 = new window.Razorpay(options);
                            rzp1.on('payment.failed', function (response){
                                showToast('Payment Failed: ' + response.error.description, 'error');
                            });
                            rzp1.open();
                        })
                        .catch(err => {
                            console.error(err);
                            if (typeof hideGlobalLoader === 'function') hideGlobalLoader();
                            showToast('Error connecting to payment gateway.', 'error');
                        });
                    } else {
                        submitFinalBooking();
                    }
                });
            }
        </script>

        <!-- Leaflet JS -->
        <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js" integrity="sha256-20nQCchB9co0qIjJZRGuk2/Z9VM+kNiyxNV1lvTlZBo=" crossorigin=""></script>
        <script>
            // Leaflet Map Initialization for Rajkot bounds
            let map, pickupMarker, dropMarker;
            let currentMode = null; // 'pickup' or 'drop'
            
            // Rajkot bounds: lat 22.15 to 22.45, lng 70.65 to 70.95
            const BOUNDS = [
                [22.15, 70.65], // Southwest
                [22.45, 70.95]  // Northeast
            ];

            function initMap() {
                if (document.getElementById('rajkotMap')) {
                    map = L.map('rajkotMap', {
                        maxBounds: BOUNDS,
                        maxBoundsViscosity: 1.0,
                        minZoom: 11
                    }).setView([22.30, 70.80], 12);
                    
                    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                        attribution: '&copy; OpenStreetMap contributors'
                    }).addTo(map);

                    map.on('click', function(e) {
                        if (!currentMode) {
                            showToast("Please click the marker icon next to Pickup or Drop input first.", "info");
                            return;
                        }

                        const lat = e.latlng.lat;
                        const lng = e.latlng.lng;
                        
                        // Enforce Rajkot bounds
                        if (lat < 22.15 || lat > 22.45 || lng < 70.65 || lng > 70.95) {
                            showToast("Selected location is outside Rajkot city boundaries.", "error");
                            return;
                        }

                        // Reverse Geocoding via server-side JSP proxy
                        var geocodeUrl = '${pageContext.request.contextPath}/geocode.jsp?lat=' + lat + '&lon=' + lng;
                        fetch(geocodeUrl)
                            .then(res => {
                                if (!res.ok) throw new Error("Network not OK: " + res.status);
                                return res.json();
                            })
                            .then(data => {
                                let address = "Selected Location";
                                if (data && data.display_name) {
                                    // Use Nominatim's high-precision display_name via proxy
                                    address = data.display_name.split(',').slice(0, 4).join(',');
                                }

                                if (currentMode === 'pickup') {
                                    if (pickupMarker) map.removeLayer(pickupMarker);
                                    pickupMarker = L.marker([lat, lng], {icon: createIcon('green')}).addTo(map)
                                        .bindPopup("Pickup: " + address).openPopup();
                                    document.getElementById('pickupLocation').value = address.trim();
                                    setSelectionMode('drop'); // Auto switch
                                } else if (currentMode === 'drop') {
                                    if (dropMarker) map.removeLayer(dropMarker);
                                    dropMarker = L.marker([lat, lng], {icon: createIcon('red')}).addTo(map)
                                        .bindPopup("Drop: " + address).openPopup();
                                    document.getElementById('dropLocation').value = address.trim();
                                    currentMode = null;
                                    document.getElementById('mapInstructions').textContent = "Both locations selected.";
                                }
                            })
                            .catch(err => {
                                showToast("Error retrieving address, please try again.", "error");
                            });
                    });
                }
            }

            function setSelectionMode(mode) {
                currentMode = mode;
                document.getElementById('mapInstructions').innerHTML = mode === 'pickup' 
                    ? "<span class='text-success fw-bold'>Click on the map to select PICKUP location within Rajkot.</span>"
                    : "<span class='text-danger fw-bold'>Click on the map to select DROP location within Rajkot.</span>";
            }
            
            function createIcon(color) {
                return new L.Icon({
                    iconUrl: `https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-2x-${color}.png`,
                    shadowUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/0.7.7/images/marker-shadow.png',
                    iconSize: [25, 41],
                    iconAnchor: [12, 41],
                    popupAnchor: [1, -34],
                    shadowSize: [41, 41]
                });
            }

            // Init map after DOM
            document.addEventListener("DOMContentLoaded", initMap);
        </script>

        <!-- Admin Contact Reply Modal setup for next phase removed from booking but kept just in case -->
        
    <%@ include file="components/footer.jsp" %>
