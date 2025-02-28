package com.servlet;

import com.dao.DriverDAO;
import com.conn.DbConnect;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/DeleteDriverServlet")
public class DeleteDriverServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        
        DriverDAO dao = new DriverDAO(DbConnect.getConn());
        dao.deleteDriver(id); // Add this method to DriverDAO
        
        response.sendRedirect("adminManageDrivers.jsp");
    }
}