package healthworker;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
//import healthworker.HealthWorker;

import java.io.IOException;
import java.net.URLEncoder;
import java.sql.SQLException;

import database.AccessDatabase;




public class HealthworkerSignup extends HttpServlet {
	private static final long serialVersionUID = 1L;
      
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HealthWorker hw = new HealthWorker();

        // Set the requested values to the resident object
        hw.setName(request.getParameter("name"));
        hw.setPassword(request.getParameter("password"));
        hw.setGender(request.getParameter("gender"));
      
        hw.setVillageName(request.getParameter("villageName"));
       
        hw. setSpecialisation(request.getParameter("specialisation"));
        hw.setSlot(request.getParameter("slot"));
        hw.setDay(request.getParameter("day"));
        String ageParam = request.getParameter("age");
        if (ageParam != null && !ageParam.isEmpty()) {
            try {
                int age = Integer.parseInt(ageParam);
                hw.setAge(age); // Assuming setAge takes an int
            } catch (NumberFormatException e) {
                e.printStackTrace(); // Log the error
                // You can also set a default value or return an error response
            }
        }
        

        String message = "";
        AccessDatabase accessDatabase = null;

        try {
            accessDatabase = AccessDatabase.getInstance();  // Get the AccessDatabase instance
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return;
        }

        // Call insertResident method to insert the resident data
        Integer inserted = accessDatabase.insertHealthWorker(hw);

        // Handle the response based on insertion result
        if (inserted != -1) {
            message = inserted.toString();
        } else {
            message = "Registration failed. Please try again.";
        }

        // Redirect back to home.jsp with the message
        response.sendRedirect("healthworker/healthWorkerLogin.jsp?message=" + URLEncoder.encode(message, "UTF-8"));

        
	}
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {
	    response.sendRedirect("healthworker/healthworkerSignup.jsp");
	}

}

