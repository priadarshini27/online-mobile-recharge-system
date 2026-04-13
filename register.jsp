<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page errorPage="error.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mobile Recharge - Register</title>
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
            margin: 40px auto;
            padding: 0 20px;
        }
        
        .auth-card {
            background: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            text-align: center;
            border-top: 5px solid #4394f8;
        }
        
        .auth-logo {
            font-size: 2.5rem;
            color: #4394f8;
            margin-bottom: 20px;
        }
        
        .auth-title {
            color: #2c3e50;
            margin-bottom: 30px;
            font-size: 1.8rem;
        }
        
        .form-group {
            margin-bottom: 20px;
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
            border-color: #4394f8;
            background: white;
            box-shadow: 0 0 0 3px rgba(0, 200, 81, 0.1);
        }
        
        .btn-auth {
            width: 100%;
            padding: 16px;
            background: linear-gradient(90deg, #4394f8, #7e8fe5);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            margin-top: 20px;
        }
        
        .btn-auth:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(0, 200, 81, 0.2);
        }
        
        .auth-footer {
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #eee;
            color: #666;
        }
        
        .auth-link {
            color: #4394f8;
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s;
        }
        
        .auth-link:hover {
            color: #004f99;
            text-decoration: underline;
        }
        
        .password-toggle {
            position: relative;
        }
        
        .toggle-password {
            position: absolute;
            right: 15px;
            top: 45px;
            cursor: pointer;
            color: #777;
        }

        input[type="password"]::-ms-reveal {
            display: none;
        }
        
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }
        
        .success-message {
            color: #00c851;
            background: rgba(0, 200, 81, 0.1);
            padding: 10px;
            border-radius: 8px;
            margin-bottom: 20px;
            display: none;
        }
        
        @media (max-width: 768px) {
            .form-row {
                grid-template-columns: 1fr;
                gap: 0;
            }
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
                    <i class="fas fa-user-plus"></i>
                </div>
                <h1 class="auth-title">Create Your Account</h1>
                
                <div id="registerSuccess" class="success-message">
                    <i class="fas fa-check-circle"></i> Registration successful! Redirecting to login...
                </div>
                
                <form id="registerForm" method="POST" action="RegisterServlet">
                    <div class="form-row">
                        <div class="form-group">
                            <label for="userName">Full Name</label>
                            <input type="text" id="userName" name="fullName" class="form-control" placeholder="Enter your full name" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="userEmail">Email Address</label>
                            <input type="email" id="userEmail" name="email" class="form-control" placeholder="name@example.com" required>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="registerMobile">Mobile Number</label>
                        <input type="tel" id="registerMobile" name="mobile" class="form-control" placeholder="+91 9876543210" required pattern="^\+91\s\d{10}$" title="Format: +91 followed by 10 digits">                    </div>
                    
                    <div class="form-row">
                        <div class="form-group password-toggle">
                            <label for="registerPassword">Password</label>
                            <input type="password" id="registerPassword" name="password" class="form-control" placeholder="Create password" required minlength="6">
                            <span class="toggle-password" id="toggleRegisterPassword">
                                <i class="fas fa-eye"></i>
                            </span>
                        </div>
                        
                        <div class="form-group password-toggle">
                            <label for="confirmPassword">Confirm Password</label>
                            <input type="password" id="confirmPassword" class="form-control" placeholder="Confirm password" required minlength="6">
                            <span class="toggle-password" id="toggleConfirmPassword">
                                <i class="fas fa-eye"></i>
                            </span>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label>
                            <input type="checkbox" id="termsAgreement" required>
                            I agree to the <a href="#" class="auth-link">Terms of Service</a> and <a href="#" class="auth-link">Privacy Policy</a>
                        </label>
                    </div>
                    
                    <button type="submit" class="btn-auth">
                        <i class="fas fa-user-plus"></i> Create Account
                    </button>
                </form>
                
                <div class="auth-footer">
                    <p>Already have an account? <a href="login.jsp" class="auth-link">Login here</a></p>
                </div>
            </div>
        </div>

        <footer>
            <p>Online Mobile Recharge System &copy; 2026 | Secure & Fast Recharge Experience</p>
        </footer>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const registerForm = document.getElementById('registerForm');
            const registerSuccess = document.getElementById('registerSuccess');
            const toggleRegisterPassword = document.getElementById('toggleRegisterPassword');
            const toggleConfirmPassword = document.getElementById('toggleConfirmPassword');
            const registerPasswordInput = document.getElementById('registerPassword');
            const confirmPasswordInput = document.getElementById('confirmPassword');
            const mobileInput = document.getElementById('registerMobile');
            
            // Set fixed "+91 " prefix
            mobileInput.value = "+91 ";
            
            // Toggle password visibility for register password
            toggleRegisterPassword.addEventListener('click', function() {
                const type = registerPasswordInput.getAttribute('type') === 'password' ? 'text' : 'password';
                registerPasswordInput.setAttribute('type', type);
                this.innerHTML = type === 'password' ? '<i class="fas fa-eye"></i>' : '<i class="fas fa-eye-slash"></i>';
            });
            
            // Toggle password visibility for confirm password
            toggleConfirmPassword.addEventListener('click', function() {
                const type = confirmPasswordInput.getAttribute('type') === 'password' ? 'text' : 'password';
                confirmPasswordInput.setAttribute('type', type);
                this.innerHTML = type === 'password' ? '<i class="fas fa-eye"></i>' : '<i class="fas fa-eye-slash"></i>';
            });
            
            // Form submission
            registerForm.addEventListener('submit', function(e) {
               // e.preventDefault();
                
                const name = document.getElementById('userName').value;
                const email = document.getElementById('userEmail').value;
                const mobile = document.getElementById('registerMobile').value;
                const password = document.getElementById('registerPassword').value;
                const confirmPassword = document.getElementById('confirmPassword').value;
                
               // Validate mobile number
                if (!mobile.startsWith("+91 ")) {
                    alert("Mobile number must start with +91");
                    return;
                }

                const mobileDigits = mobile.substring(4); // after "+91 "

                if (mobileDigits.length !== 10) {
                    alert("Please enter exactly 10 digits after +91");
                    return;
                }
                
                // Password validation
                if (password !== confirmPassword) {
                    alert("Passwords do not match!");
                    return;
                }
                
               /* if (password.length < 6) {
                    alert("Password must be at least 6 characters long!");
                    return;
                }*/
                
                // In a real application, you would send this data to a server
                console.log('Registration data:', { name, email, mobile, password });
                
                // Show success message
                registerSuccess.style.display = 'block';
            });
            
            // Mobile number input handling
            mobileInput.addEventListener('focus', function() {
                if (this.value === "+91 ") {
                    this.setSelectionRange(4, 4);
                }
            });
            
            mobileInput.addEventListener('input', function(e) {
                // Keep +91 fixed
                let value = this.value;
                
                // If user tries to delete +91, prevent it
                if (!value.startsWith('+91')) {
                    this.value = '+91 ' + value.replace(/\D/g, '');
                    return;
                }
                
                // Get only the numbers after +91
                let numbers = value.substring(4).replace(/\D/g, '');
                
                // Limit to 10 digits
                if (numbers.length > 10) {
                    numbers = numbers.substring(0, 10);
                }
                
                // Reconstruct value with +91 prefix
                this.value = '+91 ' + numbers;
                
                // Keep cursor after the last number
                setTimeout(() => {
                    this.setSelectionRange(4 + numbers.length, 4 + numbers.length);
                }, 0);
            });
            
            mobileInput.addEventListener('keydown', function(e) {
                // Prevent deletion of +91
                const cursorPos = this.selectionStart;
                if (cursorPos <= 4 && e.key === 'Backspace') {
                    e.preventDefault();
                }
                
                // Allow only numbers and navigation keys after +91
                if (cursorPos >= 4) {
                    if (!/[\d]|ArrowLeft|ArrowRight|Delete|Backspace|Tab/.test(e.key)) {
                        e.preventDefault();
                    }
                }
            });
            
            // Real-time password match validation
            confirmPasswordInput.addEventListener('input', function() {
                const password = registerPasswordInput.value;
                const confirm = this.value;
                
                if (confirm && password !== confirm) {
                    this.style.borderColor = '#ff3860';
                } else {
                    this.style.borderColor = '#00c851';
                }
            });
        });
    </script>
</body>
</html>