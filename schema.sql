-- =============================================
-- CARENT - Car Rental System Database Schema
-- PostgreSQL
-- =============================================

-- Drop tables in reverse dependency order
DROP TABLE IF EXISTS reviews CASCADE;
DROP TABLE IF EXISTS notifications CASCADE;
DROP TABLE IF EXISTS contact_messages CASCADE;
DROP TABLE IF EXISTS bookings CASCADE;
DROP TABLE IF EXISTS coupons CASCADE;
DROP TABLE IF EXISTS user_documents CASCADE;
DROP TABLE IF EXISTS cars CASCADE;
DROP TABLE IF EXISTS otps CASCADE;
DROP TABLE IF EXISTS users CASCADE;

-- =============================================
-- 1. USERS TABLE
-- =============================================
CREATE TABLE users (
    user_id       SERIAL PRIMARY KEY,
    full_name     VARCHAR(100) NOT NULL,
    email         VARCHAR(150) UNIQUE NOT NULL,
    phone         VARCHAR(15),
    username      VARCHAR(50) UNIQUE NOT NULL,
    password      VARCHAR(255) NOT NULL,
    license_no    VARCHAR(50),
    id_url        TEXT,
    license_url   TEXT,
    role          VARCHAR(20) DEFAULT 'Customer' CHECK (role IN ('Admin', 'Customer')),
    is_verified   BOOLEAN DEFAULT FALSE,
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Default admin account (password: admin123 hashed with SHA-256)
INSERT INTO users (full_name, email, phone, username, password, license_no, role, is_verified)
VALUES ('System Admin', 'admin@carent.com', '9999999999', 'admin',
        '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9',
        'ADMIN-000', 'Admin', TRUE);

-- =============================================
-- 2. USER_DOCUMENTS TABLE
-- =============================================
CREATE TABLE user_documents (
    doc_id              SERIAL PRIMARY KEY,
    user_id             INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    license_image_url   VARCHAR(500),
    id_front_url        VARCHAR(500),
    id_back_url         VARCHAR(500),
    uploaded_at         TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =============================================
-- 3. CARS TABLE
-- =============================================
CREATE TABLE cars (
    car_id        SERIAL PRIMARY KEY,
    name          VARCHAR(100) NOT NULL,
    brand         VARCHAR(50) NOT NULL,
    price_per_day DECIMAL(10, 2) NOT NULL,
    fuel_type     VARCHAR(20) DEFAULT 'Petrol' CHECK (fuel_type IN ('Petrol', 'Diesel', 'Electric', 'Hybrid')),
    transmission  VARCHAR(20) DEFAULT 'Automatic' CHECK (transmission IN ('Automatic', 'Manual')),
    image_url     VARCHAR(500),
    status        VARCHAR(20) DEFAULT 'Available' CHECK (status IN ('Available', 'Booked', 'Service')),
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Sample cars
INSERT INTO cars (name, brand, price_per_day, fuel_type, transmission, image_url, status) VALUES
('Toyota Corolla', 'Toyota', 5000.00, 'Petrol', 'Automatic', '', 'Available'),
('Honda Civic', 'Honda', 6500.00, 'Petrol', 'Automatic', '', 'Available'),
('Nissan X-Trail', 'Nissan', 8000.00, 'Diesel', 'Automatic', '', 'Available'),
('BMW 3 Series', 'BMW', 12000.00, 'Petrol', 'Automatic', '', 'Available'),
('Suzuki Swift', 'Suzuki', 3500.00, 'Petrol', 'Manual', '', 'Available');

-- =============================================
-- 4. BOOKINGS TABLE
-- =============================================
CREATE TABLE bookings (
    booking_id      SERIAL PRIMARY KEY,
    user_id         INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    car_id          INT NOT NULL REFERENCES cars(car_id) ON DELETE CASCADE,
    pickup_location VARCHAR(200),
    drop_location   VARCHAR(200),       
    start_date      DATE NOT NULL,
    end_date        DATE NOT NULL,
    total_days      INT NOT NULL,
    total_price     DECIMAL(10, 2) NOT NULL,
    discount_amount DECIMAL(10, 2) DEFAULT 0,
    final_price     DECIMAL(10, 2) NOT NULL,
    booking_status  VARCHAR(20) DEFAULT 'Pending' CHECK (booking_status IN ('Pending', 'Confirmed', 'Completed', 'Cancelled')),
    payment_method  VARCHAR(50) DEFAULT 'Cash',
    transaction_id  VARCHAR(100),
    payment_status  VARCHAR(20) DEFAULT 'Unpaid' CHECK (payment_status IN ('Unpaid', 'Paid', 'Refunded')),
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =============================================
-- 5. COUPONS TABLE
-- =============================================
CREATE TABLE coupons (
    coupon_id           SERIAL PRIMARY KEY,
    code                VARCHAR(50) UNIQUE NOT NULL,
    discount_percentage DECIMAL(5, 2) NOT NULL CHECK (discount_percentage > 0 AND discount_percentage <= 100),
    expiry_date         DATE NOT NULL,
    is_active           BOOLEAN DEFAULT TRUE
);

-- Sample coupons
INSERT INTO coupons (code, discount_percentage, expiry_date, is_active) VALUES
('WELCOME10', 10.00, '2026-12-31', TRUE),
('SAVE20', 20.00, '2026-06-30', TRUE),
('SUMMER15', 15.00, '2026-08-31', TRUE);

-- =============================================
-- 6. REVIEWS TABLE
-- =============================================
CREATE TABLE reviews (
    review_id   SERIAL PRIMARY KEY,
    booking_id  INT NOT NULL REFERENCES bookings(booking_id) ON DELETE CASCADE,
    user_id     INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    car_id      INT NOT NULL REFERENCES cars(car_id) ON DELETE CASCADE,
    rating      INT NOT NULL CHECK (rating >= 1 AND rating <= 5),
    comment     TEXT,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(booking_id)
);

-- =============================================
-- 7. NOTIFICATIONS TABLE
-- =============================================
CREATE TABLE notifications (
    notification_id SERIAL PRIMARY KEY,
    user_id         INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    message         TEXT NOT NULL,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =============================================
-- 8. CONTACT_MESSAGES TABLE
-- =============================================
CREATE TABLE contact_messages (
    message_id  SERIAL PRIMARY KEY,
    user_id     INT REFERENCES users(user_id) ON DELETE SET NULL,
    name        VARCHAR(100),
    email       VARCHAR(150),
    subject     VARCHAR(200),
    message     TEXT NOT NULL,
    reply       TEXT,
    status      VARCHAR(20) DEFAULT 'Unread' CHECK (status IN ('Unread', 'Read', 'Replied')),
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =============================================
-- 9. OTPS TABLE (Email Verification)
-- =============================================
CREATE TABLE otps (
    email       VARCHAR(255) PRIMARY KEY,
    otp         VARCHAR(6) NOT NULL,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =============================================
-- INDEXES for performance
-- =============================================
CREATE INDEX idx_bookings_user ON bookings(user_id);
CREATE INDEX idx_bookings_car ON bookings(car_id);
CREATE INDEX idx_bookings_dates ON bookings(start_date, end_date);
CREATE INDEX idx_bookings_status ON bookings(booking_status);
CREATE INDEX idx_reviews_car ON reviews(car_id);
CREATE INDEX idx_reviews_user ON reviews(user_id);
CREATE INDEX idx_cars_status ON cars(status);
CREATE INDEX idx_cars_brand ON cars(brand);
CREATE INDEX idx_contact_status ON contact_messages(status);
CREATE INDEX idx_otp_created_at ON otps(created_at);
