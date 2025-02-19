
package com.dao;

import com.entity.Booking;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class BookingDAO {
        
        private Connection conn;
        
        public BookingDAO(Connection conn){
            super();
            this.conn = conn;
        };
        public boolean saveBooking(Booking c)
        {
        boolean f=false;
        try{
            String sql ="insert into booking(name,email,address,phno,start,end,about,amount,userid) values(?,?,?,?,?,?,?,?,?) ";
            PreparedStatement ps=conn.prepareStatement(sql);
            ps.setString(1,c.getName());
            ps.setString(2,c.getEmail());
            ps.setString(3,c.getAddress());
            ps.setString(4,c.getPhno());
            ps.setString(5,c.getStart());
            ps.setString(6,c.getEnd());
            ps.setString(7, c.getAbout());
            ps.setString(8, c.getAmount());
            ps.setInt(9, c.getUserid());
            
            int i=ps.executeUpdate();
            
            if(i==1)
            {
                f=true;
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
        }
}
