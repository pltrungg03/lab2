package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Quiz;

public class QuizDAO extends DBContext {

    public void insertQuizzesByTestId(int testId, String[] quizzesOrder, String[] quizzesQuestion, String[] quizzesAnswer, String[] quizzesAnswerA, String[] quizzesAnswerB, String[] quizzesAnswerC, String[] quizzesAnswerD) {
        try {
            for (int i = 0; i < quizzesOrder.length; i++) {
                System.out.println(i);
                insertQuizByTestId(testId, quizzesOrder[i], quizzesQuestion[i], quizzesAnswer[i], quizzesAnswerA[i], quizzesAnswerB[i], quizzesAnswerC[i], quizzesAnswerD[i]);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public void insertQuizByTestId(int testId, String quizOrder, String quizQuestion, String quizAnswer, String quizAnswerA, String quizAnswerB, String quizAnswerC, String quizAnswerD) {
        String query = "INSERT INTO [Quiz] VALUES\n"
                + "(?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(query);
            st.setInt(1, testId);
            st.setInt(2, Integer.parseInt(quizOrder));
            st.setString(3, quizQuestion);
            st.setString(4, quizAnswerA);
            st.setString(5, quizAnswerB);
            st.setString(6, quizAnswerC);
            st.setString(7, quizAnswerD);
            st.setInt(8, Integer.parseInt(quizAnswer));

            System.out.println(query);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void updateQuizByQuizId(String quizId, String quizOrder, String quizQuestion, String quizAnswer, String quizAnswerA, String quizAnswerB, String quizAnswerC, String quizAnswerD) {
        String query = "UPDATE [dbo].[Quiz]\n"
                + "SET  [order] = ?,\n"
                + "	question = ?,\n"
                + "	answer_a = ?,\n"
                + "	answer_b = ?,\n"
                + "	answer_c = ?,\n"
                + "	answer_d = ?,\n"
                + "	answer = ?\n"
                + "WHERE id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(query);
            st.setInt(1, Integer.parseInt(quizOrder));
            st.setString(2, quizQuestion);
            st.setString(3, quizAnswerA);
            st.setString(4, quizAnswerB);
            st.setString(5, quizAnswerC);
            st.setString(6, quizAnswerD);
            st.setInt(7, Integer.parseInt(quizAnswer));
            st.setInt(8, Integer.parseInt(quizId));

            System.out.println(query);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public List<Quiz> getListQuizzesByTestId(int testId) {
        List<Quiz> list = new ArrayList();
        String sql = "select * from Quiz where test_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, testId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Quiz q = new Quiz();
                q.setId(rs.getInt("id"));
                q.setOrder(rs.getInt("order"));
                q.setQuestion(rs.getString("question"));
                q.setAnswerA(rs.getString("answer_a"));
                q.setAnswerB(rs.getString("answer_b"));
                q.setAnswerC(rs.getString("answer_c"));
                q.setAnswerD(rs.getString("answer_d"));
                q.setAnswer(rs.getInt("answer"));
                list.add(q);
            }
        } catch (SQLException e) {
        }
        return list;
    }

    public void removeQuizByTestId(int testId) {
        String query = "DELETE FROM Quiz WHERE test_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(query);
            st.setInt(1, testId);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void removeQuizByQuizId(int quizId) {
        String query = "DELETE FROM Quiz WHERE id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(query);
            st.setInt(1, quizId);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public static void main(String[] args) {
        QuizDAO q = new QuizDAO();
        List<Quiz> t = q.getListQuizzesByTestId(1);
        for (int i = 0; i < t.size(); i++) {
            System.out.println(t.get(i).getQuestion());
        }
    }
}
