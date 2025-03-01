<%@page import="com.entity.Booking"%>
<%@page import="java.util.List"%>
<%@page import="com.dao.BookingDAO"%>
<%@page import="com.conn.DbConnect"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Manage Bookings - Admin Panel</title>
    <%@include file="component/allCss.jsp"%>
    <style type="text/css">
        body {
            background: linear-gradient(to bottom, #fff7e6, #ffe6b3);
            min-height: 100vh;
            font-family: 'Segoe UI', sans-serif;
            margin: 0;
        }
        .container {
            width: 85%;
            margin: 60px auto;
            background: #ffffff;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
            position: relative;
            overflow: hidden;
        }
        .container::before {
            content: '';
            position: absolute;
            top: -50px;
            right: -50px;
            width: 150px;
            height: 150px;
            background: url('https://img.icons8.com/ios-filled/50/000000/ticket.png') no-repeat center;
            background-size: 80px;
            opacity: 0.1;
            transform: rotate(20deg);
        }
        h2 {
            text-align: center;
            color: #333;
            font-size: 2em;
            margin-bottom: 20px;
            text-transform: uppercase;
            letter-spacing: 2px;
            text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.1);
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 30px;
            background: #fff;
            border-radius: 10px;
            overflow: hidden;
        }
        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background: #ffca28;
            color: #333;
            font-weight: bold;
            text-transform: uppercase;
        }
        tr:hover {
            background: #fffde7;
            transition: background 0.3s ease;
        }
        .action-btn {
            padding: 8px 15px;
            border: none;
            cursor: pointer;
            border-radius: 25px;
            font-size: 0.9em;
            transition: transform 0.2s, box-shadow 0.2s;
            text-decoration: none;
            display: inline-block;
        }
        .action-btn:hover {
            transform: translateY(-3px) scale(1.05);
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.25);
            background: linear-gradient(135deg, #ff7e5f, #feb47b);
            color: white;
            text-shadow: 1px 1px 5px rgba(255, 255, 255, 0.5);
        }
        .accept-btn {
            background: #27ae60;
            color: #fff;
        }
        .pending-btn {
            background: #e67e22;
            color: #fff;
        }
        .status {
            font-weight: bold;
        }
        .status-pending {
            color: #e67e22;
        }
        .status-accepted {
            color: #27ae60;
        }
    </style>
</head>
<body>
    <%@include file="component/adminNavbar.jsp" %>

    <%
        String admin = (String) session.getAttribute("admin");
        if (admin == null) {
            response.sendRedirect("login.jsp");
            return;
        }
    %>

    <div class="container">
        <h2>Manage Bookings</h2>
        <%
            String succMsg = (String) session.getAttribute("succMsg");
            String failedMsg = (String) session.getAttribute("failedMsg");
            if (succMsg != null) {
        %>
            <div class="alert alert-success"><%= succMsg %></div>
        <%
                session.removeAttribute("succMsg");
            }
            if (failedMsg != null) {
        %>
            <div class="alert alert-danger"><%= failedMsg %></div>
        <%
                session.removeAttribute("failedMsg");
            }
        %>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Start</th>
                    <th>End</th>
                    <th>Amount</th>
                    <th>About</th>
                    <th>User ID</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    BookingDAO dao = new BookingDAO(DbConnect.getConn());
                    List<Booking> bookings = dao.getAllBookings();
                    
                    for (Booking c : bookings) {
                %>
                <tr>
                    <td><%= c.getID() %></td>
                    <td><%= c.getName() %></td>
                    <td><%= c.getEmail() %></td>
                    <td><%= c.getPhno() %></td>
                    <td><%= c.getStart() %></td>
                    <td><%= c.getEnd() %></td>
                    <td>LKR <%= c.getAmount() %></td>
                    <td><%= c.getAbout() %></td>
                    <td><%= c.getUserid() %></td>
                    <td>
                        <span class="status status-<%= c.getStatus().toLowerCase() %>"><%= c.getStatus() %></span>
                    </td>
                    <td>
                        <% if ("Pending".equals(c.getStatus())) { %>
                            <a href="updateStatus?cid=<%= c.getID() %>&status=Accepted" class="action-btn accept-btn">Accept</a>
                        <% } else { %>
                            <a href="updateStatus?cid=<%= c.getID() %>&status=Pending" class="action-btn pending-btn">Set Pending</a>
                        <% } %>
                    </td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>