<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="database.AccessDatabase" %>
<%@ page import="java.sql.*" %>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register Here - Swasth Saarthi</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        /* Background Gradient - Cloud-like Sky Effect */
        body {
            background: linear-gradient(135deg, #82c2f7, #a3d8f7); /* Light blue gradient */
            background-size: cover;
            height: 100vh;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
        }

        /* Floating bubbles effect */
        .bubble {
            position: absolute;
            border-radius: 50%;
            background-color: rgba(255, 255, 255, 0.7);
            animation: floatBubble 10s infinite;
        }

        /* Bubble animation */
        @keyframes floatBubble {
            0% {
                transform: translateY(0) scale(0.8);
            }
            50% {
                transform: translateY(-100px) scale(1.2);
            }
            100% {
                transform: translateY(0) scale(0.8);
            }
        }

        /* Styling for Registration Block */
        .form-container {
            background: rgba(255, 255, 255, 0.6); /* Slight transparency */
            backdrop-filter: blur(12px); /* Blur the background */
            border-radius: 15px;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2); /* Soft shadow for 3D effect */
            padding: 30px 40px;
            width: 100%;
            max-width: 500px; /* Compact form */
            margin: 10px;
            position: relative;
            z-index: 2;
        }

        .form-container h3 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
            font-weight: bold;
            font-size: 2rem;
            color: #039BE5;
        }

        /* Labels and Input Field on Same Line */
        .form-label {
            font-size: 1rem;
            color: #333;
        }

        .form-control {
            border-radius: 10px;
            padding: 12px;
            font-size: 1rem;
            margin-bottom: 15px;
        }

        .form-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        /* Aligning label and placeholder in one line */
        .form-group {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .form-control {
            flex: 1;
            margin-left: 10px;
        }

        .btn-primary {
            background-color: lightgreen; /* Matching button color */
            border: none;
            border-radius: 5px;
            padding: 12px;
            font-size: 1rem;
            width: 100%;
        }

        .form-container .btn-primary:hover {
            background-color: #039BE5;
        }

        /* Responsive design */
        @media (max-width: 768px) {
            .form-container {
                width: 90%;
                padding: 20px;
            }
        }

        /* Mobile responsiveness */
        @media (max-width: 768px) {
            .form-container {
                width: 100%;
            }
        }

    </style>
</head>
<body>

    <!-- Floating Bubbles for Aesthetic Effect -->
    <div class="bubble" style="width: 80px; height: 80px; top: 50%; left: 10%; animation-duration: 8s;"></div>
    <div class="bubble" style="width: 100px; height: 100px; top: 30%; left: 70%; animation-duration: 12s;"></div>
    <div class="bubble" style="width: 70px; height: 70px; top: 40%; left: 40%; animation-duration: 10s;"></div>
    <div class="bubble" style="width: 90px; height: 90px; top: 60%; left: 20%; animation-duration: 15s;"></div>

    <!-- Registration Form Block -->
    <div class="form-container">
    <form action="${pageContext.request.contextPath}/residentSignupServlet" method="post">
        <h3>Register Here</h3>
        <table class="table-borderless" style="width: 100%;">
            <!-- Name -->
            <tr>
                <td><label for="name" class="form-label">Name</label></td>
                <td><input type="text" class="form-control" id="name" name="name" placeholder="Enter your name" required></td>
            </tr>

            <!-- District -->
            <tr>
                <td><label for="district" class="form-label">District</label></td>
                <td>
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
                </td>
            </tr>

            <!-- Village -->
            <tr>
                <td><label for="villageName" class="form-label">Village</label></td>
                <td>
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
                </td>
            </tr>

            <!-- Gender -->
            <tr>
                <td><label class="form-label">Gender</label></td>
                <td>
                    <div style="display: flex; gap: 15px;">
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="gender" id="male" value="Male" required>
                            <label class="form-check-label" for="male">Male</label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="gender" id="female" value="Female" required>
                            <label class="form-check-label" for="female">Female</label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="gender" id="other" value="Other" required>
                            <label class="form-check-label" for="other">Other</label>
                        </div>
                    </div>
                </td>
            </tr>

            <!-- DOB -->
            <tr>
                <td><label for="dob" class="form-label">Date of Birth</label></td>
                <td><input type="date" class="form-control" id="dob" name="dob" required></td>
            </tr>

            <!-- Email -->
            <tr>
                <td><label for="email" class="form-label">Email</label></td>
                <td><input type="email" class="form-control" id="email" name="email" placeholder="Enter your email" required></td>
            </tr>

            <!-- Password -->
            <tr>
                <td><label for="password" class="form-label">Password</label></td>
                <td><input type="password" class="form-control" id="password" name="password" placeholder="Enter your password" required></td>
            </tr>

            <!-- Confirm Password -->
            <tr>
                <td><label for="cpassword" class="form-label">Confirm Password</label></td>
                <td><input type="password" class="form-control" id="cpassword" name="cpassword" placeholder="Confirm your password" required></td>
            </tr>

            <!-- Mobile -->
            <tr>
                <td><label for="mobile" class="form-label">Mobile Number</label></td>
                <td><input type="tel" class="form-control" id="mobile" name="mobile" placeholder="Enter your mobile number" required></td>
            </tr>

            <!-- Submit -->
            <tr>
                <td colspan="2">
                    <div class="d-grid mt-3">
                        <button type="submit" class="btn btn-primary">Register</button>
                    </div>
                </td>
            </tr>
        </table>
    </form>
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
