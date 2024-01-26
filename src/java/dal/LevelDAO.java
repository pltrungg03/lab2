package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util. *;
import model.*;


public class LevelDAO extends DBContext {

    public ArrayList<Level> getAllLevels() {
        ArrayList<Level> levels = new ArrayList<>();
        String query = "SELECT * FROM Level";
        try {
            PreparedStatement st = connection.prepareStatement(query);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                levels.add(new Level(rs.getInt("id"),
                        rs.getString("name")));
            }
            return levels;
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }
    
    public Level getLevelById(int id) {
        String query = "SELECT * FROM Level\n"
                + "WHERE id = " + id;
        try {
            PreparedStatement st = connection.prepareStatement(query);
            ResultSet rs = st.executeQuery();
            if(rs.next())
            {
                return new Level(rs.getInt("id"),
                        rs.getString("name"));
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }

    public static void main(String[] args) {
        LevelDAO ldb = new LevelDAO();
        for (Level l : ldb.getAllLevels()) {
            System.out.println(l);
        }
    }
}
