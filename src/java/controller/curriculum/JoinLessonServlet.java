/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.curriculum;

import dal.AccountDAO;
import dal.CourseDAO;
import dal.JoinLessonDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Course;
import util.SendMail;

/**
 *
 * @author 84338
 */
@WebServlet(name = "JoinLessonServlet", urlPatterns = {"/join-lesson"})
public class JoinLessonServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet JoinLessonServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet JoinLessonServlet at " + request.getContextPath() + "</h1>");
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
        int accId = Integer.parseInt(request.getParameter("accId"));
        int lId = Integer.parseInt(request.getParameter("lId"));
        int chId = Integer.parseInt(request.getParameter("chId"));
        //confirm done 
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
            }
        }

        response.sendRedirect("lesson-details?chId=" + chId + "&lId=" + lId);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
