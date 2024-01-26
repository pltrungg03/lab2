package controller.blog;

import dal.AccountDAO;
import dal.BlogDAO;
import dal.CommentBlogDAO;
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

@WebServlet(name = "BlogUserServlet", urlPatterns = {"/blog-user"})
public class BlogUserServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet BlogUserServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet BlogUserServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            AccountDAO aDAO = new AccountDAO();
            BlogDAO bDAO = new BlogDAO();

            Account a = aDAO.getAccountById(id);
            List<Blog> listB = bDAO.getAllBlogByAccountId(id);
            LinkedHashMap<Integer, Integer> map = (LinkedHashMap<Integer, Integer>) bDAO.getNumbersCommentsOfBlog();

            request.setAttribute("a", a);
            request.setAttribute("listB", listB);
            request.setAttribute("map", map);
            request.getRequestDispatcher("blog-user.jsp").forward(request, response);
        } catch (Exception e) {
            response.sendRedirect("blog-list?tag=0");
        }
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
