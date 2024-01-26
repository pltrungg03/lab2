/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.blog;

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
import jakarta.servlet.http.HttpSession;
import java.util.LinkedHashMap;
import java.util.List;
import model.Account;
import model.Blog;
import model.Tag;

@WebServlet(name = "MyBlogServlet", urlPatterns = {"/my-blog"})
public class MyBlogServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet MyBlogServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet MyBlogServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        BlogDAO bDAO = new BlogDAO();
        Account user = (Account) session.getAttribute("user");
        //lay toan bo blog cua user do
        List<Blog> list = bDAO.getAllBlogsOfAccountById(user.getId());
        request.setAttribute("list", list);

        //lay ra so luong comment
        LinkedHashMap<Integer, Integer> map = (LinkedHashMap<Integer, Integer>) bDAO.getNumbersCommentsOfBlog();
        request.setAttribute("map", map);
        request.getRequestDispatcher("my-blog.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        BlogDAO bDAO = new BlogDAO();
        TagDAO tDAO = new TagDAO();
        TagBlogDAO tbDAO = new TagBlogDAO();
        CommentBlogDAO cmbDAO = new CommentBlogDAO();
        String edit = request.getParameter("edit");
        String blogId = request.getParameter("blogId");
        if (edit != null) {//muon update blog
            Blog b = bDAO.getBlogById(Integer.parseInt(blogId));
            request.setAttribute("blog", b);
            //lay tag
            List<Tag> lisT =tDAO.getAllTags();
            request.setAttribute("listT", lisT);
            
            List<Integer> listI = tDAO.getAllTagsIdOfBlogById(Integer.parseInt(blogId));
            request.setAttribute("listI", listI);
            request.getRequestDispatcher("edit-blog.jsp").forward(request, response);
        } else {
            //muon xoa Blog
            //muon xoa blog phai xoa het comment cua blog do, va xoa tagblog cua blog do
            cmbDAO.deleteAllCommentsOfBlogById(Integer.parseInt(blogId));
            tbDAO.removeAllTagBlogOfBlogByBlogId(Integer.parseInt(blogId));
            bDAO.removeABlogById(Integer.parseInt(blogId));
            response.sendRedirect("my-blog?noti=Blog has been removed!");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
