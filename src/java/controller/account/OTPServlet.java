package controller.account;

import dal.AccountDAO;
import model.Account;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import util.HashPassword;

@WebServlet(name = "OTPServlet", urlPatterns = {"/otp"})
public class OTPServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {

        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("sign-up.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        AccountDAO d = new AccountDAO();
        HashPassword hs = new HashPassword();
        String otp = request.getParameter("otp");
        String user = request.getParameter("user");
        String pass = request.getParameter("pass");
        String otp1 = request.getParameter("otp1");
        String email = request.getParameter("email");
        String count = request.getParameter("count");
     int x = 0;
        if(count != null){
            try {
                x = Integer.parseInt(count);
            } catch (Exception e) {
            }
        }
        if(x == 5){
             request.setAttribute("error", "You input otp wrong 5 times!!!");
            request.getRequestDispatcher("sign-up.jsp").forward(request, response);
        }
        Cookie[] cookie = request.getCookies();
        Cookie o = d.getCookie(cookie, "otp");
        if (o != null) {
            if (!otp.equalsIgnoreCase(otp1)) {
                x++;
                request.setAttribute("count", x);
                request.setAttribute("error", "Wrong otp!");
                request.setAttribute("otp", otp1);
                request.setAttribute("user", user);
                request.setAttribute("pass", pass);
                request.setAttribute("email", email);
                request.getRequestDispatcher("otp.jsp").forward(request, response);
            } else {
                String md5 = hs.md5(pass);
                d.signUp(user, md5, email, "");
                Account a = new Account();
                HttpSession session = request.getSession();
                a = d.checkAccountExsit(user);
                session.setAttribute("user", a);
                o.setMaxAge(0);
                response.addCookie(o);
                response.sendRedirect("profile");
            }
        } else {
            request.setAttribute("error", "Time expired!!!");
            request.getRequestDispatcher("sign-up.jsp").forward(request, response);

        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
