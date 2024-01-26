package controller.event;

import com.google.gson.Gson;
import dal.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.*;
import util.Helpers;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name = "BuyEvent", urlPatterns = "/buy-event")
public class BuyEventController extends HttpServlet {

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

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("user");
        if(user == null){
            response.sendRedirect("login");
            return;
        }
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
        String messageReturn = "";
        List<Course> courses = new EventDAO().selectListCourseByEvent(eventId);
        for(int i = 0; i < courses.size(); i++){
            boolean checkJoinCourse = new JoinCourseDAO().checkJoinCourse(user.getId(), courses.get(i).getId());
            if(checkJoinCourse){
                courses.remove(i);
                i--;
            }
        }
        if(courses.isEmpty()){
            messageReturn = "You already join all courses in event";
            session.setAttribute("messageBuyEvent", messageReturn);
            response.sendRedirect("event-detail?eventId="+eventId);
            return;
        }
        event.setCourses(courses);
        double price = event.getSalePrice();
        user = new AccountDAO().getAccountById(user.getId());
        if(user.getWallet() < price){
            messageReturn = "Your wallet don't have enough money";
            session.setAttribute("messageBuyEvent", messageReturn);
            response.sendRedirect("event-detail?eventId="+eventId);
            return;
        }
        
        
        
        CourseDAO cDao = new CourseDAO();
        for(Course course : courses){
            JoinCourse joinCourse = new JoinCourse();
            joinCourse.setAccountId(user.getId());
            joinCourse.setCourseId(course.getId());
            joinCourse.setJoinedDate(Helpers.getDateNow());
            joinCourse.setPassed(false);
                                    
                        cDao.joinCourse(user, course.getId());
                        
        }
        user.setWallet(user.getWallet() - price);
        
                        session.removeAttribute("user");
                        session.setAttribute("user", user);
        boolean updateUserFlag = new AccountDAO().updateWallet(user);
        if(!updateUserFlag){
            messageReturn =  "Error while transaction";
            session.setAttribute("messageBuyEvent", messageReturn);
            response.sendRedirect("event-detail?eventId="+eventId);
            return;
        }

        messageReturn = "Join event successfully";
        session.setAttribute("messageBuyEvent", messageReturn);
        response.sendRedirect("event-detail?eventId="+eventId);
    }
}
