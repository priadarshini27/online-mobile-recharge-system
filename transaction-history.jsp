<%@ page session="true" %>
<%
    if (session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<?xml version="1.0" encoding="UTF-8"?>

<?xml-stylesheet type="text/xsl" href="transactions.xsl"?>

<%@ page import="java.net.*" %>
<%
response.sendRedirect("TransactionServlet?limit=all");
%>