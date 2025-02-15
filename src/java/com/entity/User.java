/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.entity;

/**
 *
 * @author ramsh
 */
public class User {
        private int id;
        private String name;
        private String Address;
        private String NIC;
        private String email;
        private String password;
        
        public User(){
            super();
        }
        public User(String name, String Address, String NIC, String email, String password) {
            super();
            this.name = name;
            this.Address = Address;
            this.NIC = NIC;
            this.email = email;
            this.password = password;
        }
        
        public int getID(){
            return id;
        }
        public void setId(int id){
            this.id = id;
        }
        public String getName(){
            return name;
        }
        public void setName(String name){
            this.name = name;
        }
        public String getAddress(){
            return Address;
        }
        public void setAddress(String Address){
            this.Address = Address;
        }
        public String getNIC(){
            return NIC;
        }
        public void setNIC(String NIC){
            this.NIC = NIC;
        }
        public String getemail(){
            return email;
        }
        public void setemail(String email){
            this.email = email;
        }
        public String getpassword(){
            return password;
        }
        public void setpassword(String password){
            this.password = password;
        }
}
