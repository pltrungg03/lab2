package model;

public class Blog {
    private int id;
    private String title;
    private String thumbnail;
    private String content;
    private String createdDate;

    public Account creator;

    public Blog() {
    }

    public Blog(int id, String createdDate, String content, Account creator) {
        this.id = id;
        this.createdDate = createdDate;
        this.content = content;
        this.creator = creator;
    }

    public Blog(int id, String createdDate, String content, Account creator, String title, String thumbnail) {
        this.id = id;
        this.createdDate = createdDate;
        this.content = content;
        this.creator = creator;
        this.title = title;
        this.thumbnail = thumbnail;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(String createdDate) {
        this.createdDate = createdDate;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Account getCreator() {
        return creator;
    }

    public void setCreator(Account creator) {
        this.creator = creator;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }    

    public String getThumbnail() {
        return thumbnail;
    }

    public void setThumbnail(String thumbnail) {
        this.thumbnail = thumbnail;
    }
    
    @Override
    public String toString() {
        return "Blog{" + "id=" + id + ", createdDate=" + createdDate + ", content=" + content + ", creator=" + creator + '}';
    }
}
