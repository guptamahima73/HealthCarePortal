<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Admin Login</title>

    <!-- Bootstrap CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" />

    <style>
        body {
            margin: 0;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, #FFECB3, #FFCCBC, #FFE0B2);
            background-size: 400% 400%;
            animation: gradientBG 15s ease infinite;
            font-family: 'Segoe UI', sans-serif;
        }

        @keyframes gradientBG {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        .glass-card {
            backdrop-filter: blur(15px);
            background: rgba(255, 255, 255, 0.3);
            border-radius: 20px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.15);
            padding: 40px;
            width: 100%;
            max-width: 400px;
            border: 1px solid rgba(255, 255, 255, 0.18);
        }

        .login-title {
            text-align: center;
            margin-bottom: 30px;
            font-weight: 700;
            color: #BF360C;
        }

        .form-label {
            font-weight: 600;
            color: #4E342E;
        }

        .form-control {
            border-radius: 10px;
        }

        .btn-login {
            background-color: #FF7043;
            color: white;
            border: none;
            border-radius: 10px;
            font-weight: 600;
            transition: background-color 0.3s ease;
        }

        .btn-login:hover {
            background-color: #E64A19;
        }

        .alert {
            border-radius: 10px;
        }
    </style>
</head>
<body>

<div class="glass-card">
    <h2 class="login-title">Admin Login</h2>

    <%-- Show error message if passed as request attribute --%>
    <%
        String errorMessage = (String) request.getAttribute("errorMessage");
        if (errorMessage != null) {
    %>
        <div class="alert alert-danger" role="alert">
            <%= errorMessage %>
        </div>
    <% } %>

    <form action="${pageContext.request.contextPath}/adminLoginServlet" method="post">
        <div class="mb-3">
            <label for="adminId" class="form-label">Admin-ID</label>
            <input type="text" class="form-control" id="adminId" name="adminId" required autofocus />
        </div>
        <div class="mb-3">
            <label for="adminPass" class="form-label">Password</label>
            <input type="password" class="form-control" id="adminPass" name="adminPass" required />
        </div>
        <button type="submit" class="btn btn-login w-100">Log In</button>
    </form>
</div>

<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
