package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import model.LessonComment;

public class LessonCommentDAO extends DBContext {

    public void addLessonComment(int accId, int lId, String content, String parentId) {
        String sql = "INSERT INTO [dbo].[LessonComment]\n"
                + "           ([parent_id]\n"
                + "           ,[account_id]\n"
                + "           ,[lesson_id]\n"
                + "           ,[comment]\n"
                + "           ,[created_date])\n"
                + "     VALUES\n"
                + "           (?,?,?,?,?)";
        LocalDate currentDate = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String createdDate = currentDate.format(formatter);
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            if (parentId == null) {
                st.setNull(1, Types.INTEGER);
            } else {
                st.setInt(1, Integer.parseInt(parentId));
            }
            st.setInt(2, accId);
            st.setInt(3, lId);
            st.setString(4, content);
            st.setString(5, createdDate);
            st.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public List<LessonComment> getAllCommentsOfLessonById(int lId) {
        AccountDAO aDAO = new AccountDAO();
        LessonDAO lDAO = new LessonDAO();
        String sql = "select * from LessonComment where lesson_id = ?";
        List<LessonComment> list = new ArrayList();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, lId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                LessonComment l = new LessonComment();
                l.setId(rs.getInt("id"));
                l.setAccount(aDAO.getAccountById(rs.getInt("account_id")));
                l.setComment(rs.getString("comment"));
                l.setCreatedDate(rs.getString("created_date"));
                l.setLesson(lDAO.getLessonsById(lId));
                l.setParentId(rs.getInt("parent_id"));
                list.add(l);
            }

        } catch (SQLException e) {
        }
        return list;
    }

    public List<LessonComment> getAllCommentsLesson() {
        AccountDAO aDAO = new AccountDAO();
        LessonDAO lDAO = new LessonDAO();
        String sql = "select * from LessonComment order by id desc";
        List<LessonComment> list = new ArrayList();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                LessonComment l = new LessonComment();
                l.setId(rs.getInt("id"));
                l.setAccount(aDAO.getAccountById(rs.getInt("account_id")));
                l.setComment(rs.getString("comment"));
                l.setCreatedDate(rs.getString("created_date"));
                l.setLesson(lDAO.getLessonsById(rs.getInt("lesson_id")));
                l.setParentId(rs.getInt("parent_id"));
                list.add(l);
            }

        } catch (SQLException e) {
        }
        return list;
    }

    public List<LessonComment> filterCommentLesson(String from, String to, String[] check) {
        AccountDAO aDAO = new AccountDAO();
        LessonDAO lDAO = new LessonDAO();
        String sql = "select * from LessonComment where 0 = 0 ";
        List<LessonComment> list = new ArrayList();
        if (check != null && check.length > 0) {
            String temp = " and comment IN (select comment from LessonComment where comment like";
            for (String s : check) {
                temp += " '%";
                temp += s;
                temp += "%' or  comment like\n";
            }
            temp += "'')";
            sql += temp;
        }
        if (from != null && from.trim().length() > 0) {
            sql += " and created_date >= '" + from + "'";
        }
        if (to != null && to.trim().length() > 0) {
            sql += " and created_date >= '" + to + "'";
        }
        sql += " order by id desc";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                LessonComment l = new LessonComment();
                l.setId(rs.getInt("id"));
                l.setAccount(aDAO.getAccountById(rs.getInt("account_id")));
                l.setComment(rs.getString("comment"));
                l.setCreatedDate(rs.getString("created_date"));
                l.setLesson(lDAO.getLessonsById(rs.getInt("lesson_id")));
                l.setParentId(rs.getInt("parent_id"));
                list.add(l);
            }

        } catch (SQLException e) {
        }
        return list;
    }

    public static void main(String[] args) {
        LessonCommentDAO lcDAO = new LessonCommentDAO();
        List<LessonComment> list = lcDAO.getAllCommentsOfLessonById(21);
        for (LessonComment i : list) {
            System.out.println(i.getId() + i.getParentId() + i.getComment());
        }
    }

    public void updateLessonComment(int cmId, String content) {
        String sql = "UPDATE [dbo].[LessonComment]\n"
                + "   SET \n"
                + "      [comment] = ?\n"
                + "      ,[created_date] = ?\n"
                + " WHERE id = ?";
        LocalDate currentDate = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String createdDate = currentDate.format(formatter);
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, content);
            st.setString(2, createdDate);
            st.setInt(3, cmId);
            st.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public void deleteLessonComment(int id) {
        String sql = "DELETE FROM [dbo].[LessonComment]\n"
                + "      WHERE id = ? or parent_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            st.setInt(2, id);
            st.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public LessonComment getCommentByLessonCommentId(String id) {
        String sql = "select * from LessonComment where id = ?";
        AccountDAO aDAO = new AccountDAO();
        LessonDAO lDAO = new LessonDAO();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                LessonComment l = new LessonComment();
                l.setId(rs.getInt("id"));
                l.setAccount(aDAO.getAccountById(rs.getInt("account_id")));
                l.setComment(rs.getString("comment"));
                l.setCreatedDate(rs.getString("created_date"));
                l.setLesson(lDAO.getLessonsById(rs.getInt("lesson_id")));
                l.setParentId(rs.getInt("parent_id"));
                return l;
            }

        } catch (SQLException e) {
        }
        return null;
    }
}
