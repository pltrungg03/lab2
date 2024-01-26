package model;

import java.util.List;

public class Test {

    private int id;
    private String name;
    private double threshold;

    //common
    private double score;
    private boolean isPassed;
    private String submmitedTime;
    private int minutes;
    
    private List<Quiz> quizzes; 
    
    public Test() {
    }

    public Test(int id, String name, double threshold) {
        this.id = id;
        this.name = name;
        this.threshold = threshold;
    }

    public int getMinutes() {
        return minutes;
    }

    public void setMinutes(int minutes) {
        this.minutes = minutes;
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

    public double getThreshold() {
        return threshold;
    }

    public void setThreshold(double threshold) {
        this.threshold = threshold;
    }

    public double getScore() {
        return score;
    }

    public void setScore(double score) {
        this.score = score;
    }

    public boolean isIsPassed() {
        return isPassed;
    }

    public void setIsPassed(boolean isPassed) {
        this.isPassed = isPassed;
    }

    
    
    public String getSubmmitedTime() {
        return submmitedTime;
    }

    public void setSubmmitedTime(String submmitedTime) {
        this.submmitedTime = submmitedTime;
    }

    public List<Quiz> getQuizzes() {
        return quizzes;
    }

    public void setQuizzes(List<Quiz> quizzes) {
        this.quizzes = quizzes;
    }

   

 
    @Override
    public String toString() {
        return "Test{" + "id=" + id + ", name=" + name + ", threshold=" + threshold + ", score=" + score + ", isPassed=" + isPassed + '}';
    }
}
