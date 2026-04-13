<header>
    <div class="header-content">
        <div class="logo">
            <i class="fas fa-mobile-alt"></i>
            <span>Online Mobile Recharge</span>
        </div>

        <div style="display:flex; align-items:center;">
            <div class="user-info">
                <h3>Welcome, <%= session.getAttribute("username") %></h3>
                <p>Last login: <%= session.getAttribute("lastLogin") %></p>
                <a href="logout.jsp" class="logout-link">Logout</a>
            </div>
            <div class="user-avatar">
                <i class="fas fa-user"></i>
            </div>
        </div>
    </div>
</header>
