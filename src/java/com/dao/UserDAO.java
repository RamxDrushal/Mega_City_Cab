package com.dao;

import com.entity.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    private Connection conn;

    public UserDAO(Connection conn) {
        this.conn = conn;
    }

    public boolean userRegister(User u) {
        boolean f = false;
        try {
            String sql = "INSERT INTO user(name, address, nic, email, password) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, u.getName());
            ps.setString(2, u.getAddress());
            ps.setString(3, u.getNIC());
            ps.setString(4, u.getemail());
            ps.setString(5, u.getpassword());

            int i = ps.executeUpdate();
            if (i == 1) {
                f = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    public User loginUser(String e, String p) {
        User user = null;
        try {
            String sql = "SELECT * FROM user WHERE email=? AND password=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, e);
            ps.setString(2, p);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setemail(rs.getString("email"));
                user.setpassword(rs.getString("password"));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return user;
    }

    public int getUserCount() {
        int count = 0;
        try {
            String sql = "SELECT COUNT(*) FROM user";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }
    
    public List<User> getAllUsers() {
        List<User> userList = new ArrayList<>();
        try {
            String sql = "SELECT * FROM user";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setAddress(rs.getString("address"));
                user.setNIC(rs.getString("nic"));
                user.setemail(rs.getString("email"));
                user.setpassword(rs.getString("password"));

                userList.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return userList;
    }

    public User getUserById(int id) {
        User user = null;
        try {
            String sql = "SELECT * FROM user WHERE id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setAddress(rs.getString("address"));
                user.setNIC(rs.getString("nic"));
                user.setemail(rs.getString("email"));
                user.setpassword(rs.getString("password"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    public boolean updateUser(User u) {
        boolean f = false;
        try {
            String sql = "UPDATE user SET name=?, address=?, nic=?, email=?, password=? WHERE id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, u.getName());
            ps.setString(2, u.getAddress());
            ps.setString(3, u.getNIC());
            ps.setString(4, u.getemail());
            ps.setString(5, u.getpassword());
            ps.setInt(6, u.getID());

            int i = ps.executeUpdate();
            if (i == 1) {
                f = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    public boolean deleteUser(int id) {
        boolean f = false;
        try {
            String sql = "DELETE FROM user WHERE id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);

            int i = ps.executeUpdate();
            if (i == 1) {
                f = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }
}
