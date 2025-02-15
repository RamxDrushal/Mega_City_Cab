package com.conn;

import java.sql.Connection;
import java.sql.DriverManager;

public class DbConnect {
    private static Connection conn;
    public static void main(String[] args){
        getConn();
    }
    public static Connection getConn()
    {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/megacitycab","root","RootPassword1");
            System.out.println(conn);
            
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }
}
