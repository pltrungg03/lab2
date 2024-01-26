/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Major;

/**
 *
 * @author 84338
 */
public class HomepageDAO extends DBContext{
    public List<Major> getMajors() {
        String sql = "select * from Major";
        List<Major> list = new ArrayList();
        
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {                
                list.add(new Major(rs.getInt("id"), rs.getString("image"), 
                        rs.getString("name")));
            }
            return list;
        } catch (SQLException e) {
        }
        return null;
    }
}
