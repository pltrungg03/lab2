package model;

public class CommentCourse {
    public int id;
    public Account account;
    public Course course;
    public String comment;
    public String createdDate;

    public CommentCourse() {
    }

    public CommentCourse(int id, Account account, Course course, String comment, String createdDate) {
        this.id = id;
        this.account = account;
        this.course = course;
        this.comment = comment;
        this.createdDate = createdDate;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Account getAccount() {
        return account;
    }

    public void setAccount(Account account) {
        this.account = account;
    }

    public Course getCourse() {
        return course;
    }

    public void setCourse(Course course) {
        this.course = course;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public String getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(String createdDate) {
        this.createdDate = createdDate;
    }

    @Override
    public String toString() {
        return "CommentCourse{" + "id=" + id + ", account=" + account + ", course=" + course + ", comment=" + comment + ", createdDate=" + createdDate + '}';
    }

    

    
}
