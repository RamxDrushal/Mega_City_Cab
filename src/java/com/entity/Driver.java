package com.entity;

public class Driver {
    private int id;
    private String name;
    private String carModel;
    private String vehicleNumber;

    public Driver() {
        super();
    }

    public Driver(String name, String carModel, String vehicleNumber) {
        this.name = name;
        this.carModel = carModel;
        this.vehicleNumber = vehicleNumber;
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
}