package com.dao;

import com.entity.User;
import org.junit.*;
import static org.junit.Assert.*;

import java.sql.*;
import java.util.List;

public class UserDAOTest {

    private static Connection testConn;
    private UserDAO userDAO;

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
            // Create user table if it doesn’t exist (for testing purposes)
            try (Statement stmt = testConn.createStatement()) {
                stmt.execute("CREATE TABLE IF NOT EXISTS user (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY, " +
                    "name VARCHAR(255), " +
                    "address VARCHAR(255), " +
                    "nic VARCHAR(255), " +
                    "email VARCHAR(255), " +
                    "password VARCHAR(255))");
                System.out.println("User table created or verified.");
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
        userDAO = new UserDAO(testConn);
        try (Statement stmt = testConn.createStatement()) {
            stmt.execute("DELETE FROM user");
            stmt.execute("ALTER TABLE user AUTO_INCREMENT = 1");
            System.out.println("Cleaned up user table, reset AUTO_INCREMENT.");
        }
    }

    @After
    public void tearDown() throws SQLException {
        System.out.println("Tear down completed.");
    }

    @Test
    public void testUserRegister_Successful() throws SQLException {
        System.out.println("Starting testUserRegister_Successful...");
        User user = new User();
        user.setName("Ramosh");
        user.setAddress("11/A WA Peries Road Moratuwa");
        user.setNIC("200010904160");
        user.setemail("ramshsamarawickrama@gmail.com");
        user.setpassword("111");

        boolean result = userDAO.userRegister(user);

        System.out.println("User registration result: " + result);
        assertTrue("User should be registered successfully", result);

        try (PreparedStatement ps = testConn.prepareStatement("SELECT * FROM user WHERE email = ?")) {
            ps.setString(1, "ramshsamarawickrama@gmail.com");
            ResultSet rs = ps.executeQuery();
            assertTrue("User should exist in the database", rs.next());
            System.out.println("User found in database with name: " + rs.getString("name"));
            assertEquals("Name should match", "Ramosh", rs.getString("name"));
        }
        System.out.println("testUserRegister_Successful completed.");
    }

    @Test
    public void testLoginUser_Successful() throws SQLException {
        System.out.println("Starting testLoginUser_Successful...");
        User user = new User("Ramosh", "11/A WA Peries Road Moratuwa", "200010904160", "ramshsamarawickrama@gmail.com", "111");
        userDAO.userRegister(user);
        System.out.println("Inserted test user for login.");

        User loggedInUser = userDAO.loginUser("ramshsamarawickrama@gmail.com", "111");

        System.out.println("Logged in user: " + (loggedInUser != null ? loggedInUser.getName() : "null"));
        assertNotNull("User should be retrieved successfully", loggedInUser);
        assertEquals("Email should match", "ramshsamarawickrama@gmail.com", loggedInUser.getemail());
        assertEquals("Name should match", "Ramosh", loggedInUser.getName());
        System.out.println("testLoginUser_Successful completed.");
    }

    @Test
    public void testLoginUser_InvalidCredentials() throws SQLException {
        System.out.println("Starting testLoginUser_InvalidCredentials...");
        User user = new User("Ramosh", "11/A WA Peries Road Moratuwa", "200010904160", "ramshsamarawickrama@gmail.com", "testpass");
        userDAO.userRegister(user);
        System.out.println("Inserted test user for invalid login test.");

        User loggedInUser = userDAO.loginUser("ramshsamarawickrama@gmail.com", "ramx");

        System.out.println("Logged in user with invalid credentials: " + (loggedInUser != null ? loggedInUser.getName() : "null"));
        assertNull("User should not be retrieved with invalid password", loggedInUser);
        System.out.println("testLoginUser_InvalidCredentials completed.");
    }

    @Test
    public void testGetUserCount_Successful() throws SQLException {
        System.out.println("Starting testGetUserCount_Successful...");
        User user1 = new User("Ramosh", "11/A WA Peries Road Moratuwa", "200010904160", "ramshsamarawickrama@gmail.com", "111");
        User user2 = new User("Thanuja", "162, Sethsiri place, Pannipitiya", "200140733501", "thanuja@gmail.com", "222");
        userDAO.userRegister(user1);
        userDAO.userRegister(user2);
        System.out.println("Inserted 2 test users.");

        int userCount = userDAO.getUserCount();

        System.out.println("Total user count: " + userCount);
        assertEquals("Should return 2 users", 2, userCount);
        System.out.println("testGetUserCount_Successful completed.");
    }

    @Test
    public void testGetAllUsers_Successful() throws SQLException {
        System.out.println("Starting testGetAllUsers_Successful...");
        User user1 = new User("Ramosh", "11/A WA Peries Road Moratuwa", "200010904160", "ramshsamarawickrama@gmail.com", "111");
        User user2 = new User("Thanuja", "162, Sethsiri place, Pannipitiya", "200140733501", "thanuja@gmail.com", "222");
        userDAO.userRegister(user1);
        userDAO.userRegister(user2);
        System.out.println("Inserted 2 test users.");

        List<User> users = userDAO.getAllUsers();

        System.out.println("Number of users retrieved: " + users.size());
        assertEquals("Should return 2 users", 2, users.size());
        assertEquals("First user name should match", "Ramosh", users.get(0).getName());
        assertEquals("Second user name should match", "Thanuja", users.get(1).getName());
        System.out.println("testGetAllUsers_Successful completed.");
    }

    @Test
    public void testGetUserById_Successful() throws SQLException {
        System.out.println("Starting testGetUserById_Successful...");
        User user = new User("Ramosh", "11/A WA Peries Road Moratuwa", "200010904160", "ramshsamarawickrama@gmail.com", "111");
        userDAO.userRegister(user);
        System.out.println("Inserted test user.");
        
        try (PreparedStatement ps = testConn.prepareStatement("SELECT id FROM user WHERE email = ?")) {
            ps.setString(1, "ramshsamarawickrama@gmail.com");
            ResultSet rs = ps.executeQuery();
            rs.next();
            int userId = rs.getInt("id");
            System.out.println("Retrieved user ID: " + userId);
            
            User retrievedUser = userDAO.getUserById(userId);

            System.out.println("Retrieved user name: " + retrievedUser.getName());
            assertNotNull("User should be retrieved", retrievedUser);
            assertEquals("Name should match", "Ramosh", retrievedUser.getName());
            assertEquals("Email should match", "ramshsamarawickrama@gmail.com", retrievedUser.getemail());
        }
        System.out.println("testGetUserById_Successful completed.");
    }

    @Test
    public void testUpdateUser_Successful() throws SQLException {
        System.out.println("Starting testUpdateUser_Successful...");
        User user = new User("Ramosh", "11/A WA Peries Road Moratuwa", "200010904160", "ramshsamarawickrama@gmail.com", "111");
        userDAO.userRegister(user);
        System.out.println("Inserted user with old details.");

        try (PreparedStatement ps = testConn.prepareStatement("SELECT id FROM user WHERE email = ?")) {
            ps.setString(1, "ramshsamarawickrama@gmail.com");
            ResultSet rs = ps.executeQuery();
            rs.next();
            int userId = rs.getInt("id");
            System.out.println("Retrieved user ID: " + userId);

            user.setId(userId);
            user.setName("Ramosh Drushal");
            user.setemail("ramshsamarawickrama1@gmail.com");

            boolean result = userDAO.updateUser(user);

            System.out.println("Update user result: " + result);
            assertTrue("User should be updated successfully", result);

            User updatedUser = userDAO.getUserById(userId);
            System.out.println("Updated user name: " + updatedUser.getName());
            assertEquals("Updated name should match", "Ramosh Drushal", updatedUser.getName());
            assertEquals("Updated email should match", "ramshsamarawickrama1@gmail.com", updatedUser.getemail());
        }
        System.out.println("testUpdateUser_Successful completed.");
    }

    @Test
    public void testDeleteUser_Successful() throws SQLException {
        System.out.println("Starting testDeleteUser_Successful...");
        User user = new User("Ramosh", "11/A WA Peries Road Moratuwa", "200010904160", "ramshsamarawickrama@gmail.com", "111");
        userDAO.userRegister(user);
        System.out.println("Inserted user to delete.");

        try (PreparedStatement ps = testConn.prepareStatement("SELECT id FROM user WHERE email = ?")) {
            ps.setString(1, "ramshsamarawickrama@gmail.com");
            ResultSet rs = ps.executeQuery();
            rs.next();
            int userId = rs.getInt("id");
            System.out.println("Retrieved user ID: " + userId);

            boolean result = userDAO.deleteUser(userId);

            System.out.println("Delete user result: " + result);
            assertTrue("User should be deleted successfully", result);

            User deletedUser = userDAO.getUserById(userId);
            System.out.println("Deleted user (should be null): " + deletedUser);
            assertNull("Deleted user should not be found", deletedUser);
        }
        System.out.println("testDeleteUser_Successful completed.");
    }
}