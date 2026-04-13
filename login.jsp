<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page errorPage="error.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mobile Recharge - Login</title>
    <link rel="stylesheet" href="css/all.min.css">
    <link rel="stylesheet" href="styles.css">
    <style>
        body {
            margin: 0;
            padding: 0;
            min-height: 100vh;
            
            background-image: url(images/bg.jpg);
            background-size: cover;          /* full screen */
            background-position: center;     /* center image */
            background-repeat: no-repeat;    /* no tiling */
            background-attachment: fixed;    /* optional parallax effect */
        }
        .auth-container {
            max-width: 700px;
            margin: 50px auto;
            padding: 0 20px;
        }
        
        .auth-card {
            background: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            text-align: center;
            border-top: 5px solid #0072ff;
        }
        
        .auth-logo {
            font-size: 2.5rem;
            color: #0072ff;
            margin-bottom: 20px;
        }
        
        .auth-title {
            color: #2c3e50;
            margin-bottom: 30px;
            font-size: 1.8rem;
        }
        
        .form-group {
            margin-bottom: 25px;
            text-align: left;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #555;
            font-weight: 600;
            font-size: 0.95rem;
        }
        
        .form-control {
            width: 100%;
            padding: 14px 18px;
            border: 2px solid #e1e5eb;
            border-radius: 10px;
            font-size: 1rem;
            transition: all 0.3s;
            background: #f8f9ff;
        }
        
        .form-control:focus {
            outline: none;
            border-color: #0072ff;
            background: white;
            box-shadow: 0 0 0 3px rgba(0, 114, 255, 0.1);
        }
        
        .btn-auth {
            width: 100%;
            padding: 16px;
            background: linear-gradient(90deg, #0072ff, #00c6ff);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            margin-top: 10px;
        }
        
        .btn-auth:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(0, 114, 255, 0.2);
        }
        
        .auth-footer {
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #eee;
            color: #666;
        }
        
        .auth-link {
            color: #0072ff;
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s;
        }
        
        .auth-link:hover {
            color: #0056cc;
            text-decoration: underline;
        }
        
        .password-toggle {
            position: relative;
        }
        
        .toggle-password {
            position: absolute;
            right: 13px;
            top: 45px;
            cursor: pointer;
            color: #777;
        }

        input[type="password"]::-ms-reveal {
            display: none;
        }

        
        .error-message {
            color: #ff3860;
            background: rgba(255, 56, 96, 0.1);
            padding: 10px;
            border-radius: 8px;
            margin-bottom: 20px;
            display: none;
        }
        
        @media (max-width: 480px) {
            .auth-card {
                padding: 30px 25px;
            }
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

        <div class="auth-container">
            <div class="auth-card">
                <div class="auth-logo">
                    <i class="fas fa-sign-in-alt"></i>
                </div>
                <h1 class="auth-title">Welcome Back</h1>
                
                <%--error message if exists --%>
                <%
                    String error = request.getParameter("error");
                    if(error != null) {
                %>
                <div id="loginError" class="error-message" style="display: block;">
                    <i class="fas fa-exclamation-circle"></i> 
                    <%= error %>
                </div>
                <%
                    } else {
                %>
                <div id="loginError" class="error-message">
                    <i class="fas fa-exclamation-circle"></i> Invalid mobile number or password
                </div>
                <%
                    }
                %>
                
                <%-- Change form method to POST and action to a servlet --%>
                <form id="loginForm" method="POST" action="LoginServlet">
                    <div class="form-group">
                        <label for="loginMobile">Mobile Number</label>
                        <input type="tel" id="loginMobile" name="mobile" class="form-control" placeholder="+91 9876543210" required pattern="^\+91\s\d{10}$" title="Format: +91 followed by 10 digits">                    </div>
                    
                    <div class="form-group password-toggle">
                        <label for="loginPassword">Password</label>
                        <input type="password" id="loginPassword" name="password" class="form-control" placeholder="Enter your password" required minlength="6">
                        <span class="toggle-password" id="toggleLoginPassword">
                            <i class="fas fa-eye"></i>
                        </span>
                    </div>
                    
                    <button type="submit" class="btn-auth">
                        <i class="fas fa-sign-in-alt"></i> Login to Your Account
                    </button>
                </form>
                
                <div class="auth-footer">
                    <p>New user? <a href="register.jsp" class="auth-link">Create an account</a></p>
                </div>
            </div>
        </div>

        <footer>
            <p>Online Mobile Recharge System &copy; 2026 | Secure & Fast Recharge Experience</p>
        </footer>
    </div>

<script>
document.addEventListener('DOMContentLoaded', function () {

    const loginForm = document.getElementById('loginForm');
    const toggleLoginPassword = document.getElementById('toggleLoginPassword');
    const loginPasswordInput = document.getElementById('loginPassword');
    const mobileInput = document.getElementById('loginMobile');

    // Set fixed "+91 " prefix
    mobileInput.value = "+91 ";

    // Toggle password visibility
    toggleLoginPassword.addEventListener('click', function () {
        const type = loginPasswordInput.getAttribute('type') === 'password' ? 'text' : 'password';
        loginPasswordInput.setAttribute('type', type);
        this.innerHTML = type === 'password'
            ? '<i class="fas fa-eye"></i>'
            : '<i class="fas fa-eye-slash"></i>';
    });

    // Validate mobile format before submitting
    loginForm.addEventListener('submit', function (e) {

        const mobile = mobileInput.value;

        if (!mobile.startsWith("+91 ")) {
            alert("Mobile number must start with +91");
            e.preventDefault();
            return;
        }

        const mobileDigits = mobile.substring(4);

        if (mobileDigits.length !== 10) {
            alert("Please enter exactly 10 digits after +91");
            e.preventDefault();
            return;
        }

        // ✅ If validation passes, form submits normally to LoginServlet
    });

    // Keep +91 fixed
    mobileInput.addEventListener('focus', function () {
        if (this.value === "+91 ") {
            this.setSelectionRange(4, 4);
        }
    });

    mobileInput.addEventListener('input', function () {
        let value = this.value;

        if (!value.startsWith('+91')) {
            this.value = '+91 ' + value.replace(/\D/g, '');
            return;
        }

        let numbers = value.substring(4).replace(/\D/g, '');

        if (numbers.length > 10) {
            numbers = numbers.substring(0, 10);
        }

        this.value = '+91 ' + numbers;

        setTimeout(() => {
            this.setSelectionRange(4 + numbers.length, 4 + numbers.length);
        }, 0);
    });

    mobileInput.addEventListener('keydown', function (e) {
        const cursorPos = this.selectionStart;

        if (cursorPos <= 4 && e.key === 'Backspace') {
            e.preventDefault();
        }

        if (cursorPos >= 4) {
            if (!/[\d]|ArrowLeft|ArrowRight|Delete|Backspace|Tab/.test(e.key)) {
                e.preventDefault();
            }
        }
    });

});
</script>

</body>
</html>