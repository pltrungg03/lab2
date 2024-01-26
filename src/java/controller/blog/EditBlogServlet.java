/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.blog;

import dal.BlogDAO;
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
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import model.Account;
import model.Blog;
import model.Tag;

@WebServlet(name = "EditBlogServlet", urlPatterns = {"/edit-blog"})
public class EditBlogServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EditBlogServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditBlogServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        BlogDAO bDAO = new BlogDAO();
        TagDAO tDAO = new TagDAO();
        Blog b = bDAO.getBlogById(Integer.parseInt(request.getParameter("id")));
        String noti = request.getParameter("noti");
        String color = request.getParameter("color");
        List<Tag> listT = tDAO.getAllTags();
        List<Integer> listI = tDAO.getAllTagsIdOfBlogById(b.getId());
        request.setAttribute("blog", b);
        request.setAttribute("noti", noti);
        request.setAttribute("color", color);
        request.setAttribute("listT", listT);
        request.setAttribute("listI", listI);

        request.getRequestDispatcher("edit-blog.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //lay cac noi dung can de edit
        HttpSession session = request.getSession();
        LocalDate currentDate = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        Account user = (Account) session.getAttribute("user");
        String title = request.getParameter("title");
        String thumbnail = request.getParameter("edit2");
        String content = request.getParameter("edit");
        int blogId = Integer.parseInt(request.getParameter("blogId"));
        int creatorId = user.getId();
        String createdDate = currentDate.format(formatter);
        String[] tag = request.getParameterValues("tag");
        if (thumbnail == null || content == null || tag == null || title.length() > 500) {
            String noti = "All fields to create a blog can not empty and title can not more 500 characters!";
            String color = "red";
            request.setAttribute("noti", noti);
            request.setAttribute("color", color);
            response.sendRedirect("edit-blog?noti=" + noti + "&color=" + color + "&id=" + blogId);
        } else {
            //da du noi dung de update

            BlogDAO bDAO = new BlogDAO();
            TagBlogDAO tbDAO = new TagBlogDAO();

            int start = thumbnail.lastIndexOf("<img src=\"");
            int end = thumbnail.lastIndexOf("\" alt=\"");
            String imgLink = thumbnail.substring(start + 10, end);
            //remove het tag cu cua 1 blog di, sau do add lai
            tbDAO.removeAllTagBlogOfBlogByBlogId(blogId);
            //update tag moi
            tbDAO.addAllTagsOfBlog(tag, blogId);
            bDAO.updateABlog(creatorId, content, createdDate, title, imgLink, blogId);
            response.sendRedirect("my-blog?noti=Blog has been updated succesful!");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
