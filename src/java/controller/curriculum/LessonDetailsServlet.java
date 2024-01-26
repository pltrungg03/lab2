package controller.curriculum;

import dal.ChapterDAO;
import dal.CourseDAO;
import dal.GradeDAO;
import dal.JoinCourseDAO;
import dal.LessonCommentDAO;
import dal.LessonDAO;
import dal.TestDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Account;
import model.Chapter;
import model.Lesson;
import model.LessonComment;

@WebServlet(name = "LessonDetails", urlPatterns = {"/lesson-details"})
public class LessonDetailsServlet extends HttpServlet {
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet LessonDetails</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LessonDetails at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            CourseDAO cDAO = new CourseDAO();
            JoinCourseDAO jcDAO = new JoinCourseDAO();
            ChapterDAO chDAO = new ChapterDAO();
            TestDAO tDAO = new TestDAO();
            LessonDAO lDAO = new LessonDAO();
            GradeDAO gDAO = new GradeDAO();
            LessonCommentDAO lcDAO = new LessonCommentDAO();
            HttpSession session = request.getSession();
            int chapId = Integer.parseInt(request.getParameter("chId"));
            int lId = Integer.parseInt(request.getParameter("lId"));
            Account user = (Account) session.getAttribute("user");
            if (!jcDAO.checkJoinCourse(user.getId(), cDAO.getCourseIdByChapterId(chapId))) {
                response.sendRedirect("course-details?id=" + cDAO.getCourseIdByChapterId(chapId));
            }

            //kiem tra xem da join chapter hay join lesson chua, chua co thi tao
            lDAO.addJoinLesson(user.getId(), lId); //join lesson
            chDAO.addJoinChapter(user.getId(), chapId); //join chapter cua lesson do
            //
            String pos = chDAO.checkPositionOfChapterById(chapId);
            request.setAttribute("pos", pos);
            //
            Chapter chap = chDAO.getChapterByIdIncludeCheckingDone(user.getId(), chapId);
            request.setAttribute("chap", chap);
            //
            Lesson lesson = lDAO.getLessonsById(lId);
            request.setAttribute("lesson", lesson);
            //
            List<LessonComment> listC = lcDAO.getAllCommentsOfLessonById(lId);
            request.setAttribute("listC", listC);
            //
            if (tDAO.getTestByLessonID(lId) != null) {
                double score = gDAO.getScoreOfAccountIdAndTestId(user.getId(), tDAO.getTestByLessonID(lId).getId());
                if (score != -1.0) {
                    request.setAttribute("score", score);
                }
            }
            request.getRequestDispatcher("lesson-details.jsp").forward(request, response);
        } catch (Exception e) {
            response.sendRedirect("home");
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
    }// </editor-fold>

}