package controller.blog;

import dal.AccountDAO;
import dal.BlogDAO;
import dal.TagDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.LinkedHashMap;
import java.util.List;
import model.Account;
import model.Blog;
import model.Tag;

@WebServlet(name = "BlogListServlet", urlPatterns = {"/blog-list"})
public class BlogListServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet BlogListServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet BlogListServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        BlogDAO bDAO = new BlogDAO();
        TagDAO tDAO = new TagDAO();
        AccountDAO aDAO = new AccountDAO();
        LinkedHashMap<Integer, Integer> map = (LinkedHashMap<Integer, Integer>) bDAO.getNumbersCommentsOfBlog();
        request.setAttribute("map", map);
        
        //------
        List<Tag> listT = tDAO.getAllTags();
        request.setAttribute("listT", listT);
        //------
        String tag = request.getParameter("tag");
        String keyword = request.getParameter("keyword");
        String choice = request.getParameter("choice");
        List<Blog> list ;
        if (tag != null) {
            list = bDAO.getBlogsByTag(tag);
        } else {
            list = bDAO.getBlogsByForm(choice, keyword);
        }
        
        if (keyword != null && !keyword.isEmpty() && !keyword.equals(" ")){
            List<Account> listA = aDAO.getAllAccountByKeywordName(keyword);
            if (listA != null && !listA.isEmpty()){
                request.setAttribute("listA", listA);
            }
        }
        
        request.setAttribute("list", list);
        
        request.getRequestDispatcher("blog-list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
