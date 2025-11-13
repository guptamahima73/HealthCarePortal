<%@page import="blog.Blog" %>
<%@page import="database.AccessDatabase" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Blog Details</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@400;600;700&display=swap" rel="stylesheet">

    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Quicksand', sans-serif;
            background: url('https://www.transparenttextures.com/patterns/purty-wood.png'), linear-gradient(to right, #c2e9fb, #a1c4fd);
            background-blend-mode: overlay;
            background-size: cover;
            color: #333;
        }

        .header {
            position: relative;
            width: 100%;
            height: 280px;
            background: linear-gradient(-45deg, #a8e063, #76c7c0, #67b26f, #a8e063);
            background-size: 600% 600%;
            animation: gradient 15s ease infinite;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            text-align: center;
            overflow: hidden;
        }

        .header h1 {
            font-size: 3rem;
            font-weight: bold;
            text-shadow: 2px 4px 8px rgba(0, 0, 0, 0.3);
        }

        .wave {
            position: absolute;
            bottom: 0;
            width: 100%;
            height: 70px;
            background: url('https://svgshare.com/i/uE9.svg') repeat-x;
            background-size: cover;
        }

        @keyframes gradient {
            0% {background-position: 0% 50%;}
            50% {background-position: 100% 50%;}
            100% {background-position: 0% 50%;}
        }

        .container {
            margin-top: -100px;
            z-index: 10;
            position: relative;
        }

        .blog-card {
            background: rgba(255, 255, 255, 0.25);
            backdrop-filter: blur(18px);
            -webkit-backdrop-filter: blur(18px);
            border: 1px solid rgba(255, 255, 255, 0.18);
            box-shadow: 0 0 20px rgba(0, 128, 128, 0.3);
            padding: 40px;
            border-radius: 20px;
            transition: transform 0.3s;
        }

        .blog-card:hover {
            transform: scale(1.01) rotateZ(-0.3deg);
        }

        .blog-title {
            font-weight: 700;
            font-size: 2.2rem;
            color: #00695c;
        }

        .blog-meta {
            font-size: 15px;
            color: #00796b;
            margin-bottom: 20px;
        }

        .blog-image {
            width: 100%;
            max-height: 400px;
            object-fit: cover;
            border-radius: 16px;
            margin-bottom: 25px;
        }

        .blog-description {
            font-size: 17px;
            line-height: 1.8;
        }

        .sticker {
            width: 60px;
            position: absolute;
            opacity: 0.3;
            transition: transform 1s ease-in-out;
        }

        .sticker:hover {
            transform: rotate(10deg) scale(1.1);
            opacity: 0.6;
        }

        .s1 { top: 20px; left: 20px; }
        .s2 { bottom: 20px; right: 30px; }
        .s3 { top: 40px; right: 40px; }
        .s4 { bottom: 30%; left: 10%; }

        @media (max-width: 768px) {
            .blog-card {
                padding: 25px;
            }
            .blog-title {
                font-size: 1.6rem;
            }
        }
    </style>
</head>
<body>

    <!-- Animated Gradient Header with Wavy Bottom -->
    <section class="header">
        <h1>📝 Blog Details</h1>
        <div class="wave"></div>
        <img src="https://cdn-icons-png.flaticon.com/128/1063/1063191.png" class="sticker s1" alt="Book Icon">
        <img src="https://cdn-icons-png.flaticon.com/128/1055/1055687.png" class="sticker s2" alt="Pen Icon">
        <img src="https://cdn-icons-png.flaticon.com/128/2948/2948035.png" class="sticker s3" alt="User Icon">
        <img src="https://cdn-icons-png.flaticon.com/128/2620/2620730.png" class="sticker s4" alt="Notes Icon">
    </section>

    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-10">
                <div class="blog-card">
                    <%
                        String blogIdParam = request.getParameter("blogId");
                        String img = request.getParameter("img");

                        AccessDatabase accessDatabase = null;
                        Blog blog = null;

                        try {
                            if (blogIdParam != null && !blogIdParam.isEmpty()) {
                                int blogId = Integer.parseInt(blogIdParam);
                                accessDatabase = AccessDatabase.getInstance();
                                blog = accessDatabase.getBlogById(blogId);
                                if (blog != null) {
                                    String healthWorkerName = accessDatabase.getHealthWorkerNameByBlogId(blogId);
                    %>
                                    <h2 class="blog-title"><%= blog.getBlogTitle() %></h2>
                                    <p class="blog-meta">📅 <%= blog.getBlogDate() %> | By <strong><%= healthWorkerName != null ? healthWorkerName : "Unknown" %></strong></p>
                                    <img src="<%= img %>" class="blog-image" alt="Blog Image">
                                    <p class="blog-description"><%= blog.getBlogDescription() %></p>
                    <%
                                } else {
                                    out.println("<p class='text-danger'>No blog found with the given ID.</p>");
                                }
                            } else {
                                out.println("<p class='text-danger'>Invalid Blog ID.</p>");
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                            out.println("<p class='text-danger'>An error occurred while loading the blog.</p>");
                        }
                    %>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
