/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.blog;

import dal.CommentBlogDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author 84338
 */
@WebServlet(name = "EditCommentBlog", urlPatterns = {"/edit-comment-blog"})
public class EditCommentBlog extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EditCommentBlog</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditCommentBlog at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        CommentBlogDAO cbDAO = new CommentBlogDAO();
        String edit = request.getParameter("edit");
        int blogId = Integer.parseInt(request.getParameter("blogId"));
        int cmId = Integer.parseInt(request.getParameter("cmId"));
        if (edit != null) {
            //muon update
            String content = request.getParameter("content");

            if (content.length() > 4000) {

                response.sendRedirect("blog-details?id=" + blogId + "&noti=Comment can not over 4000 characters!");
            } else {
                //update dc

                cbDAO.updateCommentBlogById(cmId, content);
                response.sendRedirect("blog-details?id=" + blogId);
            }
        } else {
            //muon xoa
            cbDAO.removeCommentBlogById(cmId);
            response.sendRedirect("blog-details?id=" + blogId);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
