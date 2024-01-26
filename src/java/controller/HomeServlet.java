package controller;

import dal.AccountDAO;
import dal.BlogDAO;
import dal.CourseDAO;
import dal.MajorDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.LinkedHashMap;
import java.util.List;
import model.Blog;
import model.Course;
import model.Major;

@WebServlet(name = "HomeServlet", urlPatterns = {"/home"})
public class HomeServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet HomeServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet HomeServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
             //lay ra cac List can hien thi ben trang home
        MajorDAO mDAO = new MajorDAO();
        CourseDAO cDAO = new CourseDAO();
        BlogDAO bDAO = new BlogDAO();
        AccountDAO aDAO = new AccountDAO();
        List<Major> listM = mDAO.getAllMajorOrderByNumberOfCourses();
        request.setAttribute("listM", listM);
        //--------------
        LinkedHashMap<Integer, Integer> map = (LinkedHashMap<Integer, Integer>) cDAO.getNumbersRatingOfCourse();
        request.setAttribute("map", map);
        //--------------
        LinkedHashMap<Integer, Integer> map2 = (LinkedHashMap<Integer, Integer>) bDAO.getNumbersCommentsOfBlog();
        request.setAttribute("map2", map2);
        //--------------
        List<Course> listC1 = cDAO.getCourses(null, "7", null, 0, null, null);
        request.setAttribute("listC1", listC1);
        System.out.println(listC1);
        //--------------
        List<Course> listC2 = cDAO.getCourses(null, "5", null, 0, null, null);
        request.setAttribute("listC2", listC2);
        //--------------
        List<Blog> listB = bDAO.getAllBlogSortByDate();
        request.setAttribute("listB", listB);
        //--------------
        //number of user
        int nUser = aDAO.getNumberOfUsers();
        request.setAttribute("nUser", nUser);
        //-------------
        //number of course
        int nCourse = cDAO.getNumberOfCourses();
        request.setAttribute("nCourse", nCourse);
        //number of course
        int nMajor = mDAO.getNumberOfMajors();
        request.setAttribute("nMajor", nMajor);
        //-------------
        request.getRequestDispatcher("homepage.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String search = request.getParameter("search");
        response.sendRedirect("course-list?keyword=" + search);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
