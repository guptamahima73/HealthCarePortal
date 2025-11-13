<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>

<%
    String loginSuccess = request.getParameter("login");
%>
<%
    String userName = (String) session.getAttribute("residentName");
    String initials = "";

    if (userName != null && !userName.isEmpty()) {
        String[] nameParts = userName.split(" ");
        for (String part : nameParts) {
            initials += part.charAt(0);
        }
    } else {
        initials = "U";
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Resident Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
        }
        .navbar {
            background: linear-gradient(to right, #4facfe, #00f2fe);
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        .navbar .nav-link {
            color: white !important;
            font-weight: 500;
            margin-right: 20px;
        }
        .navbar .nav-link:hover {
            text-decoration: underline;
        }
        .profile-initials {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            background-color: #0d6efd;
            color: white;
            font-weight: bold;
            text-align: center;
            line-height: 45px;
            border: 2px solid #fff;
        }
        .header-section {
            padding: 30px 20px;
            text-align: center;
            background-color: #e3f2fd;
        }
        .header-section img {
            width: 60px;
            margin-bottom: 10px;
        }
        .feature-cards {
            padding: 40px 20px;
            background-color: #64B5F6;
        }
        .feature-card {
            border-radius: 20px;
            transition: 0.3s;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        .feature-card:hover {
            transform: translateY(-5px);
        }
        .feature-card .card-body i {
            font-size: 2.5rem;
            color: #0d6efd;
        }
        .image-box img {
            width: 100%;
            border-radius: 20px;
        }
        .text-section {
            padding-left: 40px;
        }
          .feature-card {
        background: linear-gradient(to right, #e3f2fd, #ffffff); /* Light blue to white */
        border-radius: 15px;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        transition: transform 0.3s ease-in-out;
    }

    .feature-card:hover {
        transform: translateY(-5px);
    }

    .feature-card i {
        font-size: 2.5rem;
        color: #1976D2;
    }
        
    </style>
     <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg">
    <div class="container-fluid">
        <a class="navbar-brand d-flex align-items-center" href="#">
            <img src="${pageContext.request.contextPath}/resource/logo_swasth.jpg" alt="Logo" width="55" height="55" class="me-2 rounded-circle">
            <span class="text-white fs-4 fw-bold">Swasth Saarthi</span>
        </a>

        <div class="collapse navbar-collapse justify-content-end">
            <ul class="navbar-nav mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/event/event.jsp"><i class="bi bi-calendar-event me-1"></i>Event</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/appointment/bookAppointment.jsp"><i class="bi bi-journal-plus me-1"></i>Appointment</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/blog/blogList.jsp"><i class="bi bi-newspaper me-1"></i>Blog</a>
                </li>
            </ul>
            <div class="dropdown ms-3">
                <button class="btn profile-initials dropdown-toggle" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
                    <%= initials %>
                </button>
                <ul class="dropdown-menu dropdown-menu-end">
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/resident/residentProfile.jsp">User Details</a></li>
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/appointment/appointmentList.jsp">Appointment History</a></li>
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/home.jsp">Log Out</a></li>
                </ul>
            </div>
        </div>
    </div>
</nav>

<%
        if ("success".equals(loginSuccess)) {
    %>
    <script>
        Swal.fire({
            title: 'Login Successful!',
            text: 'Welcome <%= session.getAttribute("residentName") %>!',
            icon: 'success',
            confirmButtonText: 'Continue'
        });
    </script>
    <%
        }
    %>

<!-- Header Section -->
<div class="header-section">
    <img src="https://cdn-icons-png.flaticon.com/512/4320/4320337.png" alt="dashboard icon">
    <h1 class="fw-bold">Welcome to Your Health Dashboard</h1>
    <p class="text-muted">Manage your appointments, stay informed through blogs, and participate in local health events.</p>
</div>

<!-- Dashboard Image and Text -->
<div class="container my-5">
    <div class="row align-items-center">
        <div class="col-md-6">
            <img src ="${pageContext.request.contextPath}/resource/doctor.jpg" alt="dashboard" class="img-fluid rounded">
        </div>
        <div class="col-md-6 text-section">
            <h2 class="fw-bold mb-3">Why Swasth Saarthi?</h2>
            <p class="text-muted">Our platform brings healthcare awareness to your fingertips. Book appointments, attend wellness events, and learn through community blogs – all in one place!</p>
            <a href="${pageContext.request.contextPath}/appointment/bookAppointment.jsp" class="btn btn-primary mt-3">Book Appointment</a>
        </div>
    </div>
</div>

<!-- Feature Cards -->
<div class="container feature-cards">
    <div class="row g-4">
        <div class="col-md-4">
            <div class="card feature-card text-center p-4">
                <div class="card-body">
                    <i class="bi bi-calendar2-event-fill"></i>
                    <h5 class="card-title mt-3">Health Events</h5>
                    <p class="card-text">Join upcoming medical camps, awareness drives and wellness workshops in your area.</p>
                    <a href="${pageContext.request.contextPath}/event/event.jsp" class="btn btn-outline-primary btn-sm">View Events</a>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card feature-card text-center p-4">
                <div class="card-body">
                    <i class="bi bi-journal-medical"></i>
                    <h5 class="card-title mt-3">Appointments</h5>
                    <p class="card-text">Easily book appointments with local doctors and view your medical history in one place.</p>
                    <a href="${pageContext.request.contextPath}/appointment/bookAppointment.jsp" class="btn btn-outline-primary btn-sm">Book Now</a>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card feature-card text-center p-4">
                <div class="card-body">
                    <i class="bi bi-newspaper"></i>
                    <h5 class="card-title mt-3">Community Blogs</h5>
                    <p class="card-text">Explore articles, tips, and health stories from your own community and doctors.</p>
                    <a href="${pageContext.request.contextPath}/blog/blogList.jsp" class="btn btn-outline-primary btn-sm">Explore Blogs</a>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
