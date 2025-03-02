package com.servlet;

import com.conn.DbConnect;
import com.dao.BookingDAO;
import com.dao.DriverDAO;
import com.entity.driver;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/updateStatus")
public class UpdateBookingStatus extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        try {
            int cid = Integer.parseInt(req.getParameter("cid"));
            String status = req.getParameter("status");
            String driverIdStr = req.getParameter("driverId");

            Integer driverId = null;
            if (driverIdStr != null && !driverIdStr.isEmpty() && !driverIdStr.equals("-- Select Driver --")) {
                driverId = Integer.parseInt(driverIdStr);
                // Validate driverId exists in the driver table
                DriverDAO driverDao = new DriverDAO(DbConnect.getConn());
                boolean driverExists = driverDao.driverExists(driverId);
                if (!driverExists) {
                    session.setAttribute("failedMsg", "Invalid Driver ID: " + driverId);
                    resp.sendRedirect("adminManageBooking.jsp");
                    return;
                }
            }

            BookingDAO dao = new BookingDAO(DbConnect.getConn());
            boolean f = dao.updateBookingStatus(cid, status, driverId);
            
            if (f) {
                session.setAttribute("succMsg", "Booking Status Updated Successfully..");
            } else {
                session.setAttribute("failedMsg", "Failed to Update Booking Status: Database Operation Failed.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("failedMsg", "Failed to Update Booking Status: " + e.getMessage());
        }
        resp.sendRedirect("adminManageBookings.jsp");
    }
}