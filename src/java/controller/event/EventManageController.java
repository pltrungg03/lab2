package controller.event;


import com.google.gson.Gson;
import dal.CommentCourseDAO;
import dal.CourseDAO;
import dal.EventDAO;
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
import java.sql.Date;
import java.text.ParseException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "EventManage", urlPatterns = "/manage-events")
public class EventManageController extends HttpServlet {

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
        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("user");
        if(user == null){
            response.sendRedirect("home");
            return;
        }
        EventDAO eventDAO = new EventDAO();
        List<Event> events = eventDAO.selectAllListEvent();
        CourseDAO courseDAO = new CourseDAO();
        List<Course> courses = courseDAO.getAllCourses();
        for (int i = 0; i< events.size(); i++){
            eventDAO = new EventDAO();
            Event event = events.get(i);
            event.setCourses(eventDAO.selectListCourseByEvent(event.getId()));
        }
        request.setAttribute("courses", new Gson().toJson(courses));
        request.setAttribute("events", events);
        request.getRequestDispatcher("admin/manage-events.jsp").forward(request, response);
    }

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try{
            String status = "";
            HttpSession session = request.getSession();
            Account user = (Account) session.getAttribute("user");
            if(user == null){
                response.sendRedirect(request.getContextPath() + "/home");
                return;
            }
            String action = request.getParameter("action");
            if(action.equals("add")){
                doPost_Add(request, response);
                status = "Add";
            }
            if(action.equals("addCombo")){
                doPost_AddCombo(request, response);
                status = "Add combo";
            }
            if(action.equals("delete")){
                doPost_Delete(request, response);
                status = "Delete";
            }
            if(action.equals("edit")){
                doPost_Edit(request, response);
                status = "Edit";
            }
            if(response.getStatus() == 400){
                response.sendRedirect("error");
            }
            else {
                response.sendRedirect(request.getContextPath() +"/manage-events?status="+status);
            }
        }
        catch (Exception ex){
            response.sendRedirect("error");
        }
    }
    protected void doPost_AddCombo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ParseException {
        int eventId = Helpers.parseInt(request.getParameter("eventId"), -1);
        if(eventId == -1){
            response.setStatus(400);
            return;
        }

        EventDAO eventDAO = new EventDAO();
        List<Course> courses = eventDAO.selectListCourseByEvent(eventId);
        Map<String, String[]> paramMap = request.getParameterMap();
        Map<Integer, Boolean> coursesMap = new HashMap<>();
        // iterate through the parameter map
        for (String paramName : paramMap.keySet()) {
            if (paramName.startsWith("courseMap[")) {
                int courseId = Helpers.parseInt(paramName.substring(10, paramName.length() - 1), -1); // extract the courseId
                if(courseId == -1){
                    response.setStatus(400);
                    break;
                }
                boolean value = Boolean.valueOf(request.getParameter(paramName)); // get the value (true or false)
                coursesMap.put(courseId, value);
                // Now you can process the courseId and its associated value
            }
        }
        for (Course course : courses){
            if(coursesMap.get(course.getId()) == false){
                eventDAO = new EventDAO();
                eventDAO.deleteEventCourseByCompositeKey(eventId, course.getId());
            }
            coursesMap.remove(course.getId());
        }
        for (Map.Entry<Integer, Boolean> entry : coursesMap.entrySet()) {
            Integer courseId = entry.getKey();
            Boolean value = entry.getValue();
            if(value){
                eventDAO = new EventDAO();
                eventDAO.insertEventCourse(eventId, courseId);
            }
        }
    }

    protected void doPost_Delete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ParseException {
        int eventId = Helpers.parseInt(request.getParameter("eventId"), -1);
        if(eventId == -1){
            response.setStatus(400);
            return;
        }
        EventDAO eventDAO = new EventDAO();
        eventDAO.deleteEventCourseByEventId(eventId);
        eventDAO = new EventDAO();
        eventDAO.deleteEvent(eventId);
    }

    protected void doPost_Edit(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ParseException {
        int eventId = Helpers.parseInt(request.getParameter("eventId"), -1);
        if(eventId == -1){
            response.setStatus(400);
            return;
        }
        EventDAO eventDAO = new EventDAO();
        Event event = eventDAO.selectEventById(eventId);
        if(event == null){
            response.setStatus(400);
            return;
        }
        String content = request.getParameter("content");
        Date expiredDate = Helpers.convertStringToDate(request.getParameter("expiredDate"));
        Double discount = Double.parseDouble(request.getParameter("discount"));
        event.setContent(content);
        event.setDiscount(discount);
        event.setExpiredDate(expiredDate);
        event.setCreatedDate(Helpers.getDateNow());
        eventDAO = new EventDAO();
        eventDAO.updateEvent(event);
    }

    protected void doPost_Add(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ParseException {
        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("user");
        String content = request.getParameter("content");
        Double discount = Double.parseDouble(request.getParameter("discount"));
        Date expiredDate = Helpers.convertStringToDate(request.getParameter("expiredDate"));
        Date createdDate = Helpers.getDateNow();

        if(createdDate.after(expiredDate)){
            response.setStatus(400);
            response.sendRedirect(request.getContextPath() +"/manage-events");
        }

        Event event = new Event();
        event.setCreatorId(user.getId());
        event.setContent(content);
        event.setDiscount(discount);
        event.setCreatedDate(createdDate);
        event.setExpiredDate(expiredDate);
        EventDAO eventDAO = new EventDAO();
        eventDAO.insertEvent(event);

    }
    /**
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
