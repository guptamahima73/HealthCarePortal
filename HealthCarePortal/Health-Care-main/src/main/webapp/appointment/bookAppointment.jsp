<%@ page import="java.sql.*" %>
<%@ page import="java.util.List" %>
<%@ page import="healthworker.HealthWorker" %>
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

    AccessDatabase accessDatabase = AccessDatabase.getInstance();
    List<String> specializations = accessDatabase.getAllSpecializations();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Book Appointment</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CSS & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
</head>
<style>
    body {
        background: linear-gradient(to right, #e6f0ff, #ffffff);
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    .navbar {
        background: linear-gradient(to right, #0066ff, #3399ff);
    }

    .navbar-brand,
    .nav-link,
    .dropdown-toggle,
    .dropdown-item {
        color: #fff !important;
        font-weight: 500;
    }

    .navbar-brand img {
        border-radius: 10px;
    }

    .container {
        max-width: 750px;
        background: #fff;
        margin-top: 40px;
        padding: 30px;
        border-radius: 10px;
        box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
    }

    h1 {
        color: #0066cc;
        font-weight: bold;
        margin-bottom: 25px;
    }

    .profile-initials {
        width: 45px;
        height: 45px;
        border-radius: 50%;
        background-color: #ffffff55;
        color: #fff;
        text-align: center;
        font-weight: bold;
        line-height: 45px;
    }

    label i {
        margin-right: 8px;
    }

    .form-control:focus {
        border-color: #3399ff;
        box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
    }

    .btn-primary {
        background: #0066ff;
        border: none;
    }

    .btn-primary:hover {
        background: #0047cc;
    }

    .toast {
        position: fixed;
        bottom: 20px;
        right: 20px;
        z-index: 9999;
    }
    .dropdown-menu {
    background-color: #0066cc;
}

.dropdown-menu .dropdown-item {
    color: white;
}

.dropdown-menu .dropdown-item:hover {
    background-color: #005bb5;
    color: #fff;
}
    
</style>

<body>
<nav class="navbar navbar-expand-lg">
    <div class="container-fluid">
        <a class="navbar-brand d-flex align-items-center" href="#">
            <img src="${pageContext.request.contextPath}/resource/logo_swasth.jpg" alt="Logo" width="50" height="50" class="me-2">
            Swasth Sync
        </a>

        <ul class="navbar-nav ms-auto">
            <li class="nav-item"><a href="${pageContext.request.contextPath}/event/event.jsp" class="nav-link">Event</a></li>
            <li class="nav-item"><a href="${pageContext.request.contextPath}/appointment/appointmentList.jsp" class="nav-link">Appointment</a></li>
            <li class="nav-item"><a href="${pageContext.request.contextPath}/blog/blogList.jsp" class="nav-link">Blog</a></li>

            <li class="nav-item dropdown ms-3">
                <a class="nav-link dropdown-toggle profile-initials text-center" href="#" role="button" data-bs-toggle="dropdown">
                    <%= initials %>
                </a>
                <ul class="dropdown-menu dropdown-menu-end">
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/resident/residentProfile.jsp">User Details</a></li>
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/appointment/appointmentList.jsp">Appointment History</a></li>
                    <li><a class="dropdown-item" href="#">Log Out</a></li>
                </ul>
            </li>
        </ul>
    </div>
</nav>

<div class="container">
    <h1 class="text-center">Book Your Appointment</h1>
    <form action="${pageContext.request.contextPath}/bookAppointmentServlet" method="post" class="needs-validation" novalidate>

        <div class="mb-3">
            <label for="specialization" class="form-label">
                <i class="bi bi-person-vcard text-primary"></i> Specialization
            </label>
            <select class="form-select" id="specialization" name="specialization" onchange="fetchHealthWorkers(this.value)" required>
                <option value="" disabled selected>Select Specialization</option>
                <% for (String specialization : specializations) { %>
                    <option value="<%= specialization %>"><%= specialization %></option>
                <% } %>
            </select>
            <div class="invalid-feedback">Please select a specialization.</div>
        </div>

        <div class="mb-3">
            <label for="doctor" class="form-label">
                <i class="bi bi-person-circle text-success"></i> Doctor
            </label>
            <select class="form-select" id="doctor" name="doctor" required>
                <option value="" disabled selected>Select a doctor</option>
            </select>
            <div class="invalid-feedback">Please select a doctor.</div>
        </div>

        <div class="mb-3">
            <label for="appointmentDate" class="form-label">
                <i class="bi bi-calendar-event text-warning"></i> Appointment Date
            </label>
            <input type="date" class="form-control" name="appointmentDate" id="appointmentDate" required>
            <div class="invalid-feedback">Please select a date.</div>
        </div>

        <div class="mb-4">
            <label for="symptoms" class="form-label">
                <i class="bi bi-journal-medical text-danger"></i> Symptoms
            </label>
            <textarea class="form-control" name="symptoms" id="symptoms" rows="3" placeholder="Describe your symptoms..." required></textarea>
            <div class="invalid-feedback">Please describe your symptoms.</div>
        </div>

        <div class="text-center">
            <button type="submit" class="btn btn-primary px-4">Book Appointment</button>
        </div>
    </form>
</div>

<!-- Toast on success -->
<div class="toast align-items-center text-bg-success border-0" id="successToast" role="alert" aria-live="assertive" aria-atomic="true">
    <div class="d-flex">
        <div class="toast-body">
            Appointment booked successfully! 🎉
        </div>
        <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
    </div>
</div>

<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
    function fetchHealthWorkers(specialization) {
        const doctorSelect = document.getElementById("doctor");
        doctorSelect.innerHTML = '<option value="" disabled selected>Select a doctor</option>';

        <% for (String specialization : specializations) {
            List<HealthWorker> workers = accessDatabase.getHealthWorkersBySpecialization(specialization);
            StringBuilder options = new StringBuilder();
            for (HealthWorker worker : workers) {
                options.append("<option value='").append(worker.getHealthId()).append("'>")
                       .append(worker.getName()).append("</option>");
            }
        %>
        if (specialization === "<%= specialization %>") {
            doctorSelect.innerHTML += "<%= options.toString() %>";
        }
        <% } %>
    }

    // Bootstrap validation
    (() => {
        'use strict';
        const form = document.querySelector('form');
        form.addEventListener('submit', event => {
            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            } else {
                const toast = new bootstrap.Toast(document.getElementById('successToast'));
                toast.show();
            }
            form.classList.add('was-validated');
        });
    })();
</script>

</body>
</html>
