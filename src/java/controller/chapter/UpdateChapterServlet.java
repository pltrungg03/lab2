package controller.chapter;

import dal.ChapterDAO;
import dal.CourseDAO;
import dal.LessonDAO;
import dal.TestDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name="UpdateChapterServlet", urlPatterns={"/update-chapter"})
public class UpdateChapterServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UpdateChapterServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateChapterServlet at " + request.getContextPath () + "</h1>");
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
        // common 
        ChapterDAO chdb = new ChapterDAO();

        // get chapter data
        String courseId = request.getParameter("courseId");

        String chapterId = request.getParameter("chapterId");
        String chapterOrder = request.getParameter("chapterOrder");
        String chapterName = request.getParameter("chapterName");

        // update chapter
        chdb.updateChapter(chapterId, chapterOrder, chapterName);

        response.sendRedirect("manage-course?courseId=" + courseId);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
