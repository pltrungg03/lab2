/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
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
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Account;
import model.Course;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "MyCoursesServlet", urlPatterns = {"/my-courses"})
public class MyCoursesServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
                    Account acc = (Account) request.getSession().getAttribute("user");

            CourseDAO daoC = new CourseDAO();
            MajorDAO daoM = new MajorDAO();
            LevelDAO daoL = new LevelDAO();
            request.setAttribute("listM", daoM.getAllMajors());
            request.setAttribute("listL", daoL.getAllLevels());
            request.setAttribute("listC", daoC.getMyCourse(acc.getId()));
            request.getRequestDispatcher("my-courses.jsp").forward(request, response);
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
        Account acc = (Account) request.getSession().getAttribute("user");
        
        //processRequest(request, response);
        String majorId = request.getParameter("major");
        String levelId = request.getParameter("level");
        String search = request.getParameter("searchMyCourse");
        String op = request.getParameter("op");

        CourseDAO daoC = new CourseDAO();

        List<Course> listC = daoC.filterMyCourse(op, majorId, levelId, search, acc.getId());
        PrintWriter out = response.getWriter();
        for (Course c : listC) {
            String isPass = c.isIsPassed() ? "done" : "onGoing";
            out.print("<li class=\"action-card col-xl-4 col-lg-6 col-md-12 col-sm-6 " + isPass + "\">\n"
                    + "                                                                <div class=\"cours-bx\">\n"
                    + "                                                                    <div class=\"action-box\">\n"
                    + "                                                                        <img src=\"" + c.getImage() + "\" alt=\"\">\n"
                    + "                                                                        <a href=\"#\" class=\"btn\">Read More</a>\n"
                    + "                                                                    </div>\n"
                    + "                                                                    <div class=\"info-bx text-center\">\n"
                    + "                                                                        <h5><a href=\"#\">" + c.getName() + "</a></h5>\n"
                    + "                                                                        <span>" + c.getMajor().getName() + "</span>\n"
                    + "                                                                    </div>\n"
                    + "                                                                    <div class=\"cours-more-info\">\n"
                    + "                                                                        <div class=\"review\">\n"
                    + "                                                                            <span>Level</span>\n"
                    + "                                                                            <ul class=\"cours-star\">\n"
                    + "                                                                                <h5>" + c.getLevel().getName() + "</h5>\n"
                    + "                                                                            </ul>\n"
                    + "                                                                        </div>  \n"
                    + "                                                                        <div class=\"price\">\n"
                    + "                                                                            <h5>" + c.getPrice() + "</h5>\n"
                    + "                                                                        </div>\n"
                    + "                                                                    </div>\n"
                    + "                                                                </div>\n"
                    + "                                                            </li>");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
