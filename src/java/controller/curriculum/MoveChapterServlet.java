
package controller.curriculum;

import dal.ChapterDAO;
import dal.CourseDAO;
import dal.LessonDAO;
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
@WebServlet(name = "MoveChapterServlet", urlPatterns = {"/move-chapter"})
public class MoveChapterServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet MoveChapterServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet MoveChapterServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        CourseDAO cDAO = new CourseDAO();
        int chId = Integer.parseInt(request.getParameter("chId"));
        int cId = cDAO.getCourseIdByChapterId(chId);
        response.sendRedirect("overview-curriculum?id=" + cId);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ChapterDAO cDAO = new ChapterDAO();
        LessonDAO lDAO = new LessonDAO();
        int chId = Integer.parseInt(request.getParameter("chId"));
        int lId = Integer.parseInt(request.getParameter("lId"));
        String pre = request.getParameter("pre");
        if (pre == null) {
            //next chapter
            int chapIdNext = cDAO.getNextChapterIdInCourse(chId);
            if (chapIdNext == 0) {
                response.sendRedirect("lesson-details?chId=" + chId + "&lId=" + lId);
            } else {
                int firstLessonIdOfChapter = lDAO.getFirstLessonIdOfChapter(chapIdNext);
                response.sendRedirect("lesson-details?chId=" + chapIdNext + "&lId=" + firstLessonIdOfChapter);
            }
        } else {
            //previous chapter
            int chapIdPre = cDAO.getPreviousChapterIdInCourse(chId);
            if (chapIdPre == 0) {
                response.sendRedirect("lesson-details?chId=" + chId + "&lId=" + lId);
            } else {
                int firstLessonIdOfChapter = lDAO.getFirstLessonIdOfChapter(chapIdPre);
                response.sendRedirect("lesson-details?chId=" + chapIdPre + "&lId=" + firstLessonIdOfChapter);
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
