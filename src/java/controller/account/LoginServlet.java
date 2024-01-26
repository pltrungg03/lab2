package controller.account;

import dal.AccountDAO;
import dal.AlertDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import model.Account;
import util.HashPassword;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {

        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        AlertDAO alertD = new AlertDAO();
        HashPassword hs = new HashPassword();
        String user = request.getParameter("user");
        String password = request.getParameter("password");
        int count = 0;
        String x = request.getParameter("count");
        if (x == null) {
            count = 0;
        } else {
            try {
                count = Integer.parseInt(x);
            } catch (Exception e) {
            }

        }
        if (count == 4) {
            Cookie c = new Cookie("log", user);
            c.setMaxAge(60 * 5);
            response.addCookie(c);
        }
        Cookie cookie[] = request.getCookies();
        for (Cookie c : cookie) {
            if (c.getValue().equals(user)) {
                request.setAttribute("error", "You must wait 30 minutes to re-login!!!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        }
        AccountDAO d = new AccountDAO();
        String md5 = hs.md5(password);
        Account a1 = d.checkAccountExsit(user);
        if (a1 == null) {
            request.setAttribute("error", "Invalid user!!!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
        if (a1.isIsAvailable() == false) {
            request.setAttribute("error", "Your account has been banned from the system!!!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
        if (a1.getUsername().equals(user)) {
            if (!a1.getPassword().equals(md5)) {
                request.setAttribute("error", "Invalid password!!!");
                count++;
                request.setAttribute("count", count);
                request.getRequestDispatcher("login.jsp").forward(request, response);
            } else {
                HttpSession session = request.getSession();
                if (alertD.countAlertByAccountId(Integer.toString(a1.getId())) != 0) {
                    session.setAttribute("alert", "alert");
                }
                session.setAttribute("user", a1);
                response.sendRedirect("home");
            }
        } else {
            request.setAttribute("error", "Invalid user!!!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
