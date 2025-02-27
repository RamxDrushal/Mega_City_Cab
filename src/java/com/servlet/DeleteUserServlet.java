package com.servlet;

import com.dao.UserDAO;
import com.conn.DbConnect;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/DeleteUserServlet")
public class DeleteUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        try {
            int userId = Integer.parseInt(request.getParameter("id"));

            UserDAO userDao = new UserDAO(DbConnect.getConn());
            boolean deleted = userDao.deleteUser(userId);

            if (deleted) {
                session.setAttribute("successMsg", "User deleted successfully");
                response.sendRedirect("adminManageUsers.jsp");
            } else {
                session.setAttribute("errorMsg", "Failed to delete user");
                response.sendRedirect("adminManageUsers.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMsg", "Something went wrong");
            response.sendRedirect("adminManageUsers.jsp");
        }
    }
}