/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.blog;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import dal.BlogDAO;
import dal.CommentBlogDAO;
import dal.TagBlogDAO;
import dal.TagDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import model.Blog;

@WebServlet(name = "ManageBlogServlet", urlPatterns = {"/manage-blog"})
public class ManageBlogServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ManageBlogServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManageBlogServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);
        Gson gson = new Gson();
        JsonObject jsonobj = new JsonObject();
        BlogDAO b = new BlogDAO();
        List<Blog> listBlog = new ArrayList<>();
        listBlog = b.getAllBlogSortByDate();
        String list1 = gson.toJson(listBlog);
        jsonobj.addProperty("listBlog", list1);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsonobj.toString());
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);
        String from = request.getParameter("from");
        String to = request.getParameter("to");
        List<Blog> listBlog = new ArrayList<>();
        BlogDAO b = new BlogDAO();
        String check = request.getParameter("check").trim();
        String text = request.getParameter("textcheck").trim();
        String[] check123 = {"shit", "damn", "godamn", "hell", "bitch", "dick", "nigga"};
        String x2[] = check123;
        if (text != null && text.length() > 0) {
            String[] ads = text.split(" ");
            x2 = new String[check123.length + ads.length];
            System.arraycopy(ads, 0, x2, 0, ads.length);
            System.arraycopy(check123, 0, x2, ads.length, check123.length);

        }
        if (check != null && check.trim().length() > 0) {
            listBlog = b.getBadBlog(from, to, x2);
        } else {
            listBlog = b.getBadBlog(from, to, null);
        }
        Gson gson = new Gson();
        JsonObject jsonobj = new JsonObject();
        String list1 = gson.toJson(listBlog);
        jsonobj.addProperty("listBlog", list1);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsonobj.toString());
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String blID = request.getParameter("blID");
        BlogDAO c = new BlogDAO();
        CommentBlogDAO cbDAO = new CommentBlogDAO();
        TagBlogDAO t = new TagBlogDAO();
        cbDAO.removeCommentBlogById(Integer.parseInt(blID));
        t.removeAllTagBlogOfBlogByBlogId(Integer.parseInt(blID));
        c.removeABlogById(Integer.parseInt(blID));
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
