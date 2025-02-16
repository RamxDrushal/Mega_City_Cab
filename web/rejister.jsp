<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Registration Page</title>
        <%@include file="component/allCss.jsp"%>
        <style>
            body {
                background: url('img/bg.jpg');
                min-height: 100vh;
                display: flex;
                flex-direction: column;
                font-family: 'Poppins', sans-serif;
            }
            .register-card {
                background: linear-gradient(135deg, #fdfd96, #f6f4a2);
                border-radius: 25px;
                box-shadow: 0 6px 20px rgba(0, 0, 0, 0.05);
                padding: 30px;
                width: 100%;
                max-width: 400px;
                margin: auto;
                margin-top: 5%;
                border: 1px solid #f1f1b0;
            }

            .register-card h4 {
                margin-bottom: 20px;
                color: #353935;
                font-weight: bold;
                text-align: center;
                font-size: 28px;
            }
            .form-control {
                border-radius: 10px;
                padding: 12px;
                font-size: 16px;
            }
            .btn-primary {
                border-radius: 10px;
                padding: 12px 0;
                font-size: 16px;
                width: 100%;
                background-color: #B4C424;
                border: none;
                transition: 0.3s;
            }
            .btn-primary:hover {
                background-color: #C9CC3F;
            }
            .text-danger, .text-success {
                margin: 15px 0;
            }
        </style>
    </head>
    <body>
        <%@include file="component/navbar.jsp" %>
        <div class="container">
            <div class="register-card">
                <h4>Registration Page</h4>

                <% String sucssMsg = (String) session.getAttribute("sucssMsg");
                   String errorMsg = (String) session.getAttribute("errorMsg");
                   if (sucssMsg != null) { %>
                   <p class="text-success text-center"><%= sucssMsg %></p>
                   <% session.removeAttribute("sucssMsg"); } 
                   if (errorMsg != null) { %>
                   <p class="text-danger text-center"><%= errorMsg %></p>
                   <% session.removeAttribute("errorMsg"); } %>

                <form action="register" method="post">
                    <div class="form-group mb-3">
                        <label for="userName" class="fw-bold">User Name</label>
                        <input name="name" type="text" class="form-control" id="userName" placeholder="Enter your name" required>
                    </div>
                    <div class="form-group mb-3">
                        <label for="userAddress" class="fw-bold">Address</label>
                        <input name="Address" type="text" class="form-control" id="userAddress" placeholder="Enter your address" required>
                    </div>
                    <div class="form-group mb-3">
                        <label for="userNIC" class="fw-bold">NIC</label>
                        <input name="NIC" type="text" class="form-control" id="userNIC" placeholder="Enter your NIC" required>
                    </div>
                    <div class="form-group mb-3">
                        <label for="userEmail" class="fw-bold">Email address</label>
                        <input name="email" type="email" class="form-control" id="userEmail" placeholder="Enter your email" required>
                    </div>
                    <div class="form-group mb-4">
                        <label for="userPassword" class="fw-bold">Password</label>
                        <input name="password" type="password" class="form-control" id="userPassword" placeholder="Enter your password" required>
                    </div>
                    <div class="text-center">
                        <button type="submit" class="btn btn-primary">Register</button>
                    </div>
                </form>
                <div class="text-center mt-3">
                    <p>Already have an account? <a href="login.jsp" style="color: #8B8000;">Login here</a></p>
                </div>
            </div>
        </div>
    </body>
</html>
