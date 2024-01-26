package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.Map;
import model.*;

public class MajorDAO extends DBContext {

    public ArrayList<Major> getAllMajors() {
        ArrayList<Major> majors = new ArrayList<>();
        String query = "SELECT * FROM Major";
        try {
            PreparedStatement st = connection.prepareStatement(query);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                majors.add(new Major(rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("image")));
            }
            return majors;
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }

    public Major getMajorById(int id) {
        String query = "SELECT * FROM Major\n"
                + "WHERE id = " + id;
        try {
            PreparedStatement st = connection.prepareStatement(query);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return new Major(rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("image"));
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }

    public static void main(String[] args) {
        MajorDAO mdb = new MajorDAO();
        for (Major m : mdb.getAllMajors()) {
            System.out.println(m);
        }
    }

    //le hieu - 25/9 ham nay de query ra cac major co so course giam dan
    public ArrayList<Major> getAllMajorOrderByNumberOfCourses() {
        ArrayList<Major> majors = new ArrayList<>();
        String query = "select m.id, m.[image], m.[name], \n"
                + "count(c.id) as [num]\n"
                + "from Major m, Course c where m.id = c.major_id\n"
                + "group by m.id, m.[image], m.[name]\n"
                + "order by [num] desc";
        try {
            PreparedStatement st = connection.prepareStatement(query);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                majors.add(new Major(rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("image")));
            }
            return majors;
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }

    
    public Map<String, Integer> getNumberOfCoureWithEachMajor() {
        Map<String, Integer> map = new LinkedHashMap<>();
        String sql = "select m.id, m.[name], count(c.id) as num from Major m left join Course c on\n"
                + "c.major_id = m.id\n"
                + "group by m.id, m.[name] ";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                map.put(rs.getString("name"), rs.getInt("num"));
            }
        } catch (Exception e) {
        }
        return map;
    }
    
    //le hieu 26/09 ham nay de dem so major co trong he thong
    public int getNumberOfMajors() {
        String sql = "select count(id) as [num] from Major";

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
}
