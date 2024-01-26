/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.PremiumPack;

/**
 *
 * @author ADMIN
 */
public class PremiumPackDAO extends DBContext {
    
    public List<PremiumPack> getAllPack(){
        List<PremiumPack> list = new ArrayList<>();
        
        String query = "select p.id,p.name,p.price,p.value from PremiumPack as p";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                list.add(new PremiumPack(rs.getInt("id"),
                        rs.getString("name"),
                        rs.getDouble("price"),
                        rs.getInt("value")));
            }
        } catch (Exception e) {
        }
        
        return list;
    }
    
    public void insertPackage(String name, double price, int value) {
        String query = "INSERT INTO [dbo].[PremiumPack]\n"
                + "           ([name]\n"
                + "           ,[price]\n"
                + "           ,[value])\n"
                + "     VALUES\n"
                + "           (?\n"
                + "           ,?\n"
                + "           ,?)";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, name);
            ps.setDouble(2, price);
            ps.setInt(3, value);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }
    
    public void updatePackage(int id, String name, double price, int value) {
        String query = "UPDATE [dbo].[PremiumPack]\n"
                + "   SET [name] = ?\n"
                + "      ,[price] = ?\n"
                + "      ,[value] = ?\n"
                + " WHERE id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, name);
            ps.setDouble(2, price);
            ps.setInt(3, value);
            ps.setInt(4, id);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public void deletePackage(int id) {
        String query = "DELETE FROM [dbo].[PremiumPack]\n"
                + "      WHERE id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }
}
