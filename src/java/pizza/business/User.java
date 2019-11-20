/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pizza.business;

/**
 *
 * @author mycomputer
 */
public class User {
    
    private int userID;
    private String firstName;
    private String lastName;
    private String password;
    private String email;
    private String phone;
    private String street;
    private String bldType;
    private String bldNum;
    private String city;
    private String state;
    private String zipCode;
    private String country;
    private String salt;
    
    public User() {
        password = null;
    }
    public User(String firstName,
                String lastName,
                String password,
                String email,
                String phone,
                String street,
                String bldType,
                String bldNum,
                String city,
                String state,
                String zipCode,
                String salt) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.password = password;
        this.email = email;
        this.phone = phone;
        this.street = street;
        this.bldType = bldType;
        this.bldNum = bldNum;
        this.city = city;
        this.state = state;
        this.zipCode = zipCode;
        this.salt = salt;
    }
    public User(String firstName,
                String email,
                String street,
                String bldType,
                String bldNum,
                String city,
                String state,
                String zipCode) {
        this.firstName = firstName;
        this.email = email;
        this.street = street;
        this.bldType = bldType;
        this.bldNum = bldNum;
        this.city = city;
        this.state = state;
        this.zipCode = zipCode;
    }

    public String getSalt() {
        return salt;
    }

    public void setSalt(String salt) {
        this.salt = salt;
    }
    
    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }
    
    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getStreet() {
        return street;
    }

    public void setStreet(String street) {
        this.street = street;
    }

    public String getBldType() {
        return bldType;
    }

    public void setBldType(String bldType) {
        this.bldType = bldType;
    }

    public String getBldNum() {
        return bldNum;
    }

    public void setBldNum(String bldNum) {
        this.bldNum = bldNum;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getZipCode() {
        return zipCode;
    }

    public void setZipCode(String zipCode) {
        this.zipCode = zipCode;
    }
    
    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }
    
    public String getAddress() {
        return getStreet() + " " +
               getCity() + ", " +
               getState() + " " +
               getZipCode();
    }
}
