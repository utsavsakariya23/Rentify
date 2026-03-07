<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ include file="components/header.jsp" %>

        <main class="py-5" style="margin-top: 60px;">
            <!-- Header -->
            <section class="container text-center mb-5">
                <h6 class="text-primary fw-bold text-uppercase">Get In Touch</h6>
                <h1 class="display-5 fw-bold">We'd Love to Hear From You</h1>
                <p class="lead text-muted w-75 mx-auto">
                    Have questions about our fleet, pricing, or your booking? Our team is ready to assist you.
                </p>
            </section>

            <!-- Content -->
            <section class="container mb-5">
                <div class="row g-5">
                    <!-- Contact Info -->
                    <div class="col-lg-5">
                        <div class="card card-modern border-0 h-100 p-4 bg-primary text-white">
                            <h3 class="fw-bold mb-4">Contact Information</h3>
                            <p class="mb-5 opacity-75">Fill up the form and our team will get back to you within 24
                                hours.</p>

                            <div class="d-flex mb-4 align-items-center">
                                <div class="bg-white bg-opacity-25 rounded-circle d-flex align-items-center justify-content-center me-3"
                                    style="width: 50px; height: 50px;">
                                    <i class="fas fa-phone-alt"></i>
                                </div>
                                <div>
                                    <h6 class="fw-bold mb-0">Phone</h6>
                                    <p class="mb-0 opacity-75">+94 11 234 5678</p>
                                </div>
                            </div>

                            <div class="d-flex mb-4 align-items-center">
                                <div class="bg-white bg-opacity-25 rounded-circle d-flex align-items-center justify-content-center me-3"
                                    style="width: 50px; height: 50px;">
                                    <i class="fas fa-envelope"></i>
                                </div>
                                <div>
                                    <h6 class="fw-bold mb-0">Email</h6>
                                    <p class="mb-0 opacity-75">support@easyrental.com</p>
                                </div>
                            </div>

                            <div class="d-flex mb-5 align-items-center">
                                <div class="bg-white bg-opacity-25 rounded-circle d-flex align-items-center justify-content-center me-3"
                                    style="width: 50px; height: 50px;">
                                    <i class="fas fa-map-marker-alt"></i>
                                </div>
                                <div>
                                    <h6 class="fw-bold mb-0">Address</h6>
                                    <p class="mb-0 opacity-75">123, Galle Road, Colombo 03, Sri Lanka</p>
                                </div>
                            </div>

                            <div class="mt-auto">
                                <h6 class="fw-bold mb-3">Follow Us</h6>
                                <div class="d-flex gap-3">
                                    <a href="#" class="text-white"><i class="fab fa-facebook-f fa-lg"></i></a>
                                    <a href="#" class="text-white"><i class="fab fa-twitter fa-lg"></i></a>
                                    <a href="#" class="text-white"><i class="fab fa-instagram fa-lg"></i></a>
                                    <a href="#" class="text-white"><i class="fab fa-linkedin-in fa-lg"></i></a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Contact Form -->
                    <div class="col-lg-7">
                        <div class="card card-modern border-0 p-4 h-100">
                            <h3 class="fw-bold mb-4">Send Message</h3>
                            <form>
                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <label class="form-label small fw-bold text-muted">FIRST NAME</label>
                                        <input type="text" class="form-control bg-light border-0 py-2"
                                            placeholder="John">
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label small fw-bold text-muted">LAST NAME</label>
                                        <input type="text" class="form-control bg-light border-0 py-2"
                                            placeholder="Doe">
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label small fw-bold text-muted">EMAIL</label>
                                        <input type="email" class="form-control bg-light border-0 py-2"
                                            placeholder="john@example.com">
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label small fw-bold text-muted">PHONE</label>
                                        <input type="tel" class="form-control bg-light border-0 py-2"
                                            placeholder="+94 77 123 4567">
                                    </div>
                                    <div class="col-12">
                                        <label class="form-label small fw-bold text-muted">MESSAGE</label>
                                        <textarea class="form-control bg-light border-0 py-2" rows="5"
                                            placeholder="Your message here..."></textarea>
                                    </div>
                                    <div class="col-12 text-end">
                                        <button type="submit" class="btn btn-primary-custom px-5 btn-lg">Send
                                            Message</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Map Placeholder -->
            <section class="container-fluid p-0">
                <div
                    style="width: 100%; height: 400px; background-color: #e9ecef; display: flex; align-items: center; justify-content: center;">
                    <p class="text-muted"><i class="fas fa-map-marked-alt fa-3x mb-2 d-block text-center"></i>Google
                        Maps Placeholder</p>
                </div>
            </section>
        </main>

        <%@ include file="components/footer.jsp" %>