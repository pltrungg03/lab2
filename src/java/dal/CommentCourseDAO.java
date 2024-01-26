
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import model.CommentCourse;

/**
 *
 * @author 84338
 */
public class CommentCourseDAO extends DBContext {

    public List<CommentCourse> getCommentsByCourseId(int id) {
        CourseDAO cDao = new CourseDAO();
        AccountDAO aDAO = new AccountDAO();
        String sql = "select * from CourseComment where course_id = ? order by created_date desc";
        List<CommentCourse> list = new ArrayList();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new CommentCourse(rs.getInt("id"),
                        aDAO.getAccountById(rs.getInt("account_id")),
                        cDao.getCourseById(rs.getInt("course_id")),
                        rs.getString("comment"),
                        rs.getString("created_date")));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public static void main(String[] args) {
        CommentCourseDAO cm = new CommentCourseDAO();
        List<CommentCourse> list = cm.getCommentsByCourseId(2);
        for (CommentCourse x : list) {
            System.out.println(x.getComment());
        }
    }

    public void deleteAllCommentsOfCourseById(int id) {
        String sql = "DELETE FROM [dbo].[CourseComment]\n"
                + "      WHERE course_id = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            st.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public void addAComentInCourse(int courseId, int accountId, String comment) {
        String sql = "INSERT INTO [dbo].[CourseComment]\n"
                + "           ([account_id]\n"
                + "           ,[course_id]\n"
                + "           ,[comment]\n"
                + "           ,[created_date])\n"
                + "     VALUES\n"
                + "           (?,?,?,?)";
        LocalDate currentDate = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String createdDate = currentDate.format(formatter);
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, courseId);
            st.setInt(2, accountId);
            st.setString(3, comment);
            st.setString(4, createdDate);
            st.executeUpdate();
        } catch (Exception e) {
        }
    }

    public void updateCommentCourseById(int id, String comment) {
        String sql = "UPDATE [dbo].[CourseComment]\n"
                + "   SET [comment] = ?\n"
                + "      \n"
                + " WHERE id = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, comment);
            st.setInt(2, id);

            st.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public void removeCommentCourseById(int id) {
        String sql = "DELETE FROM [dbo].[CourseComment]\n"
                + "      WHERE id = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);

            st.setInt(1, id);

            st.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public List<CommentCourse> getAllCommentsCourse() {
        CourseDAO cDao = new CourseDAO();
        AccountDAO aDAO = new AccountDAO();
        String sql = "select * from CourseComment";
        List<CommentCourse> list = new ArrayList();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new CommentCourse(rs.getInt("id"),
                        aDAO.getAccountById(rs.getInt("account_id")),
                        cDao.getCourseById(rs.getInt("course_id")),
                        rs.getString("comment"),
                        rs.getString("created_date")));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public List<CommentCourse> filterCommentCourse(String from, String to, String m_id, String l_id, String[] check) {
        CourseDAO cDao = new CourseDAO();
        AccountDAO aDAO = new AccountDAO();
        String sql = "select * from CourseComment cmt, Course c where cmt.course_id = c.id ";
        String tmp = " ";
        if (check != null && check.length > 0) {
            String temp = "and comment IN (select comment from CourseComment where comment like";
            for (String s : check) {
                temp += " '%";
                temp += s;
                temp += "%' or  comment like\n";
            }
            temp += "'')";
            sql += temp;
        }
        if (from != null && from.trim().length() > 0) {
            sql += " and c.created_date >= '" + from + "'";
        }
        if (to != null && to.trim().length() > 0) {
            sql += " and c.created_date >= '" + to + "'";
        }
        if (m_id != null && m_id.trim().length() > 0) {
            tmp = " and major_id in (" + m_id;
            sql += tmp + ")";
        }
        if (l_id != null && l_id.trim().length() > 0) {
            tmp = " and level_id in (" + l_id;
            sql += tmp + ")";
        }
        System.out.println(sql);
        List<CommentCourse> list = new ArrayList();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new CommentCourse(rs.getInt("id"),
                        aDAO.getAccountById(rs.getInt("account_id")),
                        cDao.getCourseById(rs.getInt("course_id")),
                        rs.getString("comment"),
                        rs.getString("created_date")));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public CommentCourse getCommentByCommentCourseId(String id) {
        CourseDAO cDao = new CourseDAO();
        AccountDAO aDAO = new AccountDAO();
        String sql = "select * from CourseComment where id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                CommentCourse c = (new CommentCourse(rs.getInt("id"),
                        aDAO.getAccountById(rs.getInt("account_id")),
                        cDao.getCourseById(rs.getInt("course_id")),
                        rs.getString("comment"),
                        rs.getString("created_date")));
                return c;
            }
        } catch (Exception e) {
        }
        return null;
    }
}
