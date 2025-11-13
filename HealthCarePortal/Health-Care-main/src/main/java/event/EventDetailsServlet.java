package event;

import jakarta.servlet.ServletException;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import database.AccessDatabase;

import java.io.IOException;
import java.sql.SQLException;


public class EventDetailsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String eventIdStr = request.getParameter("eventId");
        if (eventIdStr == null || eventIdStr.isEmpty()) {
            response.sendRedirect("event.jsp"); // redirect if no id given
            return;
        }

        int eventId;
        try {
            eventId = Integer.parseInt(eventIdStr);
        } catch (NumberFormatException e) {
            response.sendRedirect("event.jsp"); // redirect if invalid id
            return;
        }

        try {
            AccessDatabase db = AccessDatabase.getInstance();
            Event event = db.getEventById(eventId);

            if (event == null) {
                // Event not found, redirect back or show error page
                response.sendRedirect("event.jsp");
                return;
            }

            request.setAttribute("event", event);
            request.getRequestDispatcher("event/eventDetails.jsp").forward(request, response);

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Unable to fetch event details due to server error.");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}
