package com.dao;

import com.entity.Booking;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet; // Added missing import
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {
    private Connection conn;
    
    public BookingDAO(Connection conn){
        super();
        this.conn = conn;
    }
    
    public boolean saveBooking(Booking c) {
        boolean f = false;
        try {
            String sql = "insert into booking(name,email,address,phno,start,end,about,amount,userid) values(?,?,?,?,?,?,?,?,?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, c.getName());
            ps.setString(2, c.getEmail());
            ps.setString(3, c.getAddress());
            ps.setString(4, c.getPhno());
            ps.setString(5, c.getStart());
            ps.setString(6, c.getEnd());
            ps.setString(7, c.getAbout());
            ps.setString(8, c.getAmount());
            ps.setInt(9, c.getUserid());
            
            int i = ps.executeUpdate();
            
            if(i == 1) {
                f = true;
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }
    
    public List<Booking> getAllContact(int uID) {
        List<Booking> list = new ArrayList<Booking>();
        Booking c = null;
        try {
            String sql = "select * from booking where userid=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, uID);
            
            ResultSet rs = ps.executeQuery();
            
            while(rs.next()) {
                c = new Booking();
                c.setId(rs.getInt(1));
                c.setName(rs.getString(2));
                c.setEmail(rs.getString(3));
                c.setAddress(rs.getString(4));
                c.setPhno(rs.getString(5));
                c.setStart(rs.getString(6));
                c.setEnd(rs.getString(7));
                c.setAbout(rs.getString(8));
                c.setAmount(rs.getString(9));
                list.add(c);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }          
        return list;
    }
    
    public Booking getContactById(int cid)
    {
        Booking c= new Booking();
        try {
            PreparedStatement ps=conn.prepareStatement("select * from booking where id=?");
            ps.setInt(1, cid);
            
            ResultSet rs =ps.executeQuery();
            
            while(rs.next())
            {
                c.setId(rs.getInt(1));
                c.setName(rs.getString(2));
                c.setEmail(rs.getString(3));
                c.setAddress(rs.getString(4));
                c.setPhno(rs.getString(5));
                c.setStart(rs.getString(6));
                c.setEnd(rs.getString(7));
                c.setAbout(rs.getString(8));
                c.setAmount(rs.getString(9));
                
            }
                
        } catch (Exception e){
            e.printStackTrace();
        }
        
        return c;
    }
    public boolean updateBooking(Booking c)
    {
        boolean f = false;
        try {
            String sql = "update booking set name=?,email=?,address=?,phno=?,start=?,end=?,about=?,amount=? where id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, c.getName());
            ps.setString(2, c.getEmail());
            ps.setString(3, c.getAddress());
            ps.setString(4, c.getPhno());
            ps.setString(5, c.getStart());
            ps.setString(6, c.getEnd());
            ps.setString(7, c.getAbout());
            ps.setString(8, c.getAmount());
            ps.setInt(9, c.getID());
            
            int i = ps.executeUpdate();
            
            if(i == 1) {
                f = true;
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }
    
    public boolean deleteBookingById(int id)
    {
        boolean f=false;
        try {
            String sql="delete from booking where id=?";
            PreparedStatement ps=conn.prepareStatement(sql);
            ps.setInt(1, id);
            int i = ps.executeUpdate();
            if (i == 1) {
                f=true;
            }
        
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }
            
}