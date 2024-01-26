package controller.quiz;

import dal.LessonDAO;
import dal.QuizDAO;
import dal.TestDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "UpdateQuizServlet", urlPatterns = {"/update-quiz"})
public class UpdateQuizServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UpdateQuizServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateQuizServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        // common
        TestDAO tdb = new TestDAO();
        QuizDAO qdb = new QuizDAO();
        LessonDAO ldb = new LessonDAO();

        // get quiz info
        String lessonId = request.getParameter("lessonId");

        // get quiz info
        String quizId = request.getParameter("quizId");
        String quizOrder = request.getParameter("quizOrder");
        String quizQuestion = request.getParameter("quizQuestion");
        String quizAnswer = request.getParameter("quizAnswer");
        String quizAnswerA = request.getParameter("quizAnswerA");
        String quizAnswerB = request.getParameter("quizAnswerB");
        String quizAnswerC = request.getParameter("quizAnswerC");
        String quizAnswerD = request.getParameter("quizAnswerD");

        // update quiz
        qdb.updateQuizByQuizId(quizId, quizOrder, quizQuestion, quizAnswer, quizAnswerA, quizAnswerB, quizAnswerC, quizAnswerD);
        
        // redirect
        response.sendRedirect("manage-test?lessonId=" + lessonId);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
