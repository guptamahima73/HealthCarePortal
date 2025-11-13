<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException"%>
<%@ page import="event.Event" %>
<%@ page import="database.AccessDatabase" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Events - Swasth Sync</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        body {
            background: linear-gradient(to right, #fff7e6, #fff3cc);
            font-family: 'Segoe UI', sans-serif;
        }

        .header-section {
            background-color: #FFCC80;
            padding: 40px 20px;
            text-align: center;
            border-bottom: 3px solid #ffd24d;
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
            color: #ffa534;
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
        <h2>📅 Upcoming Health Events</h2>
        <p class="text-muted">Engage with healthcare awareness programs near you</p>
        <img src="https://cdn-icons-png.flaticon.com/512/2285/2285560.png" alt="Event Icon">
    </div>

    <!-- Events Cards -->
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

                List<Event> eventsList = db.searchEvents(null, null);

                for (Event event : eventsList) {
        %>
        <div class="card">
            <div class="card-body text-center">
                <div class="icon-sticker"><i class="fas fa-calendar-alt"></i></div>
                <h5 class="card-title"><%= event.getEventName() %></h5>
                <p class="card-text"><strong>Event ID:</strong> <%= event.getEventId() %></p>
                <p class="card-text"><strong>Village:</strong> <%= event.getVillageName() %></p>
                <p class="card-text"><strong>Start:</strong> <%= event.getEventStartDate() %> @ <%= event.getEventStartTime() %></p>
                <p class="card-text"><strong>End:</strong> <%= event.getEventEndDate() %> @ <%= event.getEventEndTime() %></p>
                <p class="card-text"><strong>Description:</strong> <%= event.getEventDescription() %></p>
            </div>
        </div>
        <%
                }
            } catch (Exception e) {
                out.println("Error retrieving events: " + e.getMessage());
            }
        %>
    </div>

    <!-- Footer -->
    <div class="footer">
        © 2025 Swasth Sync. Spreading awareness, one event at a time.
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
