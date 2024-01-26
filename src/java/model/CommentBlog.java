package model;

public class CommentBlog {
    private int id;
    private Blog blog;
    private Account account;
    private String content;
    private String createdDate;
    private int parentId;

    public CommentBlog() {
    }

    public CommentBlog(int id, Blog blog, Account account, String content, String commentDate) {
        this.id = id;
        this.blog = blog;
        this.account = account;
        this.content = content;
        this.createdDate = commentDate;
    }

    public CommentBlog(int id, Blog blog, Account account, String content, String createdDate, int parentId) {
        this.id = id;
        this.blog = blog;
        this.account = account;
        this.content = content;
        this.createdDate = createdDate;
        this.parentId = parentId;
    }

    
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Blog getBlog() {
        return blog;
    }

    public void setBlog(Blog blog) {
        this.blog = blog;
    }

    public Account getAccount() {
        return account;
    }

    public void setAccount(Account account) {
        this.account = account;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(String createdDate) {
        this.createdDate = createdDate;
    }

    public int getParentId() {
        return parentId;
    }

    public void setParentId(int parentId) {
        this.parentId = parentId;
    }
    
    

}
