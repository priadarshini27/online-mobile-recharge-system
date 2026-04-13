<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.Date, java.text.SimpleDateFormat" %>
<%@ page session="true" %>
<%
    HttpSession sessionObj = request.getSession(false);

    if (sessionObj == null || sessionObj.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mobile Recharge Plans</title>
    <link rel="stylesheet" href="css/all.min.css">
    <link rel="stylesheet" href="styles.css">
    <style>
        /* Plans Page Specific Styles */
        .plans-container {
            max-width: 1400px;
            margin: 0 auto;
        }
        
        .plans-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 40px;
            border-radius: 15px;
            margin-bottom: 30px;
            text-align: center;
        }
        
        .plans-header h1 {
            font-size: 2.5rem;
            margin-bottom: 15px;
        }
        
        .plans-header p {
            font-size: 1.1rem;
            opacity: 0.95;
        }
        
        .filter-section {
            background: white;
            padding: 25px;
            border-radius: 12px;
            margin-bottom: 30px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
        }
        
        .filter-tabs {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
            margin-bottom: 20px;
        }
        
        .filter-tab {
            padding: 10px 20px;
            border: none;
            border-radius: 50px;
            background: #f0f2f5;
            color: #555;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
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
        }
        
        .search-bar input {
            flex: 1;
            padding: 12px 20px;
            border: 2px solid #e0e0e0;
            border-radius: 50px;
            font-size: 1rem;
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
            padding: 12px 25px;
            border-radius: 50px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .search-btn:hover {
            background: linear-gradient(45deg, #0056b3, #0095ff);
            transform: scale(1.02);
        }

        .search-btn i {
            font-size: 1rem;
        }
        
        .price-range {
            display: flex;
            gap: 10px;
            align-items: center;
        }
        
        .price-range select {
            padding: 12px 20px;
            border: 2px solid #e0e0e0;
            border-radius: 50px;
            font-size: 1rem;
            cursor: pointer;
        }
        
        .carrier-tabs {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
            margin-bottom: 30px;
        }
        
        .carrier-tab {
            flex: 1;
            min-width: 120px;
            padding: 15px;
            border: none;
            border-radius: 10px;
            background: white;
            color: #333;
            font-weight: 600;
            font-size: 1.1rem;
            cursor: pointer;
            transition: all 0.3s;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }
        
        .carrier-tab:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }
        
        .carrier-tab.active {
            color: white;
        }
        
        .carrier-tab[data-carrier="Airtel"].active { background: linear-gradient(45deg, #e40046, #ff6b9d); }
        .carrier-tab[data-carrier="Jio"].active { background: linear-gradient(45deg, #00a1e0, #6ad1ff); }
        .carrier-tab[data-carrier="BSNL"].active { background: linear-gradient(45deg, #ff671f, #ff9f6e); }
        .carrier-tab[data-carrier="Vi"].active { background: linear-gradient(45deg, #ec1c24, #ff6b70); }
        .carrier-tab[data-carrier="all"].active { background: linear-gradient(45deg, #6b7280, #9ca3af); }
        
        .plans-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 25px;
            margin-top: 30px;
        }
        
        .plan-card {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0,0,0,0.08);
            transition: all 0.3s;
            position: relative;
            border: 1px solid #f0f0f0;
        }
        
        .plan-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(0,0,0,0.12);
        }
        
        .plan-header {
            padding: 20px;
            color: white;
            position: relative;
        }
        
        .plan-header.airtel { background: linear-gradient(135deg, #e40046, #b0003a); }
        .plan-header.jio { background: linear-gradient(135deg, #00a1e0, #0077b6); }
        .plan-header.bsnl { background: linear-gradient(135deg, #ff671f, #cc5200); }
        .plan-header.vi { background: linear-gradient(135deg, #ec1c24, #b3131a); }
        
        .plan-type-badge {
            position: absolute;
            top: 15px;
            right: 15px;
            background: rgba(255,255,255,0.2);
            padding: 5px 12px;
            border-radius: 50px;
            font-size: 0.8rem;
            font-weight: 600;
            text-transform: uppercase;
            backdrop-filter: blur(5px);
        }
        
        .plan-price {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 10px;
        }
        
        .plan-price small {
            font-size: 1rem;
            font-weight: 400;
            opacity: 0.9;
        }
        
        .plan-name {
            font-size: 1.2rem;
            margin-bottom: 10px;
            font-weight: 600;
        }
        
        .plan-body {
            padding: 20px;
        }
        
        .plan-feature {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 10px 0;
            border-bottom: 1px solid #f0f0f0;
        }
        
        .plan-feature:last-child {
            border-bottom: none;
        }
        
        .feature-icon {
            width: 35px;
            height: 35px;
            background: #f0f8ff;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #0072ff;
            font-size: 1rem;
        }
        
        .feature-text {
            flex: 1;
            font-size: 0.95rem;
            color: #555;
        }
        
        .feature-text strong {
            color: #333;
            font-weight: 600;
        }
        
        .ott-benefits {
            margin-top: 15px;
            padding: 15px;
            background: #f8f9ff;
            border-radius: 10px;
        }
        
        .ott-benefits h4 {
            display: flex;
            align-items: center;
            gap: 8px;
            color: #2c3e50;
            margin-bottom: 10px;
            font-size: 1rem;
        }
        
        .ott-tags {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
        }
        
        .ott-tag {
            background: white;
            padding: 4px 10px;
            border-radius: 50px;
            font-size: 0.8rem;
            color: #0072ff;
            border: 1px solid #0072ff;
        }
        
        .plan-footer {
            padding: 20px;
            border-top: 1px solid #f0f0f0;
            text-align: center;
        }
        
        .recharge-btn {
            background: linear-gradient(45deg, #0072ff, #00c6ff);
            color: white;
            border: none;
            padding: 12px 30px;
            border-radius: 50px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            width: 100%;
            font-size: 1rem;
        }
        
        .recharge-btn:hover {
            background: linear-gradient(45deg, #0056b3, #0095ff);
            transform: scale(1.02);
        }
        
        .no-plans {
            text-align: center;
            padding: 60px;
            background: white;
            border-radius: 15px;
            color: #666;
        }
        
        .no-plans i {
            font-size: 4rem;
            color: #ddd;
            margin-bottom: 20px;
        }
        
        .loader {
            text-align: center;
            padding: 60px;
        }
        
        .loader i {
            font-size: 3rem;
            color: #0072ff;
            animation: spin 1s linear infinite;
        }
        
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        
        @media (max-width: 768px) {
            .plans-grid {
                grid-template-columns: 1fr;
            }
            
            .carrier-tabs {
                flex-direction: column;
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
                    </div>
                    <div class="user-avatar" onclick="openUserSettings()">
                        <i class="fas fa-user"></i>
                    </div>
                </div>
            </div>
        </header>

        <main class="main-content">
            <div class="plans-container">
                <div class="plans-header">
                    <h1><i class="fas fa-list-alt"></i> Recharge Plans</h1>
                    <p>Compare and choose the best plan from all major carriers</p>
                </div>
                
                <!-- Filter Section -->
                <div class="filter-section">
                    <div class="filter-tabs">
                        <button class="filter-tab active" onclick="filterByType('all')">All Plans</button>
                        <button class="filter-tab" onclick="filterByType('prepaid')">Prepaid</button>
                        <button class="filter-tab" onclick="filterByType('annual')">Annual</button>
                        <button class="filter-tab" onclick="filterByType('data_only')">Data Only</button>
                        <button class="filter-tab" onclick="filterByType('voice_only')">Voice Only</button>
                    </div>
                    
                    <div class="search-bar">
                        <input type="text" id="searchInput" placeholder="Search plans by name, price, or benefits..." onkeyup="searchPlans()">
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
                
                <!-- Carrier Tabs -->
                <div class="carrier-tabs">
                    <button class="carrier-tab active" data-carrier="all" onclick="filterByCarrier('all')">
                        <i class="fas fa-mobile-alt"></i> All Carriers
                    </button>
                    <button class="carrier-tab" data-carrier="Airtel" onclick="filterByCarrier('Airtel')">
                        <i class="fas fa-signal"></i> Airtel
                    </button>
                    <button class="carrier-tab" data-carrier="Jio" onclick="filterByCarrier('Jio')">
                        <i class="fas fa-wifi"></i> Jio
                    </button>
                    <button class="carrier-tab" data-carrier="BSNL" onclick="filterByCarrier('BSNL')">
                        <i class="fas fa-satellite-dish"></i> BSNL
                    </button>
                    <button class="carrier-tab" data-carrier="Vi" onclick="filterByCarrier('Vi')">
                        <i class="fas fa-broadcast-tower"></i> Vi
                    </button>
                </div>
                
                <!-- Plans Grid -->
                <div id="plansGrid" class="plans-grid">
                    <div class="loader">
                        <i class="fas fa-spinner"></i>
                        <p>Loading plans...</p>
                    </div>
                </div>
            </div>
        </main>

        <footer>
            <p>Online Mobile Recharge System &copy; 2026 | Secure & Fast Recharge Experience</p>
        </footer>
    </div>
<script>
let allPlans = [];
let currentFilter = {
    carrier: 'all',
    type: 'all',
    price: 'all',
    search: ''
};

window.onload = function () {
    loadPlans();
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
                    carrier_code: getValue(plan, "carrier_code"),
                    plan_name: getValue(plan, "plan_name"),
                    plan_price: parseFloat(getValue(plan, "plan_price")),
                    validity_days: parseInt(getValue(plan, "validity_days")),
                    data_per_day: getValue(plan, "data_per_day"),
                    total_data: getValue(plan, "total_data"),
                    unlimited_calls: getValue(plan, "unlimited_calls") === "true",
                    sms_per_day: parseInt(getValue(plan, "sms_per_day")),
                    unlimited_5g: getValue(plan, "unlimited_5g") === "true",
                    plan_type: getValue(plan, "plan_type"),
                    ott_benefits: getValue(plan, "ott_benefits"),
                    additional_benefits: getValue(plan, "additional_benefits")
                });
            }

            displayPlans();
        }
    };

    xhr.send();
}

function getValue(parent, tag) {
    var element = parent.getElementsByTagName(tag)[0];
    return element && element.firstChild ? element.firstChild.nodeValue : "";
}

function displayPlans() {
    const grid = document.getElementById("plansGrid");
    grid.innerHTML = "";

    const filtered = filterPlans();

    if (!filtered.length) {
        grid.innerHTML =
            "<div class='no-plans'><h3>No Plans Found</h3></div>";
        return;
    }

    filtered.forEach(plan => {
        const carrierName = plan.carrier_name || "Unknown";
        const planName = plan.plan_name || "Plan";
        const price = plan.plan_price || 0;
        const validity = plan.validity_days || 0;

        // SAFE DATA LOGIC
        let dataFeature = "No data";

        if (plan.data_per_day && plan.data_per_day !== "null") {
            dataFeature = plan.data_per_day + " / day";
        }
        else if (plan.total_data && plan.total_data !== "null") {
            dataFeature = plan.total_data;
        }

        const calls = plan.unlimited_calls ? "Unlimited Calls" : "No Calls";
        const sms = plan.sms_per_day && plan.sms_per_day > 0
            ? plan.sms_per_day + " SMS/day"
            : "No SMS";
        const network = plan.unlimited_5g ? "5G" : "4G";

        const card = document.createElement("div");
        card.className = "plan-card";

        card.innerHTML =
            "<div style='background:#ffffff; padding:15px; border-bottom:1px solid #ddd;'>" +
                "<h3 style='margin:0; font-size:18px; color:#000;'>" + carrierName + "</h3>" +
                "<p style='margin:5px 0; font-weight:bold; font-size:20px; color:#000;'>₹" + price + "</p>" +
                "<p style='margin:0; color:#333;'>Validity: " + validity + " days</p>" +
            "</div>" +

            "<div class='plan-body'>" +
                "<div class='plan-feature'><strong>Data:</strong> " + dataFeature + "</div>" +
                "<div class='plan-feature'><strong>Calls:</strong> " + calls + "</div>" +
                "<div class='plan-feature'><strong>SMS:</strong> " + sms + "</div>" +
                "<div class='plan-feature'><strong>Network:</strong> " + network + "</div>" +
            "</div>";

        grid.appendChild(card);
    });
}

function filterPlans() {
    return allPlans.filter(plan => {
        // Carrier filter
        if (currentFilter.carrier !== 'all' &&
            plan.carrier_name !== currentFilter.carrier) {
            return false;
        }

        // Type filter
        if (currentFilter.type !== 'all' &&
            plan.plan_type !== currentFilter.type) {
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
            const carrierName = (plan.carrier_name || '').toLowerCase();
            const price = String(plan.plan_price || '');
            const dataFeature = (plan.data_per_day || plan.total_data || '').toLowerCase();
            
            return planName.includes(searchTerm) || 
                   carrierName.includes(searchTerm) || 
                   price.includes(searchTerm) ||
                   dataFeature.includes(searchTerm);
        }

        return true;
    });
}

function filterByCarrier(carrier) {
    // Update current filter
    currentFilter.carrier = carrier;
    
    // Update active class on carrier tabs
    const carrierTabs = document.querySelectorAll('.carrier-tab');
    carrierTabs.forEach(tab => {
        if (tab.getAttribute('data-carrier') === carrier) {
            tab.classList.add('active');
        } else {
            tab.classList.remove('active');
        }
    });
    
    // Display filtered plans
    displayPlans();
}

function filterByType(type) {
    // Update current filter
    currentFilter.type = type;
    
    // Update active class on filter tabs
    const filterTabs = document.querySelectorAll('.filter-tab');
    filterTabs.forEach(tab => {
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
    
    // Display filtered plans
    displayPlans();
}

function filterByPrice() {
    currentFilter.price = document.getElementById("priceFilter").value;
    displayPlans();
}

function searchPlans() {
    currentFilter.search = document.getElementById("searchInput").value;
    displayPlans();
}

// Optional: Add enter key support for search
document.addEventListener('DOMContentLoaded', function() {
    const searchInput = document.getElementById("searchInput");
    if (searchInput) {
        searchInput.addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                searchPlans();
            }
        });
    }
});

</script>




</body>
</html>