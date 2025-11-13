<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="resident.Resident" %>
<%@ page import="database.AccessDatabase" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Resident Profile</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />
    <style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
        font-family: 'Segoe UI', sans-serif;
        background: radial-gradient(circle at top left, #e3f2fd, #bbdefb, #ffffff);
        height: 100vh;
        overflow: hidden;
        display: flex;
        justify-content: center;
        align-items: center;
        position: relative;
    }

    /* Animated floating particles */
    .floating-bg {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        overflow: hidden;
        z-index: 0;
    }

    .circle {
        position: absolute;
        border-radius: 50%;
        background: rgba(33, 150, 243, 0.15);
        animation: float 8s ease-in-out infinite;
    }

    .circle:nth-child(1) {
        width: 120px;
        height: 120px;
        top: 10%;
        left: 15%;
        animation-delay: 0s;
    }

    .circle:nth-child(2) {
        width: 80px;
        height: 80px;
        bottom: 20%;
        right: 10%;
        animation-delay: 2s;
    }

    .circle:nth-child(3) {
        width: 100px;
        height: 100px;
        top: 60%;
        left: 30%;
        animation-delay: 4s;
    }

    @keyframes float {
        0%, 100% {
            transform: translateY(0) scale(1);
        }
        50% {
            transform: translateY(-20px) scale(1.05);
        }
    }

    .profile-container {
        background-color: #fff;
        width: 420px;
        padding: 30px;
        border-radius: 20px;
        box-shadow: 0 15px 25px rgba(0, 0, 0, 0.2);
        text-align: center;
        position: relative;
        z-index: 1;
        animation: slideIn 1s ease-out;
    }

    @keyframes slideIn {
        from {
            opacity: 0;
            transform: translateY(30px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    .profile-container:hover {
        transform: perspective(800px) rotateY(3deg);
    }

    .profile-image {
        display: flex;
        justify-content: center;
        margin-bottom: 20px;
    }

    .img {
        width: 150px;
        height: 150px;
        border-radius: 50%;
        border: 5px solid #2196f3;
        display: flex;
        justify-content: center;
        align-items: center;
        background: linear-gradient(135deg, #e3f2fd, #ffffff);
        box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
    }

    .img i {
        font-size: 80px;
        color: #2196f3;
    }

    .profile-details h2 {
        font-size: 24px;
        color: #0d47a1;
        margin-bottom: 10px;
    }

    .profile-details p {
        font-size: 16px;
        color: #555;
        margin: 5px 0;
    }

    .profile-details strong {
        color: #0d47a1;
    }

    .logo-sticker {
        position: absolute;
        top: -25px;
        right: -25px;
        background: #0d47a1;
        color: white;
        padding: 10px 14px;
        border-radius: 50%;
        font-size: 22px;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
    }
</style>

</head>
<body>
<div class="floating-bg">
    <div class="circle"></div>
    <div class="circle"></div>
    <div class="circle"></div>
</div>
    <div class="profile-container">
        <div class="logo-sticker">
            <i class="fas fa-hospital-user"></i>
        </div>

        <%
            String residentIdStr = (String) session.getAttribute("residentId");
            int residentId = 0;

            if (residentIdStr != null) {
                try {
                    residentId = Integer.parseInt(residentIdStr);
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                    return;
                }
            }

            Resident rs = null;
            SimpleDateFormat sdf = new SimpleDateFormat("d-MMM-yyyy");

            try {
                AccessDatabase accessDatabase = AccessDatabase.getInstance();

                if (residentId != 0) {
                    rs = accessDatabase.getResidentById(residentId);
                }

                if (rs != null) {
                    String name = rs.getName();
                    java.sql.Date dob = rs.getDob();
                    String villageName = rs.getVillageName();
                    String gender = rs.getGender();
                    String phone = rs.getPhone();
                    String email = rs.getEmail();
                    String formattedDob = sdf.format(dob);
        %>

        <div class="profile-image">
            <div class="img">
                <i class="fa-solid fa-user-large"></i>
            </div>
        </div>

        <div class="profile-details">
            <h2><%= name %></h2>
            <p><strong>Date of Birth:</strong> <%= formattedDob %></p>
            <p><strong>Village Name:</strong> <%= villageName %></p>
            <p><strong>Gender:</strong> <%= gender %></p>
            <p><strong>Phone:</strong> <%= phone %></p>
            <p><strong>Email:</strong> <%= email %></p>
        </div>

        <%
                } else {
        %>
            <p>No resident found with the given user ID.</p>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
        %>
            <p>Error loading resident data.</p>
        <%
            }
        %>
    </div>
</body>
</html>
