/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 *
 * @author 84338
 */
public class TagBlogDAO extends DBContext {

    //le heiu: 30/9 ham nay de insert tat ca tag cua 1 blog
    public void addAllTagsOfBlog(String[] tag, int blogID) {
        for (int i = 0; i < tag.length; i++) {
            addATagOfBlog(Integer.parseInt(tag[i]), blogID);
        }
    }

    //ham nay dung de add 1 tag 1 lan voi blog id vao tagblog
    private void addATagOfBlog(int tagId, int blogID) {
        String sql = "INSERT INTO [dbo].[TagBlog]\n"
                + "           ([blog_id]\n"
                + "           ,[tag_id])\n"
                + "     VALUES\n"
                + "           (?,?)";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, blogID);
            st.setInt(2, tagId);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void removeAllTagBlogOfBlogByBlogId(int blogId) {
        String sql = "DELETE FROM [dbo].[TagBlog]\n"
                + "      WHERE blog_id = ?";
        
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, blogId);
            st.executeUpdate();
        } catch (Exception e) {
        }
    }

}
