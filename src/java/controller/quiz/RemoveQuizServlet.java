package controller.quiz;

import dal.QuizDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "RemoveQuizServlet", urlPatterns = {"/remove-quiz"})
public class RemoveQuizServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // common
        QuizDAO qdb = new QuizDAO();

        // get info
        int quizId = Integer.parseInt(request.getParameter("quizId"));
        int lessonId = Integer.parseInt(request.getParameter("lessonId"));

        // remove quiz
        qdb.removeQuizByQuizId(quizId);

        // redirect
        response.sendRedirect("manage-test?lessonId=" + lessonId);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // common
        QuizDAO qdb = new QuizDAO();

        // get info
        int quizId = Integer.parseInt(request.getParameter("quizId"));
        int lessonId = Integer.parseInt(request.getParameter("lessonId"));

        // remove quiz
        qdb.removeQuizByQuizId(quizId);

        // redirect
        response.sendRedirect("manage-test?lessonId=" + lessonId);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
