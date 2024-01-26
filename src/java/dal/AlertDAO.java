/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.time.LocalDate;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.*;
import model.Alert;

/**
 *
 * @author Admin
 */
public class AlertDAO extends DBContext{
    public void addAlert(String aid, String content) {
        LocalDate curDate = LocalDate.now();
        String date = curDate.toString();
        String sql = "INSERT INTO [dbo].[Alert]\n"
                + "           ([account_id]\n"
                + "           ,[created_date]\n"
                + "           ,[content])\n"
                + "     VALUES\n"
                + "           (?\n"
                + "           ,?\n"
                + "           ,?)";
        try {
           PreparedStatement st = connection.prepareStatement(sql);
           st.setString(1, aid);
           st.setString(2, date);
           st.setString(3, content);
           st.executeUpdate();
        } catch (Exception e) {
        }
    }
    public int countAlertByAccountId(String id){
        String sql = "select COUNT(account_id)[count] from Alert where account_id = ?";
        int n=0;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, id);
            ResultSet rs = st.executeQuery();
            while(rs.next()){
                n = rs.getInt("count");
                return n;
            }
        } catch (Exception e) {
        }
        return n;
    }
    
    public List<Alert> getAlertByAccountId(int id){
        String sql = "select * from alert where account_id = ?";
        AccountDAO a = new AccountDAO();
        List<Alert> list = new ArrayList<>();
        System.out.println(sql);
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            while(rs.next()){
                list.add(new Alert(rs.getInt("id"), a.getAccountById(rs.getInt("account_id")), rs.getString("created_date"), rs.getString("content")));
            }
        } catch (Exception e) {
        }
        return list;
    }
    
    public static void main(String[] args) {
        List<Alert> list = new ArrayList<>();
        AlertDAO a = new AlertDAO();
        list = a.getAlertByAccountId(5);
        System.out.println(list);
    }
    
}
