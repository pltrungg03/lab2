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
import model.Tag;

/**
 *
 * @author 84338
 */
@WebServlet(name = "WriteBlogServlet", urlPatterns = {"/write-blog"})
public class WriteBlogServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet WriteBlogServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet WriteBlogServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        TagDAO tDAO = new TagDAO();
        String noti = request.getParameter("noti");
        String color = request.getParameter("color");
        if (noti != null) {
            request.setAttribute("noti", noti);
        }
        if (color != null) {
            request.setAttribute("color", color);
        }
        List<Tag> listT = tDAO.getAllTags();
        request.setAttribute("listT", listT);
        request.getRequestDispatcher("write-blog.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //lay cac noi dung can de tao blog moi
        HttpSession session = request.getSession();
        LocalDate currentDate = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        Account user = (Account) session.getAttribute("user");
        String title = request.getParameter("title");
        String thumbnail = request.getParameter("edit2");
        String content = request.getParameter("edit");
        int creatorId = user.getId();
        String createdDate = currentDate.format(formatter);
        String[] tag = request.getParameterValues("tag");
        if (thumbnail == null || content == null || tag == null || title.length() > 500) {
            String noti = "All fields to create a blog can not empty and title can not more 500 characters!";
            String color = "red";
            request.setAttribute("noti", noti);
            request.setAttribute("color", color);
            response.sendRedirect("write-blog?noti=" + noti + "&color=" + color);
        } else {
            //da du noi dung de tao blog

            BlogDAO bDAO = new BlogDAO();
            TagBlogDAO tbDAO = new TagBlogDAO();

            int start = thumbnail.lastIndexOf("<img src=\"");
            int end = thumbnail.lastIndexOf("\" alt=\"");
            String imgLink = thumbnail.substring(start + 10, end);

            bDAO.addABlog(creatorId, content, createdDate, title, imgLink);
            int blogId = bDAO.getNewestIdBlogfOfAccountID(creatorId);
            tbDAO.addAllTagsOfBlog(tag, blogId);
            response.sendRedirect("my-blog?noti=Add new blog succesful!");
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
