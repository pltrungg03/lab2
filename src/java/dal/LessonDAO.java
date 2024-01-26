package dal;

import java.sql.*;
import java.util.*;
import model.*;

public class LessonDAO extends DBContext {

    public List<Lesson> getLessonsByChapterId(int chapterId) {
        TestDAO tdb = new TestDAO();
        String sql = "SELECT * FROM [Lesson] WHERE chapter_id = " + chapterId;
        List<Lesson> list = new ArrayList();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Lesson l = new Lesson(rs.getInt("id"),
                        rs.getInt("order"),
                        rs.getString("name"),
                        rs.getString("video_url"),
                        rs.getString("content"));
                l.setTest(tdb.getTestByLessonID(l.getId()));
                list.add(l);
            }
        } catch (Exception e) {
        }
        return list;
    }

    //le hieu - ham nay dung de lay list lesson cua 1 ham, bao gom ca check done or not
    public List<Lesson> getLessonsByChapterIdIncludeCheckDone(int chapterId, int accId) {
        JoinLessonDAO jlDAO = new JoinLessonDAO();
        TestDAO tDAO = new TestDAO();
        String sql = "SELECT * FROM [Lesson] WHERE chapter_id = " + chapterId;
        List<Lesson> list = new ArrayList();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Lesson l = new Lesson();
                l.setId(rs.getInt("id"));
                l.setOrder(rs.getInt("order"));
                l.setName(rs.getString("name"));
                l.setVideoUrl(rs.getString("video_url"));
                l.setContent(rs.getString("content"));
                if (checkDoneLesson(accId, rs.getInt("id"))) {
                    jlDAO.confirmDoneLesson(accId, rs.getInt("id"));
                    l.setIsPassed(true);
                } else {
                    l.setIsPassed(false);
                }
                l.setTest(tDAO.getTestByLessonID(rs.getInt("id")));
                list.add(l);
            }
        } catch (Exception e) {
        }
        return list;
    }

    public void insertLessonsByChapterId(String chapterId, String[] lessonsOrder, String[] lessonsName, String[] lessonsVideoUrl, String[] lessonsContent, String[] lessonsTestId) {
        if (lessonsOrder == null || lessonsName == null) {
            return;
        }
        for (int i = 0; i < lessonsOrder.length; i++) {
            if (lessonsOrder[i] != null && lessonsName[i] != null
                    && lessonsOrder[i].length() > 0 && lessonsName[i].length() > 0) {
                insertLessonByChapterId(chapterId, lessonsOrder[i], lessonsName[i], lessonsVideoUrl[i], lessonsContent[i], lessonsTestId[i]);
            }
        }
    }

    public void insertLessonByChapterId(String chapterId, String lessonOrder, String lessonName, String lessonVideoUrl, String lessonContent, String lessonTestId) {
        String query = "INSERT INTO [Lesson] VALUES\n"
                + "(?, ?, ?, ?, ?, NULL)";
        try {
            PreparedStatement st = connection.prepareStatement(query);
            st.setInt(1, Integer.parseInt(chapterId));
            st.setInt(2, Integer.parseInt(lessonOrder));
            st.setString(3, lessonName);
            st.setString(4, lessonVideoUrl);
            st.setString(5, lessonContent);
//            if (lessonTestId == null || lessonTestId.equals("None")) {
//                st.setObject(6, null);
//            } else {
//                st.setInt(6, Integer.parseInt(lessonTestId));
//            }

            System.out.println(query);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void updateLessonsByChapterId(String chapterId, String[] lessonsId, String[] lessonsOrder, String[] lessonsName,
            String[] lessonsVideoUrl, String[] lessonsContent, String[] lessonsTestId) {
        if (lessonsId == null || lessonsOrder == null || lessonsName == null || lessonsVideoUrl == null || lessonsContent == null || lessonsTestId == null) {
            System.out.println("There is an error in update lessons by chapter id");
            return;
        } else {
            for (int i = 0; i < lessonsId.length; i++) {
                if (lessonsId[i] == null || lessonsId[i].isEmpty()) {
                    System.out.println("Lesson id is null, redirect to insert Lesson!");
                    if (lessonsOrder[i] != null && lessonsName[i] != null && !lessonsOrder[i].isEmpty() && !lessonsName[i].isEmpty()) {
                        insertLessonByChapterId(chapterId, lessonsOrder[i], lessonsName[i], lessonsVideoUrl[i], lessonsContent[i], lessonsTestId[i]);
                    } else {
                        System.out.println("Wrong input");
                    }
                } else {
                    updateLessons(chapterId, lessonsId[i], lessonsOrder[i], lessonsName[i], lessonsVideoUrl[i], lessonsContent[i], lessonsTestId[i]);
                }
            }
        }
    }

    public void updateLessons(String chapterId, String lessonId, String lessonOrder, String lessonName, String lessonVideoUrl, String lessonContent, String lessonTestId) {
        String query = "UPDATE [Lesson] "
                + "SET [chapter_id] = ?, [order] = ?, [name] = ?, [video_url] = ?, [content] = ?, [test_id] = NULL\n"
                + "WHERE [id] = ?;";

        try {
            PreparedStatement st = connection.prepareStatement(query);
            st.setInt(1, Integer.parseInt(chapterId));
            st.setInt(2, Integer.parseInt(lessonOrder));
            st.setString(3, lessonName);
            st.setString(4, lessonVideoUrl);
            st.setString(5, lessonContent);
//            if (lessonTestId == null || lessonTestId.equals("None")) {
//                st.setObject(6, null);
//            } else {
//                st.setInt(6, Integer.parseInt(lessonTestId));
//            }
            st.setInt(6, Integer.parseInt(lessonId));

            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void updateLessonTestId(int lessonId, int lessonTestId) {
        String query = "UPDATE [Lesson] "
                + "SET [test_id] = ?\n"
                + "WHERE [id] = ?;";

        try {
            PreparedStatement st = connection.prepareStatement(query);
            st.setInt(1, lessonTestId);
            st.setInt(2, lessonId);

            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void removeLessonCommentByLessonId(int lessonId) {
        String query = "DELETE FROM LessonComment WHERE lesson_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(query);
            st.setInt(1, lessonId);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
    
    public void removeJoinLessonByLessonId(int lessonId) {
        String query = "DELETE FROM JoinLesson WHERE lesson_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(query);
            st.setInt(1, lessonId);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void removeLessonByLessonId(int lessonId) {
        LessonDAO ldb = new LessonDAO();
        TestDAO tdb = new TestDAO();
        // remove JoinLesson
        ldb.removeJoinLessonByLessonId(lessonId);
        ldb.removeLessonCommentByLessonId(lessonId);

        // remove Test
        tdb.removeTestByLessonId(lessonId);
        String query = "DELETE FROM Lesson WHERE id = ?";

        try {
            PreparedStatement st = connection.prepareStatement(query);
            st.setInt(1, lessonId);
            st.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void removeLessonByChapterId(int chapterId) {
        LessonDAO ldb = new LessonDAO();
        String query = "SELECT * FROM Lesson WHERE chapter_id = ?";

        try {
            PreparedStatement st = connection.prepareStatement(query);
            st.setInt(1, chapterId);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                ldb.removeLessonByLessonId(rs.getInt("id"));
            }
        } catch (Exception e) {
        }
    }

    private boolean checkJoinLesson(int accId, int lessonId) {
        String sql = "select * from JoinLesson where account_id = ? and lesson_id = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, accId);
            st.setInt(2, lessonId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return true;
            }
            return false;
        } catch (SQLException e) {
        }
        return false;
    }

    //lesson done khi hoc xong video va pass test (neu co)
    private boolean checkDoneLesson(int accId, int lessonId) {
        GradeDAO gDAO = new GradeDAO();
        int tId = getTestIdOfLessonIfHas(lessonId);
        if (tId != -1) {
            boolean check = gDAO.checkPassedTest(accId, tId);
            return check;
        } else {
            String sql = "select * from JoinLesson where account_id = ? "
                    + "and lesson_id = ? and is_passed = 1";
            try {
                PreparedStatement st = connection.prepareStatement(sql);
                st.setInt(1, accId);
                st.setInt(2, lessonId);
                ResultSet rs = st.executeQuery();
                if (rs.next()) {
                    return true;
                }
            } catch (SQLException e) {
            }
            return false;
        }
    }

    private int getTestIdOfLessonIfHas(int lId) {
        String sql = "select test_id from Lesson where id = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, lId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Integer testId = rs.getInt("test_id");
                if (rs.wasNull() || testId == null) {
                    return -1;
                } else {
                    return testId;
                }
            }
        } catch (SQLException e) {
        }
        return -1;
    }

    public static void main(String[] args) {
        LessonDAO ldb = new LessonDAO();
        List<Lesson> t = ldb.getLessonsByChapterIdIncludeCheckDone(14, 4);
        for (int i = 0; i < t.size(); i++) {
            System.out.println(t.get(i).getName() + t.get(i).isIsPassed());
        }
        Test ok = t.get(0).getTest();
        System.out.println(ok.getName() + ok.getThreshold());

        int l = ldb.getFirstLessonIdOfChapter(15);
        System.out.println(l);

    }

    public Lesson getLessonsById(int id) {
        TestDAO tDAO = new TestDAO();
        String sql = "SELECT * from Lesson where id = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Lesson l = new Lesson();
                l.setId(rs.getInt("id"));
                l.setOrder(rs.getInt("order"));
                l.setName(rs.getString("name"));
                l.setVideoUrl(rs.getString("video_url"));
                l.setContent(rs.getString("content"));
                l.setTest(tDAO.getTestByLessonID(id));
                return l;
            }
        } catch (Exception e) {
        }
        return null;
    }

    public int countLessonIn1Chapter(int chapId) {
        String sql = "select count(id) as num from Lesson where chapter_id = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, chapId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt("num");
            }
        } catch (Exception e) {
        }
        return 0;
    }

    //dem so lesson user da join
    public int countLessonDoneIn1ChapterOfAccount(int chapId, int accId) {
        String sql = "select count(jl.lesson_id) as num \n"
                + "from JoinLesson jl join Lesson l\n"
                + "on jl.lesson_id = l.id where l.chapter_id = ? and jl.account_id = ? and jl.is_passed = 1";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, chapId);
            st.setInt(2, accId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt("num");
            }
        } catch (Exception e) {
        }
        return 0;
    }

    //khi an vao 1 lesson thi tuc la join lesson va join chapter cua lesson do, join chapter
    //se ben chapterDAO
    public void addJoinLesson(int accId, int lId) {
        boolean check = checkJoinLesson(accId, lId);
        if (!check) {
            String sql = "INSERT INTO [dbo].[JoinLesson]\n"
                    + "           ([account_id]\n"
                    + "           ,[lesson_id]\n"
                    + "           ,[is_passed])\n"
                    + "     VALUES\n"
                    + "           (?,?,0)";
            try {
                PreparedStatement st = connection.prepareStatement(sql);
                st.setInt(1, accId);
                st.setInt(2, lId);
                st.executeUpdate();
            } catch (SQLException e) {
            }
        }
    }

    public int getFirstLessonIdOfChapter(int chapId) {
        String sql = "select * from Lesson where chapter_id = ?\n"
                + "order by [order]";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, chapId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt("id");
            }
        } catch (Exception e) {
        }
        return 0;
    }
}
