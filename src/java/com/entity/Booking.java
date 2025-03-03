package com.entity;

public class Booking {
    private int id;
    private String name;
    private String email;
    private String address;
    private String phno;
    private String start;
    private String end;
    private String about;
    private String amount;
    private int userid;
    private String status;
    private Integer driverId; // Store the driver ID (nullable)
    private String driverPhoneNumber;
    private String bookingDate;// New field for driver phone number

    public Booking() {
        super();
    }

    public Booking(String name, String email, String address, String phno, String start, String end, String about, String amount, int userid, String status, Integer driverId, String driverPhoneNumber, String bookingDate) {
        super();
        this.name = name;
        this.email = email;
        this.address = address;
        this.phno = phno;
        this.start = start;
        this.end = end;
        this.about = about;
        this.amount = amount;
        this.userid = userid;
        this.status = status;
        this.driverId = driverId;
        this.driverPhoneNumber = driverPhoneNumber;
        this.bookingDate = bookingDate;
    }

    // Existing getters and setters...
    public int getID() { return id; }
    public void setId(int id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    public String getPhno() { return phno; }
    public void setPhno(String phno) { this.phno = phno; }
    public String getStart() { return start; }
    public void setStart(String start) { this.start = start; }
    public String getEnd() { return end; }
    public void setEnd(String end) { this.end = end; }
    public String getAbout() { return about; }
    public void setAbout(String about) { this.about = about; }
    public String getAmount() { return amount; }
    public void setAmount(String amount) { this.amount = amount; }
    public int getUserid() { return userid; }
    public void setUserid(int userid) { this.userid = userid; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public Integer getDriverId() { return driverId; }
    public void setDriverId(Integer driverId) { this.driverId = driverId; }
    public String getBookingDate() { return bookingDate; }
    public void setBookingDate(String bookingDate) { this.bookingDate = bookingDate; }
    
    // New getter and setter for driver phone number
    public String getDriverPhoneNumber() { return driverPhoneNumber; }
    public void setDriverPhoneNumber(String driverPhoneNumber) { this.driverPhoneNumber = driverPhoneNumber; }
}