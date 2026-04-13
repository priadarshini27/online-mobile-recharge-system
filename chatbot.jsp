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
<!DOCTYPE html>
<html>
<head>
    <title>Chat Support - Mobile Recharge</title>
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
        /* Additional specific styles for chatbot */
        #chat-container {
            max-width: 700px;
            margin: 40px auto;
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
            overflow: hidden;
        }

        #chat-header {
            background: linear-gradient(90deg, #2c3e50, #4a6491);
            color: white;
            padding: 20px 25px;
            font-size: 1.4rem;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 10px;
            border-bottom: 5px solid #00c6ff;
        }

        #chat-header i {
            color: #00c6ff;
            font-size: 1.8rem;
        }

        #chat-body {
            height: 300px;
            overflow-y: auto;
            padding: 20px;
            background: #f8f9ff;
            border-bottom: 1px solid #e0e5f0;
        }

        #chat-body b {
            color: #2c3e50;
            display: block;
            margin-bottom: 15px;
            font-size: 1.1rem;
        }

        .message-container {
            padding: 10px;
        }

        .user {
            background: linear-gradient(45deg, #0072ff, #00c6ff);
            color: white;
            padding: 10px 15px;
            border-radius: 18px 18px 4px 18px;
            margin: 10px 0;
            max-width: 80%;
            margin-left: auto;
            text-align: right;
            box-shadow: 0 4px 10px rgba(0, 114, 255, 0.2);
            font-weight: 500;
        }

        .bot {
            background: white;
            color: #2c3e50;
            padding: 10px 15px;
            border-radius: 18px 18px 18px 4px;
            margin: 10px 0;
            max-width: 80%;
            margin-right: auto;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
            border: 1px solid #e0e5f0;
            font-weight: 500;
        }

        .questions-section {
            padding: 20px;
            background: white;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 10px;
        }

        .question {
            background: #f8f9ff;
            border: 2px solid #e0e5f0;
            padding: 12px 15px;
            text-align: left;
            cursor: pointer;
            border-radius: 10px;
            color: #2c3e50;
            font-weight: 500;
            font-size: 0.95rem;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
            width: 100%;
        }

        .question i {
            color: #0072ff;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .question:hover {
            background: linear-gradient(45deg, #0072ff, #00c6ff);
            color: white;
            border-color: transparent;
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(0, 114, 255, 0.3);
        }

        .question:hover i {
            color: white;
        }

        .back-home {
            text-align: center;
            padding: 15px;
            background: #f8f9ff;
            border-top: 1px solid #e0e5f0;
        }

        .back-home a {
            color: #0072ff;
            text-decoration: none;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s ease;
        }

        .back-home a:hover {
            color: #2c3e50;
            transform: translateX(-5px);
        }

        /* Custom scrollbar */
        #chat-body::-webkit-scrollbar {
            width: 6px;
        }

        #chat-body::-webkit-scrollbar-track {
            background: #f1f1f1;
        }

        #chat-body::-webkit-scrollbar-thumb {
            background: #c3cfe2;
            border-radius: 3px;
        }

        #chat-body::-webkit-scrollbar-thumb:hover {
            background: #0072ff;
        }
        .chat-input-section{
            display:flex;
            gap:10px;
            padding:15px;
            border-top:1px solid #e0e5f0;
            background:#ffffff;
        }

        .chat-input-section input{
            flex:1;
            padding:10px 15px;
            border-radius:8px;
            border:1px solid #ccc;
            font-size:0.95rem;
        }

        .chat-input-section button{
            background:linear-gradient(45deg,#0072ff,#00c6ff);
            border:none;
            color:white;
            padding:10px 20px;
            border-radius:8px;
            cursor:pointer;
            font-weight:600;
        }

        .chat-input-section button:hover{
            opacity:0.9;
        }
    </style>
    <script>
        function askQuestion(question){
            let chatBody = document.getElementById("chat-body");
            
            chatBody.innerHTML += "<div class='user'><i class='fas fa-user'></i> " + question + "</div>";
            
            fetch("<%= request.getContextPath() %>/chatbot",{
                method:"POST",
                headers:{
                    "Content-Type":"application/x-www-form-urlencoded"
                },
                body:"message="+encodeURIComponent(question)
            })
            .then(response=>response.text())
            
            .then(data=>{
                console.log("Response:", data);
                chatBody.innerHTML += "<div class='bot'><i class='fas fa-robot'></i> " + data + "</div>";
                chatBody.scrollTop = chatBody.scrollHeight;
            })
            
            .catch(error=>{
                chatBody.innerHTML += "<div class='bot'>Error connecting to server.</div>";
            });
        }

        function sendMessage(){

            let input = document.getElementById("userInput");

            if(!input){
                alert("Input box not found!");
                return;
            }

            let message = input.value.trim();

            if(message === ""){
                return;
            }

            askQuestion(message);

            input.value = "";
            
        }
        function openUserSettings() {
             window.location.href = "user-settings.jsp";
        }
    </script>
    <!--<script src="script.js"></script>-->
</head>
<body>
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
    <div class="body">
        <div id="chat-container">
            <!--div id="chat-header">
                <i class="fas fa-robot"></i>
                Recharge Help Chatbot
            </div>-->
            
            <div id="chat-body">
                <b><i class="fas fa-comment-dots" style="margin-right: 8px;"></i>Select a question below:</b>
            </div>
            
            <div class="questions-section">
                <button class="question" onclick="askQuestion('How do I recharge?')">
                    <i class="fas fa-bolt"></i>
                    How do I recharge my mobile?
                </button>
                
                <button class="question" onclick="askQuestion('What plans are available?')">
                    <i class="fas fa-list-alt"></i>
                    What recharge plans are available?
                </button>
                
                <button class="question" onclick="askQuestion('What payment methods are supported?')">
                    <i class="fas fa-credit-card"></i>
                    What payment methods are supported?
                </button>
                
                <button class="question" onclick="askQuestion('How to check transaction history?')">
                    <i class="fas fa-history"></i>
                    How can I check my transaction history?
                </button>
                
                <button class="question" onclick="askQuestion('How to login?')">
                    <i class="fas fa-sign-in-alt"></i>
                    How do I login to my account?
                </button>
                
                <button class="question" onclick="askQuestion('How to register?')">
                    <i class="fas fa-user-plus"></i>
                    How do I create a new account?
                </button>
                
                <button class="question" onclick="askQuestion('Which operators are supported?')">
                    <i class="fas fa-building"></i>
                    Which operators are supported?
                </button>
                
                <button class="question" onclick="askQuestion('How to manage account settings?')">
                    <i class="fas fa-cog"></i>
                    How do I manage my account settings?
                </button>
            </div>
            <div class="chat-input-section">
                <input type="text" id="userInput" placeholder="Type your message here..."
                    onkeypress="if(event.key==='Enter') sendMessage()">

                <button onclick="sendMessage()">
                    <i class="fas fa-paper-plane"></i> Send
                </button>
            </div>
            <div class="back-home">
                <a href="home.jsp">
                    <i class="fas fa-arrow-left"></i>
                    Back to Dashboard
                </a>
            </div>
        </div>
    </div>
</body>
</html>