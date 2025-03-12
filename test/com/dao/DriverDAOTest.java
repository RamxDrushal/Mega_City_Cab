package com.dao;

import com.entity.driver;
import org.junit.*;
import static org.junit.Assert.*;

import java.sql.*;
import java.util.List;

public class DriverDAOTest {

    private static Connection testConn;
    private DriverDAO driverDAO;

    @BeforeClass
    public static void setUpClass() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            testConn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/megacitycab_test", 
                "root", 
                "RootPassword1"
            );
            System.out.println("Database connection established successfully to megacitycab_test.");
            // Create driver table if it doesn’t exist (for testing purposes)
            try (Statement stmt = testConn.createStatement()) {
                stmt.execute("CREATE TABLE IF NOT EXISTS driver (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY, " +
                    "name VARCHAR(255), " +
                    "car_model VARCHAR(255), " +
                    "vehicle_number VARCHAR(255), " +
                    "phone_number VARCHAR(255))");
                System.out.println("Driver table created or verified.");
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to connect to the test database: " + e.getMessage());
        }
    }

    @AfterClass
    public static void tearDownClass() throws SQLException {
        if (testConn != null && !testConn.isClosed()) {
            testConn.close();
            System.out.println("Database connection closed.");
        }
    }

    @Before
    public void setUp() throws SQLException {
        driverDAO = new DriverDAO(testConn);
        try (Statement stmt = testConn.createStatement()) {
            stmt.execute("DELETE FROM driver");
            stmt.execute("ALTER TABLE driver AUTO_INCREMENT = 1");
            System.out.println("Cleaned up driver table, reset AUTO_INCREMENT.");
        }
    }

    @After
    public void tearDown() throws SQLException {
        System.out.println("Tear down completed.");
    }

    @Test
    public void testAddDriver_Successful() throws SQLException {
        System.out.println("Starting testAddDriver_Successful...");
        driver driver = new driver();
        driver.setName("Pubudu Chathuranga");
        driver.setCarModel("Toyota Prius");
        driver.setVehicleNumber("ABC-1234");
        driver.setPhoneNumber("0754323456");

        boolean result = driverDAO.addDriver(driver);

        System.out.println("Driver add result: " + result);
        assertTrue("Driver should be added successfully", result);

        try (PreparedStatement ps = testConn.prepareStatement("SELECT * FROM driver WHERE name = ?")) {
            ps.setString(1, "Pubudu Chathuranga");
            ResultSet rs = ps.executeQuery();
            assertTrue("Driver should exist in the database", rs.next());
            System.out.println("Driver found in database with name: " + rs.getString("name"));
            assertEquals("Name should match", "Pubudu Chathuranga", rs.getString("name"));
        }
        System.out.println("testAddDriver_Successful completed.");
    }

    @Test
    public void testGetDriverCount_Successful() throws SQLException {
        System.out.println("Starting testGetDriverCount_Successful...");
        driver driver1 = new driver("Pubudu Chathuranga", "Toyota Prius", "ABC-1234", "0754323456");
        driver driver2 = new driver("Kelum Perera", "Alto", "DEF-9012", "0721256785");
        driverDAO.addDriver(driver1);
        driverDAO.addDriver(driver2);
        System.out.println("Inserted 2 test drivers.");

        int driverCount = driverDAO.getDriverCount();

        System.out.println("Total driver count: " + driverCount);
        assertEquals("Should return 2 drivers", 2, driverCount);
        System.out.println("testGetDriverCount_Successful completed.");
    }

    @Test
    public void testGetAllDrivers_Successful() throws SQLException {
        System.out.println("Starting testGetAllDrivers_Successful...");
        driver driver1 = new driver("Pubudu Chathuranga", "Toyota Prius", "ABC-1234", "0754323456");
        driver driver2 = new driver("Kelum Perera", "Alto", "DEF-9012", "0721256785");
        driverDAO.addDriver(driver1);
        driverDAO.addDriver(driver2);
        System.out.println("Inserted 2 test drivers.");

        List<driver> drivers = driverDAO.getAllDrivers();

        System.out.println("Number of drivers retrieved: " + drivers.size());
        assertEquals("Should return 2 drivers", 2, drivers.size());
        assertEquals("First driver name should match", "Pubudu Chathuranga", drivers.get(0).getName());
        assertEquals("Second driver name should match", "Kelum Perera", drivers.get(1).getName());
        System.out.println("testGetAllDrivers_Successful completed.");
    }

    @Test
    public void testUpdateDriver_Successful() throws SQLException {
        System.out.println("Starting testUpdateDriver_Successful...");
        driver driver = new driver("Pubudu Chathuranga", "Toyota Prius", "ABC-1234", "0754323456");
        driverDAO.addDriver(driver);
        System.out.println("Inserted driver with old details.");

        try (PreparedStatement ps = testConn.prepareStatement("SELECT id FROM driver WHERE name = ?")) {
            ps.setString(1, "Pubudu Chathuranga");
            ResultSet rs = ps.executeQuery();
            rs.next();
            int driverId = rs.getInt("id");
            System.out.println("Retrieved driver ID: " + driverId);

            driver.setId(driverId);
            driver.setName("Pubudu Hasaranga");
            driver.setCarModel("AMW");

            boolean result = driverDAO.updateDriver(driver);

            System.out.println("Update driver result: " + result);
            assertTrue("Driver should be updated successfully", result);

            try (PreparedStatement ps2 = testConn.prepareStatement("SELECT * FROM driver WHERE id = ?")) {
                ps2.setInt(1, driverId);
                ResultSet rs2 = ps2.executeQuery();
                rs2.next();
                System.out.println("Updated driver name: " + rs2.getString("name"));
                assertEquals("Updated name should match", "Pubudu Hasaranga", rs2.getString("name"));
                assertEquals("Updated car model should match", "AMW", rs2.getString("car_model"));
            }
        }
        System.out.println("testUpdateDriver_Successful completed.");
    }

    @Test
    public void testDeleteDriver_Successful() throws SQLException {
        System.out.println("Starting testDeleteDriver_Successful...");
        driver driver = new driver("Pubudu Chathuranga", "Toyota Prius", "ABC-1234", "0754323456");
        driverDAO.addDriver(driver);
        System.out.println("Inserted driver to delete.");

        try (PreparedStatement ps = testConn.prepareStatement("SELECT id FROM driver WHERE name = ?")) {
            ps.setString(1, "Pubudu Chathuranga");
            ResultSet rs = ps.executeQuery();
            rs.next();
            int driverId = rs.getInt("id");
            System.out.println("Retrieved driver ID: " + driverId);

            boolean result = driverDAO.deleteDriver(driverId);

            System.out.println("Delete driver result: " + result);
            assertTrue("Driver should be deleted successfully", result);

            try (PreparedStatement ps2 = testConn.prepareStatement("SELECT * FROM driver WHERE id = ?")) {
                ps2.setInt(1, driverId);
                ResultSet rs2 = ps2.executeQuery();
                System.out.println("Driver exists after deletion: " + rs2.next());
                assertFalse("Driver should not exist after deletion", rs2.next());
            }
        }
        System.out.println("testDeleteDriver_Successful completed.");
    }

    @Test
    public void testDriverExists_Successful() throws SQLException {
        System.out.println("Starting testDriverExists_Successful...");
        driver driver = new driver("Pubudu Chathuranga", "Toyota Prius", "ABC-1234", "0754323456");
        driverDAO.addDriver(driver);
        System.out.println("Inserted driver to check existence.");

        try (PreparedStatement ps = testConn.prepareStatement("SELECT id FROM driver WHERE name = ?")) {
            ps.setString(1, "Pubudu Chathuranga");
            ResultSet rs = ps.executeQuery();
            rs.next();
            int driverId = rs.getInt("id");
            System.out.println("Retrieved driver ID: " + driverId);

            boolean exists = driverDAO.driverExists(driverId);

            System.out.println("Driver exists: " + exists);
            assertTrue("Driver should exist", exists);

            boolean notExists = driverDAO.driverExists(999); // Non-existent ID
            System.out.println("Non-existent driver exists: " + notExists);
            assertFalse("Driver should not exist", notExists);
        }
        System.out.println("testDriverExists_Successful completed.");
    }
}