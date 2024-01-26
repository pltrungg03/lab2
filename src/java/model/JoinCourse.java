package model;

import java.sql.Date;

public class JoinCourse {

    private int courseId;
    private int stars;
    private int accountId;

    private Date joinedDate;

    private boolean isPassed;

    public JoinCourse() {
    }

    public JoinCourse(int courseId, int stars, int accountId, Date joinedDate, boolean isPassed) {
        this.courseId = courseId;
        this.stars = stars;
        this.accountId = accountId;
        this.joinedDate = joinedDate;
        this.isPassed = isPassed;
    }


    public int getStars() {
        return stars;
    }

    public void setStars(int stars) {
        this.stars = stars;
    }

    public int getCourseId() {
        return courseId;
    }

    public void setCourseId(int courseId) {
        this.courseId = courseId;
    }

    public int getAccountId() {
        return accountId;
    }

    public void setAccountId(int accountId) {
        this.accountId = accountId;
    }

    public Date getJoinedDate() {
        return joinedDate;
    }

    public void setJoinedDate(Date joinedDate) {
        this.joinedDate = joinedDate;
    }

    public boolean isPassed() {
        return isPassed;
    }

    public void setPassed(boolean passed) {
        isPassed = passed;
    }
}
