<%@ page import="java.util.List" %>
<%@ page import="notifications.Notification" %>

<%
    // Assume notifications are set in request scope by the servlet
    List<Notification> notifications = (List<Notification>) request.getAttribute("notifications");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Notification List</title>
    <style>
        /* Some basic styling */
        .notification {
            border: 1px solid #ccc;
            padding: 12px;
            margin-bottom: 10px;
            border-radius: 6px;
            background: #f9f9f9;
        }
        .unread {
            font-weight: bold;
            background: #e6f7ff;
        }
    </style>
</head>
<body>
    <h2>Notifications</h2>
   <%
    if (notifications == null || notifications.isEmpty()) {
%>
    <p>No notifications found.</p>
<%
    } else {
        for (Notification n : notifications) {
            boolean unread = !n.isRead();  // true if notification is unread
%>
    <div class="notification <%= unread ? "unread" : "" %>">
        <p><strong>Message:</strong> <%= n.getMessage() %></p>
        <p><strong>Date:</strong> <%= n.getCreatedAt() %></p>
        <p><strong>Status:</strong> <%= unread ? "Unread" : "Read" %></p>
    </div>
<%
        }
    }
%>


</body>
</html>
