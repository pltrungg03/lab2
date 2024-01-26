package dal;

import model.Account;
import model.Course;
import model.Event;
import model.Major;
import oracle.jdbc.proxy.annotation.Pre;
import util.Helpers;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class EventDAO extends DBContext {

    public void insertEvent(Event event) {
        String sqlQuery = "INSERT INTO [dbo].[Event]\n" +
                "           ([creator_id]\n" +
                "           ,[content]\n" +
                "           ,[discount]\n" +
                "           ,[created_date]\n" +
                "           ,[expired_date])\n" +
                "     VALUES\n" +
                "           (?\n" +
                "           ,?\n" +
                "           ,?\n" +
                "           ,?\n" +
                "           ,?)";
        try (Connection conn = connection) {
            PreparedStatement statement = conn.prepareStatement(sqlQuery);
            statement.setInt(1, event.getCreatorId());
            statement.setString(2, event.getContent());
            statement.setDouble(3, event.getDiscount());
            statement.setDate(4, event.getCreatedDate());
            statement.setDate(5, event.getExpiredDate());
            statement.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(EventDAO.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    public void updateEvent(Event event) {
        String sqlQuery = "UPDATE [dbo].[Event]\n" +
                "   SET [content] = ?\n" +
                "      ,[discount] = ?\n" +
                "\t  ,[created_date] = ?\n" +
                "      ,[expired_date] = ?\n" +
                " WHERE [id] = ?";
        try (Connection conn = connection) {
            PreparedStatement statement = conn.prepareStatement(sqlQuery);
            statement.setString(1, event.getContent());
            statement.setDouble(2, event.getDiscount());
            statement.setDate(3, event.getCreatedDate());
            statement.setDate(4, event.getExpiredDate());
            statement.setInt(5, event.getId());
            statement.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(EventDAO.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    public void insertEventCourse(int eventId, int courseId) {
        String sqlQuery = "INSERT INTO [dbo].[EventCourse]\n" +
                "           ([event_id]\n" +
                "           ,[course_id])\n" +
                "     VALUES\n" +
                "           (?\n" +
                "           ,?)";
        try (Connection conn = connection) {
            PreparedStatement statement = conn.prepareStatement(sqlQuery);
            statement.setInt(1, eventId);
            statement.setInt(2, courseId);
            statement.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(EventDAO.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    public void deleteEventCourseByCourseId(int courseId) {
        String sqlQuery = "DELETE FROM [dbo].[EventCourse]\n" +
                "      WHERE [course_id] = ?";
        try (Connection conn = connection) {
            PreparedStatement statement = conn.prepareStatement(sqlQuery);
            statement.setInt(1, courseId);
            statement.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(EventDAO.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    public void deleteEventCourseByEventId(int eventId) {
        String sqlQuery = "DELETE FROM [dbo].[EventCourse]\n" +
                "      WHERE [event_id] = ?";
        try (Connection conn = connection) {
            PreparedStatement statement = conn.prepareStatement(sqlQuery);
            statement.setInt(1, eventId);
            statement.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(EventDAO.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    public void deleteEventCourseByCompositeKey(int eventId, int courseId) {
        String sqlQuery = "DELETE FROM [dbo].[EventCourse]\n" +
                "      WHERE [event_id] = ? AND [course_id] = ?";
        try (Connection conn = connection) {
            PreparedStatement statement = conn.prepareStatement(sqlQuery);
            statement.setInt(1, eventId);
            statement.setInt(2, courseId);
            statement.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(EventDAO.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    public List<Course> selectListCourseByEvent(int eventId){
        List<Course> courses = new ArrayList<>();
        String sqlQuery = "SELECT c.id, c.name, c.price, c.discount, c.image, c.description, c.created_date, c.updated_date,\n"
                + "AVG(jc.rating) as rating, COUNT(jc.course_id) as student_number,\n"
                + "m.id as major_id, m.[name] as major, m.image as major_image,\n"
                + "l.id as level_id, l.[name] as [level],\n"
                + "a.id as creator_id, a.first_name, a.last_name\n"
                + "FROM Course c\n"
                + "LEFT JOIN Major m ON c.major_id = m.id\n"
                + "LEFT JOIN Level l ON c.level_id = l.id\n"
                + "LEFT JOIN Account a ON c.creator_id = a.id\n"
                + "FULL JOIN JoinCourse jc ON c.id = jc.course_id\n"
                + "INNER JOIN [dbo].[EventCourse] ec ON c.[id] = ec.[course_id]\n"
                + "WHERE ec.[event_id] = ?\n"
                + "GROUP BY c.id, c.name, c.price, c.discount, c.image, c.description, c.created_date, c.updated_date, m.id, m.name, m.image, l.id, l.name, a.id, a.first_name, a.last_name";
        try(Connection conn = connection){
            PreparedStatement preparedStatement = conn.prepareStatement(sqlQuery);
            preparedStatement.setInt(1, eventId);
            ResultSet rs = preparedStatement.executeQuery();
            AccountDAO adb = new AccountDAO();
            while(rs.next()){
                Account creator = adb.getAccountById(rs.getInt("creator_id"));
                courses.add(new Course(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getDouble("price"),
                        rs.getDouble("discount"),
                        rs.getString("image"),
                        rs.getString("description"),
                        rs.getString("created_date"),
                        rs.getString("updated_date"),
                        new Major(rs.getInt("major_id"),
                                rs.getString("major"),
                                rs.getString("major_image")),
                        new model.Level(rs.getInt("level_id"),
                                rs.getString("level")),
                        creator,
                        0,
                        rs.getDouble("rating"),
                        false,
                        "unknown",
                        null,
                        null));
            }
        } catch (SQLException e) {
            Logger.getLogger(EventDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return courses;
    }

    public Event selectEventById(int eventId){
        String sqlQuery = "SELECT e.[id]\n" +
                "      ,e.[creator_id]\n" +
                "      ,e.[content]\n" +
                "      ,e.[discount]\n" +
                "      ,e.[created_date]\n" +
                "      ,e.[expired_date]\n" +
                "      ,a.[first_name]\n" +
                "      ,a.[last_name]\n" +
                "  FROM [dbo].[Event] e\n" +
                "JOIN [ByteScholar2].[dbo].[Account] a ON e.[creator_id] = a.[id]\n" +
                "  WHERE e.[id] = ?";
        try(Connection conn = connection){
            PreparedStatement statement = conn.prepareStatement(sqlQuery);
            statement.setInt(1, eventId);
            ResultSet rs = statement.executeQuery();
            if(rs.next()){
                Event event =  new Event();
                event.setId(rs.getInt(1));
                event.setCreatorId(rs.getInt(2));
                event.setContent(rs.getString(3));
                event.setDiscount(rs.getDouble(4));
                event.setCreatedDate(rs.getDate(5));
                event.setExpiredDate(rs.getDate(6));
                Account account = new Account();
                account.setId(rs.getInt(2));
                account.setFirstName(rs.getString(7));
                account.setLastName(rs.getString(8));
                event.setCreator(account);
                return event;
            }
        } catch (SQLException e) {
            Logger.getLogger(EventDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return null;
    }

    public List<Event> selectAllListEvent(){
        List<Event> events = new ArrayList<>();
        String sqlQuery = "SELECT e.[id]\n" +
                "      ,e.[creator_id]\n" +
                "      ,e.[content]\n" +
                "      ,e.[discount]\n" +
                "      ,e.[created_date]\n" +
                "      ,e.[expired_date]\n" +
                "      ,a.[first_name]\n" +
                "      ,a.[last_name]\n" +
                "FROM [dbo].[Event] e\n" +
                "JOIN [ByteScholar2].[dbo].[Account] a ON e.[creator_id] = a.[id];";
        try(Connection conn = connection){
            PreparedStatement statement = conn.prepareStatement(sqlQuery);
            ResultSet rs = statement.executeQuery();
            while(rs.next()){
                Event event =  new Event();
                event.setId(rs.getInt(1));
                event.setContent(rs.getString(3));
                event.setDiscount(rs.getDouble(4));
                event.setCreatedDate(rs.getDate(5));
                event.setExpiredDate(rs.getDate(6));
                Account account = new Account();
                account.setId(rs.getInt(2));
                account.setFirstName(rs.getString(7));
                account.setLastName(rs.getString(8));
                event.setCreator(account);
                events.add(event);
            }
        } catch (SQLException e) {
            Logger.getLogger(EventDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return events;
    }

    public List<Event> selectAllListEventIsAvailable(){
        List<Event> events = new ArrayList<>();
        String sqlQuery = "SELECT [id]\n" +
                "      ,[creator_id]\n" +
                "      ,[content]\n" +
                "      ,[discount]\n" +
                "      ,[created_date]\n" +
                "      ,[expired_date]\n" +
                "  FROM [dbo].[Event]\n" +
                "  WHERE [expired_date] > ?";
        try(Connection conn = connection){
            PreparedStatement statement = conn.prepareStatement(sqlQuery);
            statement.setDate(1, Helpers.getDateNow());
            ResultSet rs = statement.executeQuery();
            while(rs.next()){
                Event event =  new Event();
                event.setId(rs.getInt(1));
                event.setCreatorId(rs.getInt(2));
                event.setContent(rs.getString(3));
                event.setDiscount(rs.getDouble(4));
                event.setCreatedDate(rs.getDate(5));
                event.setExpiredDate(rs.getDate(6));
                events.add(event);
            }
        } catch (SQLException e) {
            Logger.getLogger(EventDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return events;
    }

    public void deleteEvent(int eventId){
        String sqlQuery = "DELETE FROM [dbo].[Event]\n" +
                "      WHERE [id] = ?";
        try(Connection conn = connection){
            PreparedStatement statement = conn.prepareStatement(sqlQuery);
            statement.setInt(1, eventId);
            statement.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(EventDAO.class.getName()).log(Level.SEVERE, null, e);
        }
    }
}
