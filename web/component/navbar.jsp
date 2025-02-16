<%@page import="com.entity.User"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mega City Cab</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    
    <style>
        /* Navbar Styling */
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

        /* User Button */
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

        /* Logout Button */
        .btn-danger {
            background-color: #e74c3c;
            border-color: #e74c3c;
            color: #fff;
            font-size: 1.1rem;
            margin-right:15px;
        }

        .btn-danger:hover {
            background-color: #c0392b;
            border-color: #c0392b;
        }

        
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark">
  <a class="navbar-brand" href="index.jsp"><i class="fa-solid fa-car"></i> Mega City Cab</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>   
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mx-auto">
      <li class="nav-item active mx-3">
        <a class="nav-link" href="index.jsp"><i class="fa-solid fa-house"></i> Home <span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item active mx-3">
        <a class="nav-link" href="about.jsp"><i class="fa-solid fa-eject"></i> About Us</a>
      </li>
      <li class="nav-item active mx-3">
        <a class="nav-link" href="AddBooking.jsp"><i class="fa-solid fa-square-plus"></i> Add Booking</a>
      </li>
      <li class="nav-item active mx-3">
        <a class="nav-link" href="ManageBooking.jsp"><i class="fa-solid fa-eye"></i> Display Booking</a>
      </li>
    </ul>
    <% 
      User user = (User) session.getAttribute("user");
      if (user == null) {
    %>
    <form class="form-inline my-2 my-lg-0">
        <a href="login.jsp" class="btn btn-success"><i class="fa-solid fa-user"></i> Login</a>
        <a href="rejister.jsp" class="btn btn-danger ml-2"><i class="fa-solid fa-users"></i> Register</a>
    </form>
    <% } else { %>
    <form class="form-inline my-2 my-lg-0">
        <button class="btn btn-success"><%= user.getName() %></button>
        <a data-toggle="modal" data-target="#exampleModalCenter" class="btn btn-danger ml-3 text-white">Logout</a>
    </form>
    <% } %>  
  </div>

  <!-- Logout Modal -->
<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content" style="border: 2px solid #FFD700; border-radius: 15px; box-shadow: 0 0 15px rgba(255, 215, 0, 0.6);">
            <div class="modal-header" style="background-color: #FFD700; color: #333; border-top-left-radius: 15px; border-top-right-radius: 15px;">
                <h5 class="modal-title" id="exampleModalLongTitle">Logout Confirmation</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="color: #333;">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body text-center" style="padding: 30px;">
                <h6 style="color: #555; margin-bottom: 20px;">Do you really want to logout?</h6>
                <button type="button" class="btn btn-secondary" data-dismiss="modal" style="margin-right: 10px; border-radius: 10px;">Close</button>
                <a href="logout" class="btn btn-warning" style="border-radius: 10px; color: #fff; background-color: #FFA500; border: none; transition: 0.3s;">Logout</a>
            </div>
        </div>
    </div>
</div>
<!-- Logout Modal -->
</nav>

</body>
</html>
