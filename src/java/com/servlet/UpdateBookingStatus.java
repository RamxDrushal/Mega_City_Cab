package com.servlet;

import com.conn.DbConnect;
import com.dao.BookingDAO;
import com.dao.DriverDAO;
import com.entity.Booking;
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
        BookingDAO dao = new BookingDAO(DbConnect.getConn());
        DriverDAO driverDao = new DriverDAO(DbConnect.getConn());
        
        try {
            int cid = Integer.parseInt(req.getParameter("cid"));
            String status = req.getParameter("status");
            String driverIdStr = req.getParameter("driverId");

            Integer driverId = null;
            String driverPhoneNumber = null;
            if (driverIdStr != null && !driverIdStr.isEmpty() && !driverIdStr.equals("-- Select Driver --")) {
                driverId = Integer.parseInt(driverIdStr);
                boolean driverExists = driverDao.driverExists(driverId);
                if (!driverExists) {
                    session.setAttribute("failedMsg", "Invalid Driver ID: " + driverId);
                    resp.sendRedirect("adminManageBookings.jsp");
                    return;
                }
                
                String[] driverDetails = dao.getDriverDetailsByDriverId(driverId);
                if (driverDetails != null) {
                    driverPhoneNumber = driverDetails[1]; // Phone number
                }
            }

            Booking booking = dao.getContactById(cid);
            if (booking == null) {
                session.setAttribute("failedMsg", "Booking not found..");
                resp.sendRedirect("adminManageBookings.jsp");
                return;
            }

            boolean f = dao.updateBookingStatus(cid, status, driverId);
            if (f && driverId != null) {
                booking.setDriverId(driverId);
                booking.setDriverPhoneNumber(driverPhoneNumber);
                dao.updateBooking(booking); // Update booking with driver phone number
            }
            
            if (f) {
                session.setAttribute("succMsg", "Booking Status Updated Successfully..");
            } else {
                session.setAttribute("failedMsg", "Failed to Update Booking Status: Database Operation Failed.");
            }
        } catch (NumberFormatException e) {
            session.setAttribute("failedMsg", "Invalid Booking or Driver ID: " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("failedMsg", "Failed to Update Booking Status: " + e.getMessage());
        }
        resp.sendRedirect("adminManageBookings.jsp"); // Fixed typo
    }
}