<%@ page import="event.Event" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Event event = (Event) request.getAttribute("event");
    if (event == null) {
        response.sendRedirect("event.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title><%= event.getEventName() %> - Event Details</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
<div class="container mt-5">
    <h2><%= event.getEventName() %></h2>
    <p><strong>Village:</strong> <%= event.getVillageName() %></p>
    <p><strong>Date:</strong> <%= event.getEventStartDate() %> to <%= event.getEventEndDate() %></p>
    <p><strong>Time:</strong> <%= event.getEventStartTime() %> to <%= event.getEventEndTime() %></p>
    <hr />
    <p><%= event.getEventDescription() %></p>
    <a href="event.jsp" class="btn btn-secondary mt-3">Back to Events</a>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
