package model;

import java.util.List;

public class Course {

    private int id;
    private String name;
    private double price;
    private double discount;
    private String image;
    private String description;
    private String createdDate;
    private String updatedDate;

    //
    private Major major;
    private Level level;
    private Account creator;

    //common
    private int studentNumber; //display course's participants
    private double avgRating; //display average rating
    private boolean isPassed;
    private String joinedDate;
    private String passedDate;

    //child
    private List<Chapter> chapters;
    private List<Account> students;

    public Course() {
    }


    public Course(int id, String name, double price, double discount, String image, String description, String createdDate, String updateDate, Major major, Level level, Account creator, int studentNumber, double avgRating, boolean isPassed, String joinedDate, List<Chapter> chapters, List<Account> students) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.discount = discount;
        this.image = image;
        this.description = description;
        this.createdDate = createdDate;
        this.updatedDate = updateDate;
        
        this.major = major;
        this.level = level;
        this.creator = creator;
        
        this.studentNumber = studentNumber;
        this.avgRating = avgRating;
        this.isPassed = isPassed;
        this.joinedDate = joinedDate;
        
        this.chapters = chapters;
        this.students = students;
    }    
    
    
    
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

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public double getDiscount() {
        return discount;
    }

    public void setDiscount(double discount) {
        this.discount = discount;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(String createdDate) {
        this.createdDate = createdDate;
    }

    public String getUpdateDate() {
        return updatedDate;
    }

    public void setUpdateDate(String updatedDate) {
        this.updatedDate = updatedDate;
    }

    public Major getMajor() {
        return major;
    }

    public void setMajor(Major major) {
        this.major = major;
    }

    public Level getLevel() {
        return level;
    }

    public void setLevel(Level level) {
        this.level = level;
    }

    public Account getCreator() {
        return creator;
    }

    public void setCreator(Account creator) {
        this.creator = creator;
    }

    public int getStudentNumber() {
        return studentNumber;
    }

    public void setStudentNumber(int studentNumber) {
        this.studentNumber = studentNumber;
    }

    public double getAvgRating() {
        return avgRating;
    }

    public void setAvgRating(double avgRating) {
        this.avgRating = avgRating;
    }

    public boolean isIsPassed() {
        return isPassed;
    }

    public void setIsPassed(boolean isPassed) {
        this.isPassed = isPassed;
    }

    public String getJoinedDate() {
        return joinedDate;
    }

    public void setJoinedDate(String joinedDate) {
        this.joinedDate = joinedDate;
    }

    public List<Chapter> getChapters() {
        return chapters;
    }

    public void setChapters(List<Chapter> chapters) {
        this.chapters = chapters;
    }

    public List<Account> getStudents() {
        return students;
    }

    public void setStudents(List<Account> students) {
        this.students = students;
    }

    public String getUpdatedDate() {
        return updatedDate;
    }

    public void setUpdatedDate(String updatedDate) {
        this.updatedDate = updatedDate;
    }

    public String getPassedDate() {
        return passedDate;
    }

    public void setPassedDate(String passedDate) {
        this.passedDate = passedDate;
    }
    
    

    @Override
    public String toString() {
        return "Course{" + "id=" + id + ", name=" + name + ", price=" + price + ", image=" + image + ", description=" + description + ", createdDate=" + createdDate + ", major=" + major + ", level=" + level + ", creator=" + creator + ", avgRating=" + avgRating + ", isPassed=" + isPassed + ", joinedDate=" + joinedDate + '}';
    }

}
