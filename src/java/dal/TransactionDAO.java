package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;
import model.Transaction;

public class TransactionDAO extends DBContext {

    public int getTotalEarned() {
        String query = "SELECT SUM([value]) as earned FROM [Transaction]\n"
                + "WHERE [value] > 0";
        try {
            PreparedStatement st = connection.prepareStatement(query);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt("earned");
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }
    
    public int getCurrentYearTotal() {
        String sql = "select sum(value) as [currentYeartotal] from [Transaction]\n"
                + "where year(created_time) = year(GETDATE()) AND [value] > 0";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt("currentYeartotal");
            }
        } catch (Exception e) {
        }
        return 0;
    }
    
    public Map<Integer, Integer> getRevanueLast5Months() {
        Map<Integer, Integer> map = new LinkedHashMap<>();
        String sql = "SELECT month(created_time) as [month],sum(value) as [total]\n"
                + "FROM [Transaction]\n"
                + "WHERE created_time >= DATEADD(MONTH, -5, GETDATE()) AND [value] > 0\n"
                + "group by created_time\n"
                + "order by created_time ";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                map.put(rs.getInt("month"), rs.getInt("total"));
            }
        } catch (Exception e) {
        }
        return map;
    }
    
    public int getLastYearTotal() {
        String sql = "select sum(value) as [lastYeartotal] from [Transaction]\n"
                + "where year(created_time) = (year(GETDATE()) - 1) AND [value] > 0";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt("lastYeartotal");
            }
        } catch (Exception e) {
        }
        return 0;
    }
    
    public boolean insertTransaction(Transaction transaction){
        String sqlQuery = "INSERT INTO [dbo].[Transaction]\n" +
                "           ([account_id]\n" +
                "           ,[created_time]\n" +
                "           ,[value]\n" +
                "           ,[note])\n" +
                "     VALUES\n" +
                "           (?\n" +
                "           ,?\n" +
                "           ,?\n" +
                "           ,?)";
        try(Connection conn = connection){
            PreparedStatement statement = conn.prepareStatement(sqlQuery);
            statement.setInt(1, transaction.getAccountId());
            statement.setTimestamp(2, transaction.getCreatedDate());
            statement.setDouble(3, transaction.getValue());
            statement.setString(4, transaction.getNote());
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
