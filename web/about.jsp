<%-- 
    Document   : AddBooking
    Created on : Feb 11, 2025, 10:35:28 PM
    Author     : ramsh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <%@include file="component/allCss.jsp"%>
    </head>
    <body>
        <%@include file="component/navbar.jsp" %>
        <%
        if (user == null){
            session.setAttribute("invalidMsg", "Login Please..");
            response.sendRedirect("login.jsp");
            }
        %>
    </body>
</html>

