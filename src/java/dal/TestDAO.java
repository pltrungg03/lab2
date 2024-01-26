package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;
import model.*;

public class TestDAO extends DBContext {

    public int insertTest(String testName, String testTime, String testThreshold) {
        String query = "INSERT INTO Test\n"
                + "VALUES (?, ?, ?)";

        try {
            PreparedStatement st = connection.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS);
            st.setString(1, testName);
            st.setInt(2, Integer.parseInt(testTime));
            st.setDouble(3, Double.parseDouble(testThreshold));
            st.executeUpdate();

            System.out.println(query);

            ResultSet generatedKeys = st.getGeneratedKeys();
            if (generatedKeys.next()) {
                int testID = generatedKeys.getInt(1);
                return testID;
            } else {
                return -1;
            }
        } catch (SQLException e) {
            System.out.println(e);
            return -1;
        }
    }

    public List<Test> getAllTests() {
        String sql = "SELECT * FROM [Test]";
        List<Test> list = new ArrayList();

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Test(rs.getInt("id"),
                        rs.getString("name"),
                        rs.getDouble("threshold")));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public Test getTestByLessonID(int lessonId) {
        QuizDAO qDAO = new QuizDAO();
        String sql = "select t.* from Lesson l join Test t\n"
                + "on l.test_id = t.id where l.id = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, lessonId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Test t = new Test();
                t.setId(rs.getInt("id"));
                t.setName(rs.getString("name"));
                t.setThreshold(rs.getDouble("threshold"));
                t.setQuizzes(qDAO.getListQuizzesByTestId(rs.getInt("id")));
                t.setMinutes(rs.getInt("minutes"));

                return t;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public Test getTestById(int id) {
        QuizDAO qDAO = new QuizDAO();
        String sql = "select * from Test where id = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Test t = new Test();
                t.setId(rs.getInt("id"));
                t.setName(rs.getString("name"));
                t.setThreshold(rs.getDouble("threshold"));
                t.setQuizzes(qDAO.getListQuizzesByTestId(rs.getInt("id")));
                return t;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public int getTestIdByLessonId(int lessonId) {
        String query = "	SELECT t.id\n"
                + "	FROM Lesson l\n"
                + "	JOIN Test t ON l.test_id = t.id\n"
                + "	WHERE l.id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(query);
            st.setInt(1, lessonId);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                return rs.getInt("id");
            }
        } catch (SQLException e) {
            System.out.println(e);
            return -1;
        }
        return -1;
    }

    public void removeGradeByLessonId(int lessonId) {
        String query = "DELETE FROM Grade\n"
                + "WHERE test_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(query);
            st.setInt(1, lessonId);
            st.executeUpdate();
            st.close();

        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void removeTestByLessonId(int lessonId) {
        TestDAO tdb = new TestDAO();
        QuizDAO qdb = new QuizDAO();
        int testId = tdb.getTestIdByLessonId(lessonId);
        if (testId != -1) {
            tdb.removeGradeByLessonId(lessonId);
            qdb.removeQuizByTestId(testId);
            String query1 = "UPDATE Lesson\n"
                    + "SET test_id = NULL\n"
                    + "WHERE id = ?;\n";
            String query2 = "DELETE FROM Test WHERE id = ?";
            try {
                PreparedStatement st1 = connection.prepareStatement(query1);
                st1.setInt(1, lessonId);
                st1.executeUpdate();
                st1.close();

                PreparedStatement st2 = connection.prepareStatement(query2);
                st2.setInt(1, testId);
                st2.executeUpdate();
                st2.close();
            } catch (SQLException e) {
                System.out.println(e);
            }
        }
    }
}
