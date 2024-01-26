package controller.course;

import dal.*;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Date;
import model.*;

@WebServlet(name = "UpdateCourseServlet", urlPatterns = {"/update-course"})
public class UpdateCourseServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        CourseDAO cdb = new CourseDAO();
        MajorDAO mdb = new MajorDAO();
        LevelDAO ldb = new LevelDAO();

        request.setAttribute("courses", cdb.getAllCourses());
        request.setAttribute("majors", mdb.getAllMajors());
        request.setAttribute("levels", ldb.getAllLevels());
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);

        //Get information
        String rawId = request.getParameter("id");
        System.out.println(rawId);
        if (rawId != null && !rawId.equals("0")) {
            int id = Integer.parseInt(rawId);
            CourseDAO cdb = new CourseDAO();
            ChapterDAO chdb = new ChapterDAO();
            Course c = cdb.getCourseById(id);

            request.setAttribute("id", id);
            request.setAttribute("name", c.getName());
            request.setAttribute("image", c.getImage());
            request.setAttribute("price", c.getPrice());
            request.setAttribute("discount", c.getDiscount());
            request.setAttribute("createdDate", c.getCreatedDate());
            request.setAttribute("majorId", c.getMajor().getId());
            request.setAttribute("levelId", c.getLevel().getId());
            request.setAttribute("creatorName", c.getCreator());
            request.setAttribute("description", c.getDescription());

            request.setAttribute("chapters", chdb.getChaptersByCourseId(id));
        }

        request.getRequestDispatcher("/admin/update-course.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // common
        CourseDAO cdb = new CourseDAO();
        ChapterDAO chdb = new ChapterDAO();
        Date currentDate = new Date();

        // Get Course Info
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String image = request.getParameter("image");
        double price = Double.parseDouble(request.getParameter("price"));
        double discount = Double.parseDouble(request.getParameter("discount"));
        int majorId = Integer.parseInt(request.getParameter("major"));
        int levelId = Integer.parseInt(request.getParameter("level"));
        String description = request.getParameter("description");

        // Get Chapters Info
//        String[] chaptersId = request.getParameterValues("chaptersId");
//        String[] chaptersOrder = request.getParameterValues("chaptersOrder");
//        String[] chaptersName = request.getParameterValues("chaptersName");

        // Update Course
        cdb.updateCourse(id, name, image, price, discount, majorId, levelId, description);
        // Update Chapters by CourseId
//        chdb.updateChaptersByCourseId(id, chaptersId, chaptersOrder, chaptersName);
        
        // Redirect
        response.sendRedirect("update-course?id=" + id);
       
//        try ( PrintWriter out = response.getWriter()) {
//            out.println(name + "\n" + image + "\n" + price + "\n" + discount + "\n" + description + "\n" + majorId + "\n" + levelId);
//            out.println("Chapters:");
//            for (int i = 0; i < chaptersOrder.length; i++) {
//                out.println(chaptersId[i] + ", " + chaptersOrder[i] + ", " + chaptersName[i]);
//            }
//        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
