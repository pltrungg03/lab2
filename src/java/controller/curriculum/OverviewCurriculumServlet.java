package controller.curriculum;

import dal.CourseDAO;
import dal.JoinCourseDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
import model.Course;

@WebServlet(name = "OverviewCurriculumServlet", urlPatterns = {"/overview-curriculum"})
public class OverviewCurriculumServlet extends HttpServlet {
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet OverviewCurriculumServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet OverviewCurriculumServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }    
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            JoinCourseDAO jcDAO = new JoinCourseDAO();
            CourseDAO cDAO = new CourseDAO();
            //servlet nay chay qua filter nen khong so null account
            Account user = (Account) session.getAttribute("user");
            int cId = Integer.parseInt(request.getParameter("id"));
            if (!jcDAO.checkJoinCourse(user.getId(), cId)) {
                response.sendRedirect("course-details?id=" + cId);
            }
            Course c = cDAO.getCourseByIdIncludeCheckingProgress(cId, user.getId());
            request.setAttribute("c", c);
            
            request.getRequestDispatcher("overview-curriculum.jsp").forward(request, response);
        } catch (Exception e) {
            response.sendRedirect("home");
        }
    }    
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    
    @Override
    public String getServletInfo() {
        return "Short description";
    }
    
}
