package com.servlet;

import com.dao.DriverDAO;
import com.entity.driver;
import com.conn.DbConnect;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/AddDriverServlet")
public class AddDriverServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        try {
            String name = request.getParameter("name");
            String carModel = request.getParameter("carModel");
            String vehicleNumber = request.getParameter("vehicleNumber");

            driver driver = new driver(name, carModel, vehicleNumber);
            DriverDAO dao = new DriverDAO(DbConnect.getConn());
            
            if (dao.addDriver(driver)) {
                session.setAttribute("succMsg", "Driver Added Successfully");
            } else {
                session.setAttribute("failedMsg", "Failed to Add Driver");
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("failedMsg", "Error Adding Driver: " + e.getMessage());
        }
        response.sendRedirect("adminManageDrivers.jsp");
    }
}