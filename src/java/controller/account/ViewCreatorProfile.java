package controller.account;

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

@WebServlet(name = "ViewCreatorProfile", urlPatterns = {"/view-creator"})
public class ViewCreatorProfile extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {

        }

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Helpers.parseInt(request.getParameter("id"), 0);

        AccountDAO accountDAO = new AccountDAO();
        Account data = accountDAO.getAccountById(id);

        CourseDAO dao = new CourseDAO();
        List<Course> listCourse = dao.getAllCoursesByCreatorId(id);
        request.setAttribute("data", data);
        request.setAttribute("listCourse", listCourse);
        request.getRequestDispatcher("creator-profile.jsp").forward(request, response);
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
