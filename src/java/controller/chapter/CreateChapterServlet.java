package controller.chapter;

import dal.ChapterDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns={"/create-chapter"})
public class CreateChapterServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CreateChapterServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CreateChapterServlet at " + request.getContextPath () + "</h1>");
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
                
        // get info
        int courseId = Integer.parseInt(request.getParameter("courseId"));
        String chapterOrder = request.getParameter("chapterOrder");
        String chapterName = request.getParameter("chapterName");
        
        // create chapter
        chdb.insertChapterByCourseId(courseId, chapterOrder, chapterName);
        
        // redirect
        response.sendRedirect("manage-course?courseId=" + courseId);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
