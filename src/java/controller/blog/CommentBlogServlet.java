package controller.blog;

import dal.BlogDAO;
import dal.CommentBlogDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;

@WebServlet(name = "CommentBlogServlet", urlPatterns = {"/comment-blog"})
public class CommentBlogServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CommentBlogServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CommentBlogServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("user");
        int blogId = Integer.parseInt(request.getParameter("blogId"));
        String content = request.getParameter("content");
        String parentId = request.getParameter("parentId");
        if (content.length() > 4000) {
            String noti = "The length of content must be less or equal 4000 characters!";
            response.sendRedirect("blog-details?id=" + blogId + "&noti=" + noti);
            
        } else {
            CommentBlogDAO cbDAO = new CommentBlogDAO();
            cbDAO.addAComentInBlog(blogId, user.getId(), content, parentId);
            response.sendRedirect("blog-details?id=" + blogId);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
