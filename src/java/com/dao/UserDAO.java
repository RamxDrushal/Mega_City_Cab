
package com.dao;
import com.entity.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


public class UserDAO {
        private Connection conn;
        
        public UserDAO(Connection conn){
            super();
            this.conn = conn;
        }
        
        public boolean userRegister(User u)
        {
             boolean f=false;
             
             try {
                 
                 String sql="insert into user(name,address,nic,email,password) values(?,?,?,?,?)";
                 
                 PreparedStatement ps = conn.prepareStatement(sql);
                 ps.setString(1, u.getName());
                 ps.setString(2, u.getAddress());
                 ps.setString(3, u.getNIC());
                 ps.setString(4, u.getemail());
                 ps.setString(5, u.getpassword());
                 
                 int i= ps.executeUpdate();
                 if(i == 1){
                     f = true;
                 }
                 
             } catch (Exception e){
                 e.printStackTrace();
             }
             return f;
        }
        
        public User loginUser(String e,String p)
        {
            User user=null;
            
            try {
                String sql="select * from user where email=? and password=?";
                PreparedStatement ps=conn.prepareStatement(sql);
                ps.setString(1, e);
                ps.setString(2, p);
                          
                ResultSet rs= ps.executeQuery();
                
                while(rs.next())
                {
                    user=new User();
                    user.setId(rs.getInt(1));
                    user.setName(rs.getString(2));
                    user.setemail(rs.getString(5));
                    user.setpassword(rs.getString(6));
                }
                
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            return user;
        }
}
