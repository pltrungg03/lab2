package controller.account;

import model.GooglePojo;
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
import util.GenerateOTP;
import util.HashPassword;

@WebServlet(name = "LoginGoogleServlet", urlPatterns = {"/logingoogle"})
public class LoginGoogleServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {

        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HashPassword hs = new HashPassword();
        GenerateOTP g2 = new GenerateOTP();
        AccountDAO d = new AccountDAO();
        String code = request.getParameter("code");
        if (code.isEmpty() || code == null) {
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {

            String accessToken = d.getToken(code);
            GooglePojo g = d.getUserInfo(accessToken);
            Account a = d.checkAccountEmail(g.getEmail());
            if (a == null) {
                String x = g2.createCaptcha();
                String x2 = g2.createCaptcha();
                String pa = x + x2;
                d.signUp(g.getEmail(), g.getEmail(), g.getEmail(), "");
                Account a1 = d.checkAccountEmail(g.getEmail());
                Account a2 = d.getAccountById(a1.getId());
                HttpSession session = request.getSession();
                session.setAttribute("user", a2);
                response.sendRedirect("profile");
            }
                      
            if (a != null && !a.getUsername().equalsIgnoreCase(g.getEmail())) {
                  if(a.isIsAvailable() == false){
                request.setAttribute("error", "Your account has been banned from the system!!!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            }
                 HttpSession session = request.getSession();
                 Account a1 = d.checkAccountEmail(g.getEmail());
                session.setAttribute("user", a1);
                response.sendRedirect("home");
            }
            if (a != null && a.getUsername().equalsIgnoreCase(g.getEmail())) {
                  if(a.isIsAvailable() == false){
                request.setAttribute("error", "Your account has been banned from the system!!!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            }
                HttpSession session = request.getSession();
    
                Account a1 = d.getAccountById(a.getId());
                session.setAttribute("user", a1);
                response.sendRedirect("home");
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
    }
}
