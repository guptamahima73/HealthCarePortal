<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.List" %>
<%@ page import="appointment.Appointment" %>
<%@ page import="database.AccessDatabase" %>
<%
    String healthWorkerIdStr = (String) session.getAttribute("healthWorkerId");
    int healthWorkerId = Integer.parseInt(healthWorkerIdStr);
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

    AccessDatabase accessDatabase = null;
    List<Appointment> appointmentList = null;

    try {
        accessDatabase = AccessDatabase.getInstance();
        appointmentList = accessDatabase.getMyAppointments(healthWorkerId);
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>My Appointments</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css" rel="stylesheet" />
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #e0f7f4 0%, #c7f3ed 100%);
            min-height: 100vh;
            margin: 0;
            color: #033d3d;
        }

        .navbar {
            background: linear-gradient(to right, #0f766e, #2dd4bf);
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .navbar-brand, .nav-link {
            color: #ecfdf5 !important;
            font-weight: 600;
        }

        .nav-link:hover {
            color: #bbf7d0 !important;
        }

        .profile-initials {
            width: 42px;
            height: 42px;
            border-radius: 50%;
            background: radial-gradient(circle, #14b8a6, #0f766e);
            color: white;
            font-weight: bold;
            display: flex;
            justify-content: center;
            align-items: center;
            transition: all 0.3s ease;
        }

        .profile-initials:hover {
            background: #0d9488;
        }

        h2 {
            text-align: center;
            margin: 30px 0;
            font-size: 2.25rem;
            color: #0f766e;
            font-weight: 700;
            position: relative;
        }

        h2::after {
            content: "";
            position: absolute;
            right: -2rem;
            top: -0.75rem;
            font-size: 1.5rem;
        }

        .card {
            border: none;
            border-radius: 16px;
            background: linear-gradient(145deg, #ffffff, #e6fffa);
            box-shadow: 0 8px 20px rgba(14, 165, 133, 0.2);
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            transition: all 0.4s ease;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 30px rgba(6, 182, 212, 0.3);
        }

        .card-title {
            color: #134e4a;
            font-size: 1.25rem;
        }

        .card-text {
            color: #115e59;
            margin-bottom: 6px;
        }

        .container {
            max-width: 900px;
            margin: auto;
            padding: 2rem 1rem;
        }

        .no-appointments {
            text-align: center;
            color: #64748b;
            font-style: italic;
            font-size: 1.25rem;
            margin-top: 50px;
        }

        .badge-tag {
            background: linear-gradient(to right, #14b8a6, #2dd4bf);
            color: white;
            font-size: 0.75rem;
            padding: 0.35rem 0.75rem;
            border-radius: 20px;
            font-weight: 600;
        }

        .icon-sticker {
            font-size: 1.3rem;
            color: #0d9488;
            margin-right: 0.5rem;
        }

        .dropdown-menu a {
            color: #0f766e;
        }

        .dropdown-menu a:hover {
            background-color: #ccfbf1;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg">
    <div class="container-fluid">
        <a class="navbar-brand d-flex align-items-center" href="${pageContext.request.contextPath}/healthworker/healthWorkerDashboard.jsp">
            <img src="${pageContext.request.contextPath}/resource/logo_swasth.jpg" alt="Logo" width="50" height="50" class="me-2"/>
            Swasth Sync
        </a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/event/workerevent.jsp">My Events</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/appointment/workerbookedAppointment.jsp">My Slots</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/blog/workerblogList.jsp">My Blogs</a></li>
            </ul>
            <div class="dropdown">
                <button class="btn profile-initials dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                    <%= initials %>
                </button>
                <ul class="dropdown-menu dropdown-menu-end">
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/home.jsp">Log Out</a></li>
                </ul>
            </div>
        </div>
    </div>
</nav>

<div class="container">
    <h2>Upcoming Appointments</h2>
    <%
        if (appointmentList == null || appointmentList.isEmpty()) {
    %>
        <div class="no-appointments">No upcoming appointments found 💤</div>
    <%
        } else {
            for (Appointment appointment : appointmentList) {
                int appointmentId = appointment.getAppointmentId();
                int healthId = appointment.getHealthId();
                int userId = appointment.getUserId();
                java.sql.Date appointmentDate = appointment.getAppointmentDate();
                String status = appointment.getStatus();
                String formattedDate = new SimpleDateFormat("d-MMM-yyyy").format(appointmentDate);
    %>
        <div class="card">
            <div class="card-body">
                <h5 class="card-title"><i class="bi bi-calendar-event icon-sticker"></i> Appointment ID: <%= appointmentId %></h5>
                <p class="card-text"><i class="bi bi-person-fill-check icon-sticker"></i><strong>Health Worker ID:</strong> <%= healthId %></p>
                <p class="card-text"><i class="bi bi-person-circle icon-sticker"></i><strong>User ID:</strong> <%= userId %></p>
                <p class="card-text"><i class="bi bi-clock icon-sticker"></i><strong>Date:</strong> <%= formattedDate %></p>
                <p class="card-text"><i class="bi bi-info-circle-fill icon-sticker"></i><strong>Status:</strong> <span class="badge-tag"><%= status %></span></p>
            </div>
        </div>
    <%
            }
        }
    %>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
