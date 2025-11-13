<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - Swasth Sync</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap + Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
<style>
   body {
    background: linear-gradient(to bottom right, #FFF3E0, #ffffff);
    font-family: 'Segoe UI', sans-serif;
    color: #4E342E;
}

.navbar {
    background: linear-gradient(90deg, #FB8C00, #F57C00);
}

.navbar-brand span,
.navbar-nav .nav-link {
    color: #FFFDE7 !important;
    font-weight: bold;
}

.logout-button {
    background-color: #D84315;
    color: white;
    border: none;
    padding: 10px 20px;
    border-radius: 6px;
    font-weight: bold;
}

.logout-button:hover {
    background-color: #BF360C;
}

.welcome-banner {
    background: linear-gradient(135deg, #FFE0B2, #FFCCBC);
    color: #BF360C;
    text-align: center;
    padding: 60px 20px;
    border-bottom: 4px solid #FF7043;
}

.welcome-banner h2 {
    font-size: 2.5rem;
}

.feature-card {
    background: #fffaf5;
    border-radius: 20px;
    padding: 30px;
    box-shadow: 0 6px 16px rgba(255, 138, 101, 0.2);
    text-align: center;
    transition: transform 0.3s, box-shadow 0.3s;
    cursor: pointer;
}

.feature-card:hover {
    transform: translateY(-6px);
    box-shadow: 0 12px 20px rgba(255, 112, 67, 0.3);
}

.feature-card i {
    font-size: 3rem;
    color: #E65100;
}

.feature-card h5 {
    margin-top: 15px;
    font-weight: bold;
    color: #F4511E;
}

.feature-card p {
    font-size: 15px;
    color: #6D4C41;
}

.footer {
    text-align: center;
    padding: 20px;
    font-size: 0.9rem;
    color: #6D4C41;
}
</style>

</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg">
    <div class="container-fluid">
        <a class="navbar-brand d-flex align-items-center" href="#">
            <img src="${pageContext.request.contextPath}/resource/logo_swasth.jpg" alt="Logo" width="50" height="50" class="me-2">
            <span>Swasth Sync Admin</span>
        </a>
        <button class="logout-button ms-auto" onclick="location.href='${pageContext.request.contextPath}/home.jsp'">Logout</button>
    </div>
</nav>

<!-- Welcome Banner -->
<div class="welcome-banner">
    <h2>Welcome, Admin!</h2>
    <p class="lead">Manage your Swasth Sync platform efficiently and effectively.</p>
</div>

<!-- Features Section -->
<section class="container my-5">
    <div class="row g-4">
        <div class="col-md-3 col-sm-6">
            <div class="feature-card" onclick="location.href='residentList.jsp'">
                <i class="bi bi-person"></i>
                <h5>Residents</h5>
                <p>Manage all registered users and their health data.</p>
            </div>
        </div>
        <div class="col-md-3 col-sm-6">
            <div class="feature-card" onclick="location.href='healthWorkerList.jsp'">
                <i class="bi bi-person-badge"></i>
                <h5>Health Workers</h5>
                <p>View and assign duties to health workers.</p>
            </div>
        </div>
        <div class="col-md-3 col-sm-6">
            <div class="feature-card" onclick="location.href='eventList.jsp'">
                <i class="bi bi-calendar-event"></i>
                <h5>Events</h5>
                <p>Schedule and manage health awareness events.</p>
            </div>
        </div>
        <div class="col-md-3 col-sm-6">
            <div class="feature-card" onclick="location.href='${pageContext.request.contextPath}/blog/blogList.jsp'">
                <i class="bi bi-journal-text"></i>
                <h5>Blogs</h5>
                <p>Review and moderate blogs shared by the team.</p>
            </div>
        </div>
    </div>
</section>

<!-- Footer -->
<div class="footer">
    © 2025 Swasth Sync | Designed for brighter healthcare in rural India
</div>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
