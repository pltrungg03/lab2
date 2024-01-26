package controller.course;

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
import java.util.ArrayList;
import java.util.List;
import model.*;

@WebServlet(name = "CourseListServlet", urlPatterns = {"/course-list"})
public class CourseListServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        LevelDAO ldb = new LevelDAO();
        MajorDAO mdb = new MajorDAO();
        request.setAttribute("majors", mdb.getAllMajors());
        request.setAttribute("levels", ldb.getAllLevels());
    }

    protected void renderContent(HttpServletRequest request, HttpServletResponse response, List<Course> courses, String page, boolean canLoadMore)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        for (Course c : courses) {
            out.println("<div class=\"col-md-6 col-lg-4 col-sm-6 m-b30\">\n"
                    + "<div class=\"cours-bx\">\n"
                    + "<div class=\"action-box\">\n"
                    + "<img src=\"" + c.getImage() + "\" alt=\"http://res.cloudinary.com/d3/image/upload/c_scale,q_auto:good,w_1110/trianglify-v1-cs85g_cc5d2i.jpg\">\n"
                    + "<a onclick=\"enrollMe(" + c.getId() +", " + c.getPrice() + ")\" class=\"btn\">Enroll Me</a>\n"
                    + "</div>\n"
                    + "<div class=\"info-bx text-center\">\n"
                    + "<h5><a href=\"course-details?id="+ c.getId() + "\">" + c.getName() + "</a></h5>\n"
                    + "<span>" + c.getCreator().getFirstName() + " " + c.getCreator().getLastName() + "</span>\n"
                    + "</div>\n"
                    + "<div class=\"cours-more-info\">\n"
                    + "<div class=\"review\">\n"
                    + "<span>" + c.getStudentNumber() + " student(s)</span>\n"
                    + "<ul class=\"cours-star\">\n"
                    + "<span>" + c.getAvgRating() + "</span>\n"
                    + "<li class=\"active\"><i class=\"fa fa-star\"></i></li>\n"
                    + "</ul>\n"
                    + "</div>\n"
                    + "<div class=\"price\">\n"
                    + "<del>$" + c.getPrice() + "</del>\n"
                    + "<h5>$" + c.getPrice() * (1- c.getDiscount()) + "</h5>\n"
                    + "</div>\n"
                    + "</div>\n"
                    + "</div>\n"
                    + "</div>");
        }
        if (canLoadMore) {
            out.println("<div class=\"col-lg-12 m-b20\">\n"
                    + "<div class=\"pagination-bx rounded-sm gray clearfix\" style=\"cursor: pointer;\">\n"
                    + "<ul class=\"pagination\">\n"
                    + "<li>\n"
                    + "<a onclick=\"updatePage(" + page + ")\">Load More <i class=\"ti-arrow-down\"></i></a>\n"
                    + "</li>\n"
                    + "</ul>\n"
                    + "</div>\n"
                    + "</div>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("_________________________GET_________________________");
        processRequest(request, response);

        // Common
        int coursesPerPage = 6;
        boolean canLoadMore = true;

        // Form submition
        String keyword = request.getParameter("keyword");
        String sort = request.getParameter("sort");
        String page = request.getParameter("page") == null ? "1" : request.getParameter("page");
        String[] major_ids = request.getParameterValues("majors");
        String[] level_ids = request.getParameterValues("levels");

        request.setAttribute("searchedKeyword", keyword);
        request.setAttribute("selectedMajorIds", major_ids);
        request.setAttribute("selectedLevelIds", level_ids);
        request.setAttribute("page", page);

        CourseDAO cdb = new CourseDAO();
        List<Course> courses = cdb.getCourses(keyword, sort, page, coursesPerPage, major_ids, level_ids);

        // Hide the "Load More" button
        if (cdb.getCourseQuantity(keyword, sort, page, coursesPerPage, major_ids, level_ids) <= Integer.parseInt(page) * coursesPerPage) {
            canLoadMore = false;
        }

        request.setAttribute("canLoadMore", canLoadMore);
        request.setAttribute("courses", courses);
        request.getRequestDispatcher("course-list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("_________________________POST_________________________");
        processRequest(request, response);

        // Common
        int coursesPerPage = 6;
        boolean canLoadMore = true;

        // Form submition
        String keyword = request.getParameter("keyword");
        String sort = request.getParameter("sort");
        String page = request.getParameter("page") == null ? "1" : request.getParameter("page");
        String[] major_ids = request.getParameterValues("majors");
        String[] level_ids = request.getParameterValues("levels");

        request.setAttribute("searchedKeyword", keyword);
        request.setAttribute("selectedMajorIds", major_ids);
        request.setAttribute("selectedLevelIds", level_ids);
        request.setAttribute("page", page);

        CourseDAO cdb = new CourseDAO();
        List<Course> courses = cdb.getCourses(keyword, sort, page, coursesPerPage, major_ids, level_ids);

        // Hide the "Load More" button
        if (cdb.getCourseQuantity(keyword, sort, page, coursesPerPage, major_ids, level_ids) <= Integer.parseInt(page) * coursesPerPage) {
            canLoadMore = false;
        }

        System.out.println(cdb.getCourseQuantity(keyword, sort, page, coursesPerPage, major_ids, level_ids));

        request.setAttribute("courses", courses);
        renderContent(request, response, courses, page, canLoadMore);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
