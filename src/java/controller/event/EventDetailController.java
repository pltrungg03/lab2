package controller.event;

import dal.EventDAO;
import dal.JoinCourseDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
import model.Course;
import model.Event;
import util.Helpers;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name = "EventDetail", urlPatterns = "/event-detail")
public class EventDetailController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CommentCourseServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CommentCourseServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int eventId = Helpers.parseInt(request.getParameter("eventId"), -1);
        if(eventId == -1){
            response.setStatus(400);
            response.getWriter().write("Error while retrieving data");
            return;
        }

        EventDAO eventDAO = new EventDAO();
        Event event = eventDAO.selectEventById(eventId);
        if(event == null){
            response.setStatus(400);
            response.getWriter().write("Error while retrieving data");
            return;
        }
        List<Course> courses =  new EventDAO().selectListCourseByEvent(eventId);
        event.setCourses(courses);
        request.setAttribute("event", event);
        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("user");
        boolean canBuyEvent = true;
        if(user != null){
            int countJoinCourse = 0;
            for (int i =0; i< courses.size(); i++){
                boolean checkJoinCourse = new JoinCourseDAO().checkJoinCourse(user.getId(), courses.get(i).getId());
                if(checkJoinCourse){
                    countJoinCourse++;
                }
            }
            if(countJoinCourse == courses.size()){
                canBuyEvent = false;
            }
        }
        request.setAttribute("canBuyEvent", canBuyEvent);
        request.getRequestDispatcher("event-detail.jsp").forward(request, response);
    }
}
