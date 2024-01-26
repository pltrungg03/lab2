package model;

public class Lesson {

    private int id;
    private int order;
    private String name;
    private String videoUrl;
    private String content;

    //common
    public boolean isPassed;

    //child
    private Test test;

    public Lesson() {
    }

    public Lesson(int id, int order, String name, String videoUrl, String content) {
        this.id = id;
        this.order = order;
        this.name = name;
        this.videoUrl = videoUrl;
        this.content = content;
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

    public String getVideoUrl() {
        return videoUrl;
    }

    public void setVideoUrl(String videoUrl) {
        this.videoUrl = videoUrl;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Test getTest() {
        return test;
    }

    public void setTest(Test test) {
        this.test = test;
    }

    public boolean isIsPassed() {
        return isPassed;
    }

    public void setIsPassed(boolean isPassed) {
        this.isPassed = isPassed;
    }

    @Override
    public String toString() {
        return "Lesson{" + "id=" + id + ", name=" + name + ", isPassed=" + isPassed + '}';
    }
}
