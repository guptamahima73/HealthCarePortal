<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.List" %>
<%@ page import="appointment.Appointment" %>
<%@ page import="database.AccessDatabase" %>
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

    AccessDatabase db = AccessDatabase.getInstance();
    List<Appointment> appointmentList = db.getUpcomingAppointments();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Upcoming Appointments</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap + Font Awesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

    <style>
        body {
            background: url('https://www.transparenttextures.com/patterns/cubes.png'), linear-gradient(to bottom right, #f0f4ff, #e8f5fc);
            font-family: 'Segoe UI', sans-serif;
        }

        .navbar {
            background: linear-gradient(to right, #007bff, #00c6ff);
            box-shadow: 0 4px 10px rgba(0,0,0,0.15);
        }

        .navbar-brand span {
            color: white;
            font-weight: bold;
            font-size: 1.6rem;
            letter-spacing: 1px;
        }

        .nav-link {
            color: white !important;
            margin-right: 20px;
        }

        .nav-link:hover {
            text-decoration: underline;
        }

        .profile-initials {
            background-color: #ffffff;
            color: #007bff;
            font-weight: bold;
            width: 45px;
            height: 45px;
            border-radius: 50%;
            text-align: center;
            line-height: 45px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.2);
        }

        .container {
            margin-top: 40px;
            max-width: 950px;
        }

        h2 {
            text-align: center;
            color: #003366;
            font-weight: bold;
            margin-bottom: 40px;
        }

        .card {
            border: none;
            border-left: 6px solid #00c6ff;
            border-radius: 10px;
            margin-bottom: 25px;
            box-shadow: 0 3px 15px rgba(0, 123, 255, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            animation: fadeIn 0.5s ease-in;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 123, 255, 0.2);
        }

        .card-title {
            color: #007bff;
            font-size: 1.2rem;
            display: flex;
            align-items: center;
        }

        .card-title i {
            margin-right: 10px;
        }

        .card-text {
            margin-bottom: 6px;
        }

        .status-badge {
            padding: 5px 10px;
            border-radius: 15px;
            font-size: 0.9rem;
        }

        .flash-message {
            display: none;
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 12px 25px;
            background-color: #28a745;
            color: white;
            border-radius: 8px;
            z-index: 999;
            box-shadow: 0 4px 10px rgba(0,0,0,0.2);
        }

        .appointment-sticker {
            width: 40px;
            margin-right: 10px;
        }

        @keyframes fadeIn {
            from {opacity: 0; transform: translateY(10px);}
            to {opacity: 1; transform: translateY(0);}
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg">
    <div class="container-fluid">
        <a class="navbar-brand d-flex align-items-center" href="${pageContext.request.contextPath}/resident/residentDashboard.jsp">
            <img src="${pageContext.request.contextPath}/resource/logo_swasth.jpg" alt="Logo" width="50" height="50" class="me-2 rounded-circle">
            <span>Swasth Saarthi</span>
        </a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/event/event.jsp"><i class="fas fa-calendar-alt"></i> Event</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/appointment/bookAppointment.jsp"><i class="fas fa-stethoscope"></i> Appointment</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/blog/blogList.jsp"><i class="fas fa-blog"></i> Blog</a></li>
            </ul>
        </div>

        <!-- Profile Dropdown -->
        <div class="dropdown">
            <button class="btn profile-initials dropdown-toggle" type="button" data-bs-toggle="dropdown">
                <%= initials %>
            </button>
            <ul class="dropdown-menu dropdown-menu-end">
                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/resident/residentProfile.jsp">User Details</a></li>
                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/appointment/appointmentList.jsp">Appointment History</a></li>
                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/home.jsp">Log Out</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="flash-message" id="flashMessage">
    <%= request.getParameter("message") != null ? request.getParameter("message") : "" %>
</div>

<div class="container">
    <h2><i class="fas fa-calendar-check"></i> Upcoming Appointments</h2>

    <%
        if (appointmentList.isEmpty()) {
    %>
        <div class="alert alert-info text-center"><i class="fas fa-info-circle"></i> No upcoming appointments found.</div>
    <%
        } else {
            for (Appointment appointment : appointmentList) {
                int appointmentId = appointment.getAppointmentId();
                int healthId = appointment.getHealthId();
                int userId = appointment.getUserId();
                java.sql.Date appointmentDate = appointment.getAppointmentDate();
                String status = appointment.getStatus();

                String formattedDate = new SimpleDateFormat("d-MMM-yyyy").format(appointmentDate);

                String badgeColor = "secondary";
                if ("Pending".equalsIgnoreCase(status)) badgeColor = "warning";
                else if ("Approved".equalsIgnoreCase(status)) badgeColor = "success";
                else if ("Rejected".equalsIgnoreCase(status)) badgeColor = "danger";
    %>
        <div class="card">
           <div class="card-body">
    <h5 class="card-title">
        <img src="https://cdn-icons-png.flaticon.com/512/3983/3983781.png" width="24" class="me-2" alt="ID Icon">
        Appointment ID: <%= appointmentId %>
    </h5>
    <p class="card-text">
        <img src="https://cdn-icons-png.flaticon.com/512/2920/2920264.png" width="20" class="me-2" alt="Health ID Icon">
        <strong>Health ID:</strong> <%= healthId %>
    </p>
    
    <p class="card-text">
        <img src="https://cdn-icons-png.flaticon.com/512/747/747376.png" width="20" class="me-2" alt="User Icon">
        <strong>User ID:</strong> <%= userId %>
    </p>
    <p class="card-text">
        <img src="https://cdn-icons-png.flaticon.com/512/747/747310.png" width="20" class="me-2" alt="Calendar Icon">
        <strong>Date:</strong> <%= formattedDate %>
    </p>
    <p class="card-text">
        <img src="https://cdn-icons-png.flaticon.com/512/190/190411.png" width="20" class="me-2" alt="Status Icon">
        <strong>Status:</strong> <%= status %>
    </p>
</div>

        </div>
    <%
            }
        }
    %>
</div>

<script>
    window.onload = function () {
        const flashMessageDiv = document.getElementById('flashMessage');
        if (flashMessageDiv.textContent.trim()) {
            flashMessageDiv.style.display = 'block';
            setTimeout(() => flashMessageDiv.style.display = 'none', 5000);
        }
    };
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
