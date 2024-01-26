package dal;

import java.sql.*;
import java.util.*;
import model.*;

public class ChapterDAO extends DBContext {

    public List<Chapter> getChaptersByCourseId(int courseId) {
        LessonDAO ldb = new LessonDAO();
        String sql = "SELECT * FROM [Chapter] WHERE course_id = " + courseId;
        List<Chapter> list = new ArrayList();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Chapter(rs.getInt("id"),
                        rs.getInt("order"),
                        rs.getString("name"),
                        ldb.getLessonsByChapterId(rs.getInt("id"))));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public Chapter getChaptersById(int id) {
        LessonDAO lDAO = new LessonDAO();
        String sql = "select * from Chapter where id = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Chapter c = new Chapter();
                c.setId(rs.getInt("id"));
                c.setOrder(rs.getInt("order"));
                c.setName(rs.getString("name"));
                c.setLessons(lDAO.getLessonsByChapterId(id));
                return c;
            }
        } catch (Exception e) {
        }
        return null;
    }

    public void insertChaptersByCourseId(int courseId, String[] chaptersOrder, String[] chaptersName) {
        if (chaptersOrder == null || chaptersName == null) {
            return;
        }
        for (int i = 0; i < chaptersOrder.length; i++) {
            if (chaptersOrder[i] != null && chaptersName[i] != null
                    && chaptersOrder[i].length() > 0 && chaptersName[i].length() > 0) {
                insertChapterByCourseId(courseId, chaptersOrder[i], chaptersName[i]);
            }
        }
    }

    public void insertChapterByCourseId(int courseId, String chapterOrder, String chapterName) {
        String query = "INSERT INTO [Chapter] VALUES\n"
                + "(?, ?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(query);
            st.setInt(1, courseId);
            st.setInt(2, Integer.parseInt(chapterOrder));
            st.setString(3, chapterName);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void updateChaptersByCourseId(int courseId, String[] chaptersId, String[] chaptersOrder, String[] chaptersName) {
        // remove old chapters
//        removeChaptersByCourseId(courseId);

        // update
        if (chaptersOrder == null || chaptersName == null) {
            return;
        } else {
            for (int i = 0; i < chaptersOrder.length; i++) {
                if (chaptersId[i] == null || chaptersId[i].isEmpty()) {
                    System.out.println("Chapter id is null, redirect to insert chapte!");
                    if (chaptersOrder[i] != null && chaptersName[i] != null && !chaptersOrder[i].isEmpty() && !chaptersName[i].isEmpty()) {
                        insertChapterByCourseId(courseId, chaptersOrder[i], chaptersName[i]);
                    } else {
                        System.out.println("Wrong input");
                    }
                } else {
                    updateChapter(chaptersId[i], chaptersOrder[i], chaptersName[i]);
                }
            }
        }
    }

    public void updateChapter(String chapterId, String chapterOrder, String chapterName) {
        String query = "UPDATE [Chapter] "
                + "SET [order] = ?, [name] = ? "
                + "WHERE [id] = ?;";

        try {
            PreparedStatement st = connection.prepareStatement(query);
            st.setString(1, chapterOrder);
            st.setString(2, chapterName);
            st.setString(3, chapterId);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public int getChapterIdByCourseId(int courseId) {
        String sql = "SELECT * FROM Chapter ch\n"
                + "WHERE ch.course_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, courseId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt("id");
            }
        } catch (Exception e) {
        }
        return -1;
    }

    public void removeJoinChaptersByChapterId(int chapterId) {
        String query = "DELETE FROM JoinChapter WHERE chapter_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(query);
            st.setInt(1, chapterId);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void removeChaptersByCourseId(int courseId) {
        LessonDAO ldb = new LessonDAO();
        ChapterDAO chdb = new ChapterDAO();
        int chapterId = chdb.getChapterIdByCourseId(courseId);

        // Remove all chapter references
        if (chapterId > 0) {
            ldb.removeLessonByChapterId(chapterId);
            chdb.removeJoinChaptersByChapterId(chapterId);
        }
        String query = "DELETE FROM Chapter WHERE course_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(query);
            st.setInt(1, courseId);
            st.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void removeChapterByChapterId(int chapterId) {
        LessonDAO ldb = new LessonDAO();
        ChapterDAO chdb = new ChapterDAO();

        ldb.removeLessonByChapterId(chapterId);
        chdb.removeJoinChaptersByChapterId(chapterId);

        String query = "DELETE FROM Chapter WHERE id = ?";

        try {
            PreparedStatement st = connection.prepareStatement(query);
            st.setInt(1, chapterId);
            st.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    //le hieu
    public List<Chapter> getChaptersByCourseIdIncludeCheckingDone(int courseId, int accId) {
        LessonDAO ldb = new LessonDAO();
        String sql = "SELECT * FROM [Chapter] WHERE course_id = " + courseId;
        List<Chapter> list = new ArrayList();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Chapter c = new Chapter();
                c.setId(rs.getInt("id"));
                c.setOrder(rs.getInt("order"));
                c.setName(rs.getString("name"));
                c.setLessons(ldb.getLessonsByChapterIdIncludeCheckDone(rs.getInt("id"), accId));
                if (checkingDone1Chapter(rs.getInt("id"), accId)) {
                    updateDone1ChapterByAccountId(accId, rs.getInt("id"));
                    c.setIsPassed(true);
                } else {
                    c.setIsPassed(false);
                }
                list.add(c);
            }
        } catch (SQLException e) {
        }
        return list;
    }

    private void updateDone1ChapterByAccountId(int accId, int chapId) {
        String sql = "UPDATE [dbo].[JoinChapter]\n"
                + "   SET \n"
                + "      [is_passed] = 1\n"
                + " WHERE [account_id] = ?\n"
                + "      and [chapter_id] = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, accId);
            st.setInt(2, chapId);
            st.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public Chapter getChapterByIdIncludeCheckingDone(int accId, int chapID) {
        LessonDAO lDAO = new LessonDAO();
        String sql = "select * from Chapter where id = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, chapID);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Chapter c = new Chapter();
                c.setId(rs.getInt("id"));
                c.setOrder(rs.getInt("order"));
                c.setName(rs.getString("name"));
                c.setLessons(lDAO.getLessonsByChapterIdIncludeCheckDone(rs.getInt("id"), accId));
                if (checkingDone1Chapter(rs.getInt("id"), accId)) {
                    updateStatusOfChapter(chapID, accId, true);
                    c.setIsPassed(true);
                } else {
                    updateStatusOfChapter(chapID, accId, false);
                    c.setIsPassed(false);
                }
                return c;
            }
        } catch (SQLException e) {
        }
        return null;
    }

    private boolean checkingDone1Chapter(int chapId, int accId) {
        LessonDAO lDAO = new LessonDAO();
        int numberLessonsOf1Chapter = lDAO.countLessonIn1Chapter(chapId);
        int numberLessonUserPassed = lDAO.countLessonDoneIn1ChapterOfAccount(chapId, accId);

        if (numberLessonsOf1Chapter == numberLessonUserPassed) {
            return true;//hoc het lesson 1 chapter
        }
        return false;
    }

    private boolean checkJoinChapter(int accId, int chapId) {
        String sql = "select * from JoinChapter where account_id = ? and chapter_id = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, accId);
            st.setInt(2, chapId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return true;
            }
            return false;
        } catch (SQLException e) {
        }
        return false;
    }

    public void addJoinChapter(int accId, int chapId) {
        boolean check = checkJoinChapter(accId, chapId);
        if (!check) {
            String sql = "INSERT INTO [dbo].[JoinChapter]\n"
                    + "           ([account_id]\n"
                    + "           ,[chapter_id]\n"
                    + "           ,[is_passed])\n"
                    + "     VALUES\n"
                    + "           (?,?,0)";
            try {
                PreparedStatement st = connection.prepareStatement(sql);
                st.setInt(1, accId);
                st.setInt(2, chapId);
                st.executeUpdate();
            } catch (SQLException e) {
            }
        }
    }

    public int countChapterIn1Course(int courseId) {
        String sql = "select count(id) as num from Chapter where course_id = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, courseId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt("num");
            }
        } catch (SQLException e) {
        }
        return 0;
    }

    public int countChapterDoneIn1CourseByIdAndAccountId(int cId, int accId) {
        String sql = "select count(jc.account_id) as [num] from JoinChapter jc join Chapter c\n"
                + "on jc.chapter_id = c.id and c.course_id = ? and jc.account_id = ?\n"
                + "and jc.is_passed = 1";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, cId);
            st.setInt(2, accId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt("num");
            }
        } catch (SQLException e) {
        }
        return 0;
    }

    public void updateStatusOfChapter(int chId, int accId, boolean stt) {
        String sql = "UPDATE [dbo].[JoinChapter]\n"
                + "   SET \n"
                + "[is_passed] = ?\n"
                + "      \n"
                + " WHERE [account_id] = ?\n"
                + "      and [chapter_id] = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setBoolean(1, stt);
            st.setInt(2, accId);
            st.setInt(3, chId);
            st.executeUpdate();
        } catch (Exception e) {
        }
    }

    public int getNextChapterIdInCourse(int chId) {
        String sql = "select * from Chapter where course_id = \n"
                + "(select course_id from Chapter where id = ?) \n"
                + "and [order] > (select [order] from Chapter where id = ?)\n"
                + "order by [order]";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, chId);
            st.setInt(2, chId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt("id");
            }
        } catch (Exception e) {
        }
        return 0;
    }

    public int getPreviousChapterIdInCourse(int chId) {
        String sql = "select * from Chapter where course_id = \n"
                + "                (select course_id from Chapter where id = ?) \n"
                + "                and [order] < (select [order] from Chapter where id = ?)\n"
                + "                order by [order] desc";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, chId);
            st.setInt(2, chId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt("id");
            }
        } catch (Exception e) {
        }
        return 0;
    }

    private int getOrderOfChapterById(int chId) {
        String sql = "select [order] from Chapter where id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, chId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt("order");
            }
        } catch (SQLException e) {
        }
        return 0;
    }

    public String checkPositionOfChapterById(int chId) {
        ChapterDAO cDAO = new ChapterDAO();
        int order = cDAO.getOrderOfChapterById(chId);
        String sql = "select max([order]) as [max], min([order]) as [min] from Chapter\n"
                + "where course_id = (\n"
                + "select course_id from Chapter where id = ?)";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, chId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                int minOrder = rs.getInt("min");
                int maxOrder = rs.getInt("max");
                if (order == minOrder) {
                    return "min";
                }
                if (order == maxOrder) {
                    return "max";
                }
            }
        } catch (SQLException e) {

        }
        return "mid";
    }
}
