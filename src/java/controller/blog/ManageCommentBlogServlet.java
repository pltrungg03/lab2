package controller.blog;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import dal.CommentBlogDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import model.CommentBlog;

@WebServlet(name = "CommentBlogListServlet", urlPatterns = {"/manage-commentblog"})
public class ManageCommentBlogServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CommentBlogListServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CommentBlogListServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Gson gson = new Gson();
        JsonObject jsonobj = new JsonObject();
        CommentBlogDAO c = new CommentBlogDAO();
        List<CommentBlog> listCmtBlog = c.getAllCommentsBlog();
        String list1 = gson.toJson(listCmtBlog);
        jsonobj.addProperty("listCmtBlog", list1);
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
        String searchNameBlog = request.getParameter("search");
        CommentBlogDAO c = new CommentBlogDAO();

        List<CommentBlog> listCmtBlog = new ArrayList<>();
        listCmtBlog = c.getAllCommentsBlog();
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
            listCmtBlog = c.getFilterCommentsBlog(from, to, searchNameBlog, x2);
        } else {
            listCmtBlog = c.getFilterCommentsBlog(from, to, searchNameBlog, null);
        }
        Gson gson = new Gson();
        String list1 = gson.toJson(listCmtBlog);
        JsonObject jsonobj = new JsonObject();
        jsonobj.addProperty("listCmtBlog", list1);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsonobj.toString());
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String cid = request.getParameter("cmID");
        CommentBlogDAO c = new CommentBlogDAO();
        try {
            int id = Integer.parseInt(cid);
            c.removeCommentBlogById(id);
        } catch (Exception e) {
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
