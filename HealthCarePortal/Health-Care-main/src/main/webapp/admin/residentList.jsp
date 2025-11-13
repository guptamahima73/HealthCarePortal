<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="resident.Resident" %>
<%@ page import="database.AccessDatabase" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Residents Directory</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Custom CSS -->
    <style>
        body {
            background: linear-gradient(135deg, #fff9e6 0%, #fff3cc 100%);
            font-family: 'Segoe UI', sans-serif;
        }

        .header-section {
            background-color: #FFCC80;
            padding: 40px 20px;
            text-align: center;
            border-bottom: 3px solid #ffde59;
        }

        .header-section h2 {
            font-size: 2.5rem;
            color: #444;
        }

        .header-section img {
            width: 100px;
            margin-top: 20px;
        }

        .card-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            padding: 30px 0;
        }

        .card {
            background-color: #fffef3;
            margin: 15px;
            width: 320px;
            border-radius: 20px;
            border: none;
            box-shadow: 0 6px 16px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.15);
        }

        .card-body {
            padding: 25px;
        }

        .card-title {
            font-size: 1.4rem;
            color: #333;
            font-weight: bold;
        }

        .card-text {
            font-size: 0.95rem;
            color: #555;
            margin: 8px 0;
        }

        .icon-sticker {
            font-size: 2rem;
            margin-bottom: 15px;
            color: #ffb347;
        }

        .footer {
            text-align: center;
            padding: 20px;
            font-size: 0.9rem;
            color: #999;
        }
    </style>
</head>
<body>

    <!-- Header -->
    <div class="header-section">
        <h2>🌟 Residents Directory</h2>
        <p class="text-muted">Discover details of registered residents in a neat and friendly format</p>
        <img src="https://cdn-icons-png.flaticon.com/512/3063/3063825.png" alt="Residents Icon">
    </div>

    <!-- Residents Card Container -->
    <div class="container card-container">
        <%
            try {
                AccessDatabase db = null;
                try {
                    db = AccessDatabase.getInstance();
                } catch (ClassNotFoundException | SQLException e) {
                    e.printStackTrace();
                    return;
                }

                List<Resident> residentsList = db.searchResidents(null, null, null, null);

                for (Resident resident : residentsList) {
        %>
        <div class="card">
            <div class="card-body text-center">
                <div class="icon-sticker"><i class="fas fa-user-circle"></i></div>
                <h5 class="card-title"><%= resident.getName() %></h5>
                <p class="card-text"><strong>User ID:</strong> <%= resident.getUserId() %></p>
                <p class="card-text"><strong>DOB:</strong> <%= resident.getDob() %></p>
                <p class="card-text"><strong>Village:</strong> <%= resident.getVillageName() %></p>
                <p class="card-text"><strong>Gender:</strong> <%= resident.getGender() %></p>
                <p class="card-text"><strong>Phone:</strong> <%= resident.getPhone() %></p>
                <p class="card-text"><strong>Email:</strong> <%= resident.getEmail() %></p>
            </div>
        </div>
        <%
                }
            } catch (Exception e) {
                out.println("Error retrieving residents: " + e.getMessage());
            }
        %>
    </div>

    <!-- Footer -->
    <div class="footer">
        © 2025 Swasth Sync. All rights reserved.
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
