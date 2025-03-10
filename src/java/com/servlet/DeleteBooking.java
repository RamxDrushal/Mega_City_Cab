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

@WebServlet("/delete")
public class DeleteBooking extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int cid = Integer.parseInt(req.getParameter("cid"));
        
        BookingDAO dao = new BookingDAO(DbConnect.getConn());
        
        boolean f = dao.deleteBookingById(cid);
        HttpSession session = req.getSession();
        if (f) {
            session.setAttribute("succMsg", "Booking Deleted Successfully..");
            resp.sendRedirect("ManageBooking.jsp");
        } else {
            session.setAttribute("failedMsg", "Something wrong on server..");
            resp.sendRedirect("ManageBooking.jsp");
        }
    }
}