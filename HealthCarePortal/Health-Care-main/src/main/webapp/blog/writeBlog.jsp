<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Blog</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

    <!-- Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            background: linear-gradient(to bottom, #e6f9f0, #ccf2e9);
            min-height: 100vh;
            overflow-x: hidden;
            position: relative;
        }

        /* Header section */
        .header-section {
            text-align: center;
            padding: 50px 20px 30px;
            background-color: #26A69A;
            color: white;
            position: relative;
        }

        .header-section img {
            width: 100px;
            margin-top: 20px;
        }

        /* Form section */
        .form-section {
            padding: 40px 20px;
            position: relative;
        }

        .form-container {
            background: rgba(255, 255, 255, 0.6);
            backdrop-filter: blur(12px);
            border-radius: 20px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            padding: 30px;
        }

        .form-label {
            font-weight: 600;
            color: #0f6848;
        }

        .form-control::placeholder {
            color: #999;
            font-style: italic;
        }

        .btn-primary {
            background-color: #0f9d58;
            border: none;
        }

        .btn-primary:hover {
            background-color: #0a7d44;
        }

        /* Bookmark icons background */
        .bookmark-bg {
            position: absolute;
            top: 0;
            left: 0;
            opacity: 0.05;
            font-size: 250px;
            transform: rotate(-30deg);
            z-index: 0;
        }

        .bookmark-bg.right {
            top: auto;
            bottom: 0;
            left: auto;
            right: 0;
            transform: rotate(30deg);
        }
    </style>
</head>
<body>

    <!-- Background Icons -->
    <i class="bi bi-bookmark-fill bookmark-bg"></i>
    <i class="bi bi-bookmark-star-fill bookmark-bg right"></i>

    <!-- Header Section -->
    <section class="header-section">
        <h1 class="fw-bold">Add New Blog</h1>
        <p>Share awareness, inspire change.</p>
        <img src="https://cdn-icons-png.flaticon.com/512/942/942748.png" alt="Blog Icon">
    </section>

    <!-- Form Section -->
    <section class="form-section">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-8 col-lg-6">
                    <div class="form-container">
                        <form action="${pageContext.request.contextPath}/WriteBlogServlet" method="post">
                            <!-- Blog Title -->
                            <div class="mb-3">
                                <label for="blogTitle" class="form-label">Blog Title</label>
                                <input type="text" class="form-control" id="blogTitle" name="blogTitle"
                                       placeholder="Enter a catchy blog title" required>
                            </div>

                            <!-- Description -->
                            <div class="mb-3">
                                <label for="blogDescription" class="form-label">Blog Description</label>
                                <textarea class="form-control" id="blogDescription" name="blogDescription" rows="5"
                                          placeholder="Write the main content of your blog..." required></textarea>
                            </div>

                            <!-- Date -->
                            <div class="mb-3">
                                <label for="blogDate" class="form-label">Blog Date</label>
                                <input type="date" class="form-control" id="blogDate" name="blogDate" required>
                            </div>

                            <!-- Category -->
                            <div class="mb-4">
                                <label for="category" class="form-label">Category</label>
                                <select class="form-control" id="category" name="category" required>
                                    <option value="" disabled selected>Select Category</option>
                                    <option value="Nutrition">Nutrition</option>
                                    <option value="Mental Health">Mental Health</option>
                                    <option value="Child Health">Child Health</option>
                                    <option value="Community Health">Community Health</option>
                                </select>
                            </div>

                            <!-- Submit -->
                            <div class="d-grid">
                                <button type="submit" class="btn btn-primary btn-lg">Publish Blog</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
