<%@ page import="java.util.List" %>
<%@ page import="blog.Blog" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="database.AccessDatabase" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Blogs</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #d9fdfb, #a7e9ea, #90e0e0);
            min-height: 100vh;
            margin: 0;
            padding: 0;
        }

        /* Full-width fancy header */
        .header-section {
            width: 100%;
            padding: 60px 20px 80px;
            background: linear-gradient(to right, #8de3e1, #3ac7c2);
            color: #fff;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .header-section h1 {
            font-size: 2.8rem;
            font-weight: 700;
            margin: 0;
            text-shadow: 1px 2px 6px rgba(0, 0, 0, 0.2);
        }

        /* Fun blog icons as background stickers */
        .header-sticker {
            position: absolute;
            width: 60px;
            opacity: 0.2;
            animation: float 6s ease-in-out infinite;
        }

        .sticker1 { top: 20px; left: 30px; animation-delay: 0s; }
        .sticker2 { bottom: 20px; right: 40px; animation-delay: 2s; }
        .sticker3 { top: 30%; right: 10%; animation-delay: 1s; }
        .sticker4 { bottom: 25%; left: 8%; animation-delay: 3s; }

        @keyframes float {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-12px); }
        }

        .container.card-section {
            max-width: 1200px;
            width: 100%;
            margin-top: -40px;
            padding: 20px 15px 60px;
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 2rem;
        }

        .card-section .card {
            background: rgba(255, 255, 255, 0.3);
            border-radius: 20px;
            backdrop-filter: blur(18px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.08);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            width: 320px;
            overflow: hidden;
            color: #004d40;
            display: flex;
            flex-direction: column;
        }

        .card-section .card:hover {
            transform: translateY(-8px);
            box-shadow: 0 16px 40px rgba(0, 0, 0, 0.15);
        }

        .card-section .card img {
            height: 220px;
            width: 100%;
            object-fit: cover;
        }

        .card-body {
            padding: 18px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            flex-grow: 1;
        }

        .card-title {
            font-weight: 700;
            margin-bottom: 8px;
        }

        .card-title a {
            color: #004d40;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .card-title a:hover {
            color: #008b85;
        }

        .card-text {
            font-size: 14px;
            color: #004d4088;
        }

        .no-blogs {
            text-align: center;
            color: #004d4d99;
            font-size: 1.3rem;
            margin-top: 50px;
            width: 100%;
        }

        @media (max-width: 768px) {
            .card-section .card {
                width: 90%;
            }
            .header-section h1 {
                font-size: 2rem;
            }
        }
    </style>
</head>
<body>

<!-- Fancy Header -->
<section class="header-section">
    <h1>My Blogs List</h1>
    <img src="https://cdn-icons-png.flaticon.com/128/1828/1828884.png" class="header-sticker sticker1" alt="Star">
    <img src="https://cdn-icons-png.flaticon.com/128/3163/3163130.png" class="header-sticker sticker2" alt="Pencil">
    <img src="https://cdn-icons-png.flaticon.com/128/3135/3135715.png" class="header-sticker sticker3" alt="User">
    <img src="https://cdn-icons-png.flaticon.com/128/9068/9068661.png" class="header-sticker sticker4" alt="Book">
</section>

<!-- Blog Cards Section -->
<div class="container card-section">
    <%
        if (session == null || session.getAttribute("healthWorkerId") == null) {
            response.sendRedirect("healthworker/healthWorkerLogin.jsp?message=" + 
                URLEncoder.encode("Please login to continue.", "UTF-8"));
            return;
        }

        String healthWorkerIdStr = (String) session.getAttribute("healthWorkerId");
        int healthWorkerId = -1;
        try {
            healthWorkerId = Integer.parseInt(healthWorkerIdStr);
        } catch (NumberFormatException e) {
            out.println("<div class='alert alert-danger'>Invalid Health Worker ID format.</div>");
        }

        AccessDatabase db = AccessDatabase.getInstance();
        List<Blog> blogList = db.getMyBlogs(healthWorkerId);

        int imgIndex = 1;

        if (blogList != null && !blogList.isEmpty()) {
            for (Blog blog : blogList) {
                String blogTitle = blog.getBlogTitle();
                int blogId = blog.getBlogId();
                String formattedDate = new SimpleDateFormat("dd MMM yyyy").format(blog.getBlogDate());
    %>

    <div class="card">
        <img src="<%= request.getContextPath() %>/resource/img<%= imgIndex %>.jpg" alt="Blog Image">
        <div class="card-body">
            <p class="card-text small"><%= formattedDate %></p>
            <h5 class="card-title">
                <a href="blog.jsp?blogId=<%= blogId %>&img=<%= request.getContextPath() %>/resource/img<%= imgIndex %>.jpg">
                    <%= blogTitle %>
                </a>
            </h5>
        </div>
    </div>

    <%
                imgIndex++;
                if (imgIndex > 3) {
                    imgIndex = 1;
                }
            }
        } else {
    %>
    <div class="no-blogs">No blogs found.</div>
    <%
        }
    %>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
