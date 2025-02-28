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

@WebServlet("/EditDriverServlet")
public class EditDriverServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String carModel = request.getParameter("carModel");
        String vehicleNumber = request.getParameter("vehicleNumber");

        driver driver = new driver(name, carModel, vehicleNumber);
        driver.setId(id);
        
        DriverDAO dao = new DriverDAO(DbConnect.getConn());
        dao.updateDriver(driver); // Add this method to DriverDAO
        
        response.sendRedirect("adminManageDrivers.jsp");
    }
}