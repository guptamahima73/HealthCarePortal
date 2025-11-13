package notifications;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


import java.io.IOException;
import java.util.List;

import database.AccessDatabase;

@WebServlet("/healthworker/notifications")
public class NotificationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("healthworkerId") == null) {
            response.sendRedirect(request.getContextPath() + "/healthworker/healthWorkerLogin.jsp");
            return;
        }
        int healthworkerId = (int) session.getAttribute("healthworkerId");

        AccessDatabase accessDatabase = null;
        try {
            accessDatabase = AccessDatabase.getInstance();
        } catch (Exception e) {
            e.printStackTrace();
        }

        List<Notification> notifications = accessDatabase.getNotificationsByUserId(healthworkerId);
        request.setAttribute("notifications", notifications);

        request.getRequestDispatcher("/healthworker/notifications.jsp").forward(request, response);
    }
}
