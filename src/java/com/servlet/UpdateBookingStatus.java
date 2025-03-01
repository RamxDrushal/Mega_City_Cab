package com.servlet;

import com.conn.DbConnect;
import com.dao.BookingDAO;
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
        int cid = Integer.parseInt(req.getParameter("cid"));
        String status = req.getParameter("status");
        
        BookingDAO dao = new BookingDAO(DbConnect.getConn());
        boolean f = dao.updateBookingStatus(cid, status);
        
        HttpSession session = req.getSession();
        if (f) {
            session.setAttribute("succMsg", "Booking Status Updated Successfully..");
        } else {
            session.setAttribute("failedMsg", "Failed to Update Booking Status..");
        }
        resp.sendRedirect("adminManageBookings.jsp");
    }
}