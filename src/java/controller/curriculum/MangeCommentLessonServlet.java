/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.curriculum;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import dal.LessonCommentDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.LessonComment;

@WebServlet(name = "MangeCommentLessonServlet", urlPatterns = {"/manage-commentlesson"})
public class MangeCommentLessonServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet MangeCommentLessonServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet MangeCommentLessonServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // processRequest(request, response);
        Gson gson = new Gson();
        JsonObject jsonobj = new JsonObject();
        LessonCommentDAO lcDAO = new LessonCommentDAO();
        List<LessonComment> list = lcDAO.getAllCommentsLesson();
        String list1 = gson.toJson(list);
        jsonobj.addProperty("listCmtLesson", list1);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsonobj.toString());
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);
        String from = request.getParameter("from");
        String to = request.getParameter("to");
        String searchNameBlog = request.getParameter("search");
        LessonCommentDAO lcDAO = new LessonCommentDAO();
        List<LessonComment> listCmtLesson = lcDAO.getAllCommentsLesson();
        listCmtLesson = lcDAO.getAllCommentsLesson();
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
            listCmtLesson = lcDAO.filterCommentLesson(from, to, x2);
        } else {
            listCmtLesson = lcDAO.filterCommentLesson(from, to, null);
        }
        Gson gson = new Gson();
        JsonObject jsonobj = new JsonObject();
        String list1 = gson.toJson(listCmtLesson);
        jsonobj.addProperty("listCmtLesson", list1);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsonobj.toString());
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        //processRequest(request, response);
        String lid = request.getParameter("cmID");
        LessonCommentDAO ls = new LessonCommentDAO();
        ls.deleteLessonComment(Integer.parseInt(lid));
    } 
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
