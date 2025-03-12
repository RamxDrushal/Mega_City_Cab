package com.dao;

import com.entity.Booking;
import org.junit.*;
import static org.junit.Assert.*;

import java.sql.*;
import java.util.List;

public class BookingDAOTest {

    private static Connection testConn;
    private BookingDAO bookingDAO;

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
            // Create tables if they don’t exist (for testing purposes)
            try (Statement stmt = testConn.createStatement()) {
                stmt.execute("CREATE TABLE IF NOT EXISTS booking (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY, " +
                    "name VARCHAR(255), " +
                    "email VARCHAR(255), " +
                    "address VARCHAR(255), " +
                    "phno VARCHAR(255), " +
                    "start VARCHAR(255), " +
                    "end VARCHAR(255), " +
                    "about VARCHAR(255), " +
                    "amount VARCHAR(255), " +
                    "userid INT, " +
                    "status VARCHAR(255), " +
                    "driver_id INT, " +
                    "booking_date VARCHAR(255))");
                stmt.execute("CREATE TABLE IF NOT EXISTS driver (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY, " +
                    "name VARCHAR(255), " +
                    "phone_number VARCHAR(255))");
                System.out.println("Booking and driver tables created or verified.");
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
        bookingDAO = new BookingDAO(testConn);
        try (Statement stmt = testConn.createStatement()) {
            stmt.execute("DELETE FROM booking");
            stmt.execute("DELETE FROM driver");
            stmt.execute("ALTER TABLE booking AUTO_INCREMENT = 1");
            stmt.execute("ALTER TABLE driver AUTO_INCREMENT = 1");
            System.out.println("Cleaned up booking and driver tables, reset AUTO_INCREMENT.");
        }
    }

    @After
    public void tearDown() throws SQLException {
        System.out.println("Tear down completed.");
    }

    @Test
    public void testSaveBooking_Successful() throws SQLException {
        System.out.println("Starting testSaveBooking_Successful...");
        Booking booking = new Booking();
        booking.setName("Ramosh Drushal");
        booking.setEmail("ramshsamarawickrama@gmail.com");
        booking.setAddress("11/A WA Peries Road Moratuwa");
        booking.setPhno("0724011543");
        booking.setStart("Bambalapitiya");
        booking.setEnd("Nugegoda");
        booking.setAbout("Test booking");
        booking.setAmount("1200");
        booking.setUserid(1);
        booking.setStatus("Pending");
        booking.setBookingDate("2025-03-12");

        boolean result = bookingDAO.saveBooking(booking);

        System.out.println("Booking save result: " + result);
        assertTrue("Booking should be saved successfully", result);

        try (PreparedStatement ps = testConn.prepareStatement("SELECT * FROM booking WHERE email = ?")) {
            ps.setString(1, "ramshsamarawickrama@gmail.com");
            ResultSet rs = ps.executeQuery();
            assertTrue("Booking should exist in the database", rs.next());
            System.out.println("Booking found in database with name: " + rs.getString("name"));
            assertEquals("Name should match", "Ramosh Drushal", rs.getString("name"));
        }
        System.out.println("testSaveBooking_Successful completed.");
    }

    @Test
    public void testSaveBooking_WithDriverId() throws SQLException {
        System.out.println("Starting testSaveBooking_WithDriverId...");
        try (PreparedStatement ps = testConn.prepareStatement(
                "INSERT INTO driver (name, phone_number) VALUES (?, ?)", Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, "Pubudu Chathuranga");
            ps.setString(2, "0754323456");
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            rs.next();
            int driverId = rs.getInt(1);
            System.out.println("Inserted driver with ID: " + driverId);

            Booking booking = new Booking();
            booking.setName("Ramosh Drushal");
            booking.setEmail("ramshsamarawickrama@gmail.com");
            booking.setAddress("11/A WA Peries Road Moratuwa");
            booking.setPhno("0724011543");
            booking.setStart("Bambalapitiya");
            booking.setEnd("Nugegoda");
            booking.setAbout("Test with driver");
            booking.setAmount("1200");
            booking.setUserid(2);
            booking.setStatus("Accepted");
            booking.setDriverId(driverId);
            booking.setBookingDate("2025-03-13");

            boolean result = bookingDAO.saveBooking(booking);

            System.out.println("Booking save result with driver: " + result);
            assertTrue("Booking with driver should be saved successfully", result);

            try (PreparedStatement ps2 = testConn.prepareStatement("SELECT driver_id FROM booking WHERE email = ?")) {
                ps2.setString(1, "ramshsamarawickrama@gmail.com");
                ResultSet rs2 = ps2.executeQuery();
                assertTrue("Booking should exist", rs2.next());
                System.out.println("Driver ID in booking: " + rs2.getInt("driver_id"));
                assertEquals("Driver ID should match", driverId, rs2.getInt("driver_id"));
            }
        }
        System.out.println("testSaveBooking_WithDriverId completed.");
    }

    @Test
    public void testGetAllContact_Successful() throws SQLException {
        System.out.println("Starting testGetAllContact_Successful...");
        Booking booking1 = new Booking("Ramosh Drushal", "ramshsamarawickrama@gmail.com", "11/A WA Peries Road Moratuwa", "0724011543", "Bambalapitiya", "Nugegoda", "Test Booking", "1200", 1, "Pending", null, null, "2025-03-15");
        Booking booking2 = new Booking("Ramosh Drushal", "ramshsamarawickrama@gmail.com", "256 Temple Road Maharagama", "0754534124", "Bambalapitiya", "Dehiwala", "Test Booking2", "1000", 1, "Accepted", 1, null, "2025-03-13");
        bookingDAO.saveBooking(booking1);
        bookingDAO.saveBooking(booking2);
        System.out.println("Inserted 2 test bookings for user 1.");

        List<Booking> bookings = bookingDAO.getAllContact(1);

        System.out.println("Number of bookings retrieved: " + bookings.size());
        assertEquals("Should return 2 bookings for user 1", 2, bookings.size());
        assertEquals("First booking name should match", "Ramosh Drushal", bookings.get(0).getName());
        assertEquals("Second booking name should match", "Ramosh Drushal", bookings.get(1).getName());
        System.out.println("testGetAllContact_Successful completed.");
    }

    @Test
    public void testGetAllBookings_Successful() throws SQLException {
        System.out.println("Starting testGetAllBookings_Successful...");
        Booking booking1 = new Booking("Ramosh Drushal", "ramshsamarawickrama@gmail.com", "11/A WA Peries Road Moratuwa", "0724011543", "Bambalapitiya", "Nugegoda", "Test Booking", "1200", 1, "Pending", null, null, "2025-03-15");
        Booking booking2 = new Booking("Thanuja Frenando", "thanuja@gmail.com", "256 Temple Road Maharagama", "0754534124", "Bambalapitiya", "Dehiwala", "Test Booking2", "1000", 2, "Accepted", 1, null, "2025-03-13");
        bookingDAO.saveBooking(booking1);
        bookingDAO.saveBooking(booking2);
        System.out.println("Inserted 2 test bookings.");

        List<Booking> bookings = bookingDAO.getAllBookings();

        System.out.println("Total bookings retrieved: " + bookings.size());
        assertEquals("Should return all 2 bookings", 2, bookings.size());
        assertEquals("First booking email should match", "ramshsamarawickrama@gmail.com", bookings.get(0).getEmail());
        assertEquals("Second booking email should match", "thanuja@gmail.com", bookings.get(1).getEmail());
        System.out.println("testGetAllBookings_Successful completed.");
    }

    @Test
    public void testGetContactById_Successful() throws SQLException {
        System.out.println("Starting testGetContactById_Successful...");
        Booking booking = new Booking("Ramosh Drushal", "ramshsamarawickrama@gmail.com", "11/A WA Peries Road Moratuwa", "0724011543", "Bambalapitiya", "Nugegoda", "Test Booking", "1200", 1, "Pending", null, null, "2025-03-15");
        bookingDAO.saveBooking(booking);
        System.out.println("Inserted test booking.");

        try (PreparedStatement ps = testConn.prepareStatement("SELECT id FROM booking WHERE email = ?")) {
            ps.setString(1, "ramshsamarawickrama@gmail.com");
            ResultSet rs = ps.executeQuery();
            rs.next();
            int bookingId = rs.getInt("id");
            System.out.println("Retrieved booking ID: " + bookingId);
            
            Booking retrievedBooking = bookingDAO.getContactById(bookingId);

            System.out.println("Retrieved booking name: " + retrievedBooking.getName());
            assertNotNull("Booking should be retrieved", retrievedBooking);
            assertEquals("Name should match", "Ramosh Drushal", retrievedBooking.getName());
            assertEquals("Email should match", "ramshsamarawickrama@gmail.com", retrievedBooking.getEmail());
        }
        System.out.println("testGetContactById_Successful completed.");
    }

    @Test
    public void testUpdateBooking_Successful() throws SQLException {
        System.out.println("Starting testUpdateBooking_Successful...");
        Booking booking = new Booking("Ramosh Drushal", "ramshsamarawickrama@gmail.com", "11/A WA Peries Road Moratuwa", "0724011543", "Bambalapitiya", "Nugegoda", "Test Booking", "1200", 1, "Pending", null, null, "2025-03-15");
        bookingDAO.saveBooking(booking);
        System.out.println("Inserted booking with old details.");

        try (PreparedStatement ps = testConn.prepareStatement("SELECT id FROM booking WHERE email = ?")) {
            ps.setString(1, "ramshsamarawickrama@gmail.com");
            ResultSet rs = ps.executeQuery();
            rs.next();
            int bookingId = rs.getInt("id");
            System.out.println("Retrieved booking ID: " + bookingId);

            booking.setId(bookingId);
            booking.setName("Ramosh Samarawickrama");
            booking.setEmail("ramshsamarawickrama20000@gmail.com");

            boolean result = bookingDAO.updateBooking(booking);

            System.out.println("Update booking result: " + result);
            assertTrue("Booking should be updated successfully", result);

            Booking updatedBooking = bookingDAO.getContactById(bookingId);
            System.out.println("Updated booking name: " + updatedBooking.getName());
            assertEquals("Updated name should match", "Ramosh Samarawickrama", updatedBooking.getName());
            assertEquals("Updated email should match", "ramshsamarawickrama20000@gmail.com", updatedBooking.getEmail());
        }
        System.out.println("testUpdateBooking_Successful completed.");
    }

    @Test
    public void testUpdateBookingStatus_Successful() throws SQLException {
        System.out.println("Starting testUpdateBookingStatus_Successful...");
        Booking booking = new Booking("Ramosh Drushal", "ramshsamarawickrama@gmail.com", "11/A WA Peries Road Moratuwa", "0724011543", "Bambalapitiya", "Nugegoda", "Test Booking", "1200", 1, "Pending", null, null, "2025-03-15");
        bookingDAO.saveBooking(booking);
        System.out.println("Inserted test booking.");

        try (PreparedStatement ps = testConn.prepareStatement("SELECT id FROM booking WHERE email = ?")) {
            ps.setString(1, "ramshsamarawickrama@gmail.com");
            ResultSet rs = ps.executeQuery();
            rs.next();
            int bookingId = rs.getInt("id");
            System.out.println("Retrieved booking ID: " + bookingId);

            boolean result = bookingDAO.updateBookingStatus(bookingId, "Accepted", 1);

            System.out.println("Update status result: " + result);
            assertTrue("Booking status should be updated successfully", result);

            Booking updatedBooking = bookingDAO.getContactById(bookingId);
            System.out.println("Updated status: " + updatedBooking.getStatus() + ", Driver ID: " + updatedBooking.getDriverId());
            assertEquals("Status should be updated", "Accepted", updatedBooking.getStatus());
            assertEquals("Driver ID should match", Integer.valueOf(1), updatedBooking.getDriverId());
        }
        System.out.println("testUpdateBookingStatus_Successful completed.");
    }

    @Test
    public void testDeleteBookingById_Successful() throws SQLException {
        System.out.println("Starting testDeleteBookingById_Successful...");
        Booking booking = new Booking("Ramosh Drushal", "ramshsamarawickrama@gmail.com", "11/A WA Peries Road Moratuwa", "0724011543", "Bambalapitiya", "Nugegoda", "Test Booking", "1200", 1, "Pending", null, null, "2025-03-15");
        bookingDAO.saveBooking(booking);
        System.out.println("Inserted booking to delete.");

        try (PreparedStatement ps = testConn.prepareStatement("SELECT id FROM booking WHERE email = ?")) {
            ps.setString(1, "ramshsamarawickrama@gmail.com");
            ResultSet rs = ps.executeQuery();
            rs.next();
            int bookingId = rs.getInt("id");
            System.out.println("Retrieved booking ID: " + bookingId);
            
            boolean result = bookingDAO.deleteBookingById(bookingId);
            
            System.out.println("Delete booking result: " + result);
            assertTrue("Booking should be deleted successfully", result);
            
            Booking deletedBooking = bookingDAO.getContactById(bookingId);
            System.out.println("Deleted booking name (should be null): " + deletedBooking.getName());
            assertEquals("Deleted booking should have no name", null, deletedBooking.getName());
        }
        System.out.println("testDeleteBookingById_Successful completed.");
    }
    
    @Test
    public void testGetTotalBookingAmount_Successful() throws SQLException {
        System.out.println("Starting testGetTotalBookingAmount_Successful...");
        Booking booking1 = new Booking("Ramosh Drushal", "ramshsamarawickrama@gmail.com", "11/A WA Peries Road Moratuwa", "0724011543", "Bambalapitiya", "Nugegoda", "Test Booking", "1200", 1, "Pending", null, null, "2025-03-15");
        Booking booking2 = new Booking("Thanuja Frenando", "thanuja@gmail.com", "256 Sethsiri place Maharagama", "0713456765", "Bambalapitiya", "Dehiwala", "Test Booking1", "1000", 2, "Accepted", 1, null, "2025-03-12");
        bookingDAO.saveBooking(booking1);
        bookingDAO.saveBooking(booking2);
        System.out.println("Inserted 2 bookings with amounts 1200 and 1000.");

        double totalAmount = bookingDAO.getTotalBookingAmount();

        System.out.println("Total booking amount: " + totalAmount);
        assertEquals("Total amount should match", 2200.0, totalAmount, 0.01);
        System.out.println("testGetTotalBookingAmount_Successful completed.");
    }   
    
    @Test
    public void testGetDriverDetailsByDriverId_Successful() throws SQLException {
        System.out.println("Starting testGetDriverDetailsByDriverId_Successful...");
        try (PreparedStatement ps = testConn.prepareStatement(
                "INSERT INTO driver (name, phone_number) VALUES (?, ?)", Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, "Pubudu Chathuranga");
            ps.setString(2, "0754323456");
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            rs.next();
            int driverId = rs.getInt(1);
            System.out.println("Inserted driver with ID: " + driverId);
                
            String[] driverDetails = bookingDAO.getDriverDetailsByDriverId(driverId);
                
            System.out.println("Driver details - Name: " + driverDetails[0] + ", Phone: " + driverDetails[1]);
            assertNotNull("Driver details should not be null", driverDetails);
            assertEquals("Driver name should match", "Pubudu Chathuranga", driverDetails[0]);
            assertEquals("Driver phone should match", "0754323456", driverDetails[1]);
        }
        System.out.println("testGetDriverDetailsByDriverId_Successful completed.");
    }

    @Test
    public void testGetDriverNameByDriverId_Successful() throws SQLException {
        System.out.println("Starting testGetDriverNameByDriverId_Successful...");
        try (PreparedStatement ps = testConn.prepareStatement(
                "INSERT INTO driver (name, phone_number) VALUES (?, ?)", Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, "Pubudu Chathuranga");
            ps.setString(2, "0754323456");
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            rs.next();
            int driverId = rs.getInt(1);
            System.out.println("Inserted driver with ID: " + driverId);

            String driverName = bookingDAO.getDriverNameByDriverId(driverId);

            System.out.println("Retrieved driver name: " + driverName);
            assertEquals("Driver name should match", "Pubudu Chathuranga", driverName);
        }
        System.out.println("testGetDriverNameByDriverId_Successful completed.");
    }

    @Test
    public void testGetBookingById_Successful() throws SQLException {
        System.out.println("Starting testGetBookingById_Successful...");
        Booking booking = new Booking("Ramosh Drushal", "ramshsamarawickrama@gmail.com", "11/A WA Peries Road Moratuwa", "0724011543", "Bambalapitiya", "Nugegoda", "Test Booking", "1200", 1, "Pending", null, null, "2025-03-15");
        bookingDAO.saveBooking(booking);
        System.out.println("Inserted test booking.");

        try (PreparedStatement ps = testConn.prepareStatement("SELECT id FROM booking WHERE email = ?")) {
            ps.setString(1, "ramshsamarawickrama@gmail.com");
            ResultSet rs = ps.executeQuery();
            rs.next();
            int bookingId = rs.getInt("id");
            System.out.println("Retrieved booking ID: " + bookingId);

            Booking retrievedBooking = bookingDAO.getBookingById(bookingId);

            System.out.println("Retrieved booking name: " + retrievedBooking.getName());
            assertNotNull("Booking should be retrieved", retrievedBooking);
            assertEquals("Name should match", "Ramosh Drushal", retrievedBooking.getName());
            assertEquals("Email should match", "ramshsamarawickrama@gmail.com", retrievedBooking.getEmail());
        }
        System.out.println("testGetBookingById_Successful completed.");
    }
}