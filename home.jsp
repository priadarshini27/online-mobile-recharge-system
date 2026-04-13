<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.text.SimpleDateFormat" %>
<%@ page session="true" %>
<%
    HttpSession sessionObj = request.getSession(false);

    if (sessionObj == null || sessionObj.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<%
    int browserVisitCount = 1;

    Cookie[] cookies = request.getCookies();

    if (cookies != null) {
        for (Cookie c : cookies) {
            if (c.getName().equals("browserVisitCount")) {
                browserVisitCount = Integer.parseInt(c.getValue());
                browserVisitCount++;
            }
        }
    }

    Cookie visitCookie = new Cookie("browserVisitCount", String.valueOf(browserVisitCount));
    visitCookie.setMaxAge(7 * 24 * 60 * 60); // 7 days
    response.addCookie(visitCookie);
%>
<%
    String[] tips = {
        "Recharge before plan expiry to avoid service interruption.",
        "Use Wi-Fi for heavy downloads to save mobile data.",
        "Check recharge history regularly to track expenses.",
        "Enable auto-recharge to never miss important calls.",
        "Compare plans before recharging to get the best value."
    }; 
    int tipIndex = new Random().nextInt(tips.length);
    String dailyTip = tips[tipIndex];
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mobile Recharge - Home</title>
    <link rel="stylesheet" href="css/all.min.css">
    <link rel="stylesheet" href="styles.css">
</head>
<a href="chatbot.jsp" class="chatbot-button">
    💬 Chat
</a>
<body>
    <div class="container">
        <header>
            <% 
                String welcomeName = (String) session.getAttribute("userName");
                if (welcomeName == null) {
                    welcomeName = "Guest";
                }
            %>
            <%
                Integer userVisitCount = (Integer) session.getAttribute("userVisitCount");
                if (userVisitCount == null) {
                    userVisitCount = 1;
                }

                Integer totalVisits = (Integer) session.getAttribute("totalVisits");
            %>
            <div class="header-content">
                <div class="logo">
                    <i class="fas fa-mobile-alt"></i>
                    <span>Online Mobile Recharge</span>
                </div>            
                <div style="display: flex; align-items: center;">
                    <div class="user-info">
                        <h3 id="userName">
                            Welcome, 
                            <%= welcomeName %>
                        </h3>

                        <p>Last login: 
                            <span id="lastLoginTime">
                                <%
                                    java.sql.Timestamp previousLogin =
                                        (java.sql.Timestamp) session.getAttribute("previousLogin");
                                    if (previousLogin == null) {
                                        out.print("This is your first login.");
                                    } else {
                                        out.print(previousLogin);
                                    }
                                %>
                            </span>
                        </p>
                        <a href="LogoutServlet" class="logout-link">Logout</a>
                        | <a href="session-details.jsp" class="logout-link">Session Info</a>
                    </div>
                    <div class="user-avatar" onclick="openUserSettings()">
                        <i class="fas fa-user"></i>
                    </div>
                </div>
            </div>
        </header>

        <main class="main-content">
            <div class="welcome-section">
                <h2>Welcome to Your Recharge Dashboard</h2>
                <p>Quickly recharge your mobile, view available plans, check transaction history, and manage your account all in one place.</p><br>
                💡 <strong>Tip of the Day:</strong> <%= dailyTip %>

            </div>
            <!--marquee-->
            <div class="operator-marquee">
                <div class="marquee-content">
                    <div class="operator-logo">
                        <div class="logo-container airtel">
                            <img src="images/Airtel.png" alt="Airtel">
                        </div>
                        <span>Airtel</span>
                        <p>Fast. Reliable. Everywhere.</p>
                    </div>
                    
                    <div class="operator-logo">
                        <div class="logo-container jio">
                            <img src="images/jio.png" alt="Jio">
                        </div>
                        <span>Jio</span>
                        <p>Powering India’s digital life.</p>
                    </div>
                    
                    <div class="operator-logo">
                        <div class="logo-container vi">
                            <img src="images/vi.jpg" alt="Vi">
                        </div>
                        <span>Vi</span>
                        <p>Flexible plans, strong network.</p>
                    </div>
                    
                    <div class="operator-logo">
                        <div class="logo-container bsnl">
                            <img src="images/bsnl.jpg" alt="BSNL">
                        </div>
                        <span>BSNL</span>
                        <p>India’s trusted telecom network.</p>
                    </div>
                    <!-- dup-->
                     <div class="operator-logo">
                        <div class="logo-container airtel">
                            <img src="images/Airtel.png" alt="Airtel">
                        </div>
                        <span>Airtel</span>
                        <p>Fast. Reliable. Everywhere.</p>
                    </div>
                    
                    <div class="operator-logo">
                        <div class="logo-container jio">
                            <img src="images/jio.png" alt="Jio">
                        </div>
                        <span>Jio</span>
                        <p>Powering India’s digital life.</p>
                    </div>
                    
                    <div class="operator-logo">
                        <div class="logo-container vi">
                            <img src="images/vi.jpg" alt="Vi">
                        </div>
                        <span>Vi</span>
                        <p>Flexible plans, strong network.</p>
                    </div>
                    
                    <div class="operator-logo">
                        <div class="logo-container bsnl">
                            <img src="images/bsnl.jpg" alt="BSNL">
                        </div>
                        <span>BSNL</span>
                        <p>India’s trusted telecom network.</p>
                    </div>
                </div>
            </div>
            </div>
            <div class="dashboard-grid">
                <div class="dashboard-card" onclick="openRecharge()">
                    <div class="card-icon recharge-icon">
                        <i class="fas fa-bolt"></i>
                    </div>
                    <h3>Mobile Recharge</h3>
                    <p>Instantly recharge your prepaid or postpaid mobile number. Select operator and recharge amount.</p>
                    <button class="card-btn">Recharge Now</button>
                </div>

                <!--<div class="dashboard-card" onclick="openPlans()">
                    <div class="card-icon plans-icon">
                        <i class="fas fa-list-alt"></i>
                    </div>
                    <h3>View Recharge Plans</h3>
                    <p>Browse and compare all available plans from different operators to find the best one for you.</p>
                    <button class="card-btn">View Plans</button>
                </div>-->

                <!-- Removed the History card from dashboard grid -->
            </div>

            <div class="recent-transactions">
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
                    <h3 style="margin: 0;"><i class="fas fa-receipt"></i> Recent Recharges</h3>
                    <button class="history-btn" onclick="openHistory()">
                        <i class="fas fa-history"></i> View Full History
                    </button>
                </div>
                <div class="transaction-list" id="transactionList">
                    <!-- Transactions will be loaded here by JavaScript -->
                </div>
            </div>
        </main>

        <footer style="display: inline;">
            <div class="visit-info">
                <p>Browser Visit Count: <%= browserVisitCount %></p>
                <p>Total Site Visits:<%= totalVisits %></p>    
            </div>
            
            <p>Online Mobile Recharge System &copy; 2026 | Secure & Fast Recharge Experience</p>
        </footer>
    </div>

    <script src="script.js"></script>
</body>
</html>