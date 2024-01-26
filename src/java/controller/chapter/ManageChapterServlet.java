package controller.chapter;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Date;
import model.*;
import dal.*;
import java.util.List;

@WebServlet(name = "ManageChapterServlet", urlPatterns = {"/manage-chapter"})
public class ManageChapterServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // common 
        CourseDAO cdb = new CourseDAO();
        ChapterDAO chdb = new ChapterDAO();
        LessonDAO ldb = new LessonDAO();
        TestDAO tdb = new TestDAO();
        Date currentDate = new Date();

        // get data
        int chapterId = Integer.parseInt(request.getParameter("id"));
        Chapter chapter = chdb.getChaptersById(chapterId);

        // set chapter
        request.setAttribute("chapterId", chapter.getId());
        request.setAttribute("chapterOrder", chapter.getOrder());
        request.setAttribute("chapterName", chapter.getName());

        // set lessons
        request.setAttribute("lessons", chapter.getLessons());

        // set tests
        request.setAttribute("tests", tdb.getAllTests());

        request.getRequestDispatcher("/admin/manage-chapter.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // common 
        CourseDAO cdb = new CourseDAO();
        ChapterDAO chdb = new ChapterDAO();
        LessonDAO ldb = new LessonDAO();
        TestDAO tdb = new TestDAO();

        // get chapter data
        String chapterId = request.getParameter("chapterId");
        String chapterOrder = request.getParameter("chapterOrder");
        String chapterName = request.getParameter("chapterName");

        // get lessons data
        String[] lessonsId = request.getParameterValues("lessonsId");
        String[] lessonsOrder = request.getParameterValues("lessonsOrder");
        String[] lessonsName = request.getParameterValues("lessonsName");
        String[] lessonsVideoUrl = request.getParameterValues("lessonsVideoUrl");
        String[] lessonsContent = request.getParameterValues("lessonsContent");
        String[] lessonsTestId = request.getParameterValues("lessonsTestId");

        // update chapter
        chdb.updateChapter(chapterId, chapterOrder, chapterName);
        
        // update lessons by chapterId
        ldb.updateLessonsByChapterId(chapterId, lessonsId, lessonsOrder, lessonsName, lessonsVideoUrl, lessonsContent, lessonsTestId);
        
        // testing
//        PrintWriter out = response.getWriter();
//        out.println(chapterId);
//        out.println(lessonsId.length);
//        out.println(lessonsOrder.length);
//        out.println(lessonsName.length);
//        out.println(lessonsVideoUrl.length);
//        out.println(lessonsContent.length);
//        out.println(lessonsTestId.length);
//        for (int i = 0; i < lessonsId.length; i++) {
//            out.println(lessonsId[i] + ", " + lessonsOrder[i] + ", " + lessonsTestId[i] + ", " + lessonsVideoUrl[i] + ", " + lessonsContent[i]);
//        }
        
        response.sendRedirect("manage-chapter?id=" + chapterId);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
