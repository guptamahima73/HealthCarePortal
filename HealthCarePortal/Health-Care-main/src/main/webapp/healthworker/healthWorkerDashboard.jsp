<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String loginSuccess = request.getParameter("login");
     String message = request.getParameter("message");
%>
<%
    String userName = (String) session.getAttribute("healthWorkerName");
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
    <title>Health Worker Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap + Icons + AOS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>
      body {
        background-color: #e0f7f9;
        font-family: 'Segoe UI', sans-serif;
    }

    .navbar {
        background-color: #008080;
    }

    .navbar-brand span, .navbar-nav .nav-link {
        color: #ffffff !important;
    }


       .profile-initials {
        width: 45px;
        height: 45px;
        border-radius: 50%;
        background-color: #006666;
        color: white;
        text-align: center;
        line-height: 45px;
        font-weight: bold;
    }

    .welcome-banner {
        background-color: #20b2aa;
        color: white;
        text-align: center;
        padding: 60px 20px;
    }

    .card-section .card {
        border: none;
        border-radius: 15px;
        overflow: hidden;
        transition: transform 0.3s;
    }

    .card-section .card:hover {
        transform: translateY(-5px);
    }

    .card-section .card img {
        height: 300px;
        object-fit: cover;
    }

    .info-section {
        padding: 60px 20px;
    }

    .info-card {
        background: linear-gradient(135deg, #a0e9e5 0%, #b2fefa 100%);
        border-radius: 20px;
        padding: 30px;
        box-shadow: 0 0 20px rgba(0, 128, 128, 0.2);
        transition: transform 0.3s;
        color: #004d4d;
    }

    .info-card:hover {
        transform: translateY(-5px);
    }

    .info-card h4 {
        font-weight: 600;
    }

    .info-card p {
        font-size: 15px;
    }

    .btn-purple {
        background-color: #008080;
        color: white;
        font-weight: bold;
    }

    .btn-purple:hover {
        background-color: #006666;
    }

    .text-purple {
        color: #008080 !important;
    }
    </style>
</head>
<body>
<%
        if ("success".equals(loginSuccess)) {
    %>
    <script>
        Swal.fire({
            title: 'Login Successful!',
            text: 'Welcome <%= session.getAttribute("healthWorkerName") %>!',
            icon: 'success',
            confirmButtonText: 'Continue'
        });
    </script>
    <%
        }
    %>


<% if (message != null && !message.isEmpty()) { %>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        const message = "<%= message %>";

        if (message === "Blog added successfully") {
            Swal.fire({
                icon: 'success',
                title: 'Success!',
                text: 'Your blog has been added successfully.',
                confirmButtonText: 'Great!'
            });
        } else {
            Swal.fire({
                icon: 'info',
                title: 'Notice',
                text: message,
                confirmButtonText: 'OK'
            });
        }

        // Remove ?message from URL
        if (window.history.replaceState) {
            const url = new URL(window.location);
            url.searchParams.delete('message');
            window.history.replaceState(null, '', url);
        }
    });
</script>
<% } %>


<!-- Navbar -->
<nav class="navbar navbar-expand-lg">
    <div class="container-fluid">
        <a class="navbar-brand d-flex align-items-center" href="#">
            <img src="${pageContext.request.contextPath}/resource/logo_swasth.jpg" alt="Logo" width="50" height="50" class="me-2">
            <span>Swasth Saarthi</span>
        </a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/event/workerevent.jsp">Events</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/appointment/workerbookedAppointment.jsp">Appointments</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/blog/workerblogList.jsp">Blogs</a></li>
            </ul>
        </div>
        <div class="dropdown">
            <button class="btn profile-initials dropdown-toggle" type="button" data-bs-toggle="dropdown">
                <%= initials %>
            </button>
            <ul class="dropdown-menu dropdown-menu-end">
                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/home.jsp">Log Out</a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- Welcome Banner -->
<section class="welcome-banner text-center py-5" data-aos="fade-up">
    <h3 style="font-size: 2.5rem;">Welcome, <%= userName != null ? userName : "Health Worker" %>!</h3>
    <p class="lead" style="font-size: 1.5rem;">Transforming rural healthcare—one click at a time.</p>
</section>


<!-- Image Card Section -->
<section class="container card-section my-5" data-aos="zoom-in-up">
    <div class="row g-4">
        <div class="col-md-4">
            <div class="card">
                <img src="${pageContext.request.contextPath}/resource/aware.jpg" class="card-img-top" alt="Health Awareness">
                <div class="card-body">
                    <h5 class="card-title text-center">Health Awareness</h5>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card">
                <img src="${pageContext.request.contextPath}/resource/health.jpg" class="card-img-top" alt="Community Checkups">
                <div class="card-body">
                    <h5 class="card-title text-center">Community Checkups</h5>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card">
                <img src="${pageContext.request.contextPath}/resource/digital.jpeg" class="card-img-top" alt="Digital Health Records">
                <div class="card-body">
                    <h5 class="card-title text-center">Digital Health Records</h5>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Dashboard Feature Section -->
<section class="container info-section">
    <div class="row text-center">
        <div class="col-md-4" data-aos="flip-left">
            <div class="info-card">
                <i class="bi bi-calendar-event display-4"></i>
                <h4>My Events</h4>
                <p>Track and manage your upcoming health events in local communities.</p>
                <a href="${pageContext.request.contextPath}/event/workerevent.jsp" class="btn btn-purple">View Events</a>
            </div>
        </div>
        <div class="col-md-4" data-aos="flip-up">
            <div class="info-card">
                <i class="bi bi-clock-history display-4"></i>
                <h4>My Appointments</h4>
                <p>Manage booked slots and patient visits efficiently with reminders.</p>
                <a href="${pageContext.request.contextPath}/appointment/workerbookedAppointment.jsp" class="btn btn-purple">My Slots</a>
            </div>
        </div>
        <div class="col-md-4" data-aos="flip-right">
            <div class="info-card">
                <i class="bi bi-journal-richtext display-4"></i>
                <h4>My Blogs</h4>
                <p>Share health tips, updates & stories to educate and inspire others.</p>
                <a href="${pageContext.request.contextPath}/blog/workerblogList.jsp" class="btn btn-purple">My Blogs</a>
            </div>
        </div>
    </div>
</section>

<!-- Write Blog CTA -->
<section class="container-fluid my-5 py-5" style="background-color: #20b2aa;">
    <div class="container text-center" data-aos="zoom-in">
        <h3 class="mb-3">Want to Share Something Important?</h3>
        <p class="mb-4">Educate your community through storytelling and knowledge sharing.</p>
        <a href="${pageContext.request.contextPath}/blog/writeBlog.jsp" class="btn btn-lg btn-purple">Write a Blog</a>
    </div>
</section>

<!-- Image and Impact Section -->
<section class="container my-5">
    <div class="row align-items-center">
        <div class="col-md-6" data-aos="fade-right">
            <img src="${pageContext.request.contextPath}/resource/doctor.jpg" alt="Healthcare Impact" class="img-fluid rounded shadow-lg">
        </div>
        <div class="col-md-6" data-aos="fade-left">
            <h3 class="text-purple">Your Role, Big Impact</h3>
            <p>By managing events, appointments, and blogs, you’re helping bridge the healthcare divide in rural areas. Keep going—you make a difference every day.</p>
        </div>
    </div>
</section>

<!-- Community Testimonials -->
<section class="container-fluid bg-white py-5">
    <div class="container">
        <h3 class="text-center mb-4 text-purple" data-aos="fade-up">What People Say</h3>
        <div class="row">
            <div class="col-md-4" data-aos="fade-up">
                <div class="info-card">
                    <p>"The health worker visited us every month—now booking and updates are just a click away!"</p>
                    <strong>- Meera Devi, Bihar</strong>
                </div>
            </div>
            <div class="col-md-4" data-aos="fade-up" data-aos-delay="200">
                <div class="info-card">
                    <p>"I uploaded a blog on local health myths—many appreciated the awareness drive."</p>
                    <strong>- Anil Kumar, UP</strong>
                </div>
            </div>
            <div class="col-md-4" data-aos="fade-up" data-aos-delay="400">
                <div class="info-card">
                    <p>"Swasth Saarthi makes my job easier and keeps everything organized."</p>
                    <strong>- Rekha S., MP</strong>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.js"></script>
<script>
    AOS.init({ duration: 1000 });
</script>






</body>
</html>
