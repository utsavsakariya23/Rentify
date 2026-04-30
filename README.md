<p align="center">
  <h1 align="center">🚗 Rentify — Car Rental Management System</h1>
  <p align="center">
    A full-stack Java web application for online car rental with integrated payments, admin dashboard, and document verification.
  </p>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Java-17-ED8B00?style=for-the-badge&logo=openjdk&logoColor=white" />
  <img src="https://img.shields.io/badge/Jakarta_EE-6.0-blue?style=for-the-badge&logo=jakarta-ee&logoColor=white" />
  <img src="https://img.shields.io/badge/PostgreSQL-16-4169E1?style=for-the-badge&logo=postgresql&logoColor=white" />
  <img src="https://img.shields.io/badge/Maven-3.9-C71A36?style=for-the-badge&logo=apachemaven&logoColor=white" />
  <img src="https://img.shields.io/badge/Tomcat-10-F8DC75?style=for-the-badge&logo=apachetomcat&logoColor=black" />
</p>

---

## 📋 Table of Contents

- [About](#-about)
- [Key Features](#-key-features)
- [Tech Stack](#-tech-stack)
- [Architecture](#-architecture)
- [Database Schema](#-database-schema)
- [Project Structure](#-project-structure)
- [Prerequisites](#-prerequisites)
- [Getting Started](#-getting-started)
- [Configuration](#-configuration)
- [API Endpoints](#-api-endpoints)
- [Testing](#-testing)
- [Default Credentials](#-default-credentials)
- [Screenshots](#-screenshots)
- [Contributing](#-contributing)
- [License](#-license)

---

## 📖 About

**Rentify** is a comprehensive car rental management platform built with Java Servlets (Jakarta EE 6.0) and JSP. It provides a seamless experience for customers to browse, book, and pay for rental cars online, while giving administrators a powerful dashboard to manage fleet operations, finances, bookings, and customer verification.

The application follows a classic **MVC (Model-View-Controller)** architecture with a layered service/repository pattern and is deployed as a WAR package on Apache Tomcat 10+.

---

## ✨ Key Features

### 🧑‍💼 Customer Portal
| Feature | Description |
|---|---|
| **User Registration** | OTP-based email verification during signup |
| **Authentication** | Login with username/email, "Remember Me" cookie support |
| **Vehicle Browsing** | Search & filter cars by keyword, fuel type, transmission, max price |
| **Car Details** | View car info with average rating, review count, and user reviews |
| **Online Booking** | Select dates, pickup/drop locations, apply coupon codes |
| **Payment Gateway** | Razorpay integration for online payments; Cash option available |
| **Coupon System** | Apply discount coupons at checkout with real-time price calculation |
| **Booking Management** | View upcoming/past bookings, cancel bookings, download invoices |
| **Reviews & Ratings** | Submit 1–5 star reviews for completed bookings |
| **Document Upload** | Upload ID & driving license via Cloudinary for admin verification |
| **Profile Management** | Edit profile, change password, view notifications |
| **Forgot Password** | Email-based password reset flow |

### 🛡️ Admin Dashboard
| Feature | Description |
|---|---|
| **Dashboard Overview** | KPIs — total users, bookings, revenue, active cars, pending bookings, unread messages |
| **Vehicle Management** | CRUD operations on cars with Cloudinary image upload |
| **Booking Management** | Confirm, complete, cancel bookings with status filtering & pagination |
| **Payment Management** | Mark as paid, process refunds, filter by status/method, export CSV reports |
| **Customer Management** | View customers, verify/revoke document verification, delete users |
| **Coupon Management** | Create, edit, delete coupons; toggle suggestion visibility; send coupon notifications |
| **Review Moderation** | View all reviews, reply to reviews, delete inappropriate ones, notify users via email |
| **Contact Messages** | View & reply to customer inquiries with email notifications |
| **Notifications** | Send targeted notifications (all users / inactive / active) with optional email broadcast |
| **Analytics** | Monthly revenue charts, booking status breakdown, payment method split, top cars & customers |
| **Finance Module** | Yearly P&L summary, quarterly GST calculations, expense tracking with receipt uploads |
| **Fleet Management** | Track service dates, insurance expiry, mileage for each vehicle |
| **CSV Export** | Export payment data with date-range presets (this month, last 3 months, this year, custom) |

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| **Language** | Java 17 |
| **Web Framework** | Jakarta Servlet 6.0 / JSP / JSTL 3.0 |
| **Build Tool** | Apache Maven 3.9+ |
| **Database** | PostgreSQL 16 |
| **Connection Pool** | HikariCP 5.1 |
| **ORM/Data Access** | Spring JDBC 6.1 (JdbcTemplate) + raw JDBC DAOs |
| **Payment Gateway** | Razorpay Java SDK 1.4.6 |
| **File Storage** | Cloudinary SDK 1.36 |
| **Email** | Jakarta Mail 2.0 (Gmail SMTP) |
| **JSON** | Gson 2.10 + org.json |
| **Logging** | SLF4J Simple 2.0 |
| **Server** | Apache Tomcat 10+ |
| **Testing** | JUnit 5.10 + Mockito 5.11 |
| **Frontend** | JSP, HTML5, CSS3, JavaScript, Bootstrap |

---

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                        CLIENT (Browser)                         │
│              JSP Pages · HTML · CSS · JavaScript                │
└──────────────────────────┬──────────────────────────────────────┘
                           │ HTTP Request/Response
┌──────────────────────────▼──────────────────────────────────────┐
│                     CONTROLLER LAYER                            │
│  PageController · AdminController · BookingController           │
│  ReviewController · ContactController · DocumentUploadServlet   │
│  AdminApiServlet · ForgotPasswordServlet                        │
└──────────────────────────┬──────────────────────────────────────┘
                           │
┌──────────────────────────▼──────────────────────────────────────┐
│                      SERVICE LAYER                              │
│  BookingService · CarService · CouponService · ReviewService    │
│  EmailService · CloudinaryService · OTPService                  │
│  NotificationService · FinanceService                           │
└──────────────────────────┬──────────────────────────────────────┘
                           │
┌──────────────────────────▼──────────────────────────────────────┐
│                    REPOSITORY (DAO) LAYER                       │
│  UserDAO · CarDAO · BookingDAO · CouponDAO · ReviewDAO          │
│  ContactMessageDAO · NotificationDAO · ExpenseDAO · OtpDAO      │
└──────────────────────────┬──────────────────────────────────────┘
                           │ JDBC
┌──────────────────────────▼──────────────────────────────────────┐
│                   PostgreSQL Database                            │
│              9 Tables · Indexed · Normalized                    │
└─────────────────────────────────────────────────────────────────┘
```

---

## 🗄️ Database Schema

The application uses **9 core tables** with proper foreign key relationships and indexes:

```
users ──────────┬──── user_documents
                ├──── bookings ──── reviews
                ├──── notifications
                ├──── contact_messages
                └──── otps

cars ───────────┬──── bookings
                └──── reviews

coupons (standalone)
expenses (standalone)
```

| Table | Purpose |
|---|---|
| `users` | Customer & admin accounts with roles and verification status |
| `user_documents` | Uploaded ID/license images (Cloudinary URLs) |
| `cars` | Vehicle inventory with pricing, fuel type, transmission, status |
| `bookings` | Rental bookings with dates, pricing, payment info, status lifecycle |
| `coupons` | Discount coupon codes with percentage and expiry |
| `reviews` | Customer ratings (1–5) and comments per completed booking |
| `notifications` | System notifications sent to users |
| `contact_messages` | Customer support messages with admin replies |
| `otps` | Temporary OTP codes for email verification |

> 💡 Full schema is available in [`schema.sql`](schema.sql) and sample data in [`rentify.sql`](rentify.sql).

---

## 📁 Project Structure

```
carent/
├── pom.xml                          # Maven build configuration
├── schema.sql                       # Database DDL + sample data
├── rentify.sql                      # Full database dump
│
├── src/main/java/com/carent/
│   ├── config/
│   │   └── DBConnection.java        # PostgreSQL JDBC connection manager
│   ├── controller/
│   │   ├── PageController.java      # Main servlet — all GET routes + auth POST
│   │   ├── AdminController.java     # Admin POST actions (CRUD, payments, etc.)
│   │   ├── AdminApiServlet.java     # Admin AJAX JSON API endpoints
│   │   ├── BookingController.java   # Booking + Razorpay payment endpoints
│   │   ├── ReviewController.java    # Submit review endpoint
│   │   ├── ContactController.java   # Contact form submission
│   │   ├── DocumentUploadServlet.java # Cloudinary document upload
│   │   └── ForgotPasswordServlet.java # Password reset flow
│   ├── model/
│   │   ├── User.java                # User entity
│   │   ├── Car.java                 # Car/vehicle entity
│   │   ├── Booking.java             # Booking entity
│   │   ├── Coupon.java              # Discount coupon entity
│   │   ├── Review.java              # Review/rating entity
│   │   ├── Expense.java             # Business expense entity
│   │   ├── Notification.java        # Notification entity
│   │   └── ContactMessage.java      # Contact message entity
│   ├── repository/
│   │   ├── UserDAO.java             # User data access
│   │   ├── CarDAO.java              # Car data access
│   │   ├── BookingDAO.java          # Booking data access + analytics queries
│   │   ├── CouponDAO.java           # Coupon data access
│   │   ├── ReviewDAO.java           # Review data access
│   │   ├── ExpenseDAO.java          # Expense data access
│   │   ├── NotificationDAO.java     # Notification data access
│   │   ├── ContactMessageDAO.java   # Contact message data access
│   │   └── OtpDAO.java              # OTP storage/verification
│   ├── service/
│   │   ├── BookingService.java      # Booking logic, pricing, coupon application
│   │   ├── CarService.java          # Car search, filtering, CRUD
│   │   ├── CouponService.java       # Coupon validation & usage tracking
│   │   ├── ReviewService.java       # Review submission & moderation
│   │   ├── EmailService.java        # Async email via Gmail SMTP
│   │   ├── CloudinaryService.java   # Image upload to Cloudinary CDN
│   │   ├── OTPService.java          # OTP generation & verification
│   │   ├── NotificationService.java # User notification management
│   │   └── FinanceService.java      # P&L, GST, expense calculations
│   ├── util/
│   │   └── PasswordUtil.java        # SHA-256 password hashing
│   └── DBDbUpdate.java              # Auto database schema migration
│
├── src/main/webapp/
│   ├── WEB-INF/
│   │   ├── web.xml                  # Servlet mappings & multipart config
│   │   └── views/
│   │       ├── home.jsp             # Landing page
│   │       ├── vehicles.jsp         # Car listing with filters
│   │       ├── car_info.jsp         # Car detail + reviews
│   │       ├── booking.jsp          # Booking form + Razorpay checkout
│   │       ├── login.jsp            # Login page
│   │       ├── register.jsp         # Registration with OTP verification
│   │       ├── profile.jsp          # User profile + bookings + notifications
│   │       ├── my_bookings.jsp      # Booking history
│   │       ├── invoice.jsp          # Printable invoice
│   │       ├── contact.jsp          # Contact form
│   │       ├── about.jsp            # About page
│   │       ├── components/
│   │       │   ├── header.jsp       # Shared navigation header
│   │       │   └── footer.jsp       # Shared footer
│   │       └── admin/
│   │           ├── dashboard.jsp    # Admin overview
│   │           ├── vehicles.jsp     # Vehicle CRUD
│   │           ├── rentrequest.jsp  # Booking management
│   │           ├── payments.jsp     # Payment tracking + CSV export
│   │           ├── customers.jsp    # Customer management
│   │           ├── coupons.jsp      # Coupon management
│   │           ├── reviews.jsp      # Review moderation
│   │           ├── messages.jsp     # Contact message replies
│   │           ├── notifications.jsp # Send notifications
│   │           ├── analytics.jsp    # Revenue & booking charts
│   │           ├── finance.jsp      # P&L + GST + expenses
│   │           ├── fleet.jsp        # Fleet maintenance tracking
│   │           ├── profile.jsp      # Admin profile
│   │           └── settings.jsp     # System settings
│   └── assets/                      # Static CSS, JS, images
│
└── src/test/java/com/carent/
    ├── model/                       # Unit tests for all model classes
    ├── service/                     # Unit tests for service layer
    ├── controller/                  # Unit tests for controllers
    └── util/                        # Unit tests for utilities
```

---

## 📌 Prerequisites

Before running the project, ensure you have the following installed:

| Tool | Version | Purpose |
|---|---|---|
| **JDK** | 17+ | Java runtime |
| **Apache Maven** | 3.9+ | Build & dependency management |
| **Apache Tomcat** | 10.1+ | Servlet container (Jakarta EE 6.0) |
| **PostgreSQL** | 14+ | Relational database |
| **Git** | Any | Version control |

---

## 🚀 Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/utsavsakariya23/Rentify.git
cd Rentify
```

### 2. Set Up PostgreSQL Database

Create the database and run the schema script:

```bash
# Connect to PostgreSQL
psql -U postgres

# Create the database
CREATE DATABASE carent_db;

# Connect to it
\c carent_db

# Run the schema (creates tables + sample data)
\i schema.sql
```

> Or import the full dump: `psql -U postgres -d carent_db -f rentify.sql`

### 3. Configure Database Connection

Edit `src/main/java/com/carent/config/DBConnection.java`:

```java
private static final String DB_URL  = "jdbc:postgresql://localhost:5432/carent_db";
private static final String DB_USER = "postgres";
private static final String DB_PASSWORD = "YOUR_PASSWORD";  // ← Change this
```

### 4. Build the Project

```bash
mvn clean package
```

This generates `target/carent-0.0.1-SNAPSHOT.war`.

### 5. Deploy to Tomcat

- Copy the WAR file to Tomcat's `webapps/` directory, **or**
- Configure the project in Eclipse/IntelliJ with Tomcat server integration

### 6. Access the Application

```
Customer Portal:  http://localhost:8080/carent/home
Admin Dashboard:  http://localhost:8080/carent/admin/dashboard
```

---

## ⚙️ Configuration

### Third-Party Service Credentials

The following services require API credentials. Update the respective files before deployment:

| Service | File | Fields to Update |
|---|---|---|
| **PostgreSQL** | `config/DBConnection.java` | `DB_URL`, `DB_USER`, `DB_PASSWORD` |
| **Gmail SMTP** | `service/EmailService.java` | `SMTP_USERNAME`, `SMTP_PASSWORD` (App Password) |
| **Cloudinary** | `service/CloudinaryService.java` | `CLOUD_NAME`, `API_KEY`, `API_SECRET` |
| **Razorpay** | `controller/BookingController.java` | `RZP_KEY_ID`, `RZP_KEY_SECRET` |

### Gmail App Password Setup

1. Enable **2-Step Verification** on your Google account
2. Go to [Google App Passwords](https://myaccount.google.com/apppasswords)
3. Generate an app password for "Mail"
4. Use this 16-character password as `SMTP_PASSWORD`

### Razorpay Setup

1. Sign up at [Razorpay Dashboard](https://dashboard.razorpay.com/)
2. Use **Test Mode** keys for development
3. Replace `RZP_KEY_ID` and `RZP_KEY_SECRET` in `BookingController.java`

---

## 🔌 API Endpoints

### Public Routes

| Method | Endpoint | Description |
|---|---|---|
| `GET` | `/home` | Home page with featured cars |
| `GET` | `/vehicles` | Vehicle listing with search filters |
| `GET` | `/car_info?id={carId}` | Car details with reviews |
| `GET` | `/about` | About page |
| `GET` | `/contact` | Contact form |
| `GET` | `/login` | Login page |
| `GET` | `/register` | Registration page |

### Authentication (POST)

| Method | Endpoint | Description |
|---|---|---|
| `POST` | `/perform_login` | Login with username & password |
| `POST` | `/perform_register` | Register new account (OTP verified) |
| `POST` | `/send_otp` | Send OTP to email (AJAX) |
| `POST` | `/verify_otp` | Verify OTP code (AJAX) |
| `POST` | `/validate_unique` | Check username/email uniqueness (AJAX) |

### Customer Routes (Authenticated)

| Method | Endpoint | Description |
|---|---|---|
| `GET` | `/profile` | User profile + bookings + notifications |
| `GET` | `/my_bookings` | All user bookings |
| `GET` | `/booking?carId={id}` | Booking form |
| `GET` | `/invoice?bookingId={id}` | Printable invoice |
| `POST` | `/book_car` | Create booking (AJAX/JSON) |
| `POST` | `/cancel_booking` | Cancel a booking |
| `POST` | `/calculate_price` | Real-time price calculator (AJAX) |
| `POST` | `/validate_coupon` | Validate coupon code (AJAX) |
| `POST` | `/create_razorpay_order` | Create Razorpay payment order (AJAX) |
| `POST` | `/submit_review` | Submit car review |
| `POST` | `/upload_documents` | Upload ID & license documents |
| `POST` | `/send_message` | Submit contact form |

### Admin Routes (Admin Role Required)

| Method | Endpoint | Description |
|---|---|---|
| `GET` | `/admin/dashboard` | Admin overview with KPIs |
| `GET` | `/admin/vehicles` | Vehicle management |
| `GET` | `/admin/rent` | Booking management |
| `GET` | `/admin/payments` | Payment tracking |
| `GET` | `/admin/customers` | Customer management |
| `GET` | `/admin/coupons` | Coupon management |
| `GET` | `/admin/reviews` | Review moderation |
| `GET` | `/admin/messages` | Contact messages |
| `GET` | `/admin/notifications` | Notifications |
| `GET` | `/admin/analytics` | Revenue analytics & charts |
| `GET` | `/admin/finance` | P&L, GST, expenses |
| `GET` | `/admin/fleet` | Fleet maintenance tracking |
| `POST` | `/admin/add_car` | Add new vehicle |
| `POST` | `/admin/edit_car` | Update vehicle details |
| `POST` | `/admin/delete_car` | Remove vehicle |
| `POST` | `/admin/confirm_booking` | Confirm a pending booking |
| `POST` | `/admin/complete_booking` | Mark booking as completed |
| `POST` | `/admin/cancel_booking` | Admin cancel booking |
| `POST` | `/admin/mark_paid` | Mark booking as paid |
| `POST` | `/admin/refund_payment` | Process refund + notify customer |
| `POST` | `/admin/export_payments_csv` | Export payments to CSV |
| `POST` | `/admin/add_coupon` | Create coupon |
| `POST` | `/admin/verify_user` | Verify/revoke user documents |
| `POST` | `/admin/send_notification` | Broadcast notification |
| `POST` | `/admin/reply_message` | Reply to contact message |
| `POST` | `/admin/add_expense` | Log a business expense |

---

## 🧪 Testing

The project includes **15 unit test files** covering models, services, controllers, and utilities using **JUnit 5** and **Mockito**.

```bash
# Run all tests
mvn test
```

### Test Coverage

| Layer | Test Files |
|---|---|
| **Model** | `UserTest`, `CarTest`, `BookingTest`, `CouponTest`, `ReviewTest`, `ExpenseTest` |
| **Service** | `BookingServiceTest`, `CarServiceTest`, `CouponServiceTest`, `EmailServiceTest`, `ReviewServiceTest` |
| **Controller** | `PageControllerLoginTest`, `PageControllerRoutingTest`, `AdminApiServletTest` |
| **Utility** | `PasswordUtilTest` |

---

## 🔑 Default Credentials

| Role | Username | Password |
|---|---|---|
| **Admin** | `admin` | `admin123` |

> ⚠️ Change the default admin password immediately after first login.

---

## 📸 Screenshots

> _Add screenshots of your application here._
>
> Suggested screenshots:
> - Home page with featured cars
> - Vehicle listing with search filters
> - Booking form with Razorpay checkout
> - User profile dashboard
> - Admin dashboard overview
> - Admin analytics page
> - Admin finance module

---

## 🤝 Contributing

1. **Fork** the repository
2. Create a feature branch: `git checkout -b feature/your-feature`
3. Commit your changes: `git commit -m "Add your feature"`
4. Push to the branch: `git push origin feature/your-feature`
5. Open a **Pull Request**

---

## 📄 License

This project is developed for educational purposes.

---

<p align="center">
  Made with ❤️ by <strong>Utsav Sakariya</strong>
</p>
