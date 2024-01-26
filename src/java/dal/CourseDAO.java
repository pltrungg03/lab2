package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.*;
import model.*;

public class CourseDAO extends DBContext {

    public List<Course> getAllCourses() {
        List<Course> courses = new ArrayList<>();
        String query = "SELECT c.id, c.name, c.price, c.discount, c.image, c.description, c.created_date, c.updated_date,\n"
                + "AVG(jc.rating) as rating, COUNT(jc.course_id) as student_number,\n"
                + "m.id as major_id, m.[name] as major, m.image as major_image,\n"
                + "l.id as level_id, l.[name] as [level],\n"
                + "a.id as creator_id, a.first_name, a.last_name\n"
                + "FROM Course c\n"
                + "LEFT JOIN Major m ON c.major_id = m.id\n"
                + "LEFT JOIN Level l ON c.level_id = l.id\n"
                + "LEFT JOIN Account a ON c.creator_id = a.id\n"
                + "FULL JOIN JoinCourse jc ON c.id = jc.course_id\n"
                + "GROUP BY c.id, c.name, c.price, c.discount, c.image, c.description, c.created_date, c.updated_date, m.id, m.name, m.image, l.id, l.name, a.id, a.first_name, a.last_name";
        try {
            PreparedStatement st = connection.prepareStatement(query);
            ResultSet rs = st.executeQuery();
            AccountDAO adb = new AccountDAO();
            while (rs.next()) {
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
                        new Level(rs.getInt("level_id"),
                                rs.getString("level")),
                        creator,
                        0,
                        rs.getDouble("rating"),
                        false,
                        "unknown",
                        null,
                        null));
            }
            return courses;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public int getNumbersOfCourseBePurchasedCurrentYear() {
        String sql = "select count(account_id) as [num] from JoinCourse where year(joined_date) = year(GETDATE())";

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
    
    public double getAverageratingOfAllCourses() {
        String sql = "select avg(rating) as [rating] from JoinCourse";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getDouble("rating");
            }
        } catch (Exception e) {
        }
        return 0;
    }

    public Course getCourseById(int id) {
        ChapterDAO chdb = new ChapterDAO();
        String query = "SELECT c.id, c.name, c.price, c.discount, c.image, c.description, c.created_date, c.updated_date,\n"
                + "AVG(jc.rating) as rating, COUNT(jc.course_id) as student_number,\n"
                + "m.id as major_id, m.[name] as major, m.image as major_image,\n"
                + "l.id as level_id, l.[name] as [level],\n"
                + "a.id as creator_id, a.first_name, a.last_name\n"
                + "FROM Course c\n"
                + "LEFT JOIN Major m ON c.major_id = m.id\n"
                + "LEFT JOIN Level l ON c.level_id = l.id\n"
                + "LEFT JOIN Account a ON c.creator_id = a.id\n"
                + "FULL JOIN JoinCourse jc ON c.id = jc.course_id\n"
                + "WHERE c.id = " + id + "\n"
                + "GROUP BY c.id, c.name, c.price, c.discount, c.image, c.description, c.created_date, c.updated_date, m.id, m.name, m.image, l.id, l.name, a.id, a.first_name, a.last_name";
        try {
            PreparedStatement st = connection.prepareStatement(query);
            ResultSet rs = st.executeQuery();
            AccountDAO adb = new AccountDAO();
            if (rs.next()) {
                Account creator = adb.getAccountById(rs.getInt("creator_id"));
                return new Course(
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
                        new Level(rs.getInt("level_id"),
                                rs.getString("level")),
                        creator,
                        0,
                        rs.getDouble("rating"),
                        false,
                        "unknown",
                        chdb.getChaptersByCourseId(rs.getInt("id")),
                        null);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public Course checkJoinedCourse(int accountId, int courseId) {
        CourseDAO daoC = new CourseDAO();
        List<Course> list = daoC.getMyCourse(accountId);
        for (Course c : list) {
            if (c.getId() == courseId) {
                return c;
            }
        }
        return null;
    }

    public List<Course> getCourses(String keyword, String sort, String page, int coursesPerPage, String[] major_ids, String[] level_ids) {
        List<Course> courses = new ArrayList<>();
        String query = "SELECT c.id, c.name, c.price, c.discount, c.image, c.description, c.created_date, c.updated_date,\n"
                + "AVG(jc.rating) as rating, COUNT(jc.course_id) as student_number,\n"
                + "m.id as major_id, m.[name] as major, m.image as major_image,\n"
                + "l.id as level_id, l.[name] as [level],\n"
                + "a.id as creator_id, a.first_name, a.last_name\n"
                + "FROM Course c\n"
                + "LEFT JOIN Major m ON c.major_id = m.id\n"
                + "LEFT JOIN Level l ON c.level_id = l.id\n"
                + "LEFT JOIN Account a ON c.creator_id = a.id\n"
                + "FULL JOIN JoinCourse jc ON c.id = jc.course_id\n"
                + "WHERE 0 = 0\n";
        String temp = "";

        // Search by name
        if (keyword != null && keyword.trim().length() > 0) {
            temp = "AND c.name LIKE '%" + keyword + "%'\n";
            query += temp;
        }

        // Classify by majors
        if (major_ids != null && major_ids.length > 0) {
            temp = "AND m.id IN (0";
            for (String s : major_ids) {
                temp += "," + s;
            }
            temp += ")\n";
            query += temp;
        }

        // Classify by levels
        if (level_ids != null && level_ids.length > 0) {
            temp = "AND l.id IN (0";
            for (String s : level_ids) {
                temp += "," + s;
            }
            temp += ")\n";
            query += temp;
        }

        query += "GROUP BY c.id, c.name, c.price, c.discount, c.image, c.description, c.created_date, c.updated_date,\n"
                + "m.id, m.name, m.image,\n"
                + "l.id, l.name,\n"
                + "a.id, a.first_name, a.last_name\n";

        // Arrange courses
        if (sort != null && sort.length() > 0) {
            if (sort.equals("1")) {
                temp = "ORDER BY c.name ASC \n";
            } else if (sort.equals("2")) {
                temp = "ORDER BY c.name DESC \n";
            } else if (sort.equals("3")) {
                temp = "ORDER BY c.price ASC \n";
            } else if (sort.equals("4")) {
                temp = "ORDER BY c.price DESC \n";
            } else if (sort.equals("5")) {
                temp = "ORDER BY c.created_date DESC \n";
            } else if (sort.equals("6")) {
                temp = "ORDER BY student_number DESC \n";
            } else if (sort.equals("7")) {
                temp = "ORDER BY rating DESC \n";
            }
        } else {
            temp = "ORDER BY c.name ASC \n";
        }

        query += temp;

        // Paginate courses
        if (page != null) {
            int p = Integer.parseInt(page);
            temp = "OFFSET 0 ROWS FETCH NEXT " + (p * coursesPerPage) + " ROWS ONLY\n";
            query += temp;
        }

        System.out.println(query);

        try {
            PreparedStatement st = connection.prepareStatement(query);
            ResultSet rs = st.executeQuery();
            AccountDAO adb = new AccountDAO();
            ChapterDAO cdb = new ChapterDAO();
            while (rs.next()) {
                Account creator = adb.getAccountById(rs.getInt("creator_id"));
                Course c = new Course(
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
                        new Level(rs.getInt("level_id"),
                                rs.getString("level")),
                        creator,
                        rs.getInt("student_number"),
                        rs.getDouble("rating"),
                        false,
                        "unknown",
                        null,
                        null);
//                c.setChapters(cdb.getChaptersByCourseId(c.getId()));
                courses.add(c);
            }
            return courses;
        } catch (SQLException e) {
            System.out.println(e);
        }

        return null;
    }

    public double getAvgRating(int courseId) {
        String query = "select AVG(jc.rating) as [avg_rating] from JoinCourse jc\n"
                + "where jc.course_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, courseId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getDouble("avg_rating");
            }

        } catch (SQLException e) {

        }
        return 0;
    }

    public int getTotalJoinCourseQuantity() {
        String query = "SELECT COUNT(jc.account_id) FROM JoinCourse jc";
        try {
            PreparedStatement st = connection.prepareStatement(query);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt("num");
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }

    public int getJoinCourseQuantity(int courseId) {
        String query = "select COUNT(jc.account_id) as quantity\n"
                + "                FROM Course c             \n"
                + "                JOIN JoinCourse jc ON c.id = jc.course_id\n"
                + "                WHERE c.id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(query);
            st.setInt(1, courseId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt("quantity");
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }

    public int getCourseQuantity(String keyword, String sort, String page, int coursesPerPage, String[] major_ids, String[] level_ids) {
        String query = "SELECT COUNT(c.id) as quantity FROM Course c\n"
                + "LEFT JOIN Major m ON c.major_id = m.id\n"
                + "LEFT JOIN Level l ON c.level_id = l.id\n"
                + "LEFT JOIN Account a ON c.creator_id = a.id\n"
                + "WHERE 0 = 0\n";
        // Search by name
        if (keyword != null && keyword.trim().length() > 0) {
            String temp = "AND c.name LIKE '%" + keyword + "%'\n";
            query += temp;
        }

        // Classify by majors
        if (major_ids != null && major_ids.length > 0) {
            String temp = "AND m.id IN (0";
            for (String s : major_ids) {
                temp += "," + s;
            }
            temp += ")\n";
            query += temp;
        }

        // Classify by levels
        if (level_ids != null && level_ids.length > 0) {
            String temp = "AND l.id IN (0";
            for (String s : level_ids) {
                temp += "," + s;
            }
            temp += ")\n";
            query += temp;
        }

        try {
            PreparedStatement st = connection.prepareStatement(query);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt("quantity");
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }

    public List<Course> getMyCourse(int accountId) {

        List<Course> list = new ArrayList<>();
        CourseDAO daoC = new CourseDAO();
        String query = "SELECT c.id, c.name, c.price, c.discount, c.image, c.description, c.created_date, c.updated_date,\n"
                + "AVG(jc.rating) as rating, COUNT(jc.course_id) as student_number,\n"
                + "m.id as major_id, m.[name] as major, m.image as major_image,\n"
                + "l.id as level_id, l.[name] as [level],\n"
                + "a.id as creator_id, a.first_name, a.last_name\n"
                + "FROM Course c\n"
                + "LEFT JOIN Major m ON c.major_id = m.id\n"
                + "LEFT JOIN Level l ON c.level_id = l.id\n"
                + "LEFT JOIN Account a ON c.creator_id = a.id\n"
                + "FULL JOIN JoinCourse jc ON c.id = jc.course_id\n"
                + "WHERE jc.account_id = ?\n"
                + "GROUP BY c.id, c.name, c.price, c.discount, c.image, c.description, c.created_date, c.updated_date, m.id, m.name, m.image, l.id, l.name, a.id, a.first_name, a.last_name";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, accountId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                double avgRating = daoC.getAvgRating(rs.getInt("id"));
                Course c = new Course(
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
                        new Level(rs.getInt("level_id"),
                                rs.getString("level")),
                        new Account(rs.getInt("creator_id")),
                        0,
                        rs.getDouble("rating"),
                        false,
                        "unknown",
                        null,
                        null);
                list.add(c);
            }

        } catch (SQLException e) {

        }

        return list;

    }

    //Le Hieu - 16/9 - Day la ham de tra ve list Course sap xep theo rating giam dan
    public List<Course> getCourseOrderByRatingDesc() {
        MajorDAO majorDAO = new MajorDAO();
        LevelDAO levelDAO = new LevelDAO();
        AccountDAO accDAO = new AccountDAO();
        List<Course> list = new ArrayList();
        String sql = "select c.*, r.avgRating from Course c left join \n"
                + "(select course_id, round(avg(rating), 2) as [avgRating] from JoinCourse\n"
                + "group by course_id) r\n"
                + "on c.id = r.course_id\n"
                + "order by r.avgRating desc";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Course c = new Course();
                c.setId(rs.getInt("id"));
                c.setName(rs.getString("name"));
                c.setPrice(rs.getDouble("price"));
                c.setImage(rs.getString("image"));
                c.setDescription(rs.getString("description"));
                c.setCreatedDate(rs.getString("created_date"));
                c.setMajor(majorDAO.getMajorById(rs.getInt("major_id")));
                c.setLevel(levelDAO.getLevelById(rs.getInt("level_id")));
                c.setCreator(accDAO.getAccountById(rs.getInt("creator_id")));
                c.setAvgRating(rs.getDouble("avgRating"));
                list.add(c);
            }
        } catch (SQLException e) {

        }
        return list;
    }

    public List<Course> filterRegistration(String m_id, String l_id, String mail,
            String dateFrom, String dateTo, String op, String min, String max, String coursename, String cre_id) {
        AccountDAO accountDAO = new AccountDAO();
        List<Course> list = new ArrayList<>();
        String tmp = " ";
        String sql = "select  j.joined_date[Registration Time], c.name[Course_name], c.image[Course_Image], c.discount, c.updated_date,c.description, c.id[course_id],\n"
                + "                C.price[Cost], c.created_date[Creation Time], c.creator_id[creator_id], j.is_passed[is_passed],\n"
                + "                j.rating[Rating], c.image[image],  a.id[learnerID], m.name[major_name], l.name[level_name]\n"
                + "                from Account a, Course c, JoinCourse j, Level l, Major m \n"
                + "               where a.id = j.account_id and c.id = j.course_id and l.id = c.level_id and m.id = c.major_id ";
        if (m_id != null && m_id.trim().length() > 0) {
            tmp = " and m.id in (" + m_id;
            sql += tmp + ")";
        }
        if (l_id != null && l_id.trim().length() > 0) {
            tmp = " and l.id in (" + l_id;
            sql += tmp + ")";
        }
        if (cre_id != null && cre_id.trim().length() > 0) {
            tmp = " and c.creator_id in (" + cre_id;
            sql += tmp + "0)";
        }
        if (mail != null && mail.trim().length() > 0) {
            sql += " and a.email LIKE'%" + mail + "%'";
        }
        if (coursename != null && coursename.trim().length() > 0) {
            sql += " and c.name LIKE'%" + coursename + "%'";
        }
        if (dateFrom != null && dateFrom.trim().length() > 0) {
            sql += " and j.joined_date >= '" + dateFrom + "'";
        }
        if (dateTo != null && dateTo.trim().length() > 0) {
            sql += " and j.joined_date <= '" + dateTo + "'";
        }
        if (min != null && min.trim().length() > 0) {
            sql += " and c.price >= " + min;
        }
        if (max != null && max.trim().length() > 0) {
            sql += " and c.price <= " + max;
        }
        if (op != null && op.trim().length() > 0) {
            sql += " order by " + op;
        }
        System.out.println(sql);
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Account creator = accountDAO.getAccountById(rs.getInt("creator_id"));
                List<Account> learner = new ArrayList<>();

                learner.add(accountDAO.getAccountById(rs.getInt("learnerID")));
                Major major = new Major(0, rs.getString("major_name"));
                Level level = new Level(0, rs.getString("level_name"));
                list.add(new Course(rs.getInt("course_id"),
                        rs.getString("Course_name"),
                        rs.getDouble("Cost"),
                        rs.getDouble("discount"),
                        rs.getString("Course_Image"),
                        rs.getString("description"),
                        rs.getString("Creation Time"),
                        rs.getString("updated_date"),
                        major, level, creator, 0, rs.getDouble("Rating"),
                        rs.getBoolean("is_passed"), rs.getString("Registration Time"), null, learner));

            }
        } catch (Exception e) {
        }
        return list;
    }

    public void joinCourse(Account acc, int courseId) {
        CourseDAO daoC = new CourseDAO();
        AccountDAO daoA = new AccountDAO();
        if (daoC.checkJoinedCourse(acc.getId(), courseId) == null) {
            String query = "INSERT INTO [dbo].[JoinCourse]\n"
                    + "           ([account_id]\n"
                    + "           ,[course_id]\n"
                    + "           ,[joined_date]\n"
                    + "           ,[is_passed])\n"
                    + "     VALUES\n"
                    + "           (?\n"
                    + "           ,?\n"
                    + "           ,getdate()\n"
                    + "           ,0)";

            try {

                PreparedStatement ps = connection.prepareStatement(query);
                ps.setInt(1, acc.getId());
                ps.setInt(2, courseId);
                ps.executeUpdate();
                System.out.println("join success!");
                // update wallet
                String query2 = "UPDATE [dbo].[Account]\n"
                        + "   SET [wallet] = ?\n"
                        + "      \n"
                        + " WHERE id = ?";
                PreparedStatement ps2 = connection.prepareStatement(query2);
                ps2.setDouble(1, acc.getWallet());
                ps2.setInt(2, acc.getId());
                ps2.executeUpdate();
                System.out.println("wallet  success!");

                Course c = daoC.getCourseById(courseId);
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
                PreparedStatement ps3 = connection.prepareStatement(query3);
                ps3.setInt(1, acc.getId());
                String note = "";
                
                String expiredDate = daoA.dateExpiredVIP(acc);
                if (expiredDate != null) {

                    // so sanh expired_date cu voi ngay hien tai
                    if (daoA.checkExpiredVIP(expiredDate)) {
                        // het han thi join mat tien binh thuong
                        System.out.println("checkkkk=========VIPHETHAN");
                        ps3.setDouble(2, -c.getPrice());
                        note = "join #" +c.getId()+" '"+ c.getName() + "' course by payment";
                    } else {
                        // con han thi join free
                        System.out.println("checkkkk=========VIP");
                        ps3.setDouble(2, 0.0);
                        note = "join #" +c.getId()+" '"+ c.getName() + "' course by VIP";
                    }

                } else {
                    ps3.setDouble(2, -c.getPrice());
                    System.out.println("checkkkk=========NOR");
                    note = "join #" +c.getId()+" '"+ c.getName() + "' course by payment";
                }
                ps3.setString(3, note);
                ps3.executeUpdate();

            } catch (SQLException e) {

            }
        } else {
            String query = "UPDATE [dbo].[JoinCourse]\n"
                    + "   SET [joined_date] = GETDATE()\n"
                    + "      \n"
                    + " WHERE account_id = ? and course_id = ?";
            try {
                PreparedStatement ps = connection.prepareStatement(query);
                ps.setInt(1, acc.getId());
                ps.setInt(2, courseId);
                ps.executeUpdate();
                //
                // update wallet
                String query2 = "UPDATE [dbo].[Account]\n"
                        + "   SET [wallet] = ?\n"
                        + "      \n"
                        + " WHERE id = ?";
                PreparedStatement ps2 = connection.prepareStatement(query2);
                ps2.setDouble(1, acc.getWallet());
                ps2.setInt(2, acc.getId());
                ps2.executeUpdate();
                System.out.println("wallet  success!");

                Course c = daoC.getCourseById(courseId);
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
                PreparedStatement ps3 = connection.prepareStatement(query3);
                ps3.setInt(1, acc.getId());
                String note = "";
                String expiredDate = daoA.dateExpiredVIP(acc);
                if (expiredDate != null) {

                    // so sanh expired_date cu voi ngay hien tai
                    if (daoA.checkExpiredVIP(expiredDate)) {
                        // het han thi join mat tien binh thuong

                        ps3.setDouble(2, -c.getPrice());
                        note = "join #" +c.getId()+" '"+ c.getName() + "' course by payment";
                    } else {
                        // con han thi join free
                        ps3.setDouble(2, 0.0);
                        note = "join #" +c.getId()+" '"+ c.getName() + "' course by VIP";
                    }

                }
                ps3.setString(3, note);
                ps3.executeUpdate();
            } catch (Exception e) {
            }
        }

    }

    public List<Course> filterMyCourse(String op, String majorId, String levelId, String search, int accountId) {
        List<Course> list = new ArrayList<>();
        String query = "SELECT c.id, c.name, c.price, c.discount, c.image, c.description, c.created_date, c.updated_date,\n"
                + "AVG(jc.rating) as rating, COUNT(jc.course_id) as student_number,\n"
                + "m.id as major_id, m.[name] as major, m.image as major_image,\n"
                + "l.id as level_id, l.[name] as [level],\n"
                + "a.id as creator_id, a.first_name, a.last_name\n"
                + "FROM Course c\n"
                + "LEFT JOIN Major m ON c.major_id = m.id\n"
                + "LEFT JOIN Level l ON c.level_id = l.id\n"
                + "LEFT JOIN Account a ON c.creator_id = a.id\n"
                + "FULL JOIN JoinCourse jc ON c.id = jc.course_id\n"
                + "WHERE jc.account_id = ?\n";
        CourseDAO daoC = new CourseDAO();
        if (majorId != null && majorId.trim().length() > 0) {
            String tmp = " and c.major_id in (";
            tmp += majorId;
            query += tmp + ")\n";
        }
        if (levelId != null && levelId.trim().length() > 0) {
            String tmp = " and c.level_id in (";
            tmp += levelId;
            query += tmp + ")\n";
        }

        if (search != null && search.trim().length() > 0) {
            query += " and c.name like '%" + search + "%'\n";
        }
        query += "GROUP BY c.id, c.name, c.price, c.discount, c.image, c.description, c.created_date, c.updated_date, m.id, m.name, m.image, l.id, l.name, a.id, a.first_name, a.last_name\n";

        if (op != null && op.trim().length() > 0) {
            query += " order by " + op;
        }
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, accountId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                double avgRating = daoC.getAvgRating(rs.getInt("id"));
                Course c = new Course(
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
                        new Level(rs.getInt("level_id"),
                                rs.getString("level")),
                        new Account(rs.getInt("creator_id")),
                        0,
                        rs.getDouble("rating"),
                        false,
                        "unknown",
                        null,
                        null);
                list.add(c);
            }
        } catch (SQLException e) {

        }
        return list;
    }

    //Le Hieu - 16/9 - Day la ham de tra ve list Course sap xep theo thoi gian ra mat
    public List<Course> getCourseOrderReleaseDate() {
        MajorDAO majorDAO = new MajorDAO();
        LevelDAO levelDAO = new LevelDAO();
        AccountDAO accDAO = new AccountDAO();
        List<Course> list = new ArrayList();
        String sql = "select c.*, r.avgRating from Course c left join \n"
                + "(select course_id, round(avg(rating), 2) as [avgRating] from JoinCourse\n"
                + "group by course_id) r\n"
                + "on c.id = r.course_id\n"
                + "order by c.created_date desc";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Course c = new Course();
                c.setId(rs.getInt("id"));
                c.setName(rs.getString("name"));
                c.setPrice(rs.getDouble("price"));
                c.setImage(rs.getString("image"));
                c.setDescription(rs.getString("description"));
                c.setCreatedDate(rs.getString("created_date"));
                c.setMajor(majorDAO.getMajorById(rs.getInt("major_id")));
                c.setLevel(levelDAO.getLevelById(rs.getInt("level_id")));
                c.setCreator(accDAO.getAccountById(rs.getInt("creator_id")));
                c.setAvgRating(rs.getDouble("avgRating"));
                list.add(c);
            }
        } catch (SQLException e) {
        }
        return list;
    }

    //le hieu 25/9 ham nay de luu so luot review tuong ung voi 1 course
    public Map<Integer, Integer> getNumbersRatingOfCourse() {
        Map<Integer, Integer> map = new LinkedHashMap<>();
        String sql = "select c.id, count(cc.account_id) as [num] from \n"
                + "Course c left join JoinCourse cc\n"
                + "on c.id = cc.course_id\n"
                + "group by c.id\n"
                + "order by [num] desc";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                map.put(rs.getInt("id"), rs.getInt("num"));
            }
        } catch (Exception e) {
        }
        return map;
    }

    public int getNumberOfCourses() {
        String sql = "select count(id) as [num] from Course";

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

    //le hieu 10/5 ham nay de lay thong tin cua Course, bao gom ca Chapter trong do 
    public Course getCourseByIdIncludeCheckingProgress(int id, int accId) {

        MajorDAO mDAO = new MajorDAO();
        JoinCourseDAO jcDAO = new JoinCourseDAO();
        LevelDAO lDAO = new LevelDAO();
        ChapterDAO cDAO = new ChapterDAO();
        String sql = "select * from Course where id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Course c = new Course();
                c.setId(rs.getInt("id"));
                c.setName(rs.getString("name"));
                c.setDescription(rs.getString("description"));
                c.setMajor(mDAO.getMajorById(rs.getInt("major_id")));
                c.setImage(rs.getString("image"));
                c.setLevel(lDAO.getLevelById(rs.getInt("level_id")));
                c.setChapters(cDAO.getChaptersByCourseIdIncludeCheckingDone(id, accId));
                if (checkingDone1CourseOfAccount(id, accId)) {
                    if (!jcDAO.isPassedCourse(accId, id)) {
                        updateStatusOf1Course(accId, id, true);
                        jcDAO.updatePassedDateCourse(accId, id);
                    }
                    c.setIsPassed(true);
                    if (jcDAO.getDatePassedCourse(id, accId) != null) {
                        c.setPassedDate(jcDAO.getDatePassedCourse(id, accId));
                    }

                } else {
                    //updateStatusOf1Course(accId, id, false);
                    c.setIsPassed(false);
                }

                c.setJoinedDate(jcDAO.getDateJoinCourse(id, accId));
                return c;
            }
        } catch (Exception e) {
        }
        return null;
    }

    public boolean checkingDone1CourseOfAccount(int courseId, int accId) {
        ChapterDAO cDAO = new ChapterDAO();
        int numberChaptersOfCourse = cDAO.countChapterIn1Course(courseId);
        int numberChaptersUserDone = cDAO.countChapterDoneIn1CourseByIdAndAccountId(courseId, accId);
        if (numberChaptersOfCourse == numberChaptersUserDone) {
            return true;
        }
        return false;
    }

    public void updateStatusOf1Course(int accId, int courseId, boolean stt) {
        String sql = "UPDATE [dbo].[JoinCourse]\n"
                + "   SET \n"
                + "[is_passed] = ?\n"
                + "      \n"
                + " WHERE [account_id] = ?\n"
                + "      and [course_id] = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setBoolean(1, stt);
            st.setInt(2, accId);
            st.setInt(3, courseId);
            st.executeUpdate();

        } catch (Exception e) {
        }
    }

    public int getCourseIdByChapterId(int chapId) {
        String sql = "select course_id from Chapter where id = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, chapId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt("course_id");
            }
        } catch (SQLException e) {
        }
        return 0;
    }

    public int getCourseIdByLessonId(int lId) {
        String sql = "select course_id from Chapter where id = (\n"
                + "select chapter_id from Lesson where id = ?)";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, lId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt("course_id");
            }
        } catch (Exception e) {
        }
        return 0;
    }

    public List<Course> getAllRegistration() {
        AccountDAO accountDAO = new AccountDAO();
        String sql = "select  j.joined_date[Registration Time], c.name[Course_name], c.image[Course_Image], c.discount, c.updated_date,c.description, c.id[course_id],\n"
                + "                               C.price[Cost], c.created_date[Creation Time], c.creator_id[creator_id], j.is_passed[is_passed],\n"
                + "                              j.rating[Rating], c.image[image],  a.id[learnerID], m.name[major_name], l.name[level_name]\n"
                + "                                from Account a, Course c, JoinCourse j, Level l, Major m \n"
                + "                               where a.id = j.account_id and c.id = j.course_id and l.id = c.level_id and m.id = c.major_id order by joined_date desc";
        List<Course> list = new ArrayList<>();

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Account creator = accountDAO.getAccountById(rs.getInt("creator_id"));
                List<Account> learner = new ArrayList<>();

                learner.add(accountDAO.getAccountById(rs.getInt("learnerID")));
                Major major = new Major(0, rs.getString("major_name"));
                Level level = new Level(0, rs.getString("level_name"));
                //int id, String name, double price, double discount, String image, String description, String createdDate,
                //String updateDate, Major major, Level level, 
                //Account creator, int studentNumber, double avgRating, boolean isPassed,
                //String joinedDate, List<Chapter> chapters, List<Account> students
                list.add(new Course(rs.getInt("course_id"),
                        rs.getString("Course_name"),
                        rs.getDouble("Cost"),
                        rs.getDouble("discount"),
                        rs.getString("Course_Image"),
                        rs.getString("description"),
                        rs.getString("Creation Time"),
                        rs.getString("updated_date"),
                        major, level, creator, 0, rs.getDouble("Rating"),
                        rs.getBoolean("is_passed"), rs.getString("Registration Time"), null, learner));

            }
        } catch (Exception e) {
        }
        return list;
    }

    public Course getRegistrationDetial(String aid, String cid) {
        AccountDAO accountDAO = new AccountDAO();
        ChapterDAO chap = new ChapterDAO();
        String sql = "select j.*, a.*, c.*,ch.*,c.name[course_name], l.id [level_id], l.name[level_name],"
                + " m.id[major_id], m.name[major_name], ch.id[chapter_id], ch.name[chapter_name]\n"
                + "                  from Account a, Course c, JoinCourse j, Level l, Major m, Chapter ch\n"
                + "                  where a.id = j.account_id and c.id = j.course_id and l.id ="
                + " c.level_id and m.id = c.major_id  and a.id =?  and c.id = ?";
        Course list = new Course();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, aid);
            st.setString(2, cid);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Account creator = accountDAO.getAccountById(rs.getInt("creator_id"));
                List<Account> learner = new ArrayList<>();

                learner.add(accountDAO.getAccountById(rs.getInt("account_id")));
                Major major = new Major(rs.getInt("major_id"), rs.getString("major_name"));
                Level level = new Level(rs.getInt("level_id"), rs.getString("level_name"));
                List<Chapter> ch = chap.getChaptersByCourseId(rs.getInt("course_id"));
                list = (new Course(rs.getInt("course_id"),
                        rs.getString("course_name"),
                        rs.getDouble("price"),
                        rs.getDouble("discount"),
                        rs.getString("image"),
                        rs.getString("description"),
                        rs.getString("created_date"),
                        rs.getString("updated_date"),
                        major, level, creator, 0, rs.getDouble("rating"),
                        rs.getBoolean("is_passed"), rs.getString("joined_date"), ch, learner));

            }
        } catch (Exception e) {
        }
        return list;
    }

    public List<Course> getAllCoursesByCreatorId(int id) {
        List<Course> courses = new ArrayList<>();
        String query = "SELECT [id]\n"
                + "      ,[name]\n"
                + "      ,[price]\n"
                + "      ,[discount]\n"
                + "      ,[image]\n"
                + "      ,[description]\n"
                + "      ,[created_date]\n"
                + "      ,[updated_date]\n"
                + "      ,[major_id]\n"
                + "      ,[level_id]\n"
                + "      ,[creator_id]\n"
                + "  FROM [dbo].[Course]\n"
                + "  WHERE [creator_id] = ?";
        try {
            PreparedStatement st = connection.prepareStatement(query);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            AccountDAO adb = new AccountDAO();
            while (rs.next()) {
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
                                null,
                                null),
                        new Level(rs.getInt("level_id"),
                                null),
                        creator,
                        0,
                        0,
                        false,
                        "unknown",
                        null,
                        null));
            }
            return courses;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public void updateCourse(int id, String name, String image, double price, double discount, int majorId, int levelId, String description) {
        String query = "UPDATE Course SET name = ?,"
                + " price = ?,"
                + " discount = ?,"
                + " image = ?,"
                + " description = ?,"
                + " updated_date = GETDATE(),"
                + " major_id = ?,"
                + " level_id = ?"
                + " WHERE id = ?";

        try {
            PreparedStatement st = connection.prepareStatement(query);
            st.setString(1, name);
            st.setDouble(2, price);
            st.setDouble(3, discount);
            st.setString(4, image);
            st.setString(5, description);
            st.setInt(6, majorId);
            st.setInt(7, levelId);
            st.setInt(8, id);

            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Update course error: " + e.getMessage());
        }
    }

    public int insertCourseReturnId(String name, double price, double discount,
            String image, String description, String createdDate, int majorId, int levelId, int creatorId) {
        String query = "INSERT INTO [Course] "
                + "([name], [price], [discount], [image], [description], [created_date], [updated_date], [major_id], [level_id], [creator_id]) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";
        int generatedId = 0;

        try {
            PreparedStatement st = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            st.setString(1, name);
            st.setDouble(2, price);
            st.setDouble(3, discount);
            st.setString(4, image);
            st.setString(5, description);
            st.setString(6, createdDate);
            st.setString(7, createdDate);
            st.setInt(8, majorId);
            st.setInt(9, levelId);
            st.setInt(10, creatorId);

            st.executeUpdate();

            ResultSet generatedKeys = st.getGeneratedKeys();
            if (generatedKeys.next()) {
                generatedId = generatedKeys.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }

        return generatedId;
    }
    
    
    public void removeCourseCommentByCourseId(int courseId) {
        String query = "DELETE FROM CourseComment WHERE course_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(query);
            st.setInt(1, courseId);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
    
    public void removeJoinCourseByCourseId(int courseId) {
        String query = "DELETE FROM JoinCourse WHERE course_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(query);
            st.setInt(1, courseId);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
    
    public void removeCourseByCourseId(int courseId) {
        // Common
        CourseDAO cdb = new CourseDAO();
        ChapterDAO chdb = new ChapterDAO();
        
        // Remove all course references
        cdb.removeCourseCommentByCourseId(courseId);
        cdb.removeJoinCourseByCourseId(courseId);
        chdb.removeChaptersByCourseId(courseId);

        // Remove Course
        String query = "DELETE FROM Course WHERE id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(query);
            st.setInt(1, courseId);
            System.out.println(query);

            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
    
    
    public Map<String, Integer> getTop5SellerCourse() {
        Map<String, Integer> map = new LinkedHashMap<>();
        String sql = "SELECT TOP 5 c.[name], a.num\n"
                + "FROM (\n"
                + "    SELECT course_id, COUNT(account_id) AS num\n"
                + "    FROM JoinCourse\n"
                + "    GROUP BY course_id\n"
                + ") a\n"
                + "INNER JOIN Course c ON a.course_id = c.id\n"
                + "ORDER BY a.num DESC ";

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
}
