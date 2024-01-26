/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import dal.AccountDAO;
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
import java.util.Collections;
import java.util.List;
import model.Account;
import model.Course;
import model.Level;

@WebServlet(urlPatterns = {"/registration-list"})
public class RegistrationListServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet RegistrationServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RegistrationServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);
        CourseDAO daoC = new CourseDAO();
        AccountDAO daoA = new AccountDAO();
        MajorDAO daoM = new MajorDAO();
        LevelDAO daoL = new LevelDAO();
        request.setAttribute("n", daoC.getAllRegistration().size());
        request.setAttribute("listCre", daoA.getAllCreators());
        request.setAttribute("listM", daoM.getAllMajors());
        request.setAttribute("listL", daoL.getAllLevels());
        double sum = 0;
        for (Course c : daoC.getAllRegistration()) {
            sum += c.getPrice();
        }
        request.setAttribute("totalcost", sum);
        request.setAttribute("listRegistration", daoC.getAllRegistration());
        
        request.getRequestDispatcher("registration-list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // processRequest(request, response);
        CourseDAO c = new CourseDAO();
        CourseDAO daoC = new CourseDAO();
        String major = request.getParameter("major");
        String level = request.getParameter("level");
        String searchbyemail = request.getParameter("searchbyemail");
        String datefrom = request.getParameter("datefrom");
        String dateto = request.getParameter("dateto");
        String op = request.getParameter("op");
        String min = request.getParameter("minprice");
        String max = request.getParameter("maxprice");
        String searchbycourse = request.getParameter("searchbycourse");
        String author = request.getParameter("creator");
        double sum = 0;
        
        List<Course> list = c.filterRegistration(major, level, searchbyemail, datefrom, dateto, op, min, max, searchbycourse, author);
        for (Course cc : list) {
            sum += cc.getPrice();
        }
        PrintWriter out = response.getWriter();
        out.println("  <table class=\"content-table\">\n"
                + "                                    <thead>\n"
                + "                                        <tr>\n"
                + "                                            <th>Email</th>\n"
                + "                                            <th>Registration Date</th>\n"
                + "                                            <th>Course Name</th>\n"
                + "                                            <th>Cost</th>\n"
                + "                                            <th>Creator</th>\n"
                + "                                            <th>Major</th>\n"
                + "                                            <th>Level</th>\n"
                + "                                            <th></th>\n"
                + "                                        </tr>\n"
                + "                                    </thead>");
        out.print(" <tbody id=\"widget-inner12\">");
        out.print("<div class=\"huuloc\">\n"
                + "                              <h4 id=\"total\">Showing " + list.size() + " results</h4>\n"
                + "                                <h5 id=\"sum\">Total cost: " + sum + "$ </h5>\n"
                + "                                    </div>");
        for (Course course : list) {
            for (Account student : course.getStudents()) {
                String isPass = course.isIsPassed() ? "Passed" : "onGoing";
                out.print(" "
                        + " <tr class=\"test\">"
                        + "                                                <td>\n"
                        + "                                                   " + student.getEmail() + "\n"
                        + "                                                </td>\n"
                        + "                                                <td>" + course.getJoinedDate() + "</td>\n"
                        + "                                                <td>" + course.getName() + "</td>\n"
                        + "                                                <td>" + course.getPrice() + "</td>\n"
                        + "    \n"
                        + "                                                <td>" + course.getCreator().getFirstName() + course.getCreator().getLastName() + "</td>\n"
                        + "                                                <td>" + course.getMajor().getName() + "</td>\n"
                        + "                                                <td>" + course.getLevel().getName() + "</td>\n"
                        + "                                                <td><a href=\"registration-detail?aid= " + student.getId() + "&cid= " + course.getId() + "\">View Detail</a></td>\n"
                        + "                                            </tr>");
                
            }
            
        }

        
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
