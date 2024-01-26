package controller.account;

import dal.AccountDAO;
import jakarta.servlet.ServletContext;
import model.Account;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import util.GenerateOTP;
import util.SendMail;

@WebServlet(name = "SignUpServlet", urlPatterns = {"/sign-up"})
public class SignUpServlet extends HttpServlet {

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
         ServletContext context = getServletContext();
        String user = request.getParameter("user");
        String pass = request.getParameter("password");
        String repass = request.getParameter("re-password");
        String email = request.getParameter("email");  
        AccountDAO d = new AccountDAO();
        SendMail s = new SendMail();
         String mail = context.getInitParameter("mail");
        String passwordMail = context.getInitParameter("password");
        Account a1 = d.getAccountByUsername(user);
        Account a2 = d.checkAccountEmail(email);
        if (a1 != null) {
            request.setAttribute("error", "Username exist!!!!!!");
             request.getRequestDispatcher("sign-up.jsp").forward(request, response);
        }
        if (a2 != null) {
            request.setAttribute("error", "Email exist!!!");
             request.getRequestDispatcher("sign-up.jsp").forward(request, response);
        }
        if (!pass.equalsIgnoreCase(repass)) {
            request.setAttribute("error", "Password must be equal Re-password!!!");
            request.getRequestDispatcher("sign-up.jsp").forward(request, response);
        }

        if (a1 == null && a2 == null && pass.equalsIgnoreCase(repass)) {
            GenerateOTP g = new GenerateOTP();
            String otp = g.createCaptcha();
            Cookie o = new Cookie("otp", otp);
            o.setMaxAge(60 * 5);
            response.addCookie(o);
            s.sentEmail(email, "OTP", "OTP: " + otp);
            request.setAttribute("otp", otp);
            request.setAttribute("user", user);
            request.setAttribute("pass", pass);
            request.setAttribute("email", email);
            request.setAttribute("notice", "notice");
            request.getRequestDispatcher("otp.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
