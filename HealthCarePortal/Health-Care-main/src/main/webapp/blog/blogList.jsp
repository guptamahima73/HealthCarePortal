<%@ page import="java.util.List" %>
<%@ page import="blog.Blog" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="database.AccessDatabase" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Swasth Saarthi Blog</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #e6f5f0, #d2f5dc);
            min-height: 100vh;
            padding-top: 40px;
        }

        .card {
            background: rgba(255, 255, 255, 0.3);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            transition: transform 0.4s ease, box-shadow 0.4s ease;
            opacity: 0;
            animation: popUp 0.6s ease forwards;
        }

        /* Staggered animation delays */
        .row > div:nth-child(1) .card { animation-delay: 0.1s; }
        .row > div:nth-child(2) .card { animation-delay: 0.2s; }
        .row > div:nth-child(3) .card { animation-delay: 0.3s; }
        .row > div:nth-child(4) .card { animation-delay: 0.4s; }
        .row > div:nth-child(5) .card { animation-delay: 0.5s; }
        .row > div:nth-child(6) .card { animation-delay: 0.6s; }

        @keyframes popUp {
            0% {
                opacity: 0;
                transform: scale(0.8) translateY(30px);
            }
            100% {
                opacity: 1;
                transform: scale(1) translateY(0);
            }
        }

        .card:hover {
            transform: scale(1.05) translateY(-10px);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
        }

        .card-img-top {
            height: 200px;
            object-fit: cover;
            border-top-left-radius: 20px;
            border-top-right-radius: 20px;
        }

        .card-title a {
            color: #0f9d58;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .card-title a:hover {
            color: #0a7d44;
        }

        .card-body {
            text-align: center;
        }

        .blog-date {
            font-size: 0.8rem;
            color: #666;
        }
    </style>
</head>
<body>

<div class="container text-center mb-5">
    <h1 class="fw-bold text-success">Swasth Saarthi Blog</h1>
    <p class="text-muted">Empowering Rural Healthcare through Awareness</p>
</div>

<div class="container mt-3">
    <div class="row">
        <%
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
            AccessDatabase accessDatabase = null;
            List<Blog> blogs = null;
            try {
                accessDatabase = AccessDatabase.getInstance();
                blogs = accessDatabase.searchBlog(null, null);
            } catch (Exception e) {
                e.printStackTrace();
            }

            if (blogs != null && !blogs.isEmpty()) {
                int imgIndex = 1;
                for (Blog blog : blogs) {
                    String blogTitle = blog.getBlogTitle();
                    java.sql.Date blogDate = blog.getBlogDate();
                    String formattedDate = sdf.format(blogDate);
                    int blogId = blog.getBlogId();
        %>
        <div class="col-md-4 mb-4 d-flex align-items-stretch">
            <div class="card w-100">
                <img src="<%=request.getContextPath()%>/resource/img<%= imgIndex %>.jpg" class="card-img-top" alt="Blog Image">
                <div class="card-body">
                    <p class="blog-date"><%= formattedDate %></p>
                    <h5 class="card-title">
                        <a href="blog.jsp?blogId=<%= blogId %>&img=<%= request.getContextPath() %>/resource/img<%= imgIndex %>.jpg">
                            <%= blogTitle %>
                        </a>
                    </h5>
                </div>
            </div>
        </div>
        <%
                    imgIndex++;
                    if (imgIndex > 3) imgIndex = 1;
                }
            } else {
        %>
        <div class="col-12">
            <p class="text-center text-muted">No blogs found.</p>
        </div>
        <%
            }
        %>
    </div>
</div>

<!-- Footer SVG -->
<footer class="text-center mt-5">
    <svg viewBox="0 0 1440 320" style="width: 100%; height: 100px;">
        <path fill="#0f9d58" fill-opacity="1"
              d="M0,160L60,165.3C120,171,240,181,360,181.3C480,181,600,171,720,149.3C840,128,960,96,1080,80C1200,64,1320,64,1380,64L1440,64L1440,320L1380,320C1320,320,1200,320,1080,320C960,320,840,320,720,320C600,320,480,320,360,320C240,320,120,320,60,320L0,320Z">
        </path>
    </svg>
</footer>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
