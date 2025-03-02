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

@WebServlet("/EditDriverServlet")
public class EditDriverServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String carModel = request.getParameter("carModel");
            String vehicleNumber = request.getParameter("vehicleNumber");
            String phoneNumber = request.getParameter("phoneNumber");

            driver driver = new driver(name, carModel, vehicleNumber, phoneNumber);
            driver.setId(id);
            
            DriverDAO dao = new DriverDAO(DbConnect.getConn());
            if (dao.updateDriver(driver)) {
                session.setAttribute("succMsg", "Driver Updated Successfully");
            } else {
                session.setAttribute("failedMsg", "Failed to Update Driver");
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("failedMsg", "Error Updating Driver: " + e.getMessage());
        }
        response.sendRedirect("adminManageDrivers.jsp");
    }
}