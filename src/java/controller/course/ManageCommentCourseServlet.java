/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.course;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import dal.CommentBlogDAO;
import dal.CommentCourseDAO;
import dal.MajorDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import model.CommentBlog;
import model.CommentCourse;
import model.Major;

@WebServlet(name = "ManageCommentCourseServlet", urlPatterns = {"/manage-commentcourse"})
public class ManageCommentCourseServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ManageCommentCourseServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManageCommentCourseServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);\
        Gson gson = new Gson();
        JsonObject jsonobj = new JsonObject();
        CommentCourseDAO c = new CommentCourseDAO();
        MajorDAO m = new MajorDAO();
        List<CommentCourse> list = new ArrayList<>();
        list = c.getAllCommentsCourse();
        String list1 = gson.toJson(list);
        jsonobj.addProperty("lisCmtCourse", list1);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsonobj.toString());
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        CommentCourseDAO c = new CommentCourseDAO();
        String from = request.getParameter("from");
        String to = request.getParameter("to");
        String level = request.getParameter("level");
        String major = request.getParameter("major");

        List<CommentCourse> list = new ArrayList<>();
        list = c.getAllCommentsCourse();
        String check = request.getParameter("check").trim();
        String text = request.getParameter("textcheck").trim();
        String[] check123 = {"shit", "damn", "godamn", "hell", "bitch", "dick", "nigga"};
        String x2[] = check123;
        if (text != null && text.length() > 0) {
            String[] ads = text.split(" ");
            x2 = new String[check123.length + ads.length];
            System.arraycopy(ads, 0, x2, 0, ads.length);
            System.arraycopy(check123, 0, x2, ads.length, check123.length);

        }
        if (check != null && check.trim().length() > 0) {
            list = c.filterCommentCourse(from, to, major, level, x2);
        } else {
            list = c.filterCommentCourse(from, to, major, level, null);
        }
        Gson gson = new Gson();
        String list1 = gson.toJson(list);
        JsonObject jsonobj = new JsonObject();
        jsonobj.addProperty("lisCmtCourse", list1);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsonobj.toString());
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String cid = request.getParameter("cmID");
        CommentCourseDAO c = new CommentCourseDAO();
        c.removeCommentCourseById(Integer.parseInt(cid));
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
