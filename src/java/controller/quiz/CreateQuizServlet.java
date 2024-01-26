/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.quiz;

import dal.QuizDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author 988le
 */
@WebServlet(name = "CreateQuizServlet", urlPatterns = {"/create-quiz"})
public class CreateQuizServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // common
        QuizDAO qdb = new QuizDAO();

        // get info
        String lessonId = request.getParameter("lessonId");
        int testId = Integer.parseInt(request.getParameter("testId"));
//        String quizId = request.getParameter("quizId");
        String quizOrder = request.getParameter("quizOrder");
        String quizQuestion = request.getParameter("quizQuestion");
        String quizAnswer = request.getParameter("quizAnswer");
        String quizAnswerA = request.getParameter("quizAnswerA");
        String quizAnswerB = request.getParameter("quizAnswerB");
        String quizAnswerC = request.getParameter("quizAnswerC");
        String quizAnswerD = request.getParameter("quizAnswerD");

        // insert quiz
        qdb.insertQuizByTestId(testId, quizOrder, quizQuestion, quizAnswer, quizAnswerA, quizAnswerB, quizAnswerC, quizAnswerD);

        response.sendRedirect("manage-test?lessonId=" + lessonId);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
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
