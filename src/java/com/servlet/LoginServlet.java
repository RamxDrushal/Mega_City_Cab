package com.servlet;

import com.conn.DbConnect;
import com.dao.UserDAO;
import com.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String pass = req.getParameter("password");

        HttpSession session = req.getSession();

        if (email.equals("admin@example.com") && pass.equals("admin123")) {
            session.setAttribute("admin", "true");
            resp.sendRedirect("AdminViewDashboard.jsp");
            return;
        }

        UserDAO dao = new UserDAO(DbConnect.getConn());
        User u = dao.loginUser(email, pass);

        if (u != null) {
            session.setAttribute("user", u);
            resp.sendRedirect("index.jsp");
        } else {
            session.setAttribute("invalidMsg", "Invalid Email & Password");
            resp.sendRedirect("login.jsp");
        }
    }
}
