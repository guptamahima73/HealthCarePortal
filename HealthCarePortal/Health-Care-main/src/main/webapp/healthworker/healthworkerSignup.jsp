<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="database.AccessDatabase" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Health Worker Sign Up</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
   <style>
    body {
    background: linear-gradient(to right, #e0f7fa, #b2ebf2); /* Light teal gradient */
    height: 100vh;
    position: relative;
    overflow-x: hidden;
}

.signup-card {
    margin-top: 30px;
    background-color: rgba(255, 255, 255, 0.85);
    border-radius: 15px;
    padding: 25px;
    box-shadow: 0 6px 16px rgba(0, 0, 0, 0.25);
    z-index: 10;
    position: relative;
}

.custom-navbar {
    background: #4DB6AC;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    z-index: 20;
}

.custom-navbar .navbar-brand,
.custom-navbar .brand-text {
    color: #004d40;
    font-weight: bold;
    font-size: 1.3rem;
}

.custom-navbar .navbar-logo {
    height: 65px;
    width: 65px; /* Fix width to ensure it's a visible circle */
    object-fit: cover; /* Ensures image fills the area properly without distortion */
    border-radius: 50%;
    border: 2px solid #004d40; /* Dark teal border */
    box-shadow: 0 0 5px rgba(0, 0, 0, 0.2);
    background-color: white;
    padding: 3px;
}


.navbar-toggler {
    background-color: #e0f2f1;
    border: none;
}

.dropdown-menu {
    background-color: #e0f2f1;
    border: none;
    box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
}

.dropdown-menu .dropdown-item {
    color: #004d40;
    font-weight: 500;
}

.dropdown-menu .dropdown-item:hover {
    background-color: #b2dfdb;
    color: #004d40;
}

.nav-link.dropdown-toggle {
    color: #004d40 !important;
    font-weight: bold;
}

.nav-link.dropdown-toggle:hover {
    color: #00796b !important;
}

.header-illustration {
    text-align: center;
    margin-top: 40px;
    margin-bottom: 20px;
    color: #004d40;
    z-index: 10;
    position: relative;
}

.header-illustration img {
    width: 100px;
    height: auto;
}

.header-illustration h2 {
    margin-top: 10px;
    font-weight: 700;
}

.header-illustration p {
    color: #00796b;
    font-style: italic;
    margin-bottom: 0;
}

.corner-sticker {
    position: absolute;
    width: 50px;
    opacity: 0.7;
    z-index: 5;
    pointer-events: none;
}

.top-left {
    top: 10px;
    left: 10px;
}

.bottom-right {
    bottom: 10px;
    right: 10px;
}

.btn-register {
    background-color: #b2dfdb;
    color: #004d40;
}

.btn-register:hover {
    background-color: #80cbc4;
    color: #00332e;
}

.navbar-logo {
    height: 65px;
    width: 65px;
    object-fit: cover; /* Prevents image distortion */
    border-radius: 50%;
    border: 2px solid #00796b; /* Teal border */
    box-shadow: 0 0 6px rgba(0, 0, 0, 0.3);
    background-color: white;
    padding: 4px;
}
    
</style>

</head>
<body>

<!-- Decorative corner stickers -->
<img src="https://cdn-icons-png.flaticon.com/512/1534/1534982.png" alt="Heart Icon" class="corner-sticker top-left">
<img src="https://cdn-icons-png.flaticon.com/512/4290/4290854.png" alt="Medical Icon" class="corner-sticker bottom-right">

<!-- Navbar -->
<nav class="navbar navbar-expand-lg custom-navbar">
    <div class="container-fluid">
       <a class="navbar-brand d-flex align-items-center" href="#">
            <img src="${pageContext.request.contextPath}resource/logo_swasth.jpg" alt="" class="me-2 navbar-logo">
            <span class="brand-text">Swasth Saarthi</span>
        </a>
       

        <!-- Toggler for mobile -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Navbar content -->
        <div class="collapse navbar-collapse" id="navbarContent">
            <ul class="navbar-nav ms-auto">
                <!-- Sign In Dropdown -->
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle text-purple" href="#" role="button" data-bs-toggle="dropdown">
                        Sign In
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <li><a class="dropdown-item" href="resident/residentSignup.jsp">Resident</a></li>
                        <li><a class="dropdown-item" href="HealthworkerSignup">Health Worker</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Header Illustration -->
<div class="header-illustration">
   
    <h2>Join as a Health Worker</h2>
    <p>Empower rural health, one step at a time.</p>
</div>


<!-- Signup form container -->
<div class="container d-flex justify-content-center align-items-center">
    <div class="col-md-7 signup-card">
        <h3 class="text-center mb-4" style="color:#00796B;">Health Worker Sign Up</h3>
       <form action="${pageContext.request.contextPath}/HealthworkerSignup" method="post">
    <div class="row">
        <!-- Name -->
        <div class="mb-3 col-md-6">
            <label class="form-label">Name</label>
            <input type="text" name="name" class="form-control" required>
        </div>

        <!-- Password -->
        <div class="mb-3 col-md-6">
            <label class="form-label">Password</label>
            <input type="password" name="password" class="form-control" required>
        </div>

        <!-- Gender -->
        <div class="mb-3 col-md-6">
            <label class="form-label">Gender</label>
            <select name="gender" class="form-select" required>
                <option value="">Select</option>
                <option>Male</option>
                <option>Female</option>
                <option>Other</option>
            </select>
        </div>

        <!-- Age -->
        <div class="mb-3 col-md-6">
            <label class="form-label">Age</label>
            <input type="number" name="age" class="form-control" required>
        </div>

        <!-- District -->
        <div class="mb-3 col-md-6">
            <label class="form-label">District</label>
            <select class="form-control" id="district" name="district" onchange="populateVillages(this.value)" required>
                        <option value="" disabled selected>Select your district</option>
                        <%
                            AccessDatabase accessDatabase = null;
                            List<String> districts = new ArrayList<>();
                            try {
                                accessDatabase = AccessDatabase.getInstance();
                                districts = accessDatabase.getAllDistricts();
                                for (String district : districts) {
                        %>
                        <option value="<%= district %>"><%= district %></option>
                        <%
                                }
                            } catch (ClassNotFoundException | SQLException e) {
                                e.printStackTrace();
                            }
                        %>
                    </select>
        </div>

        <!-- Village -->
        <div class="mb-3 col-md-6">
            <label class="form-label">Village</label>
             <select class="form-control" id="villageName" name="villageName" required>
                        <option value="" disabled selected>Select your village</option>
                        <%
                            if (!districts.isEmpty()) {
                                String firstDistrict = districts.get(0);
                                List<String> villages = accessDatabase.getVillagesByDistrict(firstDistrict);
                                for (String village : villages) {
                        %>
                        <option value="<%= village %>"><%= village %></option>
                        <%
                                }
                            }
                        %>
                    </select>
        </div>

        <!-- Specialization -->
        <div class="mb-3 col-md-6">
            <label class="form-label">Specialization</label>
            <select class="form-select" id="specialisation" name="specialisation" required>
                <option value="" disabled selected>Select your specialization</option>
                <%
                    accessDatabase = null;
                    try {
                        accessDatabase = AccessDatabase.getInstance();
                        List<String> specializations = accessDatabase.getAllSpecializations();
                        for (String specialization : specializations) {
                %>
                    <option value="<%= specialization %>"><%= specialization %></option>
                <%
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                %>
                    <option disabled>Error loading specializations</option>
                <%
                    }
                %>
            </select>
        </div>

        <!-- Slot -->
        <div class="mb-3 col-md-3">
            <label class="form-label">Slot</label>
            <input type="text" name="slot" class="form-control" placeholder="e.g. 10AM-1PM" required>
        </div>

        <!-- Day -->
        <div class="mb-3 col-md-3">
            <label class="form-label">Day</label>
            <input type="text" name="day" class="form-control" placeholder="e.g. Monday" required>
        </div>
    </div>

    <!-- Submit Button -->
    <div class="mt-3">
        <button type="submit" class="btn btn-register w-100">Register</button>
    </div>
</form>
       
    </div>
</div>


 <script>
        function populateVillages(districtName) {
            const villageSelect = document.getElementById("villageName");
            villageSelect.innerHTML = ""; // Clear existing options
            villageSelect.innerHTML += '<option value="" disabled selected>Select your village</option>'; // Add default option
            
            <% 
                // Assuming we already have a method that gives us a mapping of district to villages
                for (String district : districts) {
                    List<String> villages = accessDatabase.getVillagesByDistrict(district);
                    StringBuilder villageOptions = new StringBuilder();
                    for (String village : villages) {
                        villageOptions.append("<option value='").append(village).append("'>").append(village).append("</option>");
                    }
            %>
            if (districtName === "<%= district %>") {
                villageSelect.innerHTML += "<%= villageOptions.toString() %>";
            }
            <% } %>
        }
    </script>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
