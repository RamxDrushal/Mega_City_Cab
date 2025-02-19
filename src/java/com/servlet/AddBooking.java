/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
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
        int userid =Integer.parseInt(req.getParameter("userid"));
        String name=req.getParameter("name");
        String email=req.getParameter("email");
        String address=req.getParameter("address");
        String phno=req.getParameter("phno");
        String start=req.getParameter("start");
        String end=req.getParameter("end");
        String about=req.getParameter("about");
        String amount=req.getParameter("amount");
        
        Booking c= new Booking(name, email, address, phno, start, end, about, amount, userid);
        BookingDAO dao=new BookingDAO(DbConnect.getConn());
        
        HttpSession session=req.getSession();
        boolean f = dao.saveBooking(c);
        if(f) {
            session.setAttribute("succMsg", "Your Booking added Successfully..");
            resp.sendRedirect("AddBooking.jsp");
        } else {
            session.setAttribute("failedMsg", "Your Booking Failed..");
            resp.sendRedirect("AddBooking.java");
        }
    }
}
