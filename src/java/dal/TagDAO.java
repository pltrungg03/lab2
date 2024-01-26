/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Major;
import model.Tag;

/**
 *
 * @author 84338
 */
public class TagDAO extends DBContext {

    public List<Tag> getAllTags() {
        List<Tag> list = new ArrayList<>();
        String query = "SELECT * FROM Tag";
        try {
            PreparedStatement st = connection.prepareStatement(query);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Tag(rs.getInt("id"),
                        rs.getString("name")));
            }
            return list;
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }

    //lay ra cac tag cua 1 blog
    public List<Tag> getTagsOfBlogById(int id) {
        List<Tag> list = new ArrayList<>();
        String sql = "select t.* from TagBlog tb, Tag t\n"
                + "where tb.tag_id = t.id and tb.blog_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Tag(rs.getInt("id"),
                        rs.getString("name")));
            }

        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }

    //lay ra cac tag cua 1 blog
    public List<Integer> getAllTagsIdOfBlogById(int blogId) {
        List<Integer> list = new ArrayList<>();
        String sql = "select tag_id from TagBlog where blog_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, blogId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(rs.getInt("tag_id"));
            }

        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }
}
