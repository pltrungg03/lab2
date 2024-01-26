
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import model.CommentBlog;

/**
 *
 * @author 84338
 */
public class CommentBlogDAO extends DBContext {

    public List<CommentBlog> getCommentsByBlogId(int id) {
        BlogDAO bDAO = new BlogDAO();
        AccountDAO aDAO = new AccountDAO();
        String sql = "select * from CommentBlog where blog_id = ? order by created_date desc";
        List<CommentBlog> list = new ArrayList();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new CommentBlog(rs.getInt("id"),
                        bDAO.getBlogById(rs.getInt("blog_id")),
                        aDAO.getAccountById(rs.getInt("account_id")),
                        rs.getString("content"),
                        rs.getString("created_date"),
                        rs.getInt("parent_id")));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public static void main(String[] args) {
        CommentBlogDAO cmdb = new CommentBlogDAO();
        for (CommentBlog c : cmdb.getCommentsByBlogId(1)) {
            System.out.println(c);
        }
    }

    public void deleteAllCommentsOfBlogById(int blogId) {
        String sql = "DELETE FROM [dbo].[CommentBlog]\n"
                + "      WHERE blog_id = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, blogId);
            st.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public void addAComentInBlog(int blogId, int accountId, String content, String parentId) {
        String sql = "INSERT INTO [dbo].[CommentBlog]\n"
                + "           ([blog_id]\n"
                + "           ,[account_id]\n"
                + "           ,[content]\n"
                + "           ,[created_date], [parent_id])\n"
                + "     VALUES\n"
                + "           (?,?,?,?,?)";
        LocalDate currentDate = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String createdDate = currentDate.format(formatter);
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, blogId);
            st.setInt(2, accountId);
            st.setString(3, content);
            st.setString(4, createdDate);
            if (parentId == null) {
                st.setNull(5, Types.INTEGER);
            } else {
                st.setInt(5, Integer.parseInt(parentId));
            }
            st.executeUpdate();
        } catch (Exception e) {
        }
    }

    public void updateCommentBlogById(int id, String content) {
        String sql = "UPDATE [dbo].[CommentBlog]\n"
                + "SET \n"
                + "     \n"
                + "      [content] = ?, [created_date] = ?   \n"
                + " WHERE id = ?";
        LocalDate currentDate = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String createdDate = currentDate.format(formatter);
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, content);
            st.setInt(3, id);
            st.setString(2, createdDate);
            st.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public CommentBlog getCommentByCommentBlogId(String id) {
        BlogDAO bDAO = new BlogDAO();
        AccountDAO aDAO = new AccountDAO();
        String sql = "select * from CommentBlog where id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                CommentBlog cmt = new CommentBlog(rs.getInt("id"),
                        bDAO.getBlogById(rs.getInt("blog_id")),
                        aDAO.getAccountById(rs.getInt("account_id")),
                        rs.getString("content"),
                        rs.getString("created_date"),
                        rs.getInt("parent_id"));
                return cmt;
            }
        } catch (Exception e) {
        }
        return null;
    }

    public void removeCommentBlogById(int id) {
        String sql = "DELETE FROM [dbo].[CommentBlog]\n"
                + "      WHERE id = ? or parent_id = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);

            st.setInt(1, id);
            st.setInt(2, id);
            st.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public List<CommentBlog> getAllCommentsBlog() {
        List<CommentBlog> list = new ArrayList<>();
        String sql = "select * from CommentBlog order by id desc";
        BlogDAO bDAO = new BlogDAO();
        AccountDAO aDAO = new AccountDAO();
        try {
            PreparedStatement st = connection.prepareCall(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new CommentBlog(rs.getInt("id"),
                        bDAO.getBlogById(rs.getInt("blog_id")),
                        aDAO.getAccountById(rs.getInt("account_id")),
                        rs.getString("content"),
                        rs.getString("created_date"), rs.getInt("parent_id")));
            }
        } catch (Exception e) {
        }
        return list;
    }
    
    public List<CommentBlog> getFilterCommentsBlog(String from, String to, String blogname, String check[]) {
        List<CommentBlog> list = new ArrayList<>();
        String sql = "select c.*, b.title from CommentBlog c, Blog b where c.blog_id = b.id ";
        if (check != null && check.length > 0) {
            String temp = "and c.content IN (select content from CommentBlog where content like";
            for (String s : check) {
                temp += " '%";
                temp += s;
                temp += "%' or  content like\n";
            }
            temp += "'')";
            sql += temp;
        }
        BlogDAO bDAO = new BlogDAO();
        AccountDAO aDAO = new AccountDAO();
        if (from != null && from.trim().length() > 0) {
            sql += " and c.created_date >= '" + from + "'";
        }
        if (to != null && to.trim().length() > 0) {
            sql += " and c.created_date <= '" + to + "'";
        }
        if (blogname != null && blogname.trim().length() > 0) {
            sql += " and b.title like '%" + blogname + "%'";
        }
        sql += " order by id desc";
        System.out.println(sql);
        try {
            PreparedStatement st = connection.prepareCall(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new CommentBlog(rs.getInt("id"),
                        bDAO.getBlogById(rs.getInt("blog_id")),
                        aDAO.getAccountById(rs.getInt("account_id")),
                        rs.getString("content"),
                        rs.getString("created_date"), rs.getInt("parent_id")));
            }
        } catch (Exception e) {
        }
        return list;
    }
}
