<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String userName = (String) session.getAttribute("userName");
    String initials = "U";
    if (userName != null && !userName.isEmpty()) {
        String[] parts = userName.split(" ");
        for (String part : parts) {
            initials += part.charAt(0);
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Event</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <!-- Fonts & Libraries -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://unpkg.com/aos@2.3.4/dist/aos.css" rel="stylesheet">

    <!-- Style Section only (keep rest of HTML structure) -->
<style>
    body {
        margin: 0;
        font-family: 'Poppins', sans-serif;
        background:#B2EBF2 ; /* Teal gradient */
        min-height: 100vh;
    }

    .main-container {
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 2rem;
    }

    .hero-box {
        display: flex;
        background-color: white;
        border-radius: 20px;
        overflow: hidden;
        box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
        width: 100%;
        max-width: 1100px;
    }

   .left-img {
    flex: 1;
    background: url('<%= request.getContextPath() %>/resource/event.png') no-repeat center center;
    background-size: 120%; /* Slight zoom for Ken Burns */
    animation: kenburns 20s ease-in-out infinite alternate;
    position: relative;
    overflow: hidden;
}

/* Ken Burns Effect */
@keyframes kenburns {
    0% {
        transform: scale(1) translate(0, 0);
    }
    100% {
        transform: scale(1.1) translate(-5px, -5px);
    }
}

/* Glass Shine Effect */
.left-img::after {
    content: "";
    position: absolute;
    top: 0;
    left: -75%;
    width: 50%;
    height: 100%;
    background: linear-gradient(
        120deg,
        rgba(255, 255, 255, 0.05) 0%,
        rgba(255, 255, 255, 0.3) 50%,
        rgba(255, 255, 255, 0.05) 100%
    );
    transform: skewX(-25deg);
    animation: shine 4s infinite;
}

@keyframes shine {
    to {
        left: 125%;
    }
}


    .form-area {
        flex: 1;
        padding: 40px;
        animation: fadeInUp 1s ease-in-out;
        background-color: #ffffff;
    }

    @keyframes fadeInUp {
        from { opacity: 0; transform: translateY(20px); }
        to { opacity: 1; transform: translateY(0); }
    }

    h2 {
        font-weight: 600;
        color: #0f5132; /* Dark teal */
        margin-bottom: 30px;
        text-align: center;
    }

    .form-control {
        border-radius: 10px;
        border: 1px solid #b2f2bb;
        margin-bottom: 15px;
        padding: 10px 15px;
        background-color: #E0F2F1;
        transition: border-color 0.3s, box-shadow 0.3s;
    }

    .form-control:focus {
        border-color: #20c997;
        box-shadow: 0 0 8px rgba(32, 201, 151, 0.4);
        background-color: #ffffff;
    }

    .btn-submit {
        background: #4DB6AC;
        border: none;
        color: white;
        padding: 12px 20px;
        border-radius: 10px;
        width: 100%;
        font-weight: 600;
        transition: background 0.3s, transform 0.2s;
    }

    .btn-submit:hover {
        background: #80DEEA;
        transform: scale(1.02);
    }

    @media (max-width: 768px) {
        .hero-box {
            flex-direction: column;
        }

        .left-img {
            height: 200px;
        }
    }
</style>

    
</head>
<body>

<div class="main-container">
    <div class="hero-box" data-aos="zoom-in">
        <!-- Image Panel -->
        <div class="left-img"></div>

        <!-- Form Panel -->
        <div class="form-area">
            <h2>Add New Event</h2>
            <form action="${pageContext.request.contextPath}/AddEventServlet" method="post">
                <input type="text" class="form-control" name="eventName" placeholder="Event Name" required>

              Start Date  <input type="date" class="form-control" name="eventStartDate" placeholder="Start Date" required>

                <input type="text" class="form-control" name="eventStartTime" placeholder="Start Time (HH:mm)" required>

              End Date  <input type="date" class="form-control" name="eventEndDate"  placeholder="End Date"required>

                <input type="text" class="form-control" name="eventEndTime" placeholder="End Time (HH:mm)" required>

                <textarea name="eventDescription" class="form-control" placeholder="Event Description" rows="3" required></textarea>

                <button type="submit" class="btn btn-submit mt-2">Add Event</button>
            </form>
        </div>
    </div>
</div>

<!-- AOS for animation -->
<script src="https://unpkg.com/aos@2.3.4/dist/aos.js"></script>
<script>
    AOS.init();
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
