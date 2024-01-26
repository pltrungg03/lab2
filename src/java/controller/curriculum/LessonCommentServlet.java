package controller.curriculum;

import dal.LessonCommentDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;

@WebServlet(name = "LessonCommentServlet", urlPatterns = {"/lesson-comment"})
public class LessonCommentServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet LessonCommentServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LessonCommentServlet at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("user");
        int lId = Integer.parseInt(request.getParameter("lId"));
        int chId = Integer.parseInt(request.getParameter("chId"));
        String content = request.getParameter("content");
        String parentId = request.getParameter("parentId");
        if (content.length() <= 4000) {
            lcDAO.addLessonComment(user.getId(), lId, content, parentId);
            response.sendRedirect("lesson-details?chId=" + chId + "&lId=" + lId);
        } else {
            response.sendRedirect("lesson-details?chId=" + chId + "&lId=" + lId + "&cmt=fail");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
