package admin;

import java.io.IOException;
import java.net.URLEncoder;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class adminLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String Id = request.getParameter("adminId"); // Health Worker ID
        String password = request.getParameter("adminPass"); // Password
     
        String message = "";
        boolean isAuthenticated = false; // Variable to track if authentication is successful


        // Admin login (hardcoded id-pass)
        if(Id.equals("Aanchal25") && password.equals("123*@abc")) {
            // Admin authenticated
            HttpSession session = request.getSession();
            session.setAttribute("admin", true); // Set admin session attribute
            session.setAttribute("adminId", Id);

            session.setAttribute("adminpass", password); // Store health worker name in session
            isAuthenticated = true;
            
        }
        else
        {
        	message = "Invalid Credentials. Please try again.";
        	
        }
        if (isAuthenticated) {
            response.sendRedirect(request.getContextPath() + "/admin/adminDashboard.jsp"); // Redirect to health worker dashboard
        } else {
            response.sendRedirect("admin/adminLogin.jsp?message=" + URLEncoder.encode(message, "UTF-8")); // Redirect with message
        }
        
        
	}   

}
