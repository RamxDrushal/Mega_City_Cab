package com.servlet;

import com.dao.DriverDAO;
import com.entity.driver;
import com.conn.DbConnect;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/AddDriverServlet")
public class AddDriverServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String carModel = request.getParameter("carModel");
        String vehicleNumber = request.getParameter("vehicleNumber");

        driver driver = new driver(name, carModel, vehicleNumber);
        DriverDAO dao = new DriverDAO(DbConnect.getConn());
        
        // Add this method to DriverDAO
        dao.addDriver(driver);
        
        response.sendRedirect("adminManageDrivers.jsp");
    }
}