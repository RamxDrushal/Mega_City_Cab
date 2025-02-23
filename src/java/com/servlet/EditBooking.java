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

@WebServlet("/update")
public class EditBooking extends HttpServlet {
        
        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        int cid=Integer.parseInt(req.getParameter("cid"));
        String name=req.getParameter("name");
        String email=req.getParameter("email");
        String address=req.getParameter("address");
        String phno=req.getParameter("phno");
        String start=req.getParameter("start");
        String end=req.getParameter("end");
        String about=req.getParameter("about");
        String amount=req.getParameter("amount");
        
        Booking c= new Booking();
        c.setId(cid);
        c.setName(name);
        c.setEmail(email);
        c.setAddress(address);
        c.setPhno(phno);
        c.setStart(start);
        c.setEnd(end);
        c.setAbout(about);
        c.setAmount(amount);
        BookingDAO dao=new BookingDAO(DbConnect.getConn());
        HttpSession session=req.getSession();
        boolean f = dao.updateBooking(c);
        if(f) {
            session.setAttribute("succMsg", "Your Booking Updated..");
            resp.sendRedirect("ManageBooking.jsp");
        } else {
            session.setAttribute("failedMsg", "Your Booking Failed..");
            resp.sendRedirect("editbooking.jsp?cid="+ cid);
        }
        }
}
