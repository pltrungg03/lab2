package controller.curriculum;

import dal.LessonCommentDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "EditCommentLessonServlet", urlPatterns = {"/edit-comment-lesson"})
public class EditCommentLessonServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EditCommentLessonServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditCommentLessonServlet at " + request.getContextPath() + "</h1>");
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
        LessonCommentDAO lcDAO = new LessonCommentDAO();
        int cmId = Integer.parseInt(request.getParameter("cmId"));
        int lId = Integer.parseInt(request.getParameter("lId"));
        int chId = Integer.parseInt(request.getParameter("chId"));
        String comment = request.getParameter("content");
        String edit = request.getParameter("edit");
        if (edit != null) {
            //muon edit
            if (comment.length() <= 4000) {
                lcDAO.updateLessonComment(cmId, comment);
                response.sendRedirect("lesson-details?chId=" + chId + "&lId=" + lId);
            } else {
                response.sendRedirect("lesson-details?chId=" + chId + "&lId=" + lId + "&cmt2=fail");
            }
        } else {
            //muon xoa
            lcDAO.deleteLessonComment(cmId);
            response.sendRedirect("lesson-details?chId=" + chId + "&lId=" + lId);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
