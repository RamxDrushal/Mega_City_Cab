<%@page import="com.entity.Booking"%>
<%@page import="com.dao.BookingDAO"%>
<%@page import="com.conn.DbConnect"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>My Cab Bookings</title>
    <%@include file="component/allCss.jsp"%>
    <style type="text/css">
        body {
            background: url('img/displayb.jpg') no-repeat center center fixed;
            background-size: cover;
            font-family: 'Poppins', sans-serif;
            position: relative;
        }
        
        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.4); 
            z-index: -1;
        }
        .booking-container {
            padding: 40px 20px;
            max-width: 1200px;
            margin: 0 auto;
            position: relative; 
            z-index: 1;
        }
        .booking-card {
            background: rgba(255, 255, 255, 0.95); 
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin-bottom: 20px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            border-left: 5px solid #4a90e2;
        }
        .booking-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 25px rgba(0, 0, 0, 0.15);
        }
        .booking-card h5 {
            color: #2c3e50;
            font-weight: 600;
            margin-bottom: 10px;
            font-size: 1.2rem;
        }
        .booking-card p {
            color: #7f8c8d;
            margin: 5px 0;
            font-size: 0.95rem;
        }
        .route-icon {
            display: inline-block;
            width: 25px;
            height: 25px;
            background: #4a90e2;
            border-radius: 50%;
            color: #fff;
            text-align: center;
            line-height: 25px;
            margin-right: 10px;
        }
        .btn-custom {
            border-radius: 20px;
            padding: 8px 20px;
            font-size: 0.9rem;
            transition: all 0.3s ease;
        }
        .btn-edit {
            background: #27ae60;
            border: none;
        }
        .btn-delete {
            background: #e74c3c;
            border: none;
        }
        .btn-custom:hover {
            opacity: 0.9;
            transform: scale(1.05);
        }
        .alert {
            padding: 12px 20px;
            border-radius: 5px;
            font-size: 16px;
            font-weight: bold;
            display: flex;
            align-items: center;
            justify-content: center;
            width: 100%;
            max-width: 600px;
            margin: 10px auto;
            text-align: center;
            transition: opacity 0.5s ease-in-out;
        }
        .alert i {
            margin-right: 8px;
            font-size: 20px;
        }
        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        .fade-in {
            animation: fadeIn 0.8s ease-in-out;
        }
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
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
    <%@include file="component/navbar.jsp" %>

    <%
    if (user == null) {
        session.setAttribute("invalidMsg", "Login Please..");
        response.sendRedirect("login.jsp");
    }
    %>

    <% 
    String sucssMsg = (String) session.getAttribute("succMsg");
    String errorMsg = (String) session.getAttribute("failedMsg");
    if (sucssMsg != null) {
    %>
    <div class="alert alert-success fade-in" role="alert">
        <i class="fas fa-check-circle"></i> <%= sucssMsg %>
    </div>
    <%
        session.removeAttribute("succMsg");
    }
    if (errorMsg != null) { 
    %>
    <div class="alert alert-danger fade-in" role="alert">
        <i class="fas fa-times-circle"></i> <%= errorMsg %>
    </div>
    <%
        session.removeAttribute("failedMsg");
    }
    %> 

    <div class="booking-container">
        <div class="row">
            <% 
            if (user != null) {                       
                BookingDAO dao = new BookingDAO(DbConnect.getConn());
                List<Booking> booking = dao.getAllContact(user.getID());
                
                for (Booking c : booking) {
                    String driverName = "Not Assigned";
                    String driverPhoneNumber = "Not Available";
                    if ("Accepted".equals(c.getStatus()) && c.getDriverId() != null) {
                        String[] driverDetails = dao.getDriverDetailsByDriverId(c.getDriverId());
                        if (driverDetails != null) {
                            driverName = driverDetails[0];
                            driverPhoneNumber = driverDetails[1];
                        } else {
                            driverName = "Driver Not Found";
                        }
                    }
            %>
            <div class="col-md-4">
                <div class="booking-card">
                    <h5><span class="route-icon">S</span> Start: <%= c.getStart() %></h5>
                    <h5><span class="route-icon">E</span> End: <%= c.getEnd() %></h5>
                    <p><strong>Name:</strong> <%= c.getName() %></p>
                    <p><strong>Phone:</strong> <%= c.getPhno() %></p>
                    <p><strong>Email:</strong> <%= c.getEmail() %></p>
                    <p><strong>Address:</strong> <%= c.getAddress() %></p>
                    <p><strong>About:</strong> <%= c.getAbout() %></p>
                    <p><strong>Amount:</strong> LKR <%= c.getAmount() %></p>
                    <p><strong>Status:</strong> <span class="status status-<%= c.getStatus().toLowerCase() %>"><%= c.getStatus() %></span></p>
                    <% if ("Accepted".equals(c.getStatus())) { %>
                        <p><strong>Driver:</strong> <%= driverName %></p>
                        <p><strong>Driver Contact:</strong> <%= driverPhoneNumber %></p>
                    <% } %>
                    <div class="text-center mt-3">
                        <a href="editbooking.jsp?cid=<%= c.getID() %>" class="btn btn-custom btn-edit text-white">Edit</a> 
                        <a href="delete?cid=<%= c.getID() %>" class="btn btn-custom btn-delete text-white">Delete</a>
                    </div>
                </div>
            </div>
            <%
                }
            }
            %>
        </div>
    </div>
</body>
</html>
