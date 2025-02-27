// DriverDAO.java
package com.dao;

import com.entity.driver;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class DriverDAO {
    private Connection conn;

    public DriverDAO(Connection conn) {
        super();
        this.conn = conn;
    }

    public int getDriverCount() {
        int count = 0;
        try {
            String sql = "SELECT COUNT(*) FROM driver";
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

    public List<driver> getAllDrivers() {
        List<driver> drivers = new ArrayList<>();
        try {
            String sql = "SELECT * FROM driver";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                driver driver = new driver();
                driver.setId(rs.getInt("id"));
                driver.setName(rs.getString("name"));
                driver.setCarModel(rs.getString("car_model"));
                driver.setVehicleNumber(rs.getString("vehicle_number"));
                drivers.add(driver);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return drivers;
    }
}