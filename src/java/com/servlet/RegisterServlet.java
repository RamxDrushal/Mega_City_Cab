
package com.servlet;

import com.conn.DbConnect;
import com.dao.UserDAO;
import com.entity.User;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
        public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException
        {
            String name=request.getParameter("name");
            String Address=request.getParameter("Address");
            String NIC=request.getParameter("NIC");
            String email=request.getParameter("email");
            String password=request.getParameter("password");
            
            User u=new User(name,Address,NIC,email,password);
            
            UserDAO dao=new UserDAO(DbConnect.getConn());
            boolean f=dao.userRegister(u);
            
            HttpSession session=request.getSession();
            if(f){
                session.setAttribute("sucssMsg", "User Registered Successfully.");
                response.sendRedirect("rejister.jsp");
                
            }else {
                session.setAttribute("errorMsg", "Something wrong on Server");
                response.sendRedirect("rejister.jsp");
                
            }
        }
        
}
