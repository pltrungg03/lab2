package controller.course;

import dal.AccountDAO;
import dal.ChapterDAO;
import dal.CommentCourseDAO;
import dal.JoinCourseDAO;
import dal.LessonDAO;
import model.*;
import util.Helpers;
import dal.CourseDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

@WebServlet(name = "CourseDetailsServlet", urlPatterns = {"/course-details"})
public class CourseDetailsServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {

        }

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Helpers.parseInt(request.getParameter("id"), 0);

        CourseDAO dao = new CourseDAO();
        Course data = dao.getCourseById(id);
        request.setAttribute("data", data);
        List<Chapter> chapterList = new ChapterDAO().getChaptersByCourseId(id);
        for (Chapter chapter : chapterList) {
            List<Lesson> lessonList = new LessonDAO().getLessonsByChapterId(chapter.getId());
            chapter.setLessons(lessonList);
        }
        request.setAttribute("chapterList", chapterList);
        List<JoinCourse> joinCourseList = new JoinCourseDAO().getAllRatingOfCourse(id);
        request.setAttribute("joinCourseList", joinCourseList);
        int stu = dao.getJoinCourseQuantity(id);
        request.setAttribute("stu", stu);
        
        
        // check join course
        boolean checkJoinCourse = false;
        HttpSession session = request.getSession();
        if ((Account) session.getAttribute("user") != null) {
            Account acc = (Account) session.getAttribute("user");
            if (dao.checkJoinedCourse(acc.getId(), id) != null) {
                AccountDAO daoA = new AccountDAO();
                String checkTransaction = "#" + data.getId() + " '" + data.getName() + "'";
                // check account co tra course bang tien wallet ko
                if (daoA.checkTransactionVIP(acc, checkTransaction)) {
                    // tra tien course
                    checkJoinCourse = true;
                } else {
                    // check join bang VIP
                    if (daoA.dateExpiredVIP(acc) != null) {
                        // check VIP con han hay ko
                        if (!daoA.checkExpiredVIP(daoA.dateExpiredVIP(acc))) {
                            checkJoinCourse = true;
                        }
                    }

                }

            }
        }
        CommentCourseDAO cmcDAO = new CommentCourseDAO();
        List<CommentCourse> listCM = cmcDAO.getCommentsByCourseId(id);
        request.setAttribute("listCM", listCM);              
        
        request.setAttribute("checkJoinCourse", checkJoinCourse);
        
        request.getRequestDispatcher("course-details.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int courseId =  Helpers.parseInt(request.getParameter("courseId") , 0);
        int accountId = Helpers.parseInt(request.getParameter("accountId"), 0);
        int stars = Helpers.parseInt(request.getParameter("rating"), 1);
        JoinCourse joinCourse = new JoinCourse();
        joinCourse.setCourseId(courseId);
        joinCourse.setAccountId(accountId);
        joinCourse.setStars(stars);
        JoinCourseDAO joinCourseDAO = new JoinCourseDAO();
        joinCourseDAO.updateJoinCourse(joinCourse);
        response.sendRedirect("course-details?id="+courseId);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}


