<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ include file="components/header.jsp" %>

        <main class="container my-5 pt-5">
            <div class="row">
                <!-- Sidebar Filters -->
                <div class="col-lg-3 mb-4">
                    <div class="glass-panel p-4 rounded-3 sticky-top" style="top: 100px; background: white;">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h5 class="fw-bold mb-0">Filters</h5>
                            <button class="btn btn-sm btn-link text-decoration-none"
                                onclick="resetFilters()">Reset</button>
                        </div>

                        <!-- Price Range -->
                        <div class="mb-4">
                            <label class="form-label fw-bold small text-muted">PRICE RANGE (PER DAY)</label>
                            <input type="range" class="form-range" min="3000" max="15000" step="500" id="priceRange"
                                oninput="updatePriceLabel(this.value)">
                            <div class="d-flex justify-content-between text-muted small">
                                <span>Rs. 3000</span>
                                <span id="priceLabel" class="fw-bold text-primary">Rs. 15000</span>
                            </div>
                        </div>

                        <!-- Brand -->
                        <div class="mb-4">
                            <label class="form-label fw-bold small text-muted">BRAND</label>
                            <div class="form-check">
                                <input class="form-check-input filter-brand" type="checkbox" value="Toyota"
                                    id="brandToyota" checked>
                                <label class="form-check-label" for="brandToyota">Toyota</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input filter-brand" type="checkbox" value="Honda"
                                    id="brandHonda" checked>
                                <label class="form-check-label" for="brandHonda">Honda</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input filter-brand" type="checkbox" value="Nissan"
                                    id="brandNissan" checked>
                                <label class="form-check-label" for="brandNissan">Nissan</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input filter-brand" type="checkbox" value="BMW" id="brandBMW"
                                    checked>
                                <label class="form-check-label" for="brandBMW">BMW</label>
                            </div>
                        </div>

                        <!-- Color -->
                        <div class="mb-4">
                            <label class="form-label fw-bold small text-muted">COLOR</label>
                            <div class="d-flex flex-wrap gap-2">
                                <div class="filter-color rounded-circle border"
                                    style="width: 25px; height: 25px; background: white; cursor: pointer;"
                                    data-color="White" title="White"></div>
                                <div class="filter-color rounded-circle"
                                    style="width: 25px; height: 25px; background: black; cursor: pointer;"
                                    data-color="Black" title="Black"></div>
                                <div class="filter-color rounded-circle"
                                    style="width: 25px; height: 25px; background: silver; cursor: pointer;"
                                    data-color="Silver" title="Silver"></div>
                                <div class="filter-color rounded-circle"
                                    style="width: 25px; height: 25px; background: red; cursor: pointer;"
                                    data-color="Red" title="Red"></div>
                                <div class="filter-color rounded-circle"
                                    style="width: 25px; height: 25px; background: blue; cursor: pointer;"
                                    data-color="Blue" title="Blue"></div>
                            </div>
                            <input type="hidden" id="selectedColor" value="">
                        </div>

                        <!-- Rating -->
                        <div class="mb-4">
                            <label class="form-label fw-bold small text-muted">MIN RATING</label>
                            <select class="form-select form-select-sm" id="minRating">
                                <option value="0">Any</option>
                                <option value="4">4+ Stars</option>
                                <option value="4.5">4.5+ Stars</option>
                            </select>
                        </div>
                    </div>
                </div>

                <!-- Vehicle Grid -->
                <div class="col-lg-9">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h4 class="fw-bold">Available Vehicles <span class="text-muted fs-6"
                                id="vehicleCount">(3)</span></h4>
                        <div class="dropdown">
                            <button class="btn btn-outline-secondary btn-sm dropdown-toggle" type="button"
                                data-bs-toggle="dropdown">
                                Sort By: Recommended
                            </button>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="#">Price: Low to High</a></li>
                                <li><a class="dropdown-item" href="#">Price: High to Low</a></li>
                                <li><a class="dropdown-item" href="#">Newest First</a></li>
                            </ul>
                        </div>
                    </div>

                    <div class="row g-4" id="vehicleGrid">
                        <!-- Car 1 -->
                        <div class="col-md-6 col-lg-4 vehicle-card" data-brand="Toyota" data-price="5000"
                            data-color="White" data-rating="4.5">
                            <div class="card card-modern h-100">
                                <div class="card-img-wrapper position-relative">
                                    <span class="badge bg-success position-absolute top-0 start-0 m-3">AVAILABLE</span>
                                    <img src="${pageContext.request.contextPath}/assets/img/toyota_corolla.webp"
                                        alt="Toyota Corolla">
                                </div>
                                <div class="card-body p-4">
                                    <div class="d-flex justify-content-between mb-2">
                                        <h5 class="card-title fw-bold">Toyota Corolla</h5>
                                        <div class="text-warning small"><i class="fas fa-star"></i> 4.5</div>
                                    </div>
                                    <p class="text-muted small mb-3">Sedan • Automatic • Petrol</p>
                                    <ul class="list-unstyled small text-muted mb-3">
                                        <li><i class="fas fa-check text-success me-2"></i>AC</li>
                                        <li><i class="fas fa-check text-success me-2"></i>Bluetooth</li>
                                        <li><i class="fas fa-check text-success me-2"></i>4 Passengers</li>
                                    </ul>
                                    <div class="d-flex justify-content-between align-items-center mt-3 pt-3 border-top">
                                        <div>
                                            <span class="h5 fw-bold text-primary">Rs. 5,000</span>
                                            <span class="text-muted small">/day</span>
                                        </div>
                                        <a href="${pageContext.request.contextPath}/car_info?id=1"
                                            class="btn btn-sm btn-primary-custom rounded-pill px-3">Rent Now</a>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Car 2 -->
                        <div class="col-md-6 col-lg-4 vehicle-card" data-brand="Honda" data-price="6500"
                            data-color="Silver" data-rating="4.8">
                            <div class="card card-modern h-100">
                                <div class="card-img-wrapper">
                                    <img src="${pageContext.request.contextPath}/assets/img/honda_civic.webp"
                                        alt="Honda Civic">
                                </div>
                                <div class="card-body p-4">
                                    <div class="d-flex justify-content-between mb-2">
                                        <h5 class="card-title fw-bold">Honda Civic</h5>
                                        <div class="text-warning small"><i class="fas fa-star"></i> 4.8</div>
                                    </div>
                                    <p class="text-muted small mb-3">Sedan • Automatic • Petrol</p>
                                    <ul class="list-unstyled small text-muted mb-3">
                                        <li><i class="fas fa-check text-success me-2"></i>AC</li>
                                        <li><i class="fas fa-check text-success me-2"></i>GPS</li>
                                        <li><i class="fas fa-check text-success me-2"></i>5 Passengers</li>
                                    </ul>
                                    <div class="d-flex justify-content-between align-items-center mt-3 pt-3 border-top">
                                        <div>
                                            <span class="h5 fw-bold text-primary">Rs. 6,500</span>
                                            <span class="text-muted small">/day</span>
                                        </div>
                                        <a href="${pageContext.request.contextPath}/car_info?id=2"
                                            class="btn btn-sm btn-primary-custom rounded-pill px-3">Rent Now</a>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Car 3 -->
                        <div class="col-md-6 col-lg-4 vehicle-card" data-brand="Nissan" data-price="8000"
                            data-color="Black" data-rating="4.7">
                            <div class="card card-modern h-100">
                                <div class="card-img-wrapper">
                                    <img src="${pageContext.request.contextPath}/assets/img/nissan_x_trail.webp"
                                        alt="Nissan X-Trail">
                                </div>
                                <div class="card-body p-4">
                                    <div class="d-flex justify-content-between mb-2">
                                        <h5 class="card-title fw-bold">Nissan X-Trail</h5>
                                        <div class="text-warning small"><i class="fas fa-star"></i> 4.7</div>
                                    </div>
                                    <p class="text-muted small mb-3">SUV • Automatic • Diesel</p>
                                    <ul class="list-unstyled small text-muted mb-3">
                                        <li><i class="fas fa-check text-success me-2"></i>AC</li>
                                        <li><i class="fas fa-check text-success me-2"></i>Off-road</li>
                                        <li><i class="fas fa-check text-success me-2"></i>5 Passengers</li>
                                    </ul>
                                    <div class="d-flex justify-content-between align-items-center mt-3 pt-3 border-top">
                                        <div>
                                            <span class="h5 fw-bold text-primary">Rs. 8,000</span>
                                            <span class="text-muted small">/day</span>
                                        </div>
                                        <a href="${pageContext.request.contextPath}/car_info?id=3"
                                            class="btn btn-sm btn-primary-custom rounded-pill px-3">Rent Now</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- No Results Message -->
                    <div id="noResults" class="text-center py-5" style="display: none;">
                        <i class="fas fa-search fa-3x text-muted mb-3"></i>
                        <h5 class="text-muted">No vehicles found matching your criteria.</h5>
                        <button class="btn btn-link" onclick="resetFilters()">Clear Filters</button>
                    </div>

                </div>
            </div>
        </main>

        <script>
            function updatePriceLabel(val) {
                document.getElementById('priceLabel').innerText = 'Rs. ' + val;
                filterVehicles();
            }

            // Color Selection
            const colorOptions = document.querySelectorAll('.filter-color');
            colorOptions.forEach(opt => {
                opt.addEventListener('click', function () {
                    // Toggle selection logic
                    colorOptions.forEach(o => o.style.border = '1px solid #ddd');
                    this.style.border = '2px solid var(--primary-color)';
                    document.getElementById('selectedColor').value = this.getAttribute('data-color');
                    filterVehicles();
                });
            });

            // Checkboxes change
            const brandChecks = document.querySelectorAll('.filter-brand');
            brandChecks.forEach(chk => {
                chk.addEventListener('change', filterVehicles);
            });

            // Rating change
            document.getElementById('minRating').addEventListener('change', filterVehicles);

            function filterVehicles() {
                const maxPrice = parseInt(document.getElementById('priceRange').value);
                const selectedBrands = Array.from(document.querySelectorAll('.filter-brand:checked')).map(cb => cb.value);
                const selectedColor = document.getElementById('selectedColor').value;
                const minRating = parseFloat(document.getElementById('minRating').value);

                const cards = document.querySelectorAll('.vehicle-card');
                let visibleCount = 0;

                cards.forEach(card => {
                    const price = parseInt(card.getAttribute('data-price'));
                    const brand = card.getAttribute('data-brand');
                    const color = card.getAttribute('data-color');
                    const rating = parseFloat(card.getAttribute('data-rating'));

                    let show = true;

                    if (price > maxPrice) show = false;
                    if (selectedBrands.length > 0 && !selectedBrands.includes(brand)) show = false;
                    if (selectedColor && color !== selectedColor) show = false;
                    if (rating < minRating) show = false;

                    if (show) {
                        card.style.display = 'block';
                        visibleCount++;
                    } else {
                        card.style.display = 'none';
                    }
                });

                document.getElementById('vehicleCount').innerText = '(' + visibleCount + ')';

                if (visibleCount === 0) {
                    document.getElementById('noResults').style.display = 'block';
                } else {
                    document.getElementById('noResults').style.display = 'none';
                }
            }

            function resetFilters() {
                document.getElementById('priceRange').value = 15000;
                updatePriceLabel(15000);
                document.querySelectorAll('.filter-brand').forEach(cb => cb.checked = true);
                document.getElementById('selectedColor').value = '';
                document.querySelectorAll('.filter-color').forEach(o => o.style.border = '1px solid #ddd');
                document.getElementById('minRating').value = 0;
                filterVehicles();
            }
        </script>

        <%@ include file="components/footer.jsp" %>