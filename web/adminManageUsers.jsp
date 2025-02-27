<%@page import="java.util.List"%>
<%@page import="com.dao.UserDAO"%>
<%@page import="com.conn.DbConnect"%>
<%@page import="com.entity.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Users - Cab Admin</title>
    <style>
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
            left: -50px;
            width: 150px;
            height: 150px;
            background: url('https://img.icons8.com/ios-filled/50/000000/taxi.png') no-repeat center;
            background-size: 80px;
            opacity: 0.1;
            transform: rotate(-20deg);
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
        }
        .action-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
        }
        .edit-btn {
            background: #2196f3;
            color: #fff;
            margin-right: 10px;
            text-decoration: none;
            display: inline-block;
        }
        .delete-btn {
            background: #d32f2f;
            color: #fff;
        }
        .message {
            padding: 15px;
            margin-bottom: 25px;
            border-radius: 8px;
            font-weight: bold;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .success {
            background: #c8e6c9;
            color: #2e7d32;
            border-left: 5px solid #2e7d32;
        }
        .error {
            background: #ffcdd2;
            color: #c62828;
            border-left: 5px solid #c62828;
        }
        .cab-icon {
            font-size: 1.2em;
        }

        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.6);
            z-index: 1000;
            justify-content: center;
            align-items: center;
        }
        .modal-content {
            background: #fff;
            padding: 25px;
            border-radius: 10px;
            width: 90%;
            max-width: 400px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
            animation: slideIn 0.3s ease-out;
        }
        @keyframes slideIn {
            from {
                transform: translateY(-50px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }
        .modal-header {
            color: #d32f2f;
            font-size: 1.5em;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .modal-body {
            color: #555;
            margin-bottom: 20px;
            line-height: 1.5;
        }
        .modal-footer {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }
        .modal-btn {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            transition: all 0.3s ease;
        }
        .cancel-btn {
            background: #f5f5f5;
            color: #666;
        }
        .confirm-btn {
            background: #d32f2f;
            color: #fff;
            text-decoration: none;
            display: inline-block;
            text-align: center;
        }
        .modal-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
        }
    </style>
</head>
<body>

    <%@include file="component/adminNavbar.jsp" %>

    <div class="container">
        <h2>Registered Cab Users</h2>

        <%-- Display success or error message --%>
        <%
            String successMsg = (String) session.getAttribute("successMsg");
            String errorMsg = (String) session.getAttribute("errorMsg");
            if (successMsg != null) {
        %>
            <div class="message success"><span class="cab-icon">✔</span> <%= successMsg %></div>
        <%
                session.removeAttribute("successMsg");
            }
            if (errorMsg != null) {
        %>
            <div class="message error"><span class="cab-icon">✘</span> <%= errorMsg %></div>
        <%
                session.removeAttribute("errorMsg");
            }
        %>

        <table>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Address</th>
                <th>NIC</th>
                <th>Email</th>
                <th>Actions</th>
            </tr>
            
            <%
                UserDAO userDao = new UserDAO(DbConnect.getConn());
                List<User> userList = userDao.getAllUsers();
                
                for (User u : userList) {
            %>
            <tr>
                <td><%= u.getID() %></td>
                <td><%= u.getName() %></td>
                <td><%= u.getAddress() %></td>
                <td><%= u.getNIC() %></td>
                <td><%= u.getemail() %></td>
                <td>
                    <a href="editUser.jsp?id=<%= u.getID() %>" class="action-btn edit-btn">Edit</a>
                    <button class="action-btn delete-btn" onclick="showModal('<%= u.getID() %>', '<%= u.getName() %>')">Delete</button>
                </td>
            </tr>
            <% } %>
        </table>
    </div>

    <div id="deleteModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <span> Confirm Deletion</span>
            </div>
            <div class="modal-body">
                Are you sure you want to delete user "<span id="userName"></span>" (ID: <span id="userId"></span>)
            </div>
            <div class="modal-footer">
                <button class="modal-btn cancel-btn" onclick="hideModal()">Cancel</button>
                <a id="confirmDeleteLink" href="#" class="modal-btn confirm-btn">Delete</a>
            </div>
        </div>
    </div>
    <script>
        
    function getElement(id) {
        const element = document.getElementById(id);
        if (!element) {
            console.error(`Element with ID '${id}' not found`);
        }
        return element;
    }

    function showModal(userId, userName) {
        try {
            const userIdElement = getElement('userId');
            const userNameElement = getElement('userName');
            const confirmDeleteLink = getElement('confirmDeleteLink');
            const deleteModal = getElement('deleteModal');

            if (!userIdElement || !userNameElement || !confirmDeleteLink || !deleteModal) {
                throw new Error('Required modal elements not found');
            }

            if (!userId || typeof userId !== 'string' || !userName || typeof userName !== 'string') {
                throw new Error('Invalid userId or userName');
            }

            userIdElement.textContent = userId.trim();
            userNameElement.textContent = userName.trim();
            
            confirmDeleteLink.href = 'DeleteUserServlet?id=' + encodeURIComponent(userId.trim());
            
            deleteModal.style.opacity = '0';
            deleteModal.style.display = 'flex';
            deleteModal.offsetHeight;
            deleteModal.style.opacity = '1';
            deleteModal.style.transition = 'opacity 0.2s ease-in';
        } catch (error) {
            console.error('Error in showModal:', error.message);

            alert('An error occurred while trying to show the delete confirmation');
        }
    }

    function hideModal() {
        try {
            const deleteModal = getElement('deleteModal');
            if (deleteModal) {

                deleteModal.style.opacity = '0';
                deleteModal.style.transition = 'opacity 0.2s ease-out';
                

                setTimeout(() => {
                    deleteModal.style.display = 'none';

                    deleteModal.style.opacity = '1';
                }, 200); 
            }
        } catch (error) {
            console.error('Error in hideModal:', error.message);
        }
    }

    window.addEventListener('click', function(event) {
        try {
            const deleteModal = getElement('deleteModal');
            if (deleteModal && event.target === deleteModal) {
                hideModal();
            }
        } catch (error) {
            console.error('Error in window click handler:', error.message);
        }
    });
    document.addEventListener('keydown', function(event) {
        try {
            const deleteModal = getElement('deleteModal');
            if (deleteModal && deleteModal.style.display === 'flex' && event.key === 'Escape') {
                hideModal();
            }
        } catch (error) {
            console.error('Error in keydown handler:', error.message);
        }
    });
</script>

</body>
</html>