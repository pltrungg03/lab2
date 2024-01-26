package controller.alert;

import dal.AccountDAO;
import dal.AlertDAO;
import dal.BlogDAO;
import dal.CommentBlogDAO;
import dal.CommentCourseDAO;
import dal.LessonCommentDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Blog;
import model.CommentBlog;
import model.CommentCourse;
import model.LessonComment;
import util.SendMail;

@WebServlet(name = "AddAlertServlet", urlPatterns = {"/add-alert"})
public class AddAlertServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddAlertServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddAlertServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);

        SendMail s = new SendMail();
        BlogDAO b = new BlogDAO();
        AccountDAO accountDao = new AccountDAO();
        CommentBlogDAO cmtblogDAO = new CommentBlogDAO();
        AlertDAO alert = new AlertDAO();

        String aid = request.getParameter("aid");
        String cmtBlogid = request.getParameter("cmtBlogid");
        if (cmtBlogid != null) {
            CommentBlog cmtB = new CommentBlog();
            cmtB = cmtblogDAO.getCommentByCommentBlogId(cmtBlogid);
            alert.addAlert(aid, "Comment in Blog: '" + cmtB.getBlog().getTitle() + "' and cotent: " + "'"+ cmtB.getContent() + "'");
            int n = alert.countAlertByAccountId(aid);

            int x = n % 3;
            if (x != 0) {
                s.sentEmail(cmtB.getAccount().getEmail(), x + "-TIME VIOLATION WARNING",
                        "Send to account: " + cmtB.getAccount().getFirstName() + cmtB.getAccount().getLastName() + "\n"
                        + "Your comment: '" + cmtB.getContent() + "' on the date '" + cmtB.getCreatedDate() + "' in the Blog Name: '" + cmtB.getBlog().getTitle() + "' "
                        + "violated our community rules. Your comment will be deleted from the system and if you violate it 3 times, "
                        + "your account will be banned from the system.");
            } else {
                accountDao.disableAccount(aid);
                s.sentEmail(cmtB.getAccount().getEmail(), 3 + "-TIME VIOLATION WARNING",
                        "Send to account: " + cmtB.getAccount().getFirstName() + cmtB.getAccount().getLastName() + "\n"
                        + "Your comment: '" + cmtB.getContent() + "' on the date '" + cmtB.getCreatedDate() + "' in the Blog Name: '" + cmtB.getBlog().getTitle() + "' "
                        + "violated our community rules. Your comment will be deleted from the system and"
                         + " your account will be banned from the system. If you want to re-open, please email to us!");
            }

        }

        String cmtCourseid = request.getParameter("cmtCourseid");
        CommentCourseDAO cmtCourseDAO = new CommentCourseDAO();
        if (cmtCourseid != null) {
            CommentCourse cmtC = cmtCourseDAO.getCommentByCommentCourseId(cmtCourseid);
            alert.addAlert(aid, "Comment in Course: '" + cmtC.getCourse().getName() + "' and cotent: '" + cmtC.getComment()+ "'");
            int n = alert.countAlertByAccountId(aid);
            int x = n % 3;
            if (x != 0) {
                s.sentEmail(cmtC.getAccount().getEmail(), x + "-TIME VIOLATION WARNING",
                        "Send to account: " + cmtC.getAccount().getFirstName() + cmtC.getAccount().getLastName() + "\n"
                        + "Your comment: '" + cmtC.getComment() + "' on the date '" + cmtC.getCreatedDate() + "' in the Course Name: '" + cmtC.getCourse().getName() + "' "
                        + "violated our community rules. Your comment will be deleted from the system and if you violate it 3 times, "
                        + "your account will be banned from the system.");
            } else {
                 accountDao.disableAccount(aid);
                s.sentEmail(cmtC.getAccount().getEmail(), 3 + "-TIME VIOLATION WARNING",
                        "Send to account: " + cmtC.getAccount().getFirstName() + cmtC.getAccount().getLastName() + "\n"
                        + "Your comment: '" + cmtC.getComment() + "' on the date '" + cmtC.getCreatedDate() + "' in the Course Name: '" + cmtC.getCourse().getName() + "' "
                        + "violated our community rules. Your comment will be deleted from the system and"
                         + " your account will be banned from the system. If you want to re-open, please email to us!");

            }
        }
        String cmtLessonid = request.getParameter("cmtLessonid");
        LessonCommentDAO lesDAO = new LessonCommentDAO();
        if (cmtLessonid != null) {
            LessonComment cmtL = new LessonComment();
            cmtL = lesDAO.getCommentByLessonCommentId(cmtLessonid);
            alert.addAlert(aid, "Comment in Lesson: '" + cmtL.getLesson().getName() + "' and cotent: '" + cmtL.getComment()+"'");
            int n = alert.countAlertByAccountId(aid);
            int x = n % 3;
            if (x != 0) {
                s.sentEmail(cmtL.getAccount().getEmail(), x + "-TIME VIOLATION WARNING",
                        "Send to account: " + cmtL.getAccount().getFirstName() + cmtL.getAccount().getLastName() + "\n"
                        + "Your comment: '" + cmtL.getComment() + "' on the date '" + cmtL.getCreatedDate() + "' in the Lesson Name: '" + cmtL.getLesson().getName() + "' "
                        + "violated our community rules. Your comment will be deleted from the system and if you violate it 3 times, "
                        + "your account will be banned from the system.");
            } else {
                 accountDao.disableAccount(aid);
                   s.sentEmail(cmtL.getAccount().getEmail(), 3 + "-TIME VIOLATION WARNING",
                        "Send to account: " + cmtL.getAccount().getFirstName() + cmtL.getAccount().getLastName() + "\n"
                        + "Your comment: '" + cmtL.getComment() + "' on the date '" + cmtL.getCreatedDate() + "' in the Lesson Name: '" + cmtL.getLesson().getName() + "' "
                       + "violated our community rules. Your comment will be deleted from the system and"
                         + " your account will be banned from the system. If you want to re-open, please email to us!");
            }

        }

        String blogId = request.getParameter("blogId");
        if (blogId != null) {
            BlogDAO blogDAO = new BlogDAO();
            Blog blog = blogDAO.getBlogById(Integer.parseInt(blogId));
            alert.addAlert(aid, "The blog name: " + blog.getTitle());
            int n = alert.countAlertByAccountId(aid);
           int x = n % 3;
            if (x != 0) {
                s.sentEmail(blog.getCreator().getEmail(), x + "-TIME VIOLATION WARNING",
                    "Send to account: " + blog.getCreator().getFirstName() + " " + blog.getCreator().getLastName() + "\n"
                    + "Your blog: '" + blog.getTitle() + "' on the date '" + blog.getCreatedDate() + " "
                    + "violated our community rules. Your comment will be deleted from the system and if you violate it 3 times, "
                    + "your account will be banned from the system.");
            } else {
                 accountDao.disableAccount(aid);
                  s.sentEmail(blog.getCreator().getEmail(), 3 + "-TIME VIOLATION WARNING",
                    "Send to account: " + blog.getCreator().getFirstName() + " " + blog.getCreator().getLastName() + "\n"
                    + "Your blog: '" + blog.getTitle() + "' on the date '" + blog.getCreatedDate() + " "
                   + "violated our community rules. Your comment will be deleted from the system and"
                        + " your account will be banned from the system. If you want to re-open, please email to us!");
            }
            
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
