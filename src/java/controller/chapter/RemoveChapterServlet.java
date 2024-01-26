package controller.chapter;

import dal.ChapterDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "RemoveChapterServlet", urlPatterns = {"/remove-chapter"})
public class RemoveChapterServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // common
        ChapterDAO chdb = new ChapterDAO();

        // get info
        int courseId = Integer.parseInt(request.getParameter("courseId"));
        int chapterId = Integer.parseInt(request.getParameter("chapterId"));

        // create chapter
        chdb.removeChapterByChapterId(chapterId);
        
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
        // common
        ChapterDAO chdb = new ChapterDAO();

        // get info
        int courseId = Integer.parseInt(request.getParameter("courseId"));
        int chapterId = Integer.parseInt(request.getParameter("chapterId"));

        // create chapter
        chdb.removeChapterByChapterId(chapterId);
        
        // redirect
        response.sendRedirect("manage-course?courseId=" + courseId);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
