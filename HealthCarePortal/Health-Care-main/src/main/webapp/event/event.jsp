<%@ page import="java.util.List" %>
<%@ page import="event.Event" %>
<%@ page import="database.AccessDatabase" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

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
    List<Event> eventList = db.searchEvents(null, null);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Events</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #f4f7fa;
            font-family: 'Segoe UI', sans-serif;
        }
        .card {
            border: none;
            border-radius: 16px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.05);
            transition: transform 0.2s ease;
        }
        .card:hover {
            transform: translateY(-5px);
        }
        .event-icon {
            font-size: 30px;
            color: #5cb85c;
            margin-right: 10px;
        }
        .event-title {
            font-weight: bold;
            color: #333;
        }
        .event-description {
            color: #555;
        }
        .navbar-brand span {
            font-weight: bold;
            font-size: 1.2rem;
        }
        .profile-initials {
            background-color: #007bff;
            color: #fff;
            border-radius: 50%;
            width: 40px;
            height: 40px;
            text-align: center;
            line-height: 40px;
            font-weight: bold;
        }
        footer {
            background: #343a40;
            color: #ddd;
            padding: 40px 0;
        }
        footer h5 {
            color: #fff;
        }
        footer a {
            color: #ccc;
        }
        .social-icons a {
            color: #fff;
            margin-right: 15px;
            font-size: 18px;
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg bg-body-secondary">
    <div class="container-fluid">
        <a href="${pageContext.request.contextPath}/resident/residentDashboard.jsp" class="navbar-brand d-flex align-items-center">
            <img src="${pageContext.request.contextPath}/resource/logo_swasth.jpg" alt="Logo" width="60" height="60" class="me-2">
            <span>Swasth Saarthi</span>
        </a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item"><a href="${pageContext.request.contextPath}/event/event.jsp" class="nav-link">Event</a></li>
                <li class="nav-item"><a href="${pageContext.request.contextPath}/appointment/bookAppointment.jsp" class="nav-link">Appointment</a></li>
                <li class="nav-item"><a href="${pageContext.request.contextPath}/blog/blogList.jsp" class="nav-link">Blog</a></li>
            </ul>
        </div>

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

<div class="container mt-5">
    <h2 class="mb-4">🌿 Upcoming Health Events</h2>

    <%
        if (eventList.isEmpty()) {
    %>
        <div class="alert alert-warning">No events found.</div>
    <%
        } else {
            for (Event event : eventList) {
    %>
    <div class="card mb-4">
        <div class="card-body">
            <div class="d-flex align-items-center mb-3">
                <i class="fa-solid fa-calendar-check event-icon"></i>
                <h5 class="card-title event-title mb-0"><%= event.getEventName() %></h5>
            </div>

            <p class="mb-1"><i class="fa-solid fa-location-dot me-2 text-danger"></i><strong>Village:</strong> <%= event.getVillageName() %></p>
            <p class="mb-1"><i class="fa-solid fa-clock me-2 text-warning"></i><strong>Date:</strong> <%= event.getEventStartDate() %> to <%= event.getEventEndDate() %></p>
            <p class="mb-1"><i class="fa-solid fa-hourglass-start me-2 text-info"></i><strong>Time:</strong> <%= event.getEventStartTime() %> to <%= event.getEventEndTime() %></p>

          <p class="card-text event-description mt-2">
    <%= event.getEventDescription().length() > 150 ? event.getEventDescription().substring(0, 150) + "..." : event.getEventDescription() %>
    <% if(event.getEventDescription().length() > 150) { %>
        <a href="eventDetails?eventId=<%= event.getEventId() %>" class="ms-2">Read More</a>
    <% } %>
</p>


        </div>
    </div>
    <%
            }
        }
    %>
</div>

<footer>
    <div class="container">
        <div class="row">
            <div class="col-md-3">
                <h5>For Patients</h5>
                <ul class="list-unstyled">
                    <li><a href="#">Why Clinical Trials?</a></li>
                    <li><a href="#">Guides</a></li>
                    <li><a href="#">Patients</a></li>
                    <li><a href="blog.jsp">Blog</a></li>
                </ul>
            </div>
            <div class="col-md-3">
                <h5>For Sponsors</h5>
                <ul class="list-unstyled">
                    <li><a href="#">Overview</a></li>
                    <li><a href="#">Recruitment</a></li>
                    <li><a href="#">Patient Insights</a></li>
                    <li><a href="#">Pricing</a></li>
                </ul>
            </div>
            <div class="col-md-3">
                <h5>For Sites</h5>
                <ul class="list-unstyled">
                    <li><a href="#">Overview</a></li>
                    <li><a href="#">Pricing</a></li>
                    <li><a href="#">Trial Site Portal</a></li>
                </ul>
            </div>
            <div class="col-md-3">
                <h5>Company</h5>
                <ul class="list-unstyled">
                    <li><a href="#">About HealthMatch</a></li>
                    <li><a href="#">Careers</a></li>
                    <li><a href="#">Support</a></li>
                </ul>
            </div>
        </div>

        <div class="row mt-4">
            <div class="col-12">
                <h5>Contact</h5>
                <p>Help Centre | General Contact: <a href="mailto:hello@SwasthSarthi.io">hello@SwasthSarthi.io</a> | Media Contact: <a href="mailto:media@SwasthSarthi.io">media@SwasthSarthi.io</a></p>
            </div>
        </div>

        <div class="row mt-4">
            <div class="col-12 social-icons">
                <a href="https://facebook.com" target="_blank"><i class="fab fa-facebook-f"></i></a>
                <a href="https://twitter.com" target="_blank"><i class="fab fa-twitter"></i></a>
                <a href="https://instagram.com" target="_blank"><i class="fab fa-instagram"></i></a>
                <a href="https://linkedin.com" target="_blank"><i class="fab fa-linkedin-in"></i></a>
                <a href="https://youtube.com" target="_blank"><i class="fab fa-youtube"></i></a>
                <a href="https://github.com" target="_blank"><i class="fab fa-github"></i></a>
            </div>
        </div>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js">
function toggleDescription(id) {
    const shortDesc = document.getElementById('desc-short-' + id);
    const fullDesc = document.getElementById('desc-full-' + id);

    if (shortDesc.classList.contains('d-none')) {
        // Show short, hide full
        shortDesc.classList.remove('d-none');
        fullDesc.classList.add('d-none');
    } else {
        // Show full, hide short
        shortDesc.classList.add('d-none');
        fullDesc.classList.remove('d-none');
    }
}
</script>
</body>
</html>
