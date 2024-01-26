package model;

import com.google.gson.Gson;

import java.math.BigDecimal;
import java.sql.Date;
import java.util.List;

public class Event {

    private int id;
    private int creatorId;

    private String content;

    private double discount;

    private Date createdDate;

    private Date expiredDate;

    private List<Course> courses;

    private Account creator;

    public Event(int id, int creatorId, String content, double discount, Date createdDate, Date expiredDate, Account creator) {
        this.id = id;
        this.creatorId = creatorId;
        this.content = content;
        this.discount = discount;
        this.createdDate = createdDate;
        this.expiredDate = expiredDate;
        this.creator = creator;
    }

    public Account getCreator() {
        return creator;
    }

    public void setCreator(Account creator) {
        this.creator = creator;
    }

    public Event() {
    }

    public Event(int id, int creatorId, String content, double discount, Date createdDate, Date expiredDate) {
        this.id = id;
        this.creatorId = creatorId;
        this.content = content;
        this.discount = discount;
        this.createdDate = createdDate;
        this.expiredDate = expiredDate;
    }


    public List<Course> getCourses() {
        return courses;
    }

    public void setCourses(List<Course> courses) {
        this.courses = courses;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCreatorId() {
        return creatorId;
    }

    public void setCreatorId(int creatorId) {
        this.creatorId = creatorId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public double getDiscount() {
        return discount;
    }

    public void setDiscount(double discount) {
        this.discount = discount;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public Date getExpiredDate() {
        return expiredDate;
    }

    public void setExpiredDate(Date expiredDate) {
        this.expiredDate = expiredDate;
    }

    public int calculateDiscountPercentage() {
        double originalPrice = 0d;
        for (Course course : this.courses){
            originalPrice += course.getPrice();
        }
        return (100 - (int) ((((originalPrice - (this.discount * courses.size())) / originalPrice) * 100) + 0.5)) > 0 ? ((int) (100 - (((originalPrice - (this.discount * courses.size())) / originalPrice) * 100) + 0.5)) : 0;
    }

    public double getOldPrice(){
        double originalPrice = 0d;
        for (Course course : this.courses){
            originalPrice += course.getPrice();
        }
        return  originalPrice;
    }

    public double getSalePrice(){
        double originalPrice = 0d;
        for (Course course : this.courses){
            originalPrice += course.getPrice();
        }
        return  originalPrice - (this.discount * courses.size()) > 0d ? originalPrice - (this.discount * courses.size()) : 0d  ;
    }
}
