<%@page import="com.dao.UserDAO"%>
<%@page import="com.entity.User"%>
<%@page import="com.conn.DbConnect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    int id = Integer.parseInt(request.getParameter("id"));
    UserDAO userDao = new UserDAO(DbConnect.getConn());
    User user = userDao.getUserById(id);
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit User - Cab Service</title>
    <style>
        body {
            background: linear-gradient(to bottom, #fff7e6, #ffe6b3);
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            min-height: 100vh;
        }
        .form-container {
            width: 60%;
            max-width: 500px;
            margin: 80px auto;
            padding: 30px;
            background: rgba(255, 255, 255, 0.9);
            border-radius: 15px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            position: relative;
            overflow: hidden;
        }
        .form-container::before {
            content: '';
            position: absolute;
            top: -50px;
            left: -50px;
            width: 100px;
            height: 100px;
            background: #ffd60a;
            border-radius: 50%;
            z-index: -1;
        }
        .form-container::after {
            content: '';
            position: absolute;
            bottom: -30px;
            right: -30px;
            width: 80px;
            height: 80px;
            background: #ffaa00;
            border-radius: 50%;
            z-index: -1;
        }
        .form-container h2 {
            text-align: center;
            color: #333;
            margin-bottom: 30px;
            font-size: 28px;
            text-transform: uppercase;
            letter-spacing: 2px;
        }
        .form-group {
            margin-bottom: 20px;
            position: relative;
        }
        .form-group label {
            display: block;
            color: #555;
            font-weight: bold;
            margin-bottom: 5px;
        }
        .form-group input {
            width: 100%;
            padding: 12px;
            border: 2px solid #ffd60a;
            border-radius: 8px;
            font-size: 16px;
            background: #fff;
            transition: all 0.3s ease;
        }
        .form-group input:focus {
            border-color: #ffaa00;
            outline: none;
            box-shadow: 0 0 8px rgba(255, 170, 0, 0.3);
        }
        .form-group .error {
            color: #e63946;
            font-size: 12px;
            margin-top: 5px;
            display: none;
        }
        .submit-btn {
            background: #ffaa00;
            color: white;
            padding: 12px 25px;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
            display: block;
            margin: 20px auto 0;
            transition: background 0.3s ease;
        }
        .submit-btn:hover {
            background: #e09900;
        }
        .cab-icon {
            text-align: center;
            margin-bottom: 20px;
        }
        .cab-icon img {
            width: 60px;
            height: auto;
        }
        .password-toggle {
            position: absolute;
            right: 10px;
            top: 42px;
            cursor: pointer;
            color: #ffaa00;
            font-size: 14px;
        }
    </style>
    
    <script>
        function validateForm() {
            let isValid = true;
            document.querySelectorAll('.error').forEach(error => error.style.display = 'none');
            const name = document.getElementById('name').value;
            if (name.length < 3) {
                document.getElementById('name-error').style.display = 'block';
                isValid = false;
            }
            const address = document.getElementById('address').value;
            if (address.length < 5) {
                document.getElementById('address-error').style.display = 'block';
                isValid = false;
            }
            const nic = document.getElementById('nic').value;
            if (nic.length < 9 || nic.length > 12) {
                document.getElementById('nic-error').style.display = 'block';
                isValid = false;
            }
            const email = document.getElementById('email').value;
            const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailPattern.test(email)) {
                document.getElementById('email-error').style.display = 'block';
                isValid = false;
            }
            const password = document.getElementById('password').value;
            if (password.length < 1) {
                document.getElementById('password-error').style.display = 'block';
                isValid = false;
            }
            return isValid;
        }
        function togglePassword() {
            const passwordField = document.getElementById('password');
            const toggleText = document.querySelector('.password-toggle');
            if (passwordField.type === 'password') {
                passwordField.type = 'text';
                toggleText.textContent = 'Hide';
            } else {
                passwordField.type = 'password';
                toggleText.textContent = 'Show';
            }
        }
    </script>
</head>
<body>
    <%@include file="component/adminNavbar.jsp" %>
    <div class="form-container">
        <div class="cab-icon">
            <img src="https://img.icons8.com/ios-filled/50/ffd60a/taxi.png" alt="Cab Icon">
        </div>
        <h2>Edit User Information</h2>
        <form action="UpdateUserServlet" method="post" onsubmit="return validateForm()">
            <input type="hidden" name="id" value="<%= user.getID() %>">
            
            <div class="form-group">
                <label>Name:</label>
                <input type="text" name="name" id="name" value="<%= user.getName() %>" required>
                <span class="error" id="name-error">Name must be at least 3 characters long</span>
            </div>
            
            <div class="form-group">
                <label>Address:</label>
                <input type="text" name="address" id="address" value="<%= user.getAddress() %>" required>
                <span class="error" id="address-error">Address must be at least 5 characters long</span>
            </div>
            
            <div class="form-group">
                <label>NIC:</label>
                <input type="text" name="nic" id="nic" value="<%= user.getNIC() %>" required>
                <span class="error" id="nic-error">NIC must be 9-12 characters long</span>
            </div>
            
            <div class="form-group">
                <label>Email:</label>
                <input type="email" name="email" id="email" value="<%= user.getemail() %>" required>
                <span class="error" id="email-error">Please enter a valid email address</span>
            </div>
            
            <div class="form-group">
                <label>Password:</label>
                <input type="password" name="password" id="password" value="<%= user.getpassword() %>" required>
                <span class="password-toggle" onclick="togglePassword()">Show</span>
                
            </div>
            
            <button type="submit" class="submit-btn">Update</button>
        </form>
    </div>

    
</body>
</html>