# Mega_City_Cab

## Cab Service Web Application

Welcome to **Mega_City_Cab**, a web-based cab service application built using Java technologies. This project provides a user-friendly interface for both users and admins to manage cab bookings, user registrations, driver assignments, and more.

---

## Table of Contents
- [Overview](#overview)
- [Features](#features)
  - [User Side](#user-side)
  - [Admin Side](#admin-side)
- [Technologies Used](#technologies-used)
- [Installation](#installation)
- [Database Setup](#database-setup)
- [Running the Application](#running-the-application)
- [Testing](#testing)
- [Build Tool](#build-tool)
- [Contributing](#contributing)
- [License](#license)

---

## Overview
Mega_City_Cab is a web application designed to facilitate cab booking services. Users can register, log in, book cabs, manage their bookings, and download bills. Admins can manage users, bookings, and drivers, including assigning drivers and updating booking statuses.

---

## Features

### User Side
- **Login/Logout**: Users can log in with a username and password and log out of the system.
- **Registration**: Users can register by providing username, address, NIC, email address, and password.
- **Add Booking**: Users can create bookings by entering name, email address, phone number, booking date, trip start location, trip end location, and notes. The amount is automatically calculated using JavaScript based on the trip locations.
- **Manage Booking**: Users can view, edit, or delete their bookings. Details include name, phone, email, address, amount, booking date, status, driver, driver contact, trip start location, and trip end location.
- **Download Bill**: Users can download a bill for their bookings.

### Admin Side
- **Login/Logout**: Admins can log in and log out of the system.
- **User Management**: Admins can view total registered users, edit user details, or delete users.
- **Booking Management**: Admins can view all bookings, update booking statuses (e.g., accept, pending), and assign drivers.
- **Driver Management**: Admins can view driver information, add new drivers (name, car model, vehicle number, phone number), edit driver details, or delete drivers.
- **Dashboard**: Admins can view total booking amounts and total registered drivers.

---

## Technologies Used
- **Programming Language**: Java
- **Web Technologies**: Servlets, JSP (JavaServer Pages)
- **Build Tool**: Apache Ant
- **Database**: MySQL (managed via MySQL Workbench)
- **Testing Framework**: JUnit
- **Frontend**: HTML, CSS, JavaScript (for dynamic amount calculation)
- **Server**: Apache Tomcat (or any compatible servlet container)

---

## Installation

1. **Clone the Repository**:
   ```bash
   git clone <[repository-url](https://github.com/RamxDrushal/Mega_City_Cab.git)>
   cd Mega_City_Cab
