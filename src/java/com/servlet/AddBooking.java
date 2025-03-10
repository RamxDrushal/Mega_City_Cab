package com.servlet;

import com.conn.DbConnect;
import com.dao.BookingDAO;
import com.entity.Booking;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/addBooking")
public class AddBooking extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int userid = Integer.parseInt(req.getParameter("userid"));
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String address = req.getParameter("address");
        String phno = req.getParameter("phno");
        String start = req.getParameter("start");
        String end = req.getParameter("end");
        String about = req.getParameter("about");
        String amount = req.getParameter("amount");
        String bookingDate = req.getParameter("bookingDate"); 
        
        Booking c = new Booking(name, email, address, phno, start, end, about, amount, userid, "Pending", null, null, bookingDate);
        BookingDAO dao = new BookingDAO(DbConnect.getConn());
        
        HttpSession session = req.getSession();
        boolean f = dao.saveBooking(c);
        if (f) {
            session.setAttribute("succMsg", "Your Booking added Successfully..");
            resp.sendRedirect("ManageBooking.jsp");
        } else {
            session.setAttribute("failedMsg", "Your Booking Failed..");
            resp.sendRedirect("AddBooking.jsp");
        }
    }
}