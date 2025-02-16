<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Login Page</title>
        <%@include file="component/allCss.jsp"%>
        <style>
            body {
                background: url('img/bg.jpg');
                min-height: 100vh;
                display: flex;
                flex-direction: column;
                font-family: 'Poppins', sans-serif;
            }
            .login-card {
                background: linear-gradient(135deg, #fdfd96, #f6f4a2);
                border-radius: 25px;
                box-shadow: 0 6px 20px rgba(0, 0, 0, 0.05);
                padding: 30px;
                width: 100%;
                max-width: 400px;
                margin: auto;
                margin-top: 20%;
                border: 1px solid #f1f1b0;
}

            .login-card h4 {
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
                background-color:#B4C424;
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
            <div class="login-card">
                <h4>Login Page</h4>

                <% String inavlidMsg=(String)session.getAttribute("invalidMsg");
                    if(inavlidMsg!=null) { %>
                    <p class="text-danger text-center"><%= inavlidMsg %></p>
                    <% session.removeAttribute("invalidMsg"); } %>

                <% String logMsg =(String)session.getAttribute("logMsg");
                    if(logMsg!=null) { %>
                    <p class="text-success text-center"><%= logMsg %></p>
                    <% session.removeAttribute("logMsg"); } %>

                <form action="login" method="post">
                    <div class="form-group mb-3">
                        <label for="exampleInputEmail1" class="fw-bold">User Name</label>
                        <input name="email" type="email" class="form-control" id="exampleInputEmail1" placeholder="Enter your email" required>
                    </div>
                    <div class="form-group mb-4">
                        <label for="exampleInputPassword1" class="fw-bold">Password</label>
                        <input name="password" type="password" class="form-control" id="exampleInputPassword1" placeholder="Enter your password" required>
                    </div>
                    <div class="text-center">
                        <button type="submit" class="btn btn-primary">Login</button>
                    </div>
                </form>
                <div class="text-center mt-3">
                    <p>Do you don't have an account? <a href="rejister.jsp" style="color: #8B8000;">Register here</a></p>
                </div>
            </div>
        </div>
    </body>
</html>
