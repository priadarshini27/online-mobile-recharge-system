<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%
    HttpSession sessionObj = request.getSession(false);

    if (sessionObj == null || sessionObj.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int userId = (Integer) sessionObj.getAttribute("userId");

    String fullName = "";
    String email = "";
    String mobile = "";

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");

        conn = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/ors",
            "root",
            "pria@27"
        );

        ps = conn.prepareStatement(
            "SELECT full_name, email, mobile FROM users WHERE user_id=?"
        );

        ps.setInt(1, userId);
        rs = ps.executeQuery();

        if (rs.next()) {
            fullName = rs.getString("full_name");
            email = rs.getString("email");
            mobile = rs.getString("mobile");
        }

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch(Exception e){}
        if (ps != null) try { ps.close(); } catch(Exception e){}
        if (conn != null) try { conn.close(); } catch(Exception e){}
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>User Settings - Online Mobile Recharge</title>
    <link rel="stylesheet" href="css/all.min.css">
    <link rel="stylesheet" href="styles.css">
    <style>
        /* Additional styles for settings page to match application theme */
        .settings-container {
            max-width: 1000px;
            margin: 40px auto;
            padding: 20px;
        }
        
        .settings-card {
            background: white;
            border-radius: 15px;
            padding: 40px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            border: 1px solid #f0f0f0;
        }

        .settings-card h2 {
            color: #2c3e50;
            margin-bottom: 30px;
            font-size: 2rem;
            display: flex;
            align-items: center;
            gap: 10px;
            border-bottom: 2px solid #f0f0f0;
            padding-bottom: 15px;
        }

        .settings-card h2 i {
            color: #0072ff;
        }

        .settings-card h3 {
            color: #4a6491;
            margin: 0 0 20px 0;
            font-size: 1.3rem;
            display: flex;
            align-items: center;
            gap: 8px;
            padding-bottom: 10px;
            border-bottom: 1px solid #e0e5f0;
        }

        .form-row {
            display: flex;
            gap: 30px;
            margin-bottom: 30px;
        }

        .form-column {
            flex: 1;
            min-width: 0; /* Prevents flex overflow */
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #2c3e50;
            font-weight: 500;
            font-size: 0.95rem;
        }

        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background-color: #f8f9ff;
        }

        .form-control:focus {
            outline: none;
            border-color: #0072ff;
            box-shadow: 0 0 0 3px rgba(0, 114, 255, 0.1);
            background-color: white;
        }

        .form-control:hover {
            border-color: #4a6491;
        }

        hr {
            border: none;
            height: 2px;
            background: linear-gradient(90deg, transparent, #0072ff, #00c6ff, transparent);
            margin: 30px 0;
        }

        .btn-auth {
            width: 100%;
            padding: 14px;
            background: linear-gradient(45deg, #0072ff, #00c6ff);
            color: white;
            border: none;
            border-radius: 50px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 10px;
            box-shadow: 0 4px 15px rgba(0, 114, 255, 0.3);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        .btn-auth:hover {
            background: linear-gradient(45deg, #0056b3, #0095ff);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0, 114, 255, 0.4);
        }

        .btn-auth:active {
            transform: translateY(0);
        }

        .btn-delete {
            width: 100%;
            padding: 14px;
            background: linear-gradient(45deg, #a72828, #e93e3e);
            color: white;
            border: none;
            border-radius: 50px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 10px;
            box-shadow: 0 4px 15px rgba(231, 76, 60, 0.3);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        .btn-delete:hover {
            background: linear-gradient(45deg, #c0392b, #e74c3c);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(231, 76, 60, 0.4);
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            color: #4a6491;
            text-decoration: none;
            font-weight: 500;
            margin-top: 20px;
            padding: 10px 20px;
            border-radius: 50px;
            background: #f8f9ff;
            transition: all 0.3s ease;
        }

        .back-link:hover {
            background: #e0e7ff;
            color: #0072ff;
            transform: translateX(-5px);
        }

        .back-link i {
            font-size: 0.9rem;
        }

        .settings-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 30px;
        }

        .settings-header .user-avatar {
            width: 60px;
            height: 60px;
            background: linear-gradient(45deg, #00c6ff, #0072ff);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.8rem;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
        }

        .password-hint {
            font-size: 0.85rem;
            color: #666;
            margin-top: 5px;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .password-hint i {
            color: #ff9800;
        }

        .section-divider {
            margin: 30px 0;
            position: relative;
            text-align: center;
        }

        .section-divider::before {
            content: '';
            position: absolute;
            left: 0;
            top: 50%;
            width: 100%;
            height: 1px;
            background: linear-gradient(90deg, transparent, #0072ff, #00c6ff, transparent);
            z-index: 1;
        }

        .section-divider span {
            background: white;
            padding: 0 20px;
            color: #4a6491;
            font-weight: 600;
            position: relative;
            z-index: 2;
        }

        .form-column h3 i {
            color: #0072ff;
        }

        /* Responsive design */
        @media (max-width: 768px) {
            .form-row {
                flex-direction: column;
                gap: 20px;
            }
            
            .settings-container {
                padding: 10px;
            }
            
            .settings-card {
                padding: 25px;
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
                <div style="display: flex; align-items: center;">
                    <div class="user-info">
                        <h3>
                            Account Settings
                        </h3>
                        <p>Manage your profile and security</p>
                    </div>
                    <div class="user-avatar" onclick="window.location.href='home.jsp'">
                        <i class="fas fa-home"></i>
                    </div>
                </div>
            </div>
        </header>

        <main class="main-content">
            
                <div class="settings-card">
                    <div class="settings-header">
                        <h2>
                            <i class="fas fa-user-cog"></i>
                            Account Settings
                        </h2>
                        <div class="user-avatar">
                            <i class="fas fa-user"></i>
                        </div>
                    </div>

                    <form method="POST" action="UpdateUserServlet">
                        <div class="form-row">
                            <!-- Left Column - Profile Information -->
                            <div class="form-column">
                                <h3>
                                    <i class="fas fa-user-circle"></i>
                                    Profile Information
                                </h3>
                                
                                <div class="form-group">
                                    <label>
                                        <i class="fas fa-user" style="margin-right: 5px; color: #0072ff;"></i>
                                        Full Name
                                    </label>
                                    <input type="text" name="fullName"
                                           value="<%= fullName %>" required class="form-control"
                                           placeholder="Enter your full name">
                                </div>

                                <div class="form-group">
                                    <label>
                                        <i class="fas fa-envelope" style="margin-right: 5px; color: #0072ff;"></i>
                                        Email Address
                                    </label>
                                    <input type="email" name="email"
                                           value="<%= email %>" required class="form-control"
                                           placeholder="Enter your email">
                                </div>

                                <div class="form-group">
                                    <label>
                                        <i class="fas fa-phone" style="margin-right: 5px; color: #0072ff;"></i>
                                        Mobile Number
                                    </label>
                                    <input type="text" name="mobile"
                                           value="<%= mobile %>" required class="form-control"
                                           placeholder="Enter your mobile number">
                                </div>
                            </div>
                            
                            <!-- Right Column - Password Change -->
                            <div class="form-column">
                                <h3>
                                    <i class="fas fa-lock"></i>
                                    Security Settings
                                </h3>

                                <div class="form-group">
                                    <label>
                                        <i class="fas fa-key" style="margin-right: 5px; color: #ff9800;"></i>
                                        Current Password <span style="color: #ff3860;">*</span>
                                    </label>
                                    <input type="password" name="currentPassword"
                                           required class="form-control"
                                           placeholder="Enter your current password">
                                </div>

                                <div class="form-group">
                                    <label>
                                        <i class="fas fa-lock" style="margin-right: 5px; color: #00c851;"></i>
                                        New Password
                                    </label>
                                    <input type="password" name="newPassword"
                                           class="form-control"
                                           placeholder="Enter new password">
                                    <div class="password-hint">
                                        <i class="fas fa-info-circle"></i>
                                        Leave blank to keep current password
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label>
                                        <i class="fas fa-check-circle" style="margin-right: 5px; color: #00c851;"></i>
                                        Confirm New Password
                                    </label>
                                    <input type="password" name="confirmPassword"
                                           class="form-control"
                                           placeholder="Confirm new password">
                                </div>
                            </div>
                        </div>

                        <button type="submit" class="btn-auth">
                            <i class="fas fa-save"></i>
                            Update Account
                        </button>
                    </form>

                    <div class="section-divider">
                        <span>OR</span>
                    </div>
                    
                    <form method="POST" action="DeleteAccountServlet"
                        onsubmit="return confirm('Are you sure you want to permanently delete your account? This cannot be undone.');">
                        <div class="form-group">
                            <label style="color:#ff3860; font-weight:600;">
                                <i class="fas fa-exclamation-triangle"></i>
                                Confirm Password to Delete Account
                            </label>
                            <input type="password" name="deletePassword"
                                    required class="form-control"
                                    placeholder="Enter your current password to confirm">
                        </div>

                        <button type="submit" class="btn-delete">
                            <i class="fas fa-trash"></i>
                            Delete My Account
                        </button>
                    </form>

                    <div style="text-align: center;">
                        <a href="home.jsp" class="back-link">
                            <i class="fas fa-arrow-left"></i>
                            Back to Dashboard
                        </a>
                    </div>
                </div>
            
        </main>

        <footer>
            <div class="visit-info">
                <p><i class="far fa-clock"></i> Settings last updated: Just now</p>
            </div>
            <p>Online Mobile Recharge System &copy; 2026 | Secure & Fast Recharge Experience</p>
        </footer>
    </div>
</body>
</html>