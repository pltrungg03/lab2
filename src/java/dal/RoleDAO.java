package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;
import model.*;

public class RoleDAO extends DBContext {

    public void updateRolesByAccountId(int accountId, String[] roleIds) {
        deleteAllRolesByAccountId(accountId);
        for (String roleId : roleIds) {
            updateRoleByAccountId(accountId, Integer.parseInt(roleId));
        }
    }

    public void updateRoleByAccountId(int accountId, int roleId) {
        String sql = "IF NOT EXISTS (SELECT * FROM [AccountRole] WHERE [account_id] = ? AND [role_id] = ?) "
                + "BEGIN "
                + "    INSERT INTO [AccountRole] ([account_id], [role_id]) VALUES (?, ?); "
                + "END;";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, accountId);
            st.setInt(2, roleId);
            st.setInt(3, accountId);
            st.setInt(4, roleId);
            int rowsAffected = st.executeUpdate();
            System.out.println("Updated " + rowsAffected + "row(s)");
        } catch (Exception e) {
            System.out.println("Update role error");
            e.printStackTrace();
        }
    }

    public void deleteAllRolesByAccountId(int accountId) {
        String sql = "DELETE FROM [AccountRole] WHERE [account_id] = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, accountId);
            int rowsAffected = st.executeUpdate();
            System.out.println("Deleted " + rowsAffected + "row(s)");
        } catch (Exception e) {
            System.out.println("Delete role error");
            e.printStackTrace();
        }
    }

    public List<Role> getAllRoles() {
        String sql = "SELECT * FROM Role \n"
                + "ORDER BY id";
        List<Role> list = new ArrayList<>();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Role(rs.getInt("id"),
                        rs.getString("name")));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public List<Role> getRolesByAccountId(int accountId) {
        String sql = "SELECT r.id, r.name\n"
                + "FROM AccountRole ar\n"
                + "JOIN Account a ON ar.account_id = a.id\n"
                + "JOIN Role r ON ar.role_id = r.id\n"
                + "WHERE ar.account_id = " + accountId;
        List<Role> list = new ArrayList<>();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Role(rs.getInt("id"),
                        rs.getString("name")));
            }
        } catch (Exception e) {
        }
        return list;
    }
}
