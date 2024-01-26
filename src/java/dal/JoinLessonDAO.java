/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author 84338
 */
public class JoinLessonDAO extends DBContext {
    
    //muon done 1 lesson thi phai xong lesson do va test cua lesson do, neu co
    public void confirmDoneLesson(int accId, int lId) {
        
        String sql = "UPDATE [dbo].[JoinLesson]\n"
                + "   SET \n"
                + "[is_passed] = ?\n"
                + " WHERE [account_id] = ? and \n"
                + " [lesson_id] = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setBoolean(1, true);
            st.setInt(2, accId);
            st.setInt(3, lId);
            st.executeUpdate();
        } catch (SQLException e) {

        }
    }
    
    public void confirmNotDoneLesson(int accId, int lId) {
        String sql = "UPDATE [dbo].[JoinLesson]\n"
                + "   SET \n"
                + "[is_passed] = ?\n"
                + " WHERE [account_id] = ? and \n"
                + " [lesson_id] = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setBoolean(1, false);
            st.setInt(2, accId);
            st.setInt(3, lId);
            st.executeUpdate();
        } catch (SQLException e) {

        }
    }
    
    public boolean isDoneLesson(int accId, int lId) {
        String sql = "select * from JoinLesson where account_id = ? and lesson_id = ?";
        
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, accId);
            st.setInt(2, lId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                boolean check = rs.getBoolean("is_passed");
                if (check)
                    return true;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }
    
    public static void main(String[] args) {
        JoinLessonDAO j = new JoinLessonDAO();
        System.out.println(j.isDoneLesson(4, 30));
            
    }
}
