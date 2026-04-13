<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.Timestamp, java.text.SimpleDateFormat" %>
<%@ page session="true" %>

<%
    HttpSession sessionObj = request.getSession(false);

    if (sessionObj == null || sessionObj.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String userName = (String) sessionObj.getAttribute("userName");
    Timestamp previousLogin = (Timestamp) sessionObj.getAttribute("previousLogin");

    SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy HH:mm:ss");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Session Details</title>
</head>
<body style="font-family: Arial; padding:40px;">

    <h2>Session Details</h2>

    <p><strong>Session ID:</strong> <%= sessionObj.getId() %></p>

    <p><strong>Username:</strong> <%= userName %></p>

    <p><strong>Session Created:</strong> 
        <%= sdf.format(new java.util.Date(sessionObj.getCreationTime())) %>
    </p>

    <p><strong>Last Accessed:</strong> 
        <%= sdf.format(new java.util.Date(sessionObj.getLastAccessedTime())) %>
    </p>

    <p><strong>Previous Login:</strong>
        <%
            if (previousLogin == null) {
                out.print("This is your first login.");
            } else {
                out.print(sdf.format(previousLogin));
            }
        %>
    </p>

    <br>
    <a href="home.jsp">Back to Home</a>

</body>
</html>