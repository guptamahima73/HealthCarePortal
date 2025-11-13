<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Landing Page - Swasth Sync</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />

    <!-- Custom Styles -->
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            color: #333;
            margin: 0;
            padding: 0;
        }

        /* Navbar Styling */
        .navbar {
            background: linear-gradient(90deg, #56ab2f, #a8e063);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
            transition: background-color 0.5s ease;
        }
        .navbar a {
            color: white !important;
        }
        .navbar-brand img {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            border: 2px solid white;
        }
        .navbar-toggler {
            background-color: #fff;
            border: none;
        }

        .dropdown-menu {
            background-color: #6cbf3c; /* Bright green background */
            border: none;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.2);
        }
        .dropdown-menu .dropdown-item {
            color: white;
            font-weight: 500;
        }
        .dropdown-menu .dropdown-item:hover {
            background-color: #5aa832;
            color: #fff;
        }

        /* Hero Section */
        .hero-section {
            background: url('resource/bg.jpg') no-repeat center center;
            background-size: cover;
            color: white;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            text-align: center;
            position: relative;
            background-attachment: fixed;
            animation: fadeIn 2s ease-out;
        }
        .hero-section h1 {
            font-size: 4rem;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.7);
            opacity: 0;
            animation: slideUp 1s ease-in-out forwards;
        }
        .hero-section p {
            font-size: 1.5rem;
            margin-bottom: 30px;
            opacity: 0;
            animation: slideUp 1.2s ease-in-out forwards;
        }
        .hero-section .btn {
            font-size: 1.1rem;
            padding: 12px 30px;
            background-color: #006400;
            border-radius: 25px;
            transition: background-color 0.3s ease;
            opacity: 0;
            animation: slideUp 1.5s ease-in-out forwards;
        }
        .hero-section .btn:hover {
            background-color: #004d00;
        }

        /* Card Styling */
        .card {
            background: rgba(255, 255, 255, 0.85);
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            margin: 20px;
            overflow: hidden;
            transform: scale(1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            opacity: 0;
            animation: fadeInUp 1s ease-in-out forwards;
        }
        .card:nth-child(1) {
            animation-delay: 0.3s;
        }
        .card:nth-child(2) {
            animation-delay: 0.6s;
        }
        .card:nth-child(3) {
            animation-delay: 0.9s;
        }
        .card:hover {
            transform: scale(1.05);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3);
        }
        .card img {
            width: 100%;
            height: 220px;
            object-fit: cover;
            transition: transform 0.5s ease;
        }
        .card img:hover {
            transform: scale(1.1);
        }
        .card-body {
            padding: 20px;
            text-align: center;
        }
        .card-body h5 {
            font-size: 1.8rem;
            margin-bottom: 15px;
            color: #333;
        }
        .card-body p {
            font-size: 1rem;
            color: #555;
            min-height: 70px;
        }
        .card-body .btn {
            font-weight: bold;
            padding: 10px 15px;
            border-radius: 5px;
            transition: background-color 0.3s ease;
            color: white;
            text-transform: uppercase;
        }
        .btn.resident {
            background-color: #2196F3; /* Blue */
        }
        .btn.resident:hover {
            background-color: #0b7dda;
        }
        .btn.healthworker {
            background-color: #4CAF50; /* Green */
        }
        .btn.healthworker:hover {
            background-color: #388e3c;
        }
        .btn.admin {
            background-color: #FF5722; /* Orange */
        }
        .btn.admin:hover {
            background-color: #e64a19;
        }

        /* Font Awesome icon inside card */
        .card i.fa-icon {
            font-size: 3rem;
            margin-bottom: 15px;
            color: #4CAF50;
        }
        /* Different icon colors per role */
        .card.admin i.fa-icon {
            color: #FF5722;
        }
        .card.resident i.fa-icon {
            color: #2196F3;
        }

        /* About Section */
        .about-section {
            padding: 60px 0;
            background-color: #fff;
            text-align: center;
            animation: fadeIn 2s ease-in-out;
        }
        .about-section h2 {
            font-size: 2.5rem;
            margin-bottom: 30px;
            color: #333;
        }
        .about-section p {
            font-size: 1.1rem;
            max-width: 800px;
            margin: 0 auto 40px auto;
            color: #555;
        }

        /* Social Media Icons */
        .social-icons {
            display: flex;
            justify-content: center;
            margin-top: 40px;
        }
        .social-icons a {
            margin: 0 20px;
            transition: transform 0.3s ease;
            opacity: 0;
            animation: fadeInUp 1.5s ease-in-out forwards;
        }
        .social-icons a:hover {
            transform: scale(1.2);
        }
        .social-icons img {
            width: 40px;
            height: 40px;
        }

        /* Animation Keyframes */
        @keyframes fadeIn {
            0% { opacity: 0; }
            100% { opacity: 1; }
        }
        @keyframes fadeInUp {
            0% { opacity: 0; transform: translateY(20px); }
            100% { opacity: 1; transform: translateY(0); }
        }
        @keyframes slideUp {
            0% { opacity: 0; transform: translateY(50px); }
            100% { opacity: 1; transform: translateY(0); }
        }

        /* Responsive */
        @media (max-width: 768px) {
            .hero-section h1 {
                font-size: 2.5rem;
            }
            .hero-section p {
                font-size: 1.2rem;
            }
            .card {
                margin: 10px;
            }
        }
        .social-icon {
    width: 40px;
    height: 40px;
    transition: transform 0.3s ease, opacity 0.3s ease;
}

.social-icon:hover {
    transform: scale(1.2);
    opacity: 0.8;
}
        
    </style>
</head>

<body>

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg custom-navbar">
        <div class="container-fluid">
            <a class="navbar-brand d-flex align-items-center" href="#">
                <img src="resource/logo_swasth.jpg" alt="Logo" class="me-2" />
                <span class="brand-text">Swasth Sync</span>
            </a>

            <!-- Toggler for mobile -->
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent">
                <span class="navbar-toggler-icon"></span>
            </button>

            <!-- Navbar content -->
            <div class="collapse navbar-collapse" id="navbarContent">
                <ul class="navbar-nav ms-auto">
                    <!-- Join Us Dropdown -->
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle text-white" href="#" role="button" data-bs-toggle="dropdown">
                            Join Us
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li><a class="dropdown-item" href="resident/residentSignup.jsp">Register as Resident</a></li>
                            <li><a class="dropdown-item" href="healthworker/healthworkerSignup.jsp">Register as Health Worker</a></li>
                        </ul>
                    </li>
                    <!-- Login Dropdown -->
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle text-white" href="#" role="button" data-bs-toggle="dropdown">
                            Sign In
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li><a class="dropdown-item" href="resident/residentLogin.jsp">Resident Login</a></li>
                            <li><a class="dropdown-item" href="healthworker/healthworkerLogin.jsp">Health Worker Login</a></li>
                            <li><a class="dropdown-item" href="admin/adminLogin.jsp">Admin Login</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

   <!-- Hero Section -->
<section class="hero-section">
    <div class="container">
        <h1>Welcome to Swasth Sync</h1>
        <p>Your Gateway to Rural Healthcare</p>
        <a href="#loginSection" class="btn btn-lg text-white">Get Started</a>
    </div>
</section>


    <!-- Login Section -->
    <section id="loginSection" class="container my-5">
        <div class="row justify-content-center">
            <!-- Resident Card -->
            <div class="col-lg-4 col-md-6">
                <div class="card resident">
                    <img src="resource/resident.jpg" alt="Resident Image" />
                    <div class="card-body">
                        <i class="fas fa-user fa-icon"></i>
                        <h5 class="card-title">Resident</h5>
                        <p class="card-text">Access your health records, appointments, and stay connected with health workers.</p>
                        <a href="resident/residentLogin.jsp" class="btn resident">Login as Resident</a>
                    </div>
                </div>
            </div>

            <!-- Health Worker Card -->
            <div class="col-lg-4 col-md-6">
                <div class="card healthworker">
                    <img src="resource/health.jpg" alt="Health Worker Image" />
                    <div class="card-body">
                        <i class="fas fa-user-nurse fa-icon"></i>
                        <h5 class="card-title">Health Worker</h5>
                        <p class="card-text">Manage patients, update records, and facilitate healthcare services in rural areas.</p>
                        <a href="healthworker/healthWorkerLogin.jsp" class="btn healthworker">Login as Health Worker</a>
                    </div>
                </div>
            </div>

            <!-- Admin Card -->
            <div class="col-lg-4 col-md-6">
                <div class="card admin">
                    <img src="resource/admin.jpg" alt="Admin Image" />
                    <div class="card-body">
                        <i class="fas fa-user-shield fa-icon"></i>
                        <h5 class="card-title">Admin</h5>
                        <p class="card-text">Monitor system activities, manage users and oversee healthcare operations.</p>
                        <a href="admin/adminLogin.jsp" class="btn admin">Login as Admin</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

   <!-- About Section -->
<section class="about-section py-5" style="background-color: #f8f9f;">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-10">
                <div class="card shadow-lg border-0 rounded-4 p-4" style="background-color:#E8F5E9;">
                    <div class="card-body text-center">
                        <h2 class="mb-4" style="color: #2c3e50;">About <span style="color: #007bff;">Swasth Sync</span></h2>
                        <p class="lead text-muted">
                            Swasth Sync is dedicated to bridging the healthcare gap in rural communities by 
                            connecting <strong>residents</strong>, <strong>health workers</strong>, and 
                            <strong>administrators</strong> on a single platform.
                        </p>
                        <p class="text-muted">
                            Our mission is to provide <em>accessible</em>, <em>efficient</em>, and 
                            <em>transparent</em> healthcare services using modern technology that empowers every 
                            corner of the nation — even the most remote.
                        </p>
                        <div class="mt-4">
                            <a href="#loginSection" class="btn btn-primary px-4 py-2 rounded-pill shadow-sm">
                                Join the Mission
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>


   <!-- Social Media -->
<section class="social-icons py-4" style="background-color: #e9f5ff;">
    <div class="container text-center">
        <h5 class="mb-3" style="color: #2c3e50;">Connect With Us</h5>
        <div class="d-flex justify-content-center gap-4">
            <a href="https://facebook.com" target="_blank" title="Facebook">
                <img src="resource/facebook.png" alt="Facebook" class="social-icon" />
            </a>
            <a href="https://twitter.com" target="_blank" title="Twitter">
                <img src="resource/twitter.png" alt="Twitter" class="social-icon" />
            </a>
            <a href="https://linkedin.com" target="_blank" title="LinkedIn">
                <img src="resource/linkdin.png" alt="LinkedIn" class="social-icon" />
            </a>
        </div>
    </div>
</section>


    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
