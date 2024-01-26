package controller.blog;

import dal.BlogDAO;
import dal.CommentBlogDAO;
import dal.TagDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Blog;
import model.CommentBlog;
import model.Tag;

@WebServlet(name = "BlogDetailsServlet", urlPatterns = {"/blog-details"})
public class BlogDetailsServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet BlogDetailServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet BlogDetailServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("get get get get get get get get get get get get get get get get get get get get get get get get get get get get get get ");
        BlogDAO bDAO = new BlogDAO();
        TagDAO tDAO = new TagDAO();
        int id = Integer.parseInt(request.getParameter("id"));
        System.out.println("1");
        //hien thi thong tin chi tiet va Blog do
        Blog b = bDAO.getBlogById(id);
        request.setAttribute("blogInfo", b);
                System.out.println("2");

        //tim cac comment cua blog do
        CommentBlogDAO cbDAO = new CommentBlogDAO();
        List<CommentBlog> listC = cbDAO.getCommentsByBlogId(id);
        request.setAttribute("listC", listC);
                System.out.println("3");

        //suggest cac blog khac cua tac gia do
        List<Blog> listB = bDAO.getOtherBlogByCreatorId(id);
        request.setAttribute("listB", listB);
                System.out.println("4");

        //lay ra cac tag cua Blog do
        List<Tag> listT1 = tDAO.getTagsOfBlogById(id);
        request.setAttribute("listT1", listT1);
                System.out.println("5");

        //lay ra cac tag cua Blog do
        List<Tag> listT2 = tDAO.getAllTags();
        request.setAttribute("listT2", listT2);
        //
                System.out.println("6");

        //
        request.getRequestDispatcher("blog-details.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("post post post post post post post post post post post post post post post post post post post post post post post post post post ");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
