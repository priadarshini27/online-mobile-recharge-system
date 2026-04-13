<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mobile Recharge - Recharge Now</title>
    <link rel="stylesheet" href="css/all.min.css">
    <link rel="stylesheet" href="styles.css">
    <style>

        .r-container {
            position: relative;
            min-height: 100vh;
            background-image: url('images/bg.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed; /* This makes the background stay fixed while scrolling */
        }
        /*.recharge-container {
            max-width: 1500px;
            margin: 0 auto;
        }*/
        
        .recharge-form {
            background: white;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
            margin-top: 20px;
        }
        
        .form-group {
            margin-bottom: 25px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #2c3e50;
            font-weight: 600;
            font-size: 0.95rem;
        }
        
        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e1e5eb;
            border-radius: 8px;
            font-size: 1rem;
            transition: border 0.3s;
        }
        
        .form-control:focus {
            border-color: #0072ff;
            outline: none;
            box-shadow: 0 0 0 3px rgba(0, 114, 255, 0.1);
        }
        
        .mobile-input-group {
            display: flex;
            gap: 0;
        }
        
        .country-code {
            background: #f8f9ff;
            padding: 12px 15px;
            border: 2px solid #e1e5eb;
            border-right: none;
            border-radius: 8px 0 0 8px;
            font-weight: 600;
            color: #2c3e50;
            min-width: 80px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        #mobileNumber {
            border-radius: 0 8px 8px 0;
            flex: 1;
        }
        
        .operator-selector {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(120px, 1fr));
            gap: 15px;
            margin-top: 10px;
        }
        
        .operator-option {
            border: 2px solid #e1e5eb;
            border-radius: 8px;
            padding: 15px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s;
            background: white;
        }
        
        .operator-option:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        
        .operator-option.selected {
            border-color: #0072ff;
            background: rgba(0, 114, 255, 0.05);
        }
        
        .operator-option img {
            width: 40px;
            height: 40px;
            margin-bottom: 8px;
            object-fit: contain;
        }
        
        .plan-search-section {
            margin-top: 30px;
            background: #f8f9ff;
            padding: 25px;
            border-radius: 12px;
            display: none;
        }
        
        .plan-search-section.active {
            display: block;
        }
        
        .plan-search-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        
        .plan-search-header h4 {
            color: #2c3e50;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .plan-search-header img {
            width: 30px;
            height: 30px;
            object-fit: contain;
        }
        
        /* Updated Filter Section - Same as plans.jsp */
        .filter-section {
            background: white;
            padding: 20px;
            border-radius: 12px;
            margin-bottom: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.03);
            border: 1px solid #eef2f6;
        }
        
        .filter-tabs {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
            margin-bottom: 20px;
        }
        
        .filter-tab {
            padding: 8px 20px;
            border: none;
            border-radius: 50px;
            background: #f0f2f5;
            color: #555;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            font-size: 0.9rem;
        }
        
        .filter-tab:hover {
            background: #e0e5ec;
        }
        
        .filter-tab.active {
            background: linear-gradient(45deg, #0072ff, #00c6ff);
            color: white;
        }
        
        .search-bar {
            display: flex;
            gap: 15px;
            align-items: center;
            margin-bottom: 15px;
        }
        
        .search-bar input {
            flex: 1;
            padding: 10px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 50px;
            font-size: 0.95rem;
            transition: all 0.3s;
        }
        
        .search-bar input:focus {
            border-color: #0072ff;
            outline: none;
        }

        .search-btn {
            background: linear-gradient(45deg, #0072ff, #00c6ff);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 50px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 0.9rem;
        }

        .search-btn:hover {
            background: linear-gradient(45deg, #0056b3, #0095ff);
            transform: scale(1.02);
        }

        .search-btn i {
            font-size: 0.9rem;
        }
        
        .price-range {
            display: flex;
            gap: 10px;
            align-items: center;
        }
        
        .price-range select {
            padding: 10px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 50px;
            font-size: 0.95rem;
            cursor: pointer;
            background: white;
        }
        
        .plan-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 15px;
            max-height: 400px;
            overflow-y: auto;
            padding-right: 10px;
        }
        
        .plan-card {
            background: white;
            border-radius: 8px;
            padding: 20px;
            cursor: pointer;
            transition: all 0.3s;
            border: 2px solid #e1e5eb;
            position: relative;
        }
        
        .plan-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
        }
        
        .plan-card.selected {
            border-color: #0072ff;
            background: rgba(0, 114, 255, 0.05);
        }
        
        .plan-card.popular::before {
            content: 'POPULAR';
            position: absolute;
            top: -10px;
            right: 10px;
            background: #0072ff;
            color: white;
            padding: 3px 10px;
            border-radius: 10px;
            font-size: 0.7rem;
            font-weight: 600;
        }
        
        .plan-price {
            font-size: 1.5rem;
            font-weight: 700;
            color: #2c3e50;
        }
        
        .plan-validity {
            color: #666;
            font-size: 0.9rem;
            margin-top: 5px;
        }
        
        .plan-details {
            margin-top: 10px;
            font-size: 0.85rem;
            color: #555;
            line-height: 1.4;
        }
        
        .plan-details div {
            margin-bottom: 3px;
        }
        
        .selected-plan-info {
            background: linear-gradient(135deg, #4969f7 0%, #4b6ca2 100%);
            color: white;
            padding: 20px;
            border-radius: 8px;
            margin-top: 20px;
            display: none;
        }
        
        .selected-plan-info.active {
            display: block;
        }
        
        .selected-plan-info.airtel {
            background: linear-gradient(135deg, #E40046, #FF8BA0);
        }
        
        .selected-plan-info.jio {
            background: linear-gradient(135deg, #00A1E1, #6BD1FF);
        }
        
        .selected-plan-info.vi {
            background: linear-gradient(135deg, #EF1C25, #FF7B81);
        }
        
        .selected-plan-info.bsnl {
            background: linear-gradient(135deg, #FF671F, #FFA07A);
        }
        
        .selected-plan-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }
        
        .selected-plan-price {
            font-size: 2rem;
            font-weight: 800;
        }
        
        .selected-plan-details {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 15px;
        }
        
        .detail-item {
            background: rgba(255, 255, 255, 0.1);
            padding: 10px;
            border-radius: 6px;
            text-align: center;
        }
        
        .detail-label {
            font-size: 0.85rem;
            opacity: 0.9;
        }
        
        .detail-value {
            font-weight: 600;
            font-size: 1.1rem;
            margin-top: 5px;
        }
        
        /* Payment Method Styles */
        .payment-methods {
            display: flex;
            gap: 15px;
            margin-top: 10px;
            flex-wrap: wrap;
        }
        
        .payment-option {
            flex: 1;
            min-width: 120px;
            border: 2px solid #e1e5eb;
            border-radius: 8px;
            padding: 15px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s;
            background: white;
        }
        
        .payment-option:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        
        .payment-option.selected {
            border-color: #0072ff;
            background: rgba(0, 114, 255, 0.05);
        }
        
        .payment-option i {
            font-size: 24px;
            margin-bottom: 8px;
            color: #0072ff;
        }
        
        .payment-option span {
            display: block;
            font-weight: 600;
            color: #2c3e50;
        }
        
        .payment-details-section {
            margin-top: 20px;
            padding: 20px;
            background: #f8f9ff;
            border-radius: 8px;
            display: none;
        }
        
        .payment-details-section.active {
            display: block;
        }
        
        .payment-details-section h4 {
            color: #2c3e50;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .card-input-group {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }
        
        .card-input-group .form-control {
            flex: 1;
        }
        
        .expiry-group {
            display: flex;
            gap: 10px;
        }
        
        .expiry-group .form-control {
            width: 70px;
            text-align: center;
        }
        
        .btn-primary {
            background: linear-gradient(45deg, #0072ff, #00c6ff);
            color: white;
            border: none;
            padding: 15px 30px;
            border-radius: 8px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            width: 100%;
            margin-top: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }
        
        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(0, 114, 255, 0.2);
        }
        
        .btn-primary:disabled {
            background: #ccc;
            cursor: not-allowed;
            transform: none;
            box-shadow: none;
        }
        
        .back-link {
            display: inline-flex;
            align-items: center;
            color: #ffffff;
            text-decoration: none;
            font-weight: 600;
            margin-bottom: 20px;
        }
        
        .back-link i {
            margin-right: 10px;
        }
        
        .error-message {
            color: #e74c3c;
            font-size: 0.9rem;
            margin-top: 5px;
            display: none;
        }
        
        .no-plans {
            text-align: center;
            padding: 40px;
            background: white;
            border-radius: 15px;
            color: #666;
            grid-column: 1 / -1;
        }
        
        .no-plans i {
            font-size: 3rem;
            color: #ddd;
            margin-bottom: 15px;
        }
        
        @media (max-width: 768px) {
            .recharge-form {
                padding: 20px;
            }
            
            .operator-selector {
                grid-template-columns: repeat(2, 1fr);
            }
            
            .payment-methods {
                flex-direction: column;
            }
            
            .plan-grid {
                grid-template-columns: 1fr;
            }
            
            .selected-plan-details {
                grid-template-columns: 1fr;
            }
            
            .search-bar {
                flex-direction: column;
            }
            
            .price-range select {
                width: 100%;
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
                        <h3 id="userName">
                            Welcome, 
                            <% 
                                String userName = (String) session.getAttribute("userName");
                                if(userName != null) {
                                    out.print(userName);
                                } else {
                                    out.print("Guest");
                                }
                            %>
                        </h3>
                        <p>Last login:
                        <span>
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

        <main class="container">
            <div class="recharge-container">
                <a href="home.jsp" class="back-link">
                    <i class="fas fa-arrow-left"></i> Back to Dashboard
                </a>
                
                <div class="welcome-section">
                    <h2>Mobile Recharge</h2>
                    <p>Recharge your mobile instantly. Select operator, enter mobile number, and choose from available plans.</p>
                </div>
                
                <div class="recharge-form">
                    <div class="form-group">
                        <label for="mobileNumber"><i class="fas fa-phone"></i> Mobile Number</label>
                        <div class="mobile-input-group">
                            <div class="country-code">+91</div>
                            <input type="tel" id="mobileNumber" class="form-control" 
                                   placeholder="Enter 10-digit mobile number" 
                                   maxlength="10"
                                   pattern="[0-9]{10}"
                                   title="Please enter a valid 10-digit mobile number">
                        </div>
                        <div id="mobileError" class="error-message"></div>
                    </div>
                    
                    <div class="form-group">
                        <label><i class="fas fa-sim-card"></i> Select Operator</label>
                        <div class="operator-selector">
                            <div class="operator-option" onclick="selectOperator('Airtel')">
                                <img src="images/Airtel.png" alt="Airtel">
                                <div>Airtel</div>
                            </div>
                            <div class="operator-option" onclick="selectOperator('Jio')">
                                <img src="images/jio.png" alt="Jio">
                                <div>Jio</div>
                            </div>
                            <div class="operator-option" onclick="selectOperator('Vi')">
                                <img src="images/vi.jpg" alt="Vi">
                                <div>Vi</div>
                            </div>
                            <div class="operator-option" onclick="selectOperator('BSNL')">
                                <img src="images/bsnl.jpg" alt="BSNL">
                                <div>BSNL</div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="plan-search-section" id="planSearchSection">
                        <div class="plan-search-header">
                            <h4 id="selectedOperatorHeader">
                                <span id="operatorIcon"></span>
                                <span id="operatorName"></span> Plans
                            </h4>
                            <div id="mobileNumberDisplay" style="font-weight: 600; color: #2c3e50;"></div>
                        </div>
                        
                        <!-- Updated Filter Section - Same as plans.jsp -->
                        <div class="filter-section">
                            <div class="filter-tabs">
                                <button class="filter-tab active" onclick="filterByType('all')">All Plans</button>
                                <button class="filter-tab" onclick="filterByType('prepaid')">Prepaid</button>
                                <button class="filter-tab" onclick="filterByType('annual')">Annual</button>
                                <button class="filter-tab" onclick="filterByType('data_only')">Data Only</button>
                                <button class="filter-tab" onclick="filterByType('voice_only')">Voice Only</button>
                            </div>
                            
                            <div class="search-bar">
                                <input type="text" id="searchInput" placeholder="Search plans by amount, validity or benefits..." onkeyup="searchPlans()">
                                <button class="search-btn" onclick="searchPlans()">
                                    <i class="fas fa-search"></i> Search
                                </button>
                                <div class="price-range">
                                    <select id="priceFilter" onchange="filterByPrice()">
                                        <option value="all">All Prices</option>
                                        <option value="0-300">Under ₹300</option>
                                        <option value="300-500">₹300 - ₹500</option>
                                        <option value="500-1000">₹500 - ₹1000</option>
                                        <option value="1000-2000">₹1000 - ₹2000</option>
                                        <option value="2000+">Above ₹2000</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        
                        <div class="plan-grid" id="planGrid">
                            <!-- Plans will be loaded here dynamically -->
                        </div>
                    </div>
                    
                    <div class="selected-plan-info" id="selectedPlanInfo">
                        <div class="selected-plan-header">
                            <div>
                                <div style="font-size: 0.9rem; opacity: 0.9;">Selected Plan</div>
                                <div class="selected-plan-price" id="selectedPlanPrice">₹0</div>
                            </div>
                            <div style="text-align: right;">
                                <div style="font-size: 0.9rem; opacity: 0.9;">Validity</div>
                                <div style="font-size: 1.1rem; font-weight: 600;" id="selectedPlanValidity">0 days</div>
                            </div>
                        </div>
                        
                        <div class="selected-plan-details" id="selectedPlanDetails">
                            <!-- Plan details will be loaded here -->
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label><i class="fas fa-wallet"></i> Payment Method</label>
                        <div class="payment-methods">
                            <div class="payment-option" onclick="selectPaymentMethod('card')">
                                <i class="fas fa-credit-card"></i>
                                <span>Credit/Debit Card</span>
                            </div>
                            <div class="payment-option" onclick="selectPaymentMethod('netbanking')">
                                <i class="fas fa-university"></i>
                                <span>Net Banking</span>
                            </div>
                            <div class="payment-option" onclick="selectPaymentMethod('upi')">
                                <i class="fas fa-mobile-alt"></i>
                                <span>UPI</span>
                            </div>
                        </div>
                        
                        <!-- Credit/Debit Card Details -->
                        <div id="cardDetails" class="payment-details-section">
                            <h4><i class="fas fa-credit-card"></i> Card Details</h4>
                            <div class="form-group">
                                <label>Card Number</label>
                                <input type="text" id="cardNumber" class="form-control"
                                    placeholder="1234 5678 9012 3456"
                                    maxlength="19"
                                    inputmode="numeric"
                                    pattern="[0-9 ]*">
                            </div>
                            <div class="form-group">
                                <label>Card Holder Name</label>
                                <input type="text" id="cardName" class="form-control" placeholder="Name on card">
                            </div>
                            <div class="card-input-group">
                                <div style="flex: 2;">
                                    <label>Expiry Date</label>
                                    <div class="expiry-group">
                                        <input type="text" id="cardMonth" class="form-control" placeholder="MM" maxlength="2">
                                        <span style="align-self: center;">/</span>
                                        <input type="text" id="cardYear" class="form-control" placeholder="YY" maxlength="2">
                                    </div>
                                </div>
                                <div style="flex: 1;">
                                    <label>CVV</label>
                                    <input type="password" id="cardCvv" class="form-control" placeholder="123" maxlength="3">
                                </div>
                            </div>
                        </div>
                        
                        <!-- Net Banking Details -->
                        <div id="netbankingDetails" class="payment-details-section">
                            <h4><i class="fas fa-university"></i> Net Banking</h4>
                            <div class="form-group">
                                <label>Select Bank</label>
                                <select id="bankSelect" class="form-control">
                                    <option value="">Choose your bank</option>
                                    <option value="sbi">State Bank of India</option>
                                    <option value="hdfc">HDFC Bank</option>
                                    <option value="icici">ICICI Bank</option>
                                    <option value="axis">Axis Bank</option>
                                    <option value="kotak">Kotak Mahindra Bank</option>
                                    <option value="yes">Yes Bank</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Login ID</label>
                                <input type="text" id="netbankingLogin" class="form-control" placeholder="Enter net banking login ID">
                            </div>
                            <div class="form-group">
                                <label>Password</label>
                                <input type="password" id="netbankingPassword" class="form-control" placeholder="Enter password">
                            </div>
                        </div>
                        
                        <!-- UPI Details -->
                        <div id="upiDetails" class="payment-details-section">
                            <h4><i class="fas fa-mobile-alt"></i> UPI Payment</h4>
                            <div class="form-group">
                                <label>UPI ID</label>
                                <input type="text" id="upiId" class="form-control" placeholder="username@upi">
                            </div>
                            <div class="form-group">
                                <label>Scan QR code</label>
                                <div style="background: white; padding: 20px; text-align: center; border-radius: 8px;">
                                    <!-- Replace this with your QR code image -->
                                    <img src="images/qr.jpg" alt="UPI QR Code" style="max-width: 200px; height: auto;">
                                    <p style="color: #666; margin-top: 10px;">Scan with any UPI app</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <button id="rechargeBtn" class="btn-primary" onclick="processRecharge()" disabled>
                        <i class="fas fa-bolt"></i> Proceed to Recharge
                    </button>
                </div>
            </div>
        </main>

        <footer>
            <p>Online Mobile Recharge System &copy; 2026 | Secure & Fast Recharge Experience</p>
        </footer>
    </div>
    <%
        Integer sessionUserId = (Integer) session.getAttribute("userId");

        if (sessionUserId == null) {
            response.sendRedirect("login.jsp");
            return;
        }
    %>

    <input type="hidden" id="sessionUserId" value="<%= sessionUserId %>">
    <!--<script src="script.js"></script>-->
    <script>
        
        let allPlans = [];
        let selectedOperator = null;
        let selectedPlan = null;
        let selectedPaymentMethod = null;
        
        // Current filter state - Same as plans.jsp
        let currentFilter = {
            type: 'all',
            price: 'all',
            search: ''
        };
        
        function loadPlans() {
            var xhr = new XMLHttpRequest();
            xhr.open("GET", "GetPlansServlet", true);

            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    var xml = xhr.responseXML;
                    var plans = xml.getElementsByTagName("plan");
                    allPlans = [];

                    for (var i = 0; i < plans.length; i++) {
                        var plan = plans[i];
                        allPlans.push({
                            plan_id: getValue(plan, "plan_id"),
                            carrier_name: getValue(plan, "carrier_name"),
                            plan_name: getValue(plan, "plan_name"),
                            plan_price: parseFloat(getValue(plan, "plan_price")),
                            validity_days: parseInt(getValue(plan, "validity_days")),
                            data_per_day: getValue(plan, "data_per_day"),
                            total_data: getValue(plan, "total_data"),
                            unlimited_calls: getValue(plan, "unlimited_calls") === "true",
                            sms_per_day: parseInt(getValue(plan, "sms_per_day")),
                            unlimited_5g: getValue(plan, "unlimited_5g") === "true",
                            plan_type: getValue(plan, "plan_type")
                        });
                    }
                    renderPlans();
                }
            };
            xhr.send();
        }
        
        function openUserSettings() {
             window.location.href = "user-settings.jsp";
        }

        function getValue(parent, tag) {
            var element = parent.getElementsByTagName(tag)[0];
            return element && element.firstChild ? element.firstChild.nodeValue : "";
        }
        
        function selectOperator(operator) {
            selectedOperator = operator;
            
            // Update UI for selected operator
            document.querySelectorAll('.operator-option').forEach(opt => {
                opt.classList.remove('selected');
            });
            event.currentTarget.classList.add('selected');
            
            // Update operator header
            const operatorName = event.currentTarget.querySelector('div').textContent;
            const operatorImg = event.currentTarget.querySelector('img').src;
            document.getElementById('operatorName').textContent = operatorName;
            document.getElementById('operatorIcon').innerHTML = '<img src="' + operatorImg + '" alt="' + operatorName + '" style="width: 30px; height: 30px;">';
            
            // Show plan search section
            document.getElementById('planSearchSection').classList.add('active');
            
            // Reset filters
            currentFilter = {
                type: 'all',
                price: 'all',
                search: ''
            };
            
            // Reset UI for filters
            document.querySelectorAll('.filter-tab').forEach(tab => {
                tab.classList.remove('active');
            });
            document.querySelector('.filter-tab[onclick*="all"]').classList.add('active');
            document.getElementById('searchInput').value = '';
            document.getElementById('priceFilter').value = 'all';
            
            // Load plans for selected operator
            loadPlans();
            
            // Update mobile number display
            updateMobileDisplay();
            
            // Hide selected plan info
            document.getElementById('selectedPlanInfo').classList.remove('active');
            document.getElementById('selectedPlanInfo').classList.remove(selectedOperator);
            document.getElementById('rechargeBtn').disabled = true;
            selectedPlan = null;
        }

        function selectPaymentMethod(method) {
            selectedPaymentMethod = method;
            
            // Update UI for selected payment method
            document.querySelectorAll('.payment-option').forEach(opt => {
                opt.classList.remove('selected');
            });
            event.currentTarget.classList.add('selected');
            
            // Hide all payment details sections
            document.getElementById('cardDetails').classList.remove('active');
            document.getElementById('netbankingDetails').classList.remove('active');
            document.getElementById('upiDetails').classList.remove('active');
            
            // Show selected payment details section
            if (method === 'card') {
                document.getElementById('cardDetails').classList.add('active');
            } else if (method === 'netbanking') {
                document.getElementById('netbankingDetails').classList.add('active');
            } else if (method === 'upi') {
                document.getElementById('upiDetails').classList.add('active');
            }
            
            // Enable recharge button if all required fields are filled
            validateAllFields();
        }

        function updateMobileDisplay() {
            const mobileNumber = document.getElementById('mobileNumber').value;
            if (mobileNumber.length === 10) {
                document.getElementById('mobileNumberDisplay').textContent = "+91 " + mobileNumber;
                document.getElementById('mobileError').style.display = 'none';
            }
        }

        // Filter functions - Same as plans.jsp
        function filterPlans() {
            if (!selectedOperator) return allPlans;
            
            return allPlans.filter(plan => {
                // First filter by selected operator
                if (plan.carrier_name !== selectedOperator) {
                    return false;
                }

                // Type filter
                if (currentFilter.type !== 'all' && plan.plan_type !== currentFilter.type) {
                    return false;
                }

                // Price filter
                if (currentFilter.price !== 'all') {
                    const price = Number(plan.plan_price);

                    if (currentFilter.price === '0-300' && price > 300) return false;
                    if (currentFilter.price === '300-500' && (price < 300 || price > 500)) return false;
                    if (currentFilter.price === '500-1000' && (price < 500 || price > 1000)) return false;
                    if (currentFilter.price === '1000-2000' && (price < 1000 || price > 2000)) return false;
                    if (currentFilter.price === '2000+' && price < 2000) return false;
                }

                // Search filter
                if (currentFilter.search) {
                    const searchTerm = currentFilter.search.toLowerCase();
                    const planName = (plan.plan_name || '').toLowerCase();
                    const price = String(plan.plan_price || '');
                    const validity = String(plan.validity_days || '');
                    const dataFeature = (plan.data_per_day || plan.total_data || '').toLowerCase();
                    
                    return planName.includes(searchTerm) || 
                           price.includes(searchTerm) || 
                           validity.includes(searchTerm) ||
                           dataFeature.includes(searchTerm);
                }

                return true;
            });
        }

        function filterByType(type) {
            // Update current filter
            currentFilter.type = type;
            
            // Update active class on filter tabs
            document.querySelectorAll('.filter-tab').forEach(tab => {
                // Get the text content of the button and compare
                const tabText = tab.textContent.trim().toLowerCase();
                let typeToCompare = type;
                
                // Map the type values to button text
                if (type === 'all') typeToCompare = 'all plans';
                else if (type === 'prepaid') typeToCompare = 'prepaid';
                else if (type === 'annual') typeToCompare = 'annual';
                else if (type === 'data_only') typeToCompare = 'data only';
                else if (type === 'voice_only') typeToCompare = 'voice only';
                
                if (tabText === typeToCompare) {
                    tab.classList.add('active');
                } else {
                    tab.classList.remove('active');
                }
            });
            
            renderPlans();
        }

        function filterByPrice() {
            currentFilter.price = document.getElementById("priceFilter").value;
            renderPlans();
        }

        function searchPlans() {
            currentFilter.search = document.getElementById("searchInput").value;
            renderPlans();
        }

        function renderPlans() {
            const planGrid = document.getElementById("planGrid");
            planGrid.innerHTML = "";

            if (!selectedOperator) return;

            const filtered = filterPlans();

            if (filtered.length === 0) {
                planGrid.innerHTML = "<div class='no-plans'><i class='fas fa-search'></i><h3>No Plans Found</h3><p>Try adjusting your filters</p></div>";
                return;
            }

            filtered.forEach(plan => {
                let dataFeature = plan.data_per_day || plan.total_data || "No data";

                const card = document.createElement("div");
                card.className = "plan-card";

                card.innerHTML =
                    "<div class='plan-price'>₹" + plan.plan_price + "</div>" +
                    "<div class='plan-validity'>" + plan.validity_days + " days</div>" +
                    "<div class='plan-details'>" +
                        "<div>Data: " + dataFeature + "</div>" +
                        "<div>Calls: " + (plan.unlimited_calls ? "Unlimited" : "No") + "</div>" +
                        "<div>SMS: " + plan.sms_per_day + "/day</div>" +
                    "</div>";

                card.onclick = function() {
                    selectPlan(plan, card);
                };

                planGrid.appendChild(card);
            });
        }

        function selectPlan(plan, element) {
            selectedPlan = plan;

            // Remove previous selections
            document.querySelectorAll('.plan-card').forEach(card => {
                card.classList.remove('selected');
            });

            // Highlight selected
            element.classList.add('selected');

            // Show selected plan info box
            document.getElementById('selectedPlanInfo').classList.add('active');

            // Update price
            document.getElementById('selectedPlanPrice').textContent =
                "₹" + plan.plan_price;

            // Update validity
            document.getElementById('selectedPlanValidity').textContent =
                plan.validity_days + " days";

            // Update details
            let dataFeature = plan.data_per_day || plan.total_data || "No data";

            document.getElementById('selectedPlanDetails').innerHTML =
                "<div class='detail-item'>" +
                    "<div class='detail-label'>Data</div>" +
                    "<div class='detail-value'>" + dataFeature + "</div>" +
                "</div>" +
                "<div class='detail-item'>" +
                    "<div class='detail-label'>Calls</div>" +
                    "<div class='detail-value'>" +
                        (plan.unlimited_calls ? "Unlimited" : "No") +
                    "</div>" +
                "</div>" +
                "<div class='detail-item'>" +
                    "<div class='detail-label'>SMS</div>" +
                    "<div class='detail-value'>" +
                        plan.sms_per_day + "/day" +
                    "</div>" +
                "</div>";

            // Enable button if mobile and payment method selected
            validateAllFields();
        }

        function validateMobileNumber() {
            const mobileNumber = document.getElementById('mobileNumber').value;
            const errorDiv = document.getElementById('mobileError');
            
            if (mobileNumber.length === 0) {
                errorDiv.textContent = "Mobile number is required";
                errorDiv.style.display = 'block';
                return false;
            } else if (mobileNumber.length !== 10 || !/^\d{10}$/.test(mobileNumber)) {
                errorDiv.textContent = "Please enter a valid 10-digit mobile number";
                errorDiv.style.display = 'block';
                return false;
            } else {
                errorDiv.style.display = 'none';
                updateMobileDisplay();
                
                // Enable recharge button if plan and payment method selected
                validateAllFields();
                return true;
            }
        }

        function validateAllFields() {

            const mobile = document.getElementById("mobileNumber").value;
            const mobileValid = /^\d{10}$/.test(mobile);

            if (!mobileValid || !selectedPlan || !selectedPaymentMethod) {
                document.getElementById("rechargeBtn").disabled = true;
                return false;
            }

            let paymentValid = false;

            if (selectedPaymentMethod === "card") {

                const number = document.getElementById("cardNumber").value.trim();
                const name = document.getElementById("cardName").value.trim();
                const mm = document.getElementById("cardMonth").value.trim();
                const yy = document.getElementById("cardYear").value.trim();
                const cvv = document.getElementById("cardCvv").value.trim();

                paymentValid =
                    /^\d{4}\s\d{4}\s\d{4}\s\d{4}$/.test(number) &&
                    name.length > 2 &&
                    /^\d{2}$/.test(mm) &&
                    /^\d{2}$/.test(yy) &&
                    /^\d{3}$/.test(cvv);

            }

            else if (selectedPaymentMethod === "netbanking") {

                const bank = document.getElementById("bankSelect").value;
                const login = document.getElementById("netbankingLogin").value.trim();
                const password = document.getElementById("netbankingPassword").value.trim();

                paymentValid = bank !== "" && login.length > 2 && password.length > 2;

            }

            else if (selectedPaymentMethod === "upi") {

                const upi = document.getElementById("upiId").value.trim();

                paymentValid = /^[\w.-]+@[\w.-]+$/.test(upi);

            }

            document.getElementById("rechargeBtn").disabled = !paymentValid;

            return paymentValid;
        }

        function processRecharge() {
            if (!validateAllFields()) {
                alert("Please fill in all required fields");
                return;
            }

            const sessionUserId = document.getElementById("sessionUserId").value;
            const mobileNumber = document.getElementById("mobileNumber").value;
            const paymentMethod = selectedPaymentMethod;

            // Get payment details based on selected method
            let paymentDetails = {};
            if (paymentMethod === 'card') {
                paymentDetails.cardNumber = "XXXX-XXXX-XXXX-1234"; // Masked for security
            } else if (paymentMethod === 'netbanking') {
                paymentDetails.bank = "Selected Bank";
            } else if (paymentMethod === 'upi') {
                paymentDetails.upiId = "user@upi";
            }

            // Redirect to PHP with parameters
            window.location.href =
                "http://localhost:8081/payment.php?" +
                "user_id=" + sessionUserId +
                "&plan_id=" + selectedPlan.plan_id +
                "&amount=" + selectedPlan.plan_price +
                "&mobile=" + mobileNumber +
                "&payment=" + paymentMethod;
        }

        // Initialize event listeners
        document.addEventListener('DOMContentLoaded', function() {
            // Mobile number validation
            loadPlans();
            document.getElementById('mobileNumber').addEventListener('input', validateMobileNumber);
            document.getElementById('mobileNumber').addEventListener('blur', validateMobileNumber);
            
            // Auto-select first operator
            const firstOperator = document.querySelector('.operator-option');
            if (firstOperator) {
                firstOperator.click();
            }
            
            // Validate mobile number on page load
            validateMobileNumber();
            
            // Add enter key support for search
            const searchInput = document.getElementById("searchInput");
            if (searchInput) {
                searchInput.addEventListener('keypress', function(e) {
                    if (e.key === 'Enter') {
                        searchPlans();
                    }
                });
            }
                        // Live validation for payment fields

            document.querySelectorAll("#cardDetails input").forEach(el =>
                el.addEventListener("input", validateAllFields)
            );

            document.querySelectorAll("#netbankingDetails input, #bankSelect").forEach(el =>
                el.addEventListener("input", validateAllFields)
            );

            document.querySelectorAll("#upiDetails input").forEach(el =>
                el.addEventListener("input", validateAllFields)
            );
            const cardInput = document.getElementById("cardNumber");

            cardInput.addEventListener("input", function () {

                let value = cardInput.value.replace(/\D/g, ""); // remove non-digits

                value = value.substring(0,16); // limit to 16 digits

                let formatted = value.match(/.{1,4}/g);

                cardInput.value = formatted ? formatted.join(" ") : value;

            });
        });
    </script>
</body>
</html>