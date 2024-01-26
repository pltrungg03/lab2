/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.lesson;

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
import java.util.Date;

@WebServlet(name = "UpdateLessonSevlet", urlPatterns = {"/update-lesson"})
public class UpdateLessonSevlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UpdateLessonSevlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateLessonSevlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // common 
        CourseDAO cdb = new CourseDAO();
        LessonDAO ldb = new LessonDAO();
        ChapterDAO chdb = new ChapterDAO();
        Date currentDate = new Date();

        // get data
        int lessonId = Integer.parseInt(request.getParameter("lessonId"));
        String lessonName = request.getParameter("lessonName");
        String lessonVideoUrl = request.getParameter("lessonVideoUrl");
        String lessonContent = request.getParameter("lessonContent");
        int lessonTestId = Integer.parseInt(request.getParameter("lessonTestId"));

        try ( PrintWriter out = response.getWriter()) {
            out.println(lessonId + "," + lessonName + "," + lessonVideoUrl + "," + lessonContent + "," + lessonTestId);
        }
//        ldb.updateLessonsByChapterId(lessonName, lessonsId, lessonsOrder, lessonsName, lessonsVideoUrl, lessonsContent, lessonsTestId);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // common 
        CourseDAO cdb = new CourseDAO();
        LessonDAO ldb = new LessonDAO();
        ChapterDAO chdb = new ChapterDAO();
        Date currentDate = new Date();

        // get data
        String courseId = request.getParameter("courseId");
        String chapterId = request.getParameter("chapterId");
        String lessonId = request.getParameter("lessonId");
        String lessonOrder = request.getParameter("lessonOrder");
        String lessonName = request.getParameter("lessonName");
        String lessonVideoUrl = request.getParameter("lessonVideoUrl");
        String lessonContent = request.getParameter("lessonContent");
        String lessonTestId = request.getParameter("lessonTestId");

//        try ( PrintWriter out = response.getWriter()) {
//            out.println(chapterId + "\n" + lessonId + "\n" + lessonOrder + "\n" + lessonName + "\n" + lessonVideoUrl + "\n" + lessonContent + "\n" + lessonTestId);
//        }
        ldb.updateLessons(chapterId, lessonId, lessonOrder, lessonName, lessonVideoUrl, lessonContent, lessonTestId);
        ldb.updateLessonTestId(Integer.parseInt(lessonId), Integer.parseInt(lessonTestId));

        response.sendRedirect("manage-course?courseId=" + courseId);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
