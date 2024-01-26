package controller.test;

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
import java.util.List;
import model.Lesson;
import model.Quiz;
import model.Test;

@WebServlet(name="ManageTestServlet", urlPatterns={"/manage-test"})
public class ManageTestServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ManageTestServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManageTestServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // common
        LessonDAO ldb = new LessonDAO();
        TestDAO tdb = new TestDAO();
        QuizDAO qdb = new QuizDAO();

        // get lesson id
        String lessonId = request.getParameter("lessonId");
        Lesson l = ldb.getLessonsById(Integer.parseInt(lessonId));

        // get lesson test
        Test t = tdb.getTestByLessonID(l.getId());
        if (t != null) {
            // get quizzes
            List<Quiz> qs = qdb.getListQuizzesByTestId(t.getId());

            request.setAttribute("test", t);
            request.setAttribute("quizzes", qs);
        }

        // set info
        request.setAttribute("lessonId", l.getId());

        request.getRequestDispatcher("/admin/manage-test.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // common
        TestDAO tdb = new TestDAO();
        QuizDAO qdb = new QuizDAO();
        LessonDAO ldb = new LessonDAO();

        // get lesson id
        int lessonId = Integer.parseInt(request.getParameter("lessonId"));

        // create test info
//        String testId = request.getParameter("testId");
        String testName = request.getParameter("testName");
        String testTime = request.getParameter("testTime");
        String testThreshold = request.getParameter("testThreshold");
        // get quizzes info
        String quizId = request.getParameter("quizId");
        String[] quizzesOrder = request.getParameterValues("quizzesOrder");
        String[] quizzesQuestion = request.getParameterValues("quizzesQuestion");
        String[] quizzesAnswer = request.getParameterValues("quizzesAnswer");
        String[] quizzesAnswerA = request.getParameterValues("quizzesAnswerA");
        String[] quizzesAnswerB = request.getParameterValues("quizzesAnswerB");
        String[] quizzesAnswerC = request.getParameterValues("quizzesAnswerC");
        String[] quizzesAnswerD = request.getParameterValues("quizzesAnswerD");

        // insert test 
        int testId = tdb.insertTest(testName, testTime, testThreshold);
        System.out.println("Insert test with id: " + testId);

        // update test id in lesson
        ldb.updateLessonTestId(lessonId, testId);
        System.out.println("Update test id in lesson id: " + lessonId);

        // insert quiz
        System.out.println("insert quizzes");
        qdb.insertQuizzesByTestId(testId, quizzesOrder, quizzesQuestion, quizzesAnswer, quizzesAnswerA, quizzesAnswerB, quizzesAnswerC, quizzesAnswerD);
        // update lesson testId

//        response.setContentType("text/html;charset=UTF-8");
//        PrintWriter out = response.getWriter();
//        for (int i = 0; i < quizzesOrder.length; i++) {
//            out.println(quizzesOrder[i] + ", " + quizzesQuestion[i] + ", " + quizzesAnswer[i] + ", " + quizzesAnswerA[i] + ", " + quizzesAnswerB[i] + ", " + quizzesAnswerC[i] + ", " + quizzesAnswerD[i]);
//        }
        response.sendRedirect("manage-test?lessonId=" + lessonId);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
