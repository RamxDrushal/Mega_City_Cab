<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Driver - Cab Admin</title>
    <style>
        body {
            background: linear-gradient(to bottom, #fff7e6, #ffe6b3);
            min-height: 100vh;
            font-family: 'Segoe UI', sans-serif;
            margin: 0;
        }
        .form-container {
            width: 85%;
            max-width: 500px;
            margin: 60px auto;
            background: #ffffff;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
            position: relative;
            overflow: hidden;
        }
        .form-container::before {
            content: '';
            position: absolute;
            top: -50px;
            right: -50px;
            width: 150px;
            height: 150px;
            background: url('https://img.icons8.com/ios-filled/50/000000/car.png') no-repeat center;
            background-size: 80px;
            opacity: 0.1;
            transform: rotate(20deg);
        }
        h2 {
            text-align: center;
            color: #333;
            font-size: 2em;
            margin-bottom: 30px;
            text-transform: uppercase;
            letter-spacing: 2px;
            text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.1);
        }
        .form-group {
            margin-bottom: 20px;
            position: relative;
        }
        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #555;
            font-weight: 500;
            transition: color 0.3s ease;
        }
        .form-group input {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 1em;
            box-sizing: border-box;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }
        .form-group input:focus {
            border-color: #ffca28;
            box-shadow: 0 0 8px rgba(255, 202, 40, 0.3);
            outline: none;
        }
        .form-group label:focus-within {
            color: #ffca28;
        }
        .submit-btn {
            display: block;
            width: 100%;
            padding: 12px;
            background: #2ecc71;
            color: #fff;
            border: none;
            border-radius: 25px;
            font-size: 1.1em;
            font-weight: bold;
            cursor: pointer;
            transition: transform 0.2s, box-shadow 0.2s, background 0.3s;
        }
        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            background: #27ae60;
        }
        .form-group input:invalid:focus {
            border-color: #d32f2f;
            box-shadow: 0 0 8px rgba(211, 47, 47, 0.3);
        }
        .form-container {
            animation: fadeIn 0.5s ease-out;
        }
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
</head>
<body>
    <%@include file="component/adminNavbar.jsp" %>
    <div class="form-container">
        <h2>Add New Driver</h2>
        <form action="AddDriverServlet" method="post" id="driverForm">
            <div class="form-group">
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" required placeholder="Enter driver's name">
                <span id="name-error" style="color: red; display: none;">Invalid name</span>
            </div>
            <div class="form-group">
                <label for="carModel">Car Model:</label>
                <input type="text" id="carModel" name="carModel" required placeholder="Enter car model">
                <span id="carModel-error" style="color: red; display: none;">Invalid car model</span>
            </div>
            <div class="form-group">
                <label for="vehicleNumber">Vehicle Number:</label>
                <input type="text" id="vehicleNumber" name="vehicleNumber" required placeholder="Enter vehicle number">
                <span id="vehicleNumber-error" style="color: red; display: none;">Invalid vehicle number</span>
            </div>
            <div class="form-group">
                <label for="phoneNumber">Phone Number:</label>
                <input type="text" id="phoneNumber" name="phoneNumber" required placeholder="Enter phone number">
                <span id="phoneNumber-error" style="color: red; display: none;">Invalid phone number</span>
            </div>
            <button type="submit" class="submit-btn">Add Driver</button>
        </form>
    </div>

    <script>
        const driverForm = document.getElementById('driverForm');
        driverForm.addEventListener('submit', function(e) {
            if (!validateForm()) {
                e.preventDefault();
            }
        });

        const inputs = document.querySelectorAll('input');
        inputs.forEach(input => {
            input.addEventListener('input', function() {
                validateField(this);
            });
        });

        function validateForm() {
            let isValid = true;
            inputs.forEach(input => {
                if (!validateField(input)) {
                    isValid = false;
                }
            });
            return isValid;
        }

        function validateField(input) {
            const fieldName = input.id;
            const value = input.value.trim();
            const errorElement = document.getElementById(`${fieldName}-error`);
            const formGroup = input.closest('.form-group');
            let isValid = true;

            formGroup.classList.remove('valid', 'invalid');

            switch(fieldName) {
                case 'name':
                    isValid = /^[A-Za-z ]{2,50}$/.test(value);
                    break;
                case 'carModel':
                    isValid = /^[A-Za-z0-9 -]{2,50}$/.test(value);
                    break;
                case 'vehicleNumber':
                    isValid = /^[A-Za-z0-9-]{2,20}$/.test(value);
                    break;
                case 'phoneNumber':
                    isValid = /^[0-9]{10}$/.test(value); // 10-digit phone number
                    break;
            }

            if (value === '') {
                isValid = false;
            }

            if (!isValid) {
                formGroup.classList.add('invalid');
                errorElement.style.display = 'block';
            } else {
                formGroup.classList.add('valid');
                errorElement.style.display = 'none';
            }
            return isValid;
        }
    </script>
</body>
</html>