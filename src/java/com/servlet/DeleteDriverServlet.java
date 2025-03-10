package com.servlet;

import com.conn.DbConnect;
import com.dao.DriverDAO;
import com.dao.BookingDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.PreparedStatement;

@WebServlet("/DeleteDriverServlet")
public class DeleteDriverServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        try {
            int id = Integer.parseInt(request.getParameter("id"));

            
            BookingDAO bookingDao = new BookingDAO(DbConnect.getConn());
            String sql = "UPDATE booking SET driver_id = NULL WHERE driver_id = ?";
            PreparedStatement ps = DbConnect.getConn().prepareStatement(sql);
            ps.setInt(1, id);
            int rowsUpdated = ps.executeUpdate();
            ps.close();

            
            System.out.println("Updated " + rowsUpdated + " bookings by setting driver_id to NULL for driver ID: " + id);

            
            DriverDAO driverDao = new DriverDAO(DbConnect.getConn());
            boolean driverDeleted = driverDao.deleteDriver(id); 

            if (driverDeleted) {
                session.setAttribute("succMsg", "Driver Deleted Successfully..");
            } else {
                session.setAttribute("failedMsg", "Failed to Delete Driver.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("failedMsg", "Error Deleting Driver: " + e.getMessage());
        }
        response.sendRedirect("adminManageDrivers.jsp");
    }
}