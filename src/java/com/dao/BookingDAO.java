package com.dao;

import com.entity.Booking;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {
    private Connection conn;

    public BookingDAO(Connection conn) {
        this.conn = conn;
    }

    public boolean saveBooking(Booking c) {
        boolean f = false;
        try {
            String sql = "insert into booking(name,email,address,phno,start,end,about,amount,userid,status) values(?,?,?,?,?,?,?,?,?,?)";
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
            ps.setString(10, c.getStatus() != null ? c.getStatus() : "Pending"); // Default to "Pending"
            
            int i = ps.executeUpdate();
            if (i == 1) f = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    public List<Booking> getAllContact(int uID) {
        List<Booking> list = new ArrayList<>();
        try {
            String sql = "select * from booking where userid=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, uID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Booking c = new Booking();
                c.setId(rs.getInt(1));
                c.setName(rs.getString(2));
                c.setEmail(rs.getString(3));
                c.setAddress(rs.getString(4));
                c.setPhno(rs.getString(5));
                c.setStart(rs.getString(6));
                c.setEnd(rs.getString(7));
                c.setAbout(rs.getString(8));
                c.setAmount(rs.getString(9));
                c.setUserid(rs.getInt(10));
                c.setStatus(rs.getString(11)); // Fetch status
                list.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Booking> getAllBookings() {
        List<Booking> list = new ArrayList<>();
        try {
            String sql = "select * from booking";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Booking c = new Booking();
                c.setId(rs.getInt(1));
                c.setName(rs.getString(2));
                c.setEmail(rs.getString(3));
                c.setAddress(rs.getString(4));
                c.setPhno(rs.getString(5));
                c.setStart(rs.getString(6));
                c.setEnd(rs.getString(7));
                c.setAbout(rs.getString(8));
                c.setAmount(rs.getString(9));
                c.setUserid(rs.getInt(10));
                c.setStatus(rs.getString(11)); // Fetch status
                list.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Booking getContactById(int cid) {
        Booking c = new Booking();
        try {
            PreparedStatement ps = conn.prepareStatement("select * from booking where id=?");
            ps.setInt(1, cid);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                c.setId(rs.getInt(1));
                c.setName(rs.getString(2));
                c.setEmail(rs.getString(3));
                c.setAddress(rs.getString(4));
                c.setPhno(rs.getString(5));
                c.setStart(rs.getString(6));
                c.setEnd(rs.getString(7));
                c.setAbout(rs.getString(8));
                c.setAmount(rs.getString(9));
                c.setUserid(rs.getInt(10));
                c.setStatus(rs.getString(11)); // Fetch status
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return c;
    }

    public boolean updateBooking(Booking c) {
        boolean f = false;
        try {
            String sql = "update booking set name=?,email=?,address=?,phno=?,start=?,end=?,about=?,amount=?,status=? where id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, c.getName());
            ps.setString(2, c.getEmail());
            ps.setString(3, c.getAddress());
            ps.setString(4, c.getPhno());
            ps.setString(5, c.getStart());
            ps.setString(6, c.getEnd());
            ps.setString(7, c.getAbout());
            ps.setString(8, c.getAmount());
            ps.setString(9, c.getStatus());
            ps.setInt(10, c.getID());
            int i = ps.executeUpdate();
            if (i == 1) f = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    public boolean updateBookingStatus(int id, String status) {
        boolean f = false;
        try {
            String sql = "update booking set status=? where id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, status);
            ps.setInt(2, id);
            int i = ps.executeUpdate();
            if (i == 1) f = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    public boolean deleteBookingById(int id) {
        boolean f = false;
        try {
            String sql = "delete from booking where id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            int i = ps.executeUpdate();
            if (i == 1) f = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    public double getTotalBookingAmount() {
        double totalAmount = 0.0;
        try {
            String sql = "SELECT SUM(CAST(amount AS DOUBLE)) FROM booking";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                totalAmount = rs.getDouble(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return totalAmount;
    }
}