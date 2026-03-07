<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Easy Rental</title>

            <!-- Fonts -->
            <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
                rel="stylesheet">

            <!-- CSS -->
            <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.min.css">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/modern-global.css">
        </head>

        <body>

            <!-- Navbar -->
            <nav class="navbar navbar-expand-lg navbar-custom fixed-top">
                <div class="container">
                    <a class="navbar-brand fw-bold fs-4" href="${pageContext.request.contextPath}/home">
                        <i class="fas fa-car-side me-2 text-primary"></i>EASY RENTAL
                    </a>
                    <button class="navbar-toggler navbar-dark" type="button" data-bs-toggle="collapse"
                        data-bs-target="#navbarNav">
                        <span class="navbar-toggler-icon"></span>
                    </button>

                    <div class="collapse navbar-collapse" id="navbarNav">
                        <ul class="navbar-nav mx-auto">
                            <li class="nav-item"><a class="nav-link"
                                    href="${pageContext.request.contextPath}/home">HOME</a>
                            </li>
                            <li class="nav-item"><a class="nav-link"
                                    href="${pageContext.request.contextPath}/vehicles">VEHICLES</a></li>
                            <li class="nav-item"><a class="nav-link"
                                    href="${pageContext.request.contextPath}/about">ABOUT</a></li>
                            <li class="nav-item"><a class="nav-link"
                                    href="${pageContext.request.contextPath}/contact">CONTACT</a></li>
                        </ul>

                        <ul class="navbar-nav">
                            <c:choose>
                                <c:when test="${not empty sessionScope.user}">
                                    <%-- User is Logged In --%>
                                        <li class="nav-item">
                                            <a class="nav-link" href="${pageContext.request.contextPath}/profile">
                                                <i class="fas fa-user-circle me-1"></i> PROFILE
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link text-danger"
                                                href="${pageContext.request.contextPath}/logout">LOGOUT</a>
                                        </li>
                                </c:when>
                                <c:otherwise>
                                    <%-- Guest User --%>
                                        <li class="nav-item">
                                            <a class="nav-link text-dark"
                                                href="${pageContext.request.contextPath}/login">LOGIN</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="btn btn-outline-primary ms-2 px-4"
                                                href="${pageContext.request.contextPath}/register">REGISTER</a>
                                        </li>
                                </c:otherwise>
                            </c:choose>
                        </ul>
                    </div>
                </div>
            </nav>

            <!-- Spacing for fixed navbar if needed, handled in CSS by page padding usually -->