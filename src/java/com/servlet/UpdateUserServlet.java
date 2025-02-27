package com.servlet;

import java.io.IOException;

import com.dao.UserDAO;
import com.conn.DbConnect;
import com.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/UpdateUserServlet")
public class UpdateUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {

            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String address = request.getParameter("address");
            String nic = request.getParameter("nic");
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            User user = new User(name, address, nic, email, password);
            user.setId(id);

            UserDAO userDao = new UserDAO(DbConnect.getConn());
            boolean updated = userDao.updateUser(user);

            if (updated) {
                response.sendRedirect("adminManageUsers.jsp?msg=success");
            } else {
                response.sendRedirect("editUser.jsp?id=" + id + "&msg=error");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("editUser.jsp?msg=error");
        }
    }
}
