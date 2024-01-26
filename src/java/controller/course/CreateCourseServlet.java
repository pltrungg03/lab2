package controller.course;

import dal.ChapterDAO;
import dal.CourseDAO;
import dal.LevelDAO;
import dal.MajorDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import model.Account;
import model.Course;

@WebServlet(name = "CreateCourseServlet", urlPatterns = {"/create-course"})
public class CreateCourseServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UpdateCourseServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateCourseServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        MajorDAO mdb = new MajorDAO();
        LevelDAO ldb = new LevelDAO();

        request.setAttribute("majors", mdb.getAllMajors());
        request.setAttribute("levels", ldb.getAllLevels());
        request.getRequestDispatcher("/admin/create-course.jsp").forward(request, response);
    }
    
    protected int getCreatorId(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account creator = (Account) session.getAttribute("user");
        return creator.getId();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // common
        CourseDAO cdb = new CourseDAO();
        ChapterDAO chdb = new ChapterDAO();
        Date currentDate = new Date();

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        String createdDate = dateFormat.format(currentDate);
        
        // Get Course Info
        String name = request.getParameter("name");
        String image = request.getParameter("image");
        double price = 0;
        if(request.getParameter("price") != null || !request.getParameter("price").isEmpty())
            price = Double.parseDouble(request.getParameter("price"));
        double discount = 0;
        if(request.getParameter("discount") != null || !request.getParameter("discount").isEmpty())
            discount = Double.parseDouble(request.getParameter("discount"));
        String description = request.getParameter("description");
        int majorId = Integer.parseInt(request.getParameter("major"));
        int levelId = Integer.parseInt(request.getParameter("level"));
        int creatorId = getCreatorId(request, response);
        
        // Get Chapters Info
//        String[] chaptersOrder = request.getParameterValues("chaptersOrder");
//        String[] chaptersName = request.getParameterValues("chaptersName");
        
        // Create Course
        int courseId = cdb.insertCourseReturnId(name, price, discount, image, description, createdDate, majorId, levelId, creatorId);
        
        // Create & Insert Chapters
//        chdb.insertChaptersByCourseId(courseId, chaptersOrder, chaptersName);
        
        // print testing
//        try ( PrintWriter out = response.getWriter()) {
//            out.println(name + "\n" + image + "\n" + price + "\n" + discount + "\n" + description + "\n" + majorId + "\n" + levelId);
//            out.println("Chapters:");
//            for(int i = 0; i < chaptersOrder.length; i++)
//            {
//                out.println(chaptersOrder[i] + ", " + chaptersName[i]);
//            }
//        }

//        request.getRequestDispatcher("/admin/create-course.jsp").forward(request, response);

        response.sendRedirect("manage-course?courseId=" + courseId);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
