
package controller.curriculum;

import dal.GradeDAO;
import dal.TestDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
import model.Test;


@WebServlet(name = "TestDetailsServlet", urlPatterns = {"/test-details"})
public class TestDetailsServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet TestDetailsServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet TestDetailsServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("user");
        GradeDAO gDAO = new GradeDAO();
        TestDAO tDAO = new TestDAO();
        int lId = Integer.parseInt(request.getParameter("lId"));
        int chId = Integer.parseInt(request.getParameter("chId"));
        Test t = tDAO.getTestByLessonID(lId);
        request.setAttribute("t", t);
        request.setAttribute("chId", chId);
        request.setAttribute("lId", lId);
        boolean existGrade = gDAO.checkExistGrade(user.getId(), t.getId());

        if (existGrade) {
            boolean checkTest = gDAO.checkCanTest(user.getId(), t.getId());
            if (checkTest) {
                request.getRequestDispatcher("test-details.jsp").forward(request, response);
            } else {
                response.sendRedirect("lesson-details?chId=" + chId + "&lId=" + lId + "&msg=fail");
            }

        } else {
            request.getRequestDispatcher("test-details.jsp").forward(request, response);

        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
