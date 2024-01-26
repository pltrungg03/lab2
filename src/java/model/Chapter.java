package model;

import java.util.*;

public class Chapter {

    private int id;
    private int order;
    private String name;

    //common
    private boolean isPassed;

    //child
    private List<Lesson> lessons;

    public Chapter() {
    }

    public Chapter(int id, int order, String name, List<Lesson> lessons) {
        this.id = id;
        this.order = order;
        this.name = name;
        this.lessons = lessons;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getOrder() {
        return order;
    }

    public void setOrder(int order) {
        this.order = order;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public boolean isIsPassed() {
        return isPassed;
    }

    public void setIsPassed(boolean isPassed) {
        this.isPassed = isPassed;
    }

    public List<Lesson> getLessons() {
        return lessons;
    }

    public void setLessons(List<Lesson> lessons) {
        this.lessons = lessons;
    }

    @Override
    public String toString() {
        return "Chapter{" + "id=" + id + ", order=" + order + ", name=" + name + ", isPassed=" + isPassed + ", lessons=" + lessons + '}';
    }

}
