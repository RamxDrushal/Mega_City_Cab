package com.entity;

public class driver {
    private int id;
    private String name;
    private String carModel;
    private String vehicleNumber;
    private String phoneNumber; // New field

    public driver() {
        super();
    }

    public driver(String name, String carModel, String vehicleNumber, String phoneNumber) {
        this.name = name;
        this.carModel = carModel;
        this.vehicleNumber = vehicleNumber;
        this.phoneNumber = phoneNumber; // Initialize new field
    }

    // Getters and setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCarModel() {
        return carModel;
    }

    public void setCarModel(String carModel) {
        this.carModel = carModel;
    }

    public String getVehicleNumber() {
        return vehicleNumber;
    }

    public void setVehicleNumber(String vehicleNumber) {
        this.vehicleNumber = vehicleNumber;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }
}