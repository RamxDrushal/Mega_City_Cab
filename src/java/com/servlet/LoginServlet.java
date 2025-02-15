/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.servlet;

import com.conn.DbConnect;
import com.dao.UserDAO;
import com.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 *
 * @author ramsh
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String pass = req.getParameter("password");
        
        //System.out.println(email + " " + pass);
        UserDAO dao = new UserDAO(DbConnect.getConn());
        User u=dao.loginUser(email, pass);
        HttpSession session=req.getSession();
        if(u!=null){
            session.setAttribute("user",u);
            resp.sendRedirect("index.jsp");
            //System.out.println("User Is Availble"+u);
        } else{
            session.setAttribute("invalidMsg","Invalid Email & Password");
            resp.sendRedirect("login.jsp");
            //System.out.println("User Is not Availble"+u);
        }
    }
    
}
