package controller.lesson;

import dal.*;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name="RemoveLessonServlet", urlPatterns={"/remove-lesson"})
public class RemoveLessonServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        // common
        LessonDAO ldb = new LessonDAO();

        // get info
        int courseId = Integer.parseInt(request.getParameter("courseId"));
        int lessonId = Integer.parseInt(request.getParameter("lessonId"));

        // remove lesson
        ldb.removeLessonByLessonId(lessonId);
        
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
