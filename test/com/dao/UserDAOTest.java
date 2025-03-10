package com.dao;

import com.entity.User;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import org.junit.*;
import static org.junit.Assert.*;

public class UserDAOTest {
    
    private static Connection testConn;
    private UserDAO userDAO;
    
    // Set up the database connection before all tests
    @BeforeClass
    public static void setUpClass() throws SQLException {
        try {
            // Load the MySQL driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            // Establish connection to the megacitycab database
            testConn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/megacitycab", 
                "root", 
                "RootPassword1"
            );
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to connect to the database: " + e.getMessage());
        }
    }
    
    // Close the database connection after all tests
    @AfterClass
    public static void tearDownClass() throws SQLException {
        if (testConn != null && !testConn.isClosed()) {
            testConn.close();
        }
    }
    
    // Set up before each test
    @Before
    public void setUp() throws SQLException {
        userDAO = new UserDAO(testConn);
        
        // Clean up the user table by deleting test users (based on email prefix)
        try (Statement stmt = testConn.createStatement()) {
            stmt.execute("DELETE FROM user WHERE email LIKE 'testuser%@example.com'");
        }
    }
    
    // Clean up after each test (optional, as @Before handles most cleanup)
    @After
    public void tearDown() throws SQLException {
        // Additional cleanup if needed
    }
    
    @Test
    public void testUserRegister_Successful() throws SQLException {
        // Arrange: Create a new user
        User user = new User();
        user.setName("Drushal Samarawickrama");
        user.setAddress("123 Uyana Road Lunawa");
        user.setNIC("TEST123456");
        user.setemail("drushal@gmail.com");
        user.setpassword("testpass123");
        
        // Act: Register the user
        boolean result = userDAO.userRegister(user);
        
        // Assert: Check if registration was successful
        assertTrue("User registration should be successful", result);
        
        // Verify: Check if the user exists in the database
        User retrievedUser = userDAO.loginUser("drushal@gmail.com", "testpass123");
        assertNotNull("User should exist in database", retrievedUser);
        assertEquals("Names should match", "Drushal Samarawickrama", retrievedUser.getName());
        assertEquals("Emails should match", "drushal@gmail.com", retrievedUser.getemail());
    }
 
}