<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Health Worker Login</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        body {
            background: linear-gradient(to right, #e0f7fa, #b2ebf2); /* Light teal gradient */
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .login-card {
            background-color: rgba(255, 255, 255, 0.92);
            padding: 30px;
            border-radius: 16px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
            width: 100%;
            max-width: 500px;
        }

        h3 {
            color: #004d40; /* Teal */
            font-weight: 700;
            text-align: center;
            margin-bottom: 25px;
        }

        .form-label {
            color: #00695c;
            font-weight: 500;
        }

        .btn-login {
            background-color: #26a69a;
            color: white;
            font-weight: 600;
        }

        .btn-login:hover {
            background-color: #1e857e;
        }

        .flash-message {
            display: none;
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 12px 20px;
            background-color: #26a69a;
            color: white;
            border-radius: 8px;
            font-weight: 500;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            z-index: 1000;
        }
    </style>
</head>
<body>

    <!-- Flash Message Container 
    <div class="flash-message" id="flashMessage">
       // <%= request.getParameter("message") != null ? request.getParameter("message") : "" %>
    </div> 
    -->

    <!-- Login Form Card -->
    <div class="login-card">
        <h3>Health Worker Login</h3>
        <form action="${pageContext.request.contextPath}/healthWorkerLoginServlet" method="post">
            <!-- Health Worker ID -->
            <div class="mb-3">
                <label for="healthId" class="form-label">Health Worker ID</label>
                <input type="text" class="form-control" id="healthId" name="healthId" placeholder="Enter your ID" required>
            </div>

            <!-- Password -->
            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <input type="password" class="form-control" id="password" name="password" placeholder="Enter your password" required>
            </div>

            <!-- Submit Button -->
            <div class="d-grid">
                <button type="submit" class="btn btn-login">Login</button>
            </div>
        </form>
    </div>
    <!-- SweetAlert logic -->
   <%
    String message = request.getParameter("message");
    boolean isNumeric = false;

    if (message != null) {
        try {
            // Check if message is a numeric user ID (from registration)
            Integer.parseInt(message);
            isNumeric = true;
        } catch (NumberFormatException e) {
            isNumeric = false;
        }
    }
%>

<% if (isNumeric) { %>
<script>
    Swal.fire({
        title: "Registered Successfully!",
        text: "Your user ID is <%= message %>",
        icon: "success",
        confirmButtonText: "OK"
    });
</script>
<% } else if ("Invalid Credentials. Please try again.".equals(message)) { %>
<script>
    Swal.fire({
        title: "Login Failed!",
        text: "Invalid credentials. Please try again.",
        icon: "error",
        confirmButtonText: "Retry"
    });
</script>
<% } %>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

    
    </script>
</body>
</html>
