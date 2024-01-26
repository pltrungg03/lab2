package controller.test;

import dal.CourseDAO;
import dal.TestDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name="RemoveTestServlet", urlPatterns={"/remove-test"})
public class RemoveTestServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet RemoveTestServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RemoveTestServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        // common
        CourseDAO cdb = new CourseDAO();
        TestDAO tdb = new TestDAO();
        
        // get info
        int lessonId = Integer.parseInt(request.getParameter("lessonId"));
        int courseId = cdb.getCourseIdByLessonId(lessonId);

        // remove test
        tdb.removeTestByLessonId(lessonId);
        
        // redirect
        response.sendRedirect("manage-course?courseId=" + courseId);
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        // common
        TestDAO tdb = new TestDAO();
        
        // get info
        int lessonId = Integer.parseInt(request.getParameter("lessonId"));
        
        // remove test
        tdb.removeTestByLessonId(lessonId);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
