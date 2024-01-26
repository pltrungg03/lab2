package dal;

import dal.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;

public class GradeDAO extends DBContext {

    public boolean checkPassedTest(int accId, int testId) {
        String sql = "select is_passed from Grade where account_id = ? and test_id = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, accId);
            st.setInt(2, testId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                boolean check = rs.getBoolean("is_passed");
                if (check) {
                    return true;
                }
            }
        } catch (SQLException e) {
        }
        return false;
    }

    public void insertOrUpdateGrade(int accId, int tId, double score, boolean isPassed) {
        boolean check = checkExistGradeOfAccount(accId, tId);
        Date currentDate = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String submitTime = sdf.format(currentDate);
        String sql = "";
        if (check) {
            sql = "UPDATE [dbo].[Grade]\n"
                    + "   SET \n"
                    + "		[score] = ?\n"
                    + "      ,[submitted_time] = ?\n"
                    + "      ,[is_passed] = ?\n"
                    + " WHERE \n"
                    + " [account_id] = ?\n"
                    + " and [test_id] = ?";
        } else {
            sql = "INSERT INTO [dbo].[Grade]\n"
                    + "           ([score]\n"
                    + "		   ,[submitted_time]\n"
                    + "		   ,[is_passed]\n"
                    + "		   ,[account_id]\n"
                    + "           ,[test_id])\n"
                    + "     VALUES\n"
                    + "           (?,?,?,?,?)";
        }
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setDouble(1, score);
            st.setString(2, submitTime);
            st.setBoolean(3, isPassed);
            st.setInt(4, accId);
            st.setInt(5, tId);
            st.executeUpdate();
        } catch (SQLException e) {
        }

    }

    private boolean checkExistGradeOfAccount(int accId, int tId) {
        String sql = "select * from Grade where account_id = ? and test_id = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, accId);
            st.setInt(2, tId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
        }
        return false;
    }

    public static void main(String[] args) {
        Date currentDate = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String submitTime = sdf.format(currentDate);
        System.out.println(submitTime);

        GradeDAO gDAO = new GradeDAO();
        System.out.println(gDAO.getScoreOfAccountIdAndTestId(100, 100));
        //
        System.out.println(gDAO.checkCanTest(4, 1));
    }

    public Double getScoreOfAccountIdAndTestId(int accId, int testId) {
        String sql = "select score from Grade where account_id = ? and test_id = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, accId);
            st.setInt(2, testId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getDouble("score");
            }
        } catch (SQLException e) {
        }
        return -1.0;
    }

    public boolean checkCanTest(int accId, int tId) {
        String sql = "select * from Grade where account_id = ? and test_id = ?";
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        LocalDateTime currentDateTime = LocalDateTime.now();
        String targetDateTimeString = "";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, accId);
            st.setInt(2, tId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                targetDateTimeString = rs.getString("submitted_time");
                targetDateTimeString = targetDateTimeString.substring(0, targetDateTimeString.length() - 2);
            }
        } catch (Exception e) {
        }
        LocalDateTime inputTime = LocalDateTime.parse(targetDateTimeString, formatter);
        Duration duration = Duration.between(inputTime, currentDateTime);
        double hoursWithMinutes = duration.toMinutes() / 60.0;
        if (Math.abs(hoursWithMinutes) > 0.3) {
            return true;
        }
        return false;

    }

    public boolean checkExistGrade(int accId, int tId) {
        String sql = "select * from Grade where account_id = ? and test_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, accId);
            st.setInt(2, tId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
        }
        return false;

    }

    public boolean isPassedTestByLessonId(int lId, int accId) {
        String sql = "select is_passed from grade where test_id = (\n"
                + "select test_id from Lesson where id = ?) and account_id = ?";
        
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, lId);
            st.setInt(2, accId);
            ResultSet rs = st.executeQuery();
            if (rs.next()){
                boolean check = rs.getBoolean("is_passed");
                return check;
            }
        } catch (Exception e) {
        }
        return false;
    }

    public void updateTimeOfLastTest(int accId, int tId) {
        boolean check = checkExistGradeOfAccount(accId, tId);
        Date currentDate = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String submitTime = sdf.format(currentDate);
        String sql = "";
        if (check) {
            sql = "UPDATE [dbo].[Grade]\n"
                    + "   SET \n"
                    + "      [submitted_time] = ?\n"
                    + " WHERE \n"
                    + " [account_id] = ?\n"
                    + " and [test_id] = ?";
        }
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, submitTime);
            st.setInt(2, accId);
            st.setInt(3, tId);
            st.executeUpdate();
        } catch (SQLException e) {
        }
    }
}
