<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException"%>
<%@ page import="healthworker.HealthWorker" %>
<%@ page import="database.AccessDatabase" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Health Workers Directory</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <!-- Custom CSS -->
    <style>
        body {
            background: linear-gradient(to right, #fff9e6, #fff3cc);
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

        .header-section p {
            color: #666;
        }

        .header-section img {
            width: 100px;
            margin-top: 20px;
        }

        .card-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            padding: 40px 20px;
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
            margin: 6px 0;
        }

        .icon-sticker {
            font-size: 2rem;
            margin-bottom: 15px;
            color: #ffb347;
        }

        .add-button {
            position: fixed;
            bottom: 30px;
            right: 30px;
            background-color: #ffcd3c;
            color: #fff;
            border: none;
            border-radius: 50%;
            width: 60px;
            height: 60px;
            font-size: 24px;
            box-shadow: 0 6px 16px rgba(0, 0, 0, 0.2);
            display: flex;
            align-items: center;
            justify-content: center;
            transition: background-color 0.3s;
            z-index: 1000;
        }

        .add-button:hover {
            background-color: #f4b400;
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
        <h2>👩‍⚕️ Health Workers Directory</h2>
        <p class="text-muted">Meet our dedicated professionals ensuring rural healthcare awareness</p>
        <img src="https://cdn-icons-png.flaticon.com/512/3774/3774299.png" alt="Health Worker Icon">
    </div>

    <!-- Health Workers Cards -->
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

                List<HealthWorker> healthWorkerList = db.searchHealthWorkers(null, null, null, null);

                for (HealthWorker worker : healthWorkerList) {
        %>
        <div class="card">
            <div class="card-body text-center">
                <div class="icon-sticker"><i class="fas fa-user-nurse"></i></div>
                <h5 class="card-title"><%= worker.getName() %></h5>
                <p class="card-text"><strong>Health ID:</strong> <%= worker.getHealthId() %></p>
                <p class="card-text"><strong>Gender:</strong> <%= worker.getGender() %></p>
                <p class="card-text"><strong>Age:</strong> <%= worker.getAge() %></p>
                <p class="card-text"><strong>Specialization:</strong> <%= worker.getSpecialisation() %></p>
                <p class="card-text"><strong>Village:</strong> <%= worker.getVillageName() %></p>
                <p class="card-text"><strong>Slot:</strong> <%= worker.getSlot() %></p>
                <p class="card-text"><strong>Day:</strong> <%= worker.getDay() %></p>
            </div>
        </div>
        <%
                }
            } catch (Exception e) {
                out.println("Error retrieving health workers: " + e.getMessage());
            }
        %>
    </div>

    <!-- Add Health Worker Floating Button -->
    <a href="${pageContext.request.contextPath}/healthworker/healthworkerSignup.jsp" class="add-button" title="Add Health Worker">

        <i class="fas fa-plus"></i>
    </a>

    <!-- Footer -->
    <div class="footer">
        © 2025 Swasth Sync. Empowering rural health.
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
