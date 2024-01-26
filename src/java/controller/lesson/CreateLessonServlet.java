package controller.lesson;

import dal.LessonDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name="CreateLessonServlet", urlPatterns={"/create-lesson"})
public class CreateLessonServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        // common
        LessonDAO ldb = new LessonDAO();
        
        // get info
        String courseId = request.getParameter("courseId");
        String chapterId = request.getParameter("chapterId");
        
        String lessonOrder = request.getParameter("lessonOrder");
        String lessonName = request.getParameter("lessonName");
        String lessonVideoUrl = request.getParameter("lessonVideoUrl");
        String lessonContent = request.getParameter("lessonContent");
        String lessonTestId = "";
        
        // insert lesson 
        ldb.insertLessonByChapterId(chapterId, lessonOrder, lessonName, lessonVideoUrl, lessonContent, lessonTestId);
        
        // redirect
        response.sendRedirect("manage-course?courseId=" + courseId);
    } 

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
