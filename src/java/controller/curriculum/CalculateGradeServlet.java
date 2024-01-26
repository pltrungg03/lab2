package controller.curriculum;

import dal.AccountDAO;
import dal.ChapterDAO;
import dal.CourseDAO;
import dal.GradeDAO;
import dal.JoinCourseDAO;
import dal.JoinLessonDAO;
import dal.TestDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Chapter;
import model.Course;
import model.Test;
import util.SendMail;

@WebServlet(name = "CalculateGradeServlet", urlPatterns = {"/calculate-grade"})
public class CalculateGradeServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CalculateGradeServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CalculateGradeServlet at " + request.getContextPath() + "</h1>");
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
        JoinLessonDAO jlDAO = new JoinLessonDAO();
        GradeDAO gDAO = new GradeDAO();
        TestDAO tDAO = new TestDAO();
        JoinCourseDAO jcDAO = new JoinCourseDAO();
        
        int tId = Integer.parseInt(request.getParameter("tId"));
        int chId = Integer.parseInt(request.getParameter("chId"));
        int lId = Integer.parseInt(request.getParameter("lId"));
        int accId = Integer.parseInt(request.getParameter("accId"));
        Test t = tDAO.getTestById(tId);
        String q[] = new String[t.getQuizzes().size()];
        for (int i = 0; i < q.length; i++) {
            q[i] = request.getParameter("q" + t.getQuizzes().get(i).getId());
        }

        //dem so dap an dung
        int count = 0;
        for (int i = 0; i < q.length; i++) {
            for (int j = 0; j < q.length; j++) {
                if (q[j] != null) {
                    String s[] = q[j].split("-");
                    if (t.getQuizzes().get(i).getId() == Integer.parseInt(s[0])
                            && t.getQuizzes().get(i).getAnswer() == Integer.parseInt(s[1])) {
                        count++;
                    }
                }
            }
        }

        double score = (count * 1.0) / (q.length * 1.0);

        if (score * 10 >= t.getThreshold()) {
            //du diem pass
            gDAO.insertOrUpdateGrade(accId, tId, score * 10, true);
            if (!jlDAO.isDoneLesson(accId, lId)) {
                jlDAO.confirmDoneLesson(accId, lId);
                CourseDAO cDAO = new CourseDAO();
                AccountDAO aDAO = new AccountDAO();
                int cId = cDAO.getCourseIdByChapterId(chId);
                Course c = cDAO.getCourseByIdIncludeCheckingProgress(cId, accId);
                if (cDAO.checkingDone1CourseOfAccount(cId, accId)) {
                    SendMail send = new SendMail();
                    String stuName = aDAO.getAccountById(accId).getFirstName() + " " + aDAO.getAccountById(accId).getLastName();
                    String subject = "Congratulations on Completing Your Online Course with Byte Scholar!";
                    String content = "Dear " + stuName + ", \n" + "We are thrilled to extend our warmest congratulations to you on successfully completing your online course: " + c.getName().toUpperCase() + " with Byte Scholar! 🎉\n"
                            + "Your dedication, hard work, and commitment to your education have paid off, and we couldn't be prouder of your achievement. We understand that online learning can be a challenging journey, but you've demonstrated resilience and determination throughout your course, and for that, you deserve all the applause.\n"
                            + "\n"
                            + "At Byte Scholar, we strive to provide top-notch online education that empowers individuals like you to achieve their learning goals. Your successful course completion is a testament to your ability to adapt to new learning environments and make the most of the opportunities presented.\n"
                            + "\n"
                            + "We hope that this accomplishment is just the beginning of your educational journey with us. Byte Scholar is here to support your continued growth and learning, and we look forward to seeing you excel in future courses and endeavors.\n"
                            + "\n"
                            + "Should you have any feedback or suggestions on how we can further enhance your learning experience, please do not hesitate to share. Your input is invaluable to us as we work to continuously improve our platform.\n"
                            + "\n"
                            + "Once again, congratulations on this remarkable achievement. We are excited to witness your future successes and remain committed to being your partner in learning.\n"
                            + "\n"
                            + "Best regards!" + "\nBYTE SCHOLAR";
                    send.sentEmail(aDAO.getAccountById(accId).getEmail(), subject, content);
                    jcDAO.updatePassedDateCourse(accId, cId);
                }
            }
        } else {
            //neu khong du diem pass, check xem trong database no da tung pass
            //hay chua, neu da pass roi thi ko sua lai thanh false
            boolean checkPassTest = gDAO.checkPassedTest(accId, tId);
            if (!checkPassTest) {
                gDAO.insertOrUpdateGrade(accId, tId, score * 10, false);
                jlDAO.confirmNotDoneLesson(accId, lId);
            } else {
                gDAO.updateTimeOfLastTest(accId, tId);
            }
        }

        //gui chi tiet bai kiem tra sang ben trang xem ket qua chi tiet
        t.setScore(Math.round(score * 10 * 100.0) / 100.0);
        //set selected answer
        for (int i = 0; i < q.length; i++) {
            for (int j = 0; j < q.length; j++) {
                if (q[j] != null) {
                    String s[] = q[j].split("-");
                    if (t.getQuizzes().get(i).getId() == Integer.parseInt(s[0])) {
                        t.getQuizzes().get(i).setSelectedAnswer(Integer.parseInt(s[1]));
                    } 
                }
            }
        }
        //
        request.setAttribute("t", t);
        request.setAttribute("chId", chId);
        request.setAttribute("lId", lId);
        request.getRequestDispatcher("test-result-details.jsp").forward(request, response);

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
