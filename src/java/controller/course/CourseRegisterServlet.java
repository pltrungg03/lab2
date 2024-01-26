package controller.course;

import dal.CourseDAO;
import dal.AccountDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
import model.Course;
import model.Role;

@WebServlet(name = "CourseRegisterServlet", urlPatterns = {"/course-register"})
public class CourseRegisterServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("user");
        String courseId_raw = request.getParameter("courseId");
        try {
            int courseId = Integer.parseInt(courseId_raw);

            double wallet = acc.getWallet();
            CourseDAO dao = new CourseDAO();

            Course c = dao.getCourseById(courseId);
            if (dao.checkJoinedCourse(acc.getId(), courseId) != null) {

                response.sendRedirect("course-details?id=" + courseId + "&error=You+already+joined+this+course%21");
            } else {
                if (!acc.getRoles().isEmpty()) {
                    for (Role r : acc.getRoles()) {
                        if (r.getName().equalsIgnoreCase("VIP")) {
                            dao.joinCourse(acc, courseId);
                        }
                    }
                }
                if (dao.checkJoinedCourse(acc.getId(), courseId) != null) {
                    response.sendRedirect("course-details?id=" + courseId + "&success=Register+course+success%21");

                } else {
                    if (wallet < c.getPrice()) {
                        response.sendRedirect("course-details?id=" + courseId + "&error=You+don%27t+have+enough+money+to+buy+this+course%21+Please+charge+your+wallet");
                    } else {
                        wallet -= c.getPrice();
                        acc.setWallet(wallet);
                        dao.joinCourse(acc, courseId);
                        AccountDAO daoA = new AccountDAO();
                        acc = daoA.getAccountById(acc.getId());
                        session.removeAttribute("user");
                        session.setAttribute("user", acc);
                        response.sendRedirect("course-details?id=" + courseId + "&success=Register+course+success%21");
                    }

                }
            }

        } catch (NumberFormatException e) {

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
        HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("user");
        String courseId_raw = request.getParameter("courseId");
        AccountDAO daoA = new AccountDAO();
        try {
            int courseId = Integer.parseInt(courseId_raw);
            String dateExpiredVip = daoA.dateExpiredVIP(acc);
            double wallet = acc.getWallet();
            CourseDAO dao = new CourseDAO();
            String msg = "";
            Course c = dao.getCourseById(courseId);
            if (dao.checkJoinedCourse(acc.getId(), courseId) != null) {
                msg = "You already join this course!";
                // check user co phai VIP hay ko
                if (dateExpiredVip != null) {
                    // check user het han VIP hay chua
                    if (daoA.checkExpiredVIP(dateExpiredVip)) {
                        // check transaction VIP ma co value khac 0
                        String checkTransaction = "#" + c.getId() + " '" + c.getName()+"'";
                        if (daoA.checkTransactionVIP(acc, checkTransaction)) {
                            // ton tai transaction VIP khac 0 
                            // user da mua khoa hoc bang wallet
                            // khong lam gi ca
                        } else {
                            // khong ton tai transaction VIP khac 0
                            // user 1 la mua bang VIP nhung het han, 2 la chua mua khoa hoc bao gio
                            if (wallet < c.getPrice()) {
                                msg = "You don't have enough money to buy this course";
                            } else {
                                wallet -= c.getPrice();
                                acc.setWallet(wallet);
                                dao.joinCourse(acc, courseId);
                                acc = daoA.getAccountById(acc.getId());
                                session.removeAttribute("user");
                                session.setAttribute("user", acc);
                                msg = "Join course succcess!!";
                            }
                        }

                    }

                }
            } else {
                if (dateExpiredVip != null) {
                    if (!daoA.checkExpiredVIP(dateExpiredVip)) {
                        dao.joinCourse(acc, courseId);
                        msg = "Join course succcess!";
                    } 
                }
                if (dao.checkJoinedCourse(acc.getId(), courseId) == null) {
                    if (wallet < c.getPrice()) {
                        msg = "You don't have enough money to buy this course";
                    } else {
                        wallet -= c.getPrice();
                        acc.setWallet(wallet);
                        dao.joinCourse(acc, courseId);
                        acc = daoA.getAccountById(acc.getId());
                        session.removeAttribute("user");
                        session.setAttribute("user", acc);
                        msg = "Join course succcess";
                    }

                }
            }

            PrintWriter out = response.getWriter();
            out.print(msg);
        } catch (NumberFormatException e) {

        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
