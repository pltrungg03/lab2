package model;

import java.util.*;

public class Account {
    private int id;
    private String username;
    private String password;
    private String firstName;
    private String lastName;
    private String email;
    private String avatar;
    private String phoneNumber;
    private boolean gender;
    private String country;
    private double wallet;
    private String dob;
    private boolean isAvailable;
    private String createdDate;
    
    //common
    private List<Role> roles;
    private boolean isPremium;
    private String expiredDate;
    
    //grade
    public int score;
    
    public Account() {
    }

    public Account(int id) {
        this.id = id;
    }

    public Account(int id, String username, String password) {
        this.id = id;
        this.username = username;
        this.password = password;
    }
    public boolean isAdmin() {
        for(Role r : roles){
            if(r.getName().equalsIgnoreCase("admin")){
                return true;
            }
        }
        return false;
    }
    public boolean isCourseManager() {
        for(Role r : roles){
            if(r.getId() == 3){
                return true;
            }
        }
        return false;
    }
    public boolean isModerator() {
        for(Role r : roles){
            if(r.getId() == 2){
                return true;
            }
        }
        return false;
    }
    public Account(int id, String username, String password, String firstName, String lastName, String email, String avatar, String phoneNumber, boolean gender, String country, double wallet, String dob, List<Role> roles) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.avatar = avatar;
        this.phoneNumber = phoneNumber;
        this.gender = gender;
        this.country = country;
        this.wallet = wallet;
        this.dob = dob;
        this.roles = roles;
    }

    public Account(int id, String username, String password, String firstName, String lastName, String email, String avatar, String phoneNumber, boolean gender, String country, double wallet, String dob, boolean isAvailable, String createdDate, List<Role> roles) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.avatar = avatar;
        this.phoneNumber = phoneNumber;
        this.gender = gender;
        this.country = country;
        this.wallet = wallet;
        this.dob = dob;
        this.isAvailable = isAvailable;
        this.createdDate = createdDate;
        this.roles = roles;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
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

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public boolean isGender() {
        return gender;
    }

    public void setGender(boolean gender) {
        this.gender = gender;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public double getWallet() {
        return wallet;
    }

    public void setWallet(double wallet) {
        this.wallet = wallet;
    }

    public String getDob() {
        return dob;
    }

    public void setDob(String dob) {
        this.dob = dob;
    }

    public boolean isIsAvailable() {
        return isAvailable;
    }

    public void setIsAvailable(boolean isAvailable) {
        this.isAvailable = isAvailable;
    }

    public String getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(String createdDate) {
        this.createdDate = createdDate;
    }

    public List<Role> getRoles() {
        return roles;
    }

    public void setRoles(List<Role> roles) {
        this.roles = roles;
    }

    public boolean isIsPremium() {
        return isPremium;
    }

    public void setIsPremium(boolean isPremium) {
        this.isPremium = isPremium;
    }

    public String getExpiredDate() {
        return expiredDate;
    }

    public void setExpiredDate(String expiredDate) {
        this.expiredDate = expiredDate;
    }

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }

    @Override
    public String toString() {
        return "Account{" + "id=" + id + ", username=" + username + ", password=" + password + ", firstName=" + firstName + ", lastName=" + lastName + ", email=" + email + ", avatar=" + avatar + ", phoneNumber=" + phoneNumber + ", gender=" + gender + ", country=" + country + ", wallet=" + wallet + ", dob=" + dob + ", roles=" + roles + '}';
    }
    
    
}
