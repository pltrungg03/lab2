package dal;

import model.GooglePojo;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.paypal.api.payments.Transaction;
import jakarta.servlet.http.Cookie;
import java.io.IOException;
import java.sql.Connection;
import model.Account;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.*;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.fluent.Form;
import org.apache.http.client.fluent.Request;
import model.Constants;
import model.OrderHistory;
import model.Role;

public class AccountDAO extends DBContext {

    public Account getAccount(String user, String password) {
        String sql = "select * from Account where username = ? and password = ?";
        try {
            PreparedStatement st = connection.prepareCall(sql);
            st.setString(1, user);
            st.setString(2, password);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Account a = new Account(rs.getInt("id"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("first_name"),
                        rs.getString("last_name"),
                        rs.getString("email"),
                        rs.getString("avatar"),
                        rs.getString("phone_number"),
                        rs.getBoolean("gender"),
                        rs.getString("country"),
                        rs.getDouble("wallet"),
                        rs.getString("dob"),
                        null);
                return a;
            }
        } catch (Exception e) {
        }
        return null;
    }

    public List<Account> getAllCreators() {
        AccountDAO a = new AccountDAO();
        String sql = "select distinct creator_id  from  Course c ";
        List<Account> list = new ArrayList<>();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(a.getAccountById(rs.getInt("creator_id")));
            }
        } catch (Exception e) {
        }
        return list;

    }

    public boolean checkTransactionVIP(Account acc, String content) {
        String query = "select * from [Transaction] as t\n"
                + "where t.account_id = ?\n"
                + "and t.note like ?";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, acc.getId());
            ps.setString(2, '%' + content + '%');
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                if (rs.getDouble("value") != 0) {
                    return true;
                }
            }
        } catch (Exception e) {
        }
        return false;
    }

    public boolean checkExpiredVIP(String dateExpired) {
        // format date
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        // current date
        Date date = new Date();
        try {
            // so sanh expired_date cu voi ngay hien tai
            if (format.parse(dateExpired).before(date)) {
                return true;
            } else {
                return false;
            }
        } catch (Exception e) {
        }
        return false;
    }

    public String dateExpiredVIP(Account acc) {

        String query = "select * from AccountPremium where account_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, acc.getId());
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("expired_date");
            }
        } catch (Exception e) {
        }

        return null;
    }

    public void upgradeVIP(Account acc, int days, double price) {
        String query = "";
        int accountId = acc.getId();
        String expiredDate = dateExpiredVIP(acc);
        // modify expired date
        Calendar cal = Calendar.getInstance();
        // format date
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        // current date
        Date date = new Date();
        if (expiredDate != null) {
            query = "UPDATE [dbo].[AccountPremium]\n"
                    + "   SET [account_id] = ?\n"
                    + "      ,[expired_date] = ?\n"
                    + " WHERE account_id = " + accountId;

            try {
                // so sanh expired_date cu voi ngay hien tai
                if (format.parse(expiredDate).before(date)) {
                    // het han thi add tu ngay hien tai
                    cal.setTime(date);
                    cal.add(Calendar.DAY_OF_MONTH, days);
                    expiredDate = format.format(cal.getTime());
                } else {
                    // con han thi add tiep tu expiredDate
                    cal.setTime(format.parse(expiredDate));
                    cal.add(Calendar.DAY_OF_MONTH, days);
                    expiredDate = format.format(cal.getTime());
                }
            } catch (Exception e) {
            }

        } else {
            query = "INSERT INTO [dbo].[AccountPremium]\n"
                    + "           ([account_id]\n"
                    + "           ,[expired_date])\n"
                    + "     VALUES\n"
                    + "           (?\n"
                    + "           ,?)";
            cal.setTime(date);
            cal.add(Calendar.DAY_OF_MONTH, days);
            expiredDate = format.format(cal.getTime());
        }
        System.out.println("set up success!");
        System.out.println(expiredDate);
        System.out.println(query);
        try {
            // update VIP cho account
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, accountId);
            ps.setString(2, expiredDate);

            ps.executeUpdate();
            System.out.println("update VIP cho account");
            // tru tien tai khoan 
            String query2 = "UPDATE [dbo].[Account]\n"
                    + "   SET [wallet] = ?\n"
                    + "      \n"
                    + " WHERE Account.id = ?";
            ps = connection.prepareStatement(query2);
            ps.setDouble(1, acc.getWallet() - price);
            ps.setInt(2, accountId);
            ps.executeUpdate();
            System.out.println("tru tien tai khoan ");
            // insert transaction upgradeVIP
            String query3 = "INSERT INTO [dbo].[Transaction]\n"
                    + "           ([account_id]\n"
                    + "           ,[created_time]\n"
                    + "           ,[value]\n"
                    + "           ,[note])\n"
                    + "     VALUES\n"
                    + "           (?\n"
                    + "           ,GETDATE()\n"
                    + "           ,?\n"
                    + "           ,?)";
            ps = connection.prepareStatement(query3);
            ps.setInt(1, accountId);
            ps.setDouble(2, -price);
            ps.setString(3, "Upgrade VIP account " + days + " days.");
            ps.executeUpdate();
            System.out.println("insert transaction upgradeVIP");

        } catch (Exception e) {
        }
    }

    public Account getAccountById(int id) {
        String sql = "select * from Account where id = ?";
        try {
            PreparedStatement st = connection.prepareCall(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Account a = new Account(rs.getInt("id"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("first_name"),
                        rs.getString("last_name"),
                        rs.getString("email"),
                        rs.getString("avatar"),
                        rs.getString("phone_number"),
                        rs.getBoolean("gender"),
                        rs.getString("country"),
                        rs.getDouble("wallet"),
                        rs.getString("dob"),
                        null);

                String query = "select ar.role_id,r.name as [role_name] from AccountRole as ar, Role as r\n"
                        + "where ar.account_id = ?\n"
                        + "and ar.role_id = r.id";
                PreparedStatement ps = connection.prepareStatement(query);
                ps.setInt(1, a.getId());
                ResultSet rs2 = ps.executeQuery();
                ArrayList<Role> listR = new ArrayList<>();
                while (rs2.next()) {
                    listR.add(new Role(rs2.getInt("role_id"), rs2.getString("role_name")));
                }
                a.setRoles(listR);
                return a;
            }
        } catch (Exception e) {
        }
        return null;
    }

    public void updateAvatar(int id, String img) {
        String sql = "UPDATE [dbo].[Account]\n"
                + "   SET \n"
                + "    [avatar] =?\n"
                + "      \n"
                + " WHERE id = ?";
        try {
            PreparedStatement st = connection.prepareCall(sql);
            st.setInt(2, id);
            st.setString(1, img);
            st.executeUpdate();

        } catch (Exception e) {
        }
    }

    public int maxIDAccount() {
        String sql = "select * from Account where id = (select top 1 id from account order by id desc)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return 0;
    }

    public void updateMailByID(int id, String email) {
        String sql = "UPDATE [dbo].[Account]\n"
                + "   SET \n"
                + "      [email] = ?\n"
                + " WHERE id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, email);
            st.setInt(2, id);
            st.executeUpdate();
        } catch (Exception e) {
        }
    }

    public void signUp(String user, String password, String email, String gender) {
        LocalDate curDate = LocalDate.now();
        String date = curDate.toString();
        String sql = "INSERT INTO [dbo].[Account]\n"
                + "           ([username]\n"
                + "           ,[password]\n"
                + "           ,[email]\n"
                + "           ,[gender]\n"
                + "           ,[wallet]\n"
                + "           ,[is_available]\n"
                + "           ,[created_date])\n"
                + "     VALUES\n"
                + "           (?,?,?,?,?,?,?)";
        try {
            PreparedStatement st = connection.prepareCall(sql);
            st.setString(1, user);
            st.setString(2, password);
            st.setString(3, email);
            st.setString(4, gender);
            st.setDouble(5, 0);
            st.setBoolean(6, true);
            st.setString(7, date);
            st.executeUpdate();
            System.out.println(sql);

        } catch (Exception e) {
        }
        String sql2 = "INSERT INTO [dbo].[AccountRole]\n"
                + "           ([account_id]\n"
                + "           ,[role_id])\n"
                + "     VALUES\n"
                + "           (?\n"
                + "           ,4)";
        try {
            PreparedStatement st2 = connection.prepareStatement(sql2);
            int n = maxIDAccount();
            st2.setInt(1, n);
            st2.executeUpdate();
        } catch (Exception e) {
        }

    }

    public Account checkAccountExsit(String user) {
        String sql = "select * from account where username = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, user);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Account a = new Account(rs.getInt("id"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("first_name"),
                        rs.getString("last_name"),
                        rs.getString("email"),
                        rs.getString("avatar"),
                        rs.getString("phone_number"),
                        rs.getBoolean("gender"),
                        rs.getString("country"),
                        rs.getDouble("wallet"),
                        rs.getString("dob"),
                        null);
                a.setIsAvailable(rs.getBoolean("is_available"));

                String query = "select ar.role_id,r.name as [role_name] from AccountRole as ar, Role as r\n"
                        + "where ar.account_id = ?\n"
                        + "and ar.role_id = r.id";
                PreparedStatement ps = connection.prepareStatement(query);
                ps.setInt(1, a.getId());
                ResultSet rs2 = ps.executeQuery();
                ArrayList<Role> listR = new ArrayList<>();
                while (rs2.next()) {
                    listR.add(new Role(rs2.getInt("role_id"), rs2.getString("role_name")));
                }
                a.setRoles(listR);
                return a;
            }
        } catch (Exception e) {
        }

        return null;
    }

    public List<Account> getAllAccountByKeywordName(String keyword) {
        String sql = "select * from Account where (first_name + ' '+ last_name) like '%" + keyword + "%'"
                + " or (last_name + ' ' + first_name) like '%" + keyword + "%'";
        List<Account> list = new ArrayList<>();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Account a = new Account();
                a.setId(rs.getInt("id"));
                a.setUsername(rs.getString("username"));
                a.setPassword(rs.getString("password"));
                a.setEmail(rs.getString("email"));
                a.setFirstName(rs.getString("first_name"));
                a.setLastName(rs.getString("last_name"));
                a.setGender(rs.getBoolean("gender"));
                a.setDob(rs.getString("dob"));
                a.setPhoneNumber(rs.getString("phone_number"));
                a.setAvatar(rs.getString("avatar"));
                a.setCountry(rs.getString("country"));
                a.setWallet(rs.getDouble("wallet"));
                a.setIsAvailable(rs.getBoolean("is_available"));
                a.setCreatedDate(rs.getString("created_date"));
                list.add(a);
            }
        } catch (Exception e) {
        }
        return list;
    }

    public Account checkAccountEmail(String email) {
        String sql = "select * from account where email = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, email);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Account a = new Account(rs.getInt("id"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("first_name"),
                        rs.getString("last_name"),
                        rs.getString("email"),
                        rs.getString("avatar"),
                        rs.getString("phone_number"),
                        rs.getBoolean("gender"),
                        rs.getString("country"),
                        rs.getDouble("wallet"),
                        rs.getString("dob"),
                        null);
                a.setIsAvailable(rs.getBoolean("is_available"));
                return a;
            }
        } catch (Exception e) {
        }
        return null;
    }

    public void enableAccount(String id) {
        String sql = "UPDATE [Account]\n"
                + "SET [is_available] = 1\n"
                + "WHERE id = " + id;
        try {
            PreparedStatement st = connection.prepareCall(sql);
            st.executeUpdate();
        } catch (Exception e) {
        }
    }

    public void disableAccount(String id) {
        String sql = "UPDATE [Account]\n"
                + "SET [is_available] = 0\n"
                + "WHERE id = " + id;
        try {
            PreparedStatement st = connection.prepareCall(sql);
            st.executeUpdate();
        } catch (Exception e) {
        }
    }

    public void changePass(int id, String pass) {
        String sql = "UPDATE [dbo].[Account]\n"
                + "   SET\n"
                + "[password] = ?\n"
                + " WHERE id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, pass);
            st.setInt(2, id);
            st.executeUpdate();
        } catch (Exception e) {
        }
    }

    public void updateProfile(int id, String phone, String country, String dob, String firstname, String lastname, String email) {

        String sql2 = "UPDATE [dbo].[Account]\n"
                + "   SET [email] = ?\n"
                + "      ,[first_name] = ?\n"
                + "      ,[last_name] = ?\n"
                + "      ,[dob] = ?\n"
                + "      ,[phone_number] = ?\n"
                + "      ,[country] = ?\n"
                + " WHERE id = ?";
        try {
            System.out.println(sql2);
            PreparedStatement st2 = connection.prepareStatement(sql2);
            st2.setString(1, email);
            st2.setString(2, firstname);
            st2.setString(3, lastname);
            st2.setString(4, dob);
            st2.setString(5, phone);
            st2.setString(6, country);
            st2.setInt(7, id);
            st2.executeUpdate();
        } catch (Exception e) {
        }
    }

    public boolean updateWallet(Account account) {
        String query = "UPDATE [dbo].[Account]\n"
                + "   SET [wallet] = ?\n"
                + "      \n"
                + " WHERE id = ?";
        try ( Connection conn = connection) {
            PreparedStatement statement = conn.prepareStatement(query);
            statement.setDouble(1, account.getWallet());
            statement.setInt(2, account.getId());
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Account getAccountByUsername(String username) {
        String sql = "select * from account where username = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Account a = new Account(rs.getInt("id"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("first_name"),
                        rs.getString("last_name"),
                        rs.getString("email"),
                        rs.getString("avatar"),
                        rs.getString("phone_number"),
                        rs.getBoolean("gender"),
                        rs.getString("country"),
                        rs.getDouble("wallet"),
                        rs.getString("dob"),
                        null);
                a.setIsAvailable(rs.getBoolean("is_available"));
                return a;
            }
        } catch (Exception e) {
        }
        return null;
    }

    public Cookie getCookie(Cookie[] coo, String name) {
        for (Cookie c : coo) {
            if (c.getName().equalsIgnoreCase(name)) {
                return c;
            }
        }
        return null;
    }

    public List<Account> getAllAccounts() {
        String sql = "SELECT * FROM Account";
        RoleDAO rdb = new RoleDAO();
        List<Account> list = new ArrayList<>();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Account(rs.getInt("id"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("first_name"),
                        rs.getString("last_name"),
                        rs.getString("email"),
                        rs.getString("avatar"),
                        rs.getString("phone_number"),
                        rs.getBoolean("gender"),
                        rs.getString("country"),
                        rs.getDouble("wallet"),
                        rs.getString("dob"),
                        rs.getBoolean("is_available"),
                        rs.getString("created_date"),
                        rdb.getRolesByAccountId(rs.getInt("id"))));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public String getToken(final String code) throws ClientProtocolException, IOException {
        String response = Request.Post(Constants.GOOGLE_LINK_GET_TOKEN)
                .bodyForm(Form.form().add("client_id", Constants.GOOGLE_CLIENT_ID)
                        .add("client_secret", Constants.GOOGLE_CLIENT_SECRET)
                        .add("redirect_uri", Constants.GOOGLE_REDIRECT_URI).add("code", code)
                        .add("grant_type", Constants.GOOGLE_GRANT_TYPE).build())
                .execute().returnContent().asString();
        JsonObject jobj = new Gson().fromJson(response, JsonObject.class);
        String accessToken = jobj.get("access_token").toString().replaceAll("\"", "");
        return accessToken;
    }

    public GooglePojo getUserInfo(final String accessToken) throws ClientProtocolException, IOException {
        String link = Constants.GOOGLE_LINK_GET_USER_INFO + accessToken;
        String response = Request.Get(link).execute().returnContent().asString();
        GooglePojo googlePojo = new Gson().fromJson(response, GooglePojo.class);
        System.out.println(googlePojo);
        return googlePojo;
    }

    public List<OrderHistory> getChargeTransaction(Account acc) {
        String query = "select * from [Transaction] as t\n"
                + "where t.account_id = ?\n"
                + "and t.value > 0\n"
                + "order by t.created_time desc";
        List<OrderHistory> list = new ArrayList<>();
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, acc.getId());
            ResultSet rs = ps.executeQuery();
            // format price

            while (rs.next()) {
                double price = rs.getDouble("value");
                String priceString = String.format("%.2f", price);
                String date = rs.getString("created_time");
                date = date.substring(0, 19);
                list.add(new OrderHistory(rs.getInt("id"),
                        priceString,
                        date,
                        rs.getString("note")));
            }

        } catch (Exception e) {
        }
        return list;
    }

    public void chargeWallet(Account acc, Transaction transaction) {
        String query = "UPDATE [dbo].[Account]\n"
                + "   SET [wallet] = ?\n"
                + "      \n"
                + " WHERE id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            double wallet = Double.parseDouble(transaction.getAmount().getDetails().getSubtotal()) + acc.getWallet();

            ps.setDouble(1, wallet);
            ps.setInt(2, acc.getId());
            ps.executeUpdate();
            String query2 = "INSERT INTO [dbo].[Transaction]\n"
                    + "           ([account_id]\n"
                    + "           ,[created_time]\n"
                    + "           ,[value]\n"
                    + "           ,[note])\n"
                    + "     VALUES\n"
                    + "           (?\n"
                    + "           ,GETDATE()\n"
                    + "           ,?\n"
                    + "           ,?)";
            PreparedStatement ps2 = connection.prepareStatement(query2);
            ps2.setInt(1, acc.getId());
            ps2.setString(2, transaction.getAmount().getDetails().getSubtotal());
            ps2.setString(3, "charge " + transaction.getDescription());
            ps2.executeUpdate();
        } catch (SQLException e) {

        }
    }

    public List<OrderHistory> getUsageTransaction(Account acc) {
        String query = "select * from [Transaction] as t\n"
                + "where t.account_id = ?\n"
                + "and t.value <= 0\n"
                + "order by t.created_time desc";
        List<OrderHistory> list = new ArrayList<>();
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, acc.getId());
            ResultSet rs = ps.executeQuery();
            // format price

            while (rs.next()) {
                double price = rs.getDouble("value");
                String priceString = String.format("%.2f", price);
                String date = rs.getString("created_time");
                date = date.substring(0, 19);
                list.add(new OrderHistory(rs.getInt("id"),
                        priceString,
                        date,
                        rs.getString("note")));
            }

        } catch (Exception e) {
        }
        return list;
    }

    public int getNumbersOfUserCurrentYear() {
        String sql = "select count(id) as num from Account where year(created_date) = year(GETDATE())";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt("num");
            }
        } catch (Exception e) {
        }
        return 0;
    }

    public List<OrderHistory> filterUsageTransaction(Account acc, String from, String to) {
        String query = "select * from [Transaction] as t\n"
                + "where t.account_id = ?\n"
                + "and t.value <= 0";
        if (from != null && from.trim().length() > 0) {
            query += " and t.created_time >= '" + from + "'\n";
        }
        if (to != null && to.trim().length() > 0) {
            query += " and t.created_time <= '" + to + " 23:59:59'\n";
        }
        query += "\norder by t.created_time desc";
        List<OrderHistory> list = new ArrayList<>();
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, acc.getId());
            ResultSet rs = ps.executeQuery();
            // format price

            while (rs.next()) {
                double price = rs.getDouble("value");
                String priceString = String.format("%.2f", price);
                String date = rs.getString("created_time");
                date = date.substring(0, 19);
                list.add(new OrderHistory(rs.getInt("id"),
                        priceString,
                        date,
                        rs.getString("note")));
            }

        } catch (Exception e) {
        }
        return list;
    }

    public List<OrderHistory> filterChargeTransaction(Account acc, String from, String to) {
        String query = "select * from [Transaction] as t\n"
                + "where t.account_id = ?\n"
                + "and t.value > 0";
        if (from != null && from.trim().length() > 0) {
            query += " and t.created_time >= '" + from + "'\n";
        }
        if (to != null && to.trim().length() > 0) {
            query += " and t.created_time <= '" + to + " 23:59:59'\n";
        }
        query += "\norder by t.created_time desc";
        List<OrderHistory> list = new ArrayList<>();
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, acc.getId());
            ResultSet rs = ps.executeQuery();
            // format price

            while (rs.next()) {
                double price = rs.getDouble("value");
                String priceString = String.format("%.2f", price);
                String date = rs.getString("created_time");
                date = date.substring(0, 19);
                list.add(new OrderHistory(rs.getInt("id"),
                        priceString,
                        date,
                        rs.getString("note")));
            }

        } catch (Exception e) {
        }
        return list;
    }

    //le hieu 26/09 ham nay de dem so user co trong he thong
    public int getNumberOfUsers() {
        String sql = "select count(ar.account_id) as [num] \n"
                + "from AccountRole ar, [Role] r\n"
                + "where ar.role_id = r.id and r.[name] = 'User'";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt("num");
            }
        } catch (Exception e) {
        }
        return 0;
    }

    public int getNumberOfAccounts() {
        String sql = "SELECT COUNT(id) as number FROM account ";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt("number");
            }
        } catch (Exception e) {
        }
        return 0;
    }

    public static void main(String[] args) {
        AccountDAO adb = new AccountDAO();
        for (Account a : adb.getAllAccounts()) {
            System.out.println(1);
        }
    }
}
