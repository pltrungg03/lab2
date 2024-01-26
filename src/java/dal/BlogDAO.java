package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import model.Blog;

public class BlogDAO extends DBContext {

    public List<Blog> getAllBlogSortByDate() {
        String sql = "select * from Blog order by created_date desc";
        List<Blog> list = new ArrayList();
        AccountDAO accDAO = new AccountDAO();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Blog b = new Blog();
                b.setId(rs.getInt("id"));
                b.setCreatedDate(rs.getString("created_date"));
                b.setContent(rs.getString("content"));
                b.setCreator(accDAO.getAccountById(rs.getInt("creator_id")));
                b.setTitle(rs.getString("title"));
                b.setThumbnail(rs.getString("thumbnail"));
                list.add(b);
            }
        } catch (SQLException e) {
        }
        return list;
    }

    public Blog getBlogById(int id) {
        String sql = "select * from Blog where id = ?";
        AccountDAO accDAO = new AccountDAO();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Blog b = new Blog();
                b.setId(rs.getInt("id"));
                b.setCreatedDate(rs.getString("created_date"));
                b.setContent(rs.getString("content"));
                b.setCreator(accDAO.getAccountById(rs.getInt("creator_id")));
                b.setTitle(rs.getString("title"));
                b.setThumbnail(rs.getString("thumbnail"));
                return b;
            }
        } catch (SQLException e) {
        }
        return null;
    }

    public List<Blog> getRandomBlogExceptId(int id) {
        String sql = "select * from Blog where id != ?\n"
                + "order by NEWID()";
        List<Blog> list = new ArrayList();
        AccountDAO accDAO = new AccountDAO();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Blog b = new Blog();
                b.setId(rs.getInt("id"));
                b.setCreatedDate(rs.getString("created_date"));
                b.setContent(rs.getString("content"));
                b.setCreator(accDAO.getAccountById(rs.getInt("creator_id")));
                b.setTitle(rs.getString("title"));
                b.setThumbnail(rs.getString("thumbnail"));
                list.add(b);
            }
        } catch (SQLException e) {
        }
        return list;
    }

    public List<Blog> getBlogByFilter(int choice, String from, String to, String key) {
        //ham nay de loc ra cac filter dua theo cac tieu chi o phan blog: thoi gian - do dai - nguoi dang ,....
        String sql = "select b.*, a.first_name + ' ' +  a.last_name as\n"
                + "[full] from Blog b, Account a\n"
                + "where b.creator_id = a.id ";
        if (from != null && !from.equals("")) {
            int year = Integer.parseInt(from);
            sql += " and Year(b.created_date) >= " + year + " ";
        }

        if (to != null && !to.equals("")) {
            int year = Integer.parseInt(to);
            sql += " and Year(b.created_date) <= " + year + " ";
        }
        if (key != null && !key.equals("")) {
            sql += " and ((a.first_name + ' ' +  a.last_name) like '%" + key + "%' ";
            sql += " or b.content like '%" + key + "%' ";
            sql += " or b.[title] like '%" + key + "%') ";
        }

        switch (choice) {
            case 0:
                sql += " order by b.created_date desc";
                break;
            case 1:
                sql += " order by b.created_date asc";
                break;
            case 2:
                sql += " order by len(b.content) desc";
                break;
            case 3:
                sql += " order by len(b.content) asc";
                break;
            case 4:
                sql += " order by (a.first_name + ' ' +  a.last_name)";
                break;
        }

        List<Blog> list = new ArrayList();
        AccountDAO accDAO = new AccountDAO();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Blog b = new Blog();
                b.setId(rs.getInt("id"));
                b.setCreatedDate(rs.getString("created_date"));
                b.setContent(rs.getString("content"));
                b.setCreator(accDAO.getAccountById(rs.getInt("creator_id")));
                b.setTitle(rs.getString("title"));
                b.setThumbnail(rs.getString("thumbnail"));
                list.add(b);
            }
        } catch (SQLException e) {
        }
        return list;
    }

    //le hieu - 25/09 ham nay de tinh so comment ung voi tung blog
    public Map<Integer, Integer> getNumbersCommentsOfBlog() {
        Map<Integer, Integer> map = new LinkedHashMap<>();
        String sql = "select b.id, count(cb.account_id) as [num]\n"
                + "                from Blog b left join CommentBlog cb\n"
                + "                on b.id = cb.blog_id\n"
                + "				where cb.parent_id is null\n"
                + "                group by b.id";

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

    //le hieu 26/09 ham nay de tra ve list Blog theo cac tieu chi - ngay xb, author, most
    //interractive
    public List<Blog> getBlogsByTag(String tag) {
        AccountDAO accDAO = new AccountDAO();
        List<Blog> list = new ArrayList();
        String sql;
        if (tag.equals("0")) {
            sql = "select * from Blog order by created_date desc";
        } else {
            sql = "select b.* from Blog b, TagBlog tb \n"
                    + "where b.id = tb.blog_id\n"
                    + "and tb.tag_id = " + tag + " "
                    + " order by b.created_date desc";
        }

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Blog b = new Blog();
                b.setId(rs.getInt("id"));
                b.setCreatedDate(rs.getString("created_date"));
                b.setContent(rs.getString("content"));
                b.setCreator(accDAO.getAccountById(rs.getInt("creator_id")));
                b.setTitle(rs.getString("title"));
                b.setThumbnail(rs.getString("thumbnail"));
                list.add(b);
            }
        } catch (Exception e) {
        }
        return list;
    }

    public List<Blog> getBlogsByForm(String choice, String keyword) {
        AccountDAO accDAO = new AccountDAO();
        List<Blog> list = new ArrayList();
        String sql = "";
        if (choice.equals("0") || choice.equals("1")) {
            sql = "select b.* from Blog b, Account a where b.creator_id = a.id  ";
            if (keyword != null && !keyword.isEmpty()) {
                sql += " and (b.title like '%" + keyword + "%'" + " or b.[content] like '%" + keyword + "%' or "
                        + "(a.first_name + ' ' + a.last_name) like '%" + keyword + "%' or "
                        + "(a.last_name + ' ' + a.first_name) like '%" + keyword + "%') ";
            }
            if (choice.equals("0")) {
                sql += " order by b.created_date desc";
            } else {
                sql += " order by b.creator_id";
            }
        }
        if (choice.equals("2")) {
            sql = "select tb1.id, tb1.creator_id, tb1.thumbnail, tb1.title, tb1.content, tb1.created_date\n"
                    + ", tb1.first_name, tb1.last_name, count(cb.account_id) as [num]\n"
                    + "from (select b.*, a.first_name, a.last_name from Blog b, Account a \n"
                    + "where b.creator_id = a.id) tb1 left join CommentBlog cb\n"
                    + "on tb1.id = cb.blog_id where cb.parent_id is null ";
            if (keyword != null && !keyword.isEmpty()) {
                sql += " and (tb1.title like '%" + keyword + "%'" + " or tb1.[content] like '%" + keyword + "%' or "
                        + "(tb1.first_name + ' ' + tb1.last_name) like '%" + keyword + "%' or "
                        + "(tb1.last_name + ' ' + tb1.first_name) like '%" + keyword + "%') ";
            }
            sql += " group by tb1.id, tb1.creator_id, tb1.thumbnail, tb1.title, tb1.content, tb1.created_date\n"
                    + ", tb1.first_name, tb1.last_name\n"
                    + "order by [num] desc";
        }

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Blog b = new Blog();
                b.setId(rs.getInt("id"));
                b.setCreatedDate(rs.getString("created_date"));
                b.setContent(rs.getString("content"));
                b.setCreator(accDAO.getAccountById(rs.getInt("creator_id")));
                b.setTitle(rs.getString("title"));
                b.setThumbnail(rs.getString("thumbnail"));
                list.add(b);
            }
        } catch (Exception e) {
        }
        return list;
    }

    public static void main(String[] args) {
        BlogDAO bd = new BlogDAO();

    }

    public List<Blog> getOtherBlogByCreatorId(int id) {
        List<Blog> list = new ArrayList();
        String sql = "select * from Blog where creator_id = (\n"
                + "select creator_id from Blog where id = ?)\n"
                + "and id != ? order by NEWID()";
        AccountDAO accDAO = new AccountDAO();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            st.setInt(2, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Blog b = new Blog();
                b.setId(rs.getInt("id"));
                b.setCreatedDate(rs.getString("created_date"));
                b.setContent(rs.getString("content"));
                b.setCreator(accDAO.getAccountById(rs.getInt("creator_id")));
                b.setTitle(rs.getString("title"));
                b.setThumbnail(rs.getString("thumbnail"));
                list.add(b);
            }
        } catch (SQLException e) {
        }
        return list;
    }

    //le hieu 30-9 them 1 blog
    //can them thong tin blog - va thong tin tag cua blog do
    //can dung 2 DAO: BlogDAO va TagBlog
    public void addABlog(int creatorId, String content, String createdDate, String title, String thumbnail) {
        String sql = "INSERT INTO [dbo].[Blog]\n"
                + "           ([creator_id]\n"
                + "           ,[content]\n"
                + "           ,[created_date]\n"
                + "           ,[title]\n"
                + "           ,[thumbnail])\n"
                + "     VALUES\n"
                + "           (?,?,?,?,?)";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, creatorId);
            st.setString(2, content);
            st.setString(3, createdDate);
            st.setString(4, title);
            st.setString(5, thumbnail);
            st.executeUpdate();
        } catch (SQLException e) {
        }
    }

    //ham nay de lay Blog ID cua Post moi dang cua nguoi dung
    public int getNewestIdBlogfOfAccountID(int accountID) {
        String sql = "select max(id) as [id] from Blog where creator_id = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, accountID);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt("id");
            }
        } catch (Exception e) {
        }
        return 0;
    }

    //le hieu 10/1 - ham nay dung de lay ra toan bo blog cua 1 user
    public List<Blog> getAllBlogsOfAccountById(int creatorId) {
        List<Blog> list = new ArrayList();
        String sql = "select * from Blog where creator_id = ? \n"
                + "order by created_date desc";
        AccountDAO accDAO = new AccountDAO();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, creatorId);

            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Blog b = new Blog();
                b.setId(rs.getInt("id"));
                b.setCreatedDate(rs.getString("created_date"));
                b.setContent(rs.getString("content"));
                b.setCreator(accDAO.getAccountById(rs.getInt("creator_id")));
                b.setTitle(rs.getString("title"));
                b.setThumbnail(rs.getString("thumbnail"));
                list.add(b);
            }
        } catch (SQLException e) {
        }
        return list;
    }

    //le hieu - update 1 blog
    public void updateABlog(int creatorId, String content, String createdDate, String title, String thumbnail, int blogId) {
        String sql = "UPDATE [dbo].[Blog]\n"
                + "   SET [creator_id] = ?\n"
                + "      ,[content] = ?\n"
                + "      ,[created_date] = ?\n"
                + "      ,[title] =  ?\n"
                + "      ,[thumbnail] = ?\n"
                + " WHERE id = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, creatorId);
            st.setString(2, content);
            st.setString(3, createdDate);
            st.setString(4, title);
            st.setString(5, thumbnail);
            st.setInt(6, blogId);
            st.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public void removeABlogById(int blogId) {
        String sql = "DELETE FROM [dbo].[Blog]\n"
                + "      WHERE id = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, blogId);
            st.executeUpdate();
        } catch (Exception e) {
        }
    }

    public List<Blog> getAllBlogByAccountId(int id) {
        String sql = "select * from Blog where creator_id = ? order by created_date desc";
        List<Blog> list = new ArrayList();
        AccountDAO accDAO = new AccountDAO();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Blog b = new Blog();
                b.setId(rs.getInt("id"));
                b.setCreatedDate(rs.getString("created_date"));
                b.setContent(rs.getString("content"));
                b.setCreator(accDAO.getAccountById(rs.getInt("creator_id")));
                b.setTitle(rs.getString("title"));
                b.setThumbnail(rs.getString("thumbnail"));
                list.add(b);
            }
        } catch (SQLException e) {
        }
        return list;
    }
    public List<Blog> getBadBlog(String from, String to, String[] check) {
        String sql = "select * from Blog where 0=0";
        if (from != null && from.trim().length() > 0) {
            sql += " and created_date >= '" + from + "'";
        }
        if (to != null && to.trim().length() > 0) {
            sql += " and created_date >= '" + to + "'";
        }
        if (check != null && check.length > 0) {
            String temp = "and title IN (select title from Blog where title like";
            for (String s : check) {
                temp += " '%";
                temp += s;
                temp += "%' or  title like\n";
            }
            temp += "'')";
            sql += temp;
        }
        sql += " order by id desc";
        System.out.println(sql);
        List<Blog> list = new ArrayList();
        AccountDAO accDAO = new AccountDAO();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Blog b = new Blog();
                b.setId(rs.getInt("id"));
                b.setCreatedDate(rs.getString("created_date"));
                b.setContent(rs.getString("content"));
                b.setCreator(accDAO.getAccountById(rs.getInt("creator_id")));
                b.setTitle(rs.getString("title"));
                b.setThumbnail(rs.getString("thumbnail"));
                list.add(b);
            }
        } catch (SQLException e) {
        }

        return list;
    }
}
