package controller.curriculum;

import dal.AccountDAO;
import dal.CourseDAO;
import dal.JoinCourseDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;


@WebServlet(name = "CertificateServlet", urlPatterns = {"/certificate"})
public class CertificateServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CertificateServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CertificateServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        CourseDAO cDAO = new CourseDAO();
        AccountDAO aDAO = new AccountDAO();
        JoinCourseDAO jcDAO = new JoinCourseDAO();
        HttpSession session = request.getSession();
        //xu ly chuyen huong du lieu sang certificate
        try {
            int cId = Integer.parseInt(request.getParameter("cId"));
            int accId = Integer.parseInt(request.getParameter("accId"));
            if (((Account)session.getAttribute("user")).getId() != accId)
                throw new Exception();
            if (jcDAO.checkJoinCourseAndDone(accId, cId)) {
                request.setAttribute("c", cDAO.getCourseById(cId));
                String name = aDAO.getAccountById(accId).getFirstName() + " " + aDAO.getAccountById(accId).getLastName();
                request.setAttribute("name", name);
                String passedDate = jcDAO.getDatePassedCourse(cId, accId);
                request.setAttribute("passedDate", passedDate);
            } else{
                request.setAttribute("msg", false);
            }
            request.getRequestDispatcher("certificate.jsp").forward(request, response);
        } catch (Exception e) {
            response.sendRedirect("accomplishment");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
