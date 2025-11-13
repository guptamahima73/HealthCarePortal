<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>User Login Form</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" />
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>
        body {
            margin: 0;
            padding: 0;
            height: 100vh;
            background: url('https://img.freepik.com/free-photo/vivid-blurred-colorful-wallpaper-background_58702-3798.jpg?ga=GA1.1.1883168269.1747250089&semt=ais_hybrid&w=740') no-repeat center center fixed;
            background-size: cover;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .login-container {
            background: rgba(255, 255, 255, 0.15);
            border-radius: 15px;
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.18);
            padding: 30px;
            width: 100%;
            max-width: 400px;
            color: #fff;
        }

        .text-info {
            color: white;
            font-weight: 600;
            text-decoration: none;
        }

        .text-white {
            color: #1976D2 !important;
        }

        /* Override input-group-text background and border for better style */
        .input-group-text {
            background: white !important;
            border: 1px solid #ced4da !important;
        }
    </style>
</head>
<body>
    <!-- Login Form Container -->
    <div class="login-container">
        <!-- Friendly sticker icon -->
        <div class="text-center mb-3">
            <i class="bi bi-heart-pulse-fill" style="font-size: 3rem; color: #1976D2;"></i>
        </div>

        <h3 class="text-center mb-4 text-white">Login Form</h3>

        <form action="${pageContext.request.contextPath}/residentLoginServlet" method="post">
            <div class="mb-3">
                <label for="userId" class="form-label text-white">User ID</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="bi bi-person-fill" style="color:#1976D2;"></i></span>
                    <input
                        type="text"
                        class="form-control"
                        id="userId"
                        name="userId"
                        placeholder="Enter Token No."
                        required
                    />
                </div>
            </div>

            <div class="mb-3">
                <label for="password" class="form-label text-white">Password</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="bi bi-lock-fill" style="color:#1976D2;"></i></span>
                    <input
                        type="password"
                        class="form-control"
                        id="password"
                        name="password"
                        placeholder="Enter your password"
                        required
                    />
                </div>
            </div>

            <div class="d-grid">
                <button type="submit" class="btn btn-primary">
                    <i class="bi bi-box-arrow-in-right me-2"></i> Login
                </button>
            </div>
        </form>

        <div class="mt-3 text-center text-white">
            <p>
                Don't have an account?
                <a href="residentSignup.jsp" class="text-info">Register here</a>
            </p>
        </div>
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
</body>
</html>
