<%@page import="java.text.DecimalFormat"%>
<%@page import="com.dao.BookingDAO"%>
<%@page import="com.dao.DriverDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.dao.UserDAO" %>
<%@ page import="com.conn.DbConnect" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - Cab Service</title>
    <style>
        .dashboard-container {
            display: flex;
            justify-content: center;
            gap: 25px;
            margin: 220px auto;
            max-width: 1200px;
            perspective: 1000px;
        }

        .dashboard-card {
            width: 320px;
            padding: 25px;
            background: linear-gradient(135deg, #fff9e6, #fff3cc);
            border-radius: 15px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.1);
            text-align: center;
            transition: all 0.3s ease;
            transform: translateZ(0);
        }

        .dashboard-card:hover {
            transform: translateY(-10px) translateZ(20px);
            box-shadow: 0 15px 40px rgba(255, 204, 0, 0.2);
        }

        .dashboard-card h2 {
            color: #2c3e50;
            font-size: 1.5em;
            margin-bottom: 15px;
            text-transform: uppercase;
            letter-spacing: 1px;
            position: relative;
        }

        .dashboard-card h2::after {
            content: '';
            width: 50px;
            height: 3px;
            background: linear-gradient(to right, #ffcc00, #ff9900);
            position: absolute;
            bottom: -5px;
            left: 50%;
            transform: translateX(-50%);
            border-radius: 2px;
        }

        .dashboard-card h3 {
            color: #ff6600;
            font-size: 2.2em;
            margin: 15px 0;
            font-weight: 700;
            animation: numberFade 1s ease-in;
        }

        .btn-adminView {
            display: inline-block;
            padding: 12px 25px;
            background: linear-gradient(45deg, #ffcc00, #ff9900);
            color: #fff;
            text-decoration: none;
            border-radius: 25px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: all 0.3s ease;
            border: none;
            box-shadow: 0 4px 15px rgba(255, 204, 0, 0.4);
        }

        .btn-adminView:hover {
            background: linear-gradient(45deg, #ff9900, #ff6600);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(255, 153, 0, 0.5);
        }

        @keyframes numberFade {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @media (max-width: 768px) {
            .dashboard-container {
                flex-direction: column;
                align-items: center;
                margin: 20px;
            }           
            .dashboard-card {
                width: 90%;
                margin-bottom: 20px;
            }
        }

        body { /* Fixed the class selector to tag selector */
            background: linear-gradient(to bottom, #fff7e6, #ffe6b3); 
            min-height: 100vh;
            font-family: 'Segoe UI', sans-serif;
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
        
        UserDAO userDao = new UserDAO(DbConnect.getConn());
        BookingDAO bookingDao = new BookingDAO(DbConnect.getConn());
        DriverDAO driverDao = new DriverDAO(DbConnect.getConn());
        
        int userCount = userDao.getUserCount();
        double totalAmount = bookingDao.getTotalBookingAmount();
        int driverCount = driverDao.getDriverCount();
        
        DecimalFormat df = new DecimalFormat("#,##0.00");
        String formattedAmount = df.format(totalAmount);
    %>
    
    <div class="dashboard-container">
        <div class="dashboard-card">
            <h2>Total Users</h2>
            <h3><%= userCount %></h3>
            <a href="adminManageUsers.jsp" class="btn-adminView">View Users</a>
        </div>
        
        <div class="dashboard-card">
            <h2>Total Booking Amount</h2>
            <h3>Rs. <%= formattedAmount %></h3>
            <a href="adminManageBookings.jsp" class="btn-adminView">View Bookings</a>
        </div>
        
        <div class="dashboard-card">
            <h2>Total Drivers</h2>
            <h3><%= driverCount %></h3>
            <a href="adminManageDrivers.jsp" class="btn-adminView">View Drivers</a>
        </div>
    </div>
</body>
</html>