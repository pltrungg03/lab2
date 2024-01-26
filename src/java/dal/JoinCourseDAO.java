package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import model.JoinCourse;

public class JoinCourseDAO extends DBContext {

    public boolean insertJoinCourse(JoinCourse joinCourse) {
        String sqlQuery = "INSERT INTO [dbo].[JoinCourse]\n"
                + "           ([account_id]\n"
                + "           ,[course_id]\n"
                + "           ,[joined_date]\n"
                + "           ,[is_passed])\n"
                + "     VALUES\n"
                + "           (?\n"
                + "           ,?\n"
                + "           ,?\n"
                + "           ,?)";
        try ( Connection conn = connection) {
            PreparedStatement statement = conn.prepareStatement(sqlQuery);
            statement.setInt(1, joinCourse.getAccountId());
            statement.setInt(2, joinCourse.getCourseId());
            statement.setDate(3, joinCourse.getJoinedDate());
            statement.setBoolean(4, joinCourse.isPassed());
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public List<JoinCourse> getAllRatingOfCourse(int courseId) {
        String sqlQuery = "SELECT [account_id]\n"
                + "      ,[course_id]\n"
                + "      ,[joined_date]\n"
                + "      ,[is_passed]\n"
                + "      ,[rating]\n"
                + "  FROM [dbo].[JoinCourse]\n"
                + "  WHERE [course_id] = ? AND [rating] IS NOT NULL";
        List<JoinCourse> joinCourseList = new ArrayList<>();
        try {
            PreparedStatement statement = connection.prepareStatement(sqlQuery);
            statement.setInt(1, courseId);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                JoinCourse joinCourse = new JoinCourse();
                joinCourse.setAccountId(rs.getInt(1));
                joinCourse.setCourseId(rs.getInt(2));
                joinCourse.setJoinedDate(rs.getDate(3));
                joinCourse.setPassed(rs.getBoolean(4));
                joinCourse.setStars(rs.getInt(5));
                joinCourseList.add(joinCourse);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return joinCourseList;
    }

    public boolean updateJoinCourse(JoinCourse joinCourse) {
        String sqlQuery = "UPDATE [dbo].[JoinCourse]\n"
                + "   SET [rating]  = ?\n"
                + " WHERE [account_id] = ? AND [course_id] = ?";
        try {
            PreparedStatement statement = connection.prepareStatement(sqlQuery);
            statement.setInt(1, joinCourse.getStars());
            statement.setInt(2, joinCourse.getAccountId());
            statement.setInt(3, joinCourse.getCourseId());
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public String getDateJoinCourse(int cId, int accId) {
        String sql = "select joined_date from JoinCourse where account_id = ? and course_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, accId);
            st.setInt(2, cId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getString("joined_date");
            }
        } catch (Exception e) {
        }
        return null;
    }

    public static void main(String[] args) {
        JoinCourseDAO jc = new JoinCourseDAO();
        System.out.println(jc.checkJoinCourse(4, 11));
    }

    public Map<String, String> getListLinkCourseDoneByAccountId(int accId) {
        Map<String, String> map = new LinkedHashMap<>();
        String sql = "select jc.*, c.name from \n"
                + "(select * from JoinCourse where account_id = ? and is_passed = 1) jc\n"
                + "left join Course c on jc.course_id = c.id";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, accId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                map.put("cId=" + rs.getInt("course_id") + "&accId=" + accId,
                        rs.getString("name"));
            }
        } catch (SQLException e) {
        }
        return map;

    }

    public void updatePassedDateCourse(int accId, int courseId) {
        String sql = "update JoinCourse\n"
                + "set passed_date = ?\n"
                + "where account_id = ? and course_id = ? and is_passed = 1";
        LocalDate currentDate = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String passedDate = currentDate.format(formatter);
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, passedDate);
            st.setInt(2, accId);
            st.setInt(3, courseId);
            st.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public boolean checkJoinCourse(int accId, int cId) {
        String sql = "select * from JoinCourse where account_id = ? and course_id = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, accId);
            st.setInt(2, cId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
        }
        return false;
    }

    public String getDatePassedCourse(int cId, int accId) {
        String sql = "select passed_date from JoinCourse where account_id = ? and course_id = ? and is_passed = 1";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, accId);
            st.setInt(2, cId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getString("passed_date");
            }
        } catch (Exception e) {
        }
        return null;
    }

    public boolean checkJoinCourseAndDone(int accId, int cId) {
        String sql = "select * from JoinCourse where account_id = ? and course_id = ?"
                + " and is_passed = 1";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, accId);
            st.setInt(2, cId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
        }
        return false;
    }

    public boolean isPassedCourse(int accId, int courseId) {
        String sql = "select * from JoinCourse where account_id = ? and course_id = ? and is_passed = 1";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, accId);
            st.setInt(2, courseId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
        }
        return false;
    }
}
