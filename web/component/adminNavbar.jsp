<%@page import="com.entity.User"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Mega City Cab</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <style>
        .navbar {
            background-color: #1d1d1d;
            padding: 15px 0; 
        }

        .navbar-brand {
            font-size: 1.8rem;
            font-weight: bold;
            color: #ffffff;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-left: 15px;
        }

        .navbar-nav .nav-item .nav-link {
            color: #ffffff !important;
            font-size: 1.1rem;
            font-weight: 500;
            padding: 10px 15px;
            transition: all 0.3s ease;
        }

        .navbar-nav .nav-item .nav-link:hover {
            color: #FFEA00 !important; 
            background-color: #2c2c2c;
            border-radius: 5px;
        }

        .navbar-toggler {
            border: none;
        }

        .navbar-toggler-icon {
            background-color: #f39c12;
        }

        .btn-success {
            background-color: #FFD700;
            border-color: #f39c12;
            color: #fff;
            font-size: 1.1rem;   
        }

        .btn-success:hover {
            background-color: #e67e22;
            border-color: #e67e22;
        }

        .btn-danger {
            background-color: #e74c3c;
            border-color: #e74c3c;
            color: #fff;
            font-size: 1.1rem;
            margin-right:35px;
        }

        .btn-danger:hover {
            background-color: #c0392b;
            border-color: #c0392b;
        }

        .modal-content {
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .modal-header {
            background-color: #FFD700;
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
            border-bottom: none;
            padding: 15px;
            color: #333;
            font-weight: bold;
        }

        .modal-title {
            text-align: center;
            width: 100%;
            font-size: 1.1rem;
        }

        .modal-body {
            padding: 20px;
            text-align: center;
            color: #333;
            background-color: #fff;
            border-bottom-left-radius: 10px;
            border-bottom-right-radius: 10px;
        }

        .btn-close {
            position: absolute;
            right: 15px;
            top: 15px;
            color: #333;
            opacity: 1;
        }

        .modal-footer {
            border-top: none;
            padding: 15px;
            justify-content: center;
        }

        .modal-footer .btn {
            border-radius: 5px;
            padding: 8px 20px;
            font-size: 1rem;
        }

        .modal-footer .btn-secondary {
            background-color: #808080;
            border: none;
            color: #fff;
        }

        .modal-footer .btn-secondary:hover {
            background-color: #666;
        }

        .modal-footer .btn-danger {
            background-color: #FFA500; 
            border: none;
            color: #fff;
        }

        .modal-footer .btn-danger:hover {
            background-color: #cc8400;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark">
    <a class="navbar-brand" href="AdminViewDashboard.jsp"><i class="fa-solid fa-car"></i> Admin Panel</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>   
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mx-auto">
            <li class="nav-item active mx-3">
                <a class="nav-link" href="AdminViewDashboard.jsp"><i class="fa-solid fa-house"></i> Dashboard</a>
            </li>
            <li class="nav-item active mx-3">
                <a class="nav-link" href="adminManageUsers.jsp"><i class="fa-solid fa-users"></i> Manage Users</a>
            </li>
            <li class="nav-item active mx-3">
                <a class="nav-link" href="adminManageBookings.jsp"><i class="fa-solid fa-calendar-check"></i> Manage Bookings</a>
            </li>
            <li class="nav-item active mx-3">
                <a class="nav-link" href="adminManageDrivers.jsp"><i class="fa-solid fa-chart-bar"></i> Manage Drivers</a>
            </li>
        </ul>

        <!-- Logout Button with Modal Trigger -->
        <div class="navbar-nav ml-auto">
            <button class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#logoutModal">
                <i class="fa-solid fa-sign-out-alt"></i> Logout
            </button>
        </div>
    </div>
</nav>

<!-- Logout Confirmation Modal -->
<div class="modal fade" id="logoutModal" tabindex="-1" aria-labelledby="logoutModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="logoutModalLabel">Logout Confirmation</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                Do you really want to logout?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <a href="login.jsp" class="btn btn-danger">Logout</a>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS and dependencies -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>