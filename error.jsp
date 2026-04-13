<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error - Mobile Recharge</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="styles.css">
    <style>
        .error-container {
            max-width: 600px;
            margin: 50px auto;
            text-align: center;
            padding: 40px;
            background: white;
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
        }
        
        .error-icon {
            font-size: 4rem;
            color: #ff3860;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <div class="header-content">
                <div class="logo">
                    <i class="fas fa-mobile-alt"></i>
                    <span>Online Mobile Recharge</span>
                </div>
            </div>
        </header>

        <div class="error-container">
            <div class="error-icon">
                <i class="fas fa-exclamation-triangle"></i>
            </div>
            <h1>Oops! Something went wrong</h1>
            <p>We're sorry, but an error has occurred.</p>
            
            <% if(exception != null) { %>
            <div style="background: #f8f9ff; padding: 15px; border-radius: 8px; margin: 20px 0;">
                <p><strong>Error Message:</strong> <%= exception.getMessage() %></p>
            </div>
            <% } %>
            
            <a href="home.jsp" class="btn-auth" style="display: inline-block; width: auto; padding: 10px 30px;">
                <i class="fas fa-home"></i> Back to Home
            </a>
        </div>

        <footer>
            <p>Online Mobile Recharge System &copy; 2026 | Secure & Fast Recharge Experience</p>
        </footer>
    </div>
</body>
</html>