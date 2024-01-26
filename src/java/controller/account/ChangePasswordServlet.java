package controller.account;

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
import util.HashPassword;

@WebServlet(name = "ChangePasswordServlet", urlPatterns = {"/change-password"})
public class ChangePasswordServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account a = (Account) session.getAttribute("user");
        if (a == null) {
            response.sendRedirect("login.jsp");
        } else {
            response.sendRedirect("change-password.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HashPassword hs = new HashPassword();
        AccountDAO d = new AccountDAO();
        String pass = request.getParameter("password");
        String repass = request.getParameter("repassword");
        String old = request.getParameter("old");
        HttpSession session = request.getSession();
        Account a = (Account) session.getAttribute("user");
        String newpass = hs.md5(pass);
        String oldpass = "";
        if(old != null && !old.isEmpty()){
            oldpass = hs.md5(old);
        }       
        if(old==null){
            if (!pass.equalsIgnoreCase(repass)) {
            request.setAttribute("error", "Password must be equal Re-password!!!");
            request.getRequestDispatcher("change-password.jsp").forward(request, response);
            } else {
               d.changePass(a.getId(), newpass);
            Account a1 = d.getAccountById(a.getId());
            session.setAttribute("user", a1);
            response.sendRedirect("home");
            }
        }else {
             if (a == null) {
            response.sendRedirect("login.jsp");
        } else if (!oldpass.equalsIgnoreCase(a.getPassword())) {
            request.setAttribute("error", "Old password incorrect!!!");
            request.getRequestDispatcher("change-password.jsp").forward(request, response);
        } else if (!pass.equalsIgnoreCase(repass)) {
            request.setAttribute("error", "Password must be equal Re-password!!!");
            request.getRequestDispatcher("change-password.jsp").forward(request, response);
        } else if (oldpass.equals(newpass)) {
            request.setAttribute("error", "New Password must not be equal old-password!!!");
            request.getRequestDispatcher("change-password.jsp").forward(request, response);
        } else {
            d.changePass(a.getId(), newpass);
            Account a1 = d.getAccountById(a.getId());
            session.setAttribute("user", a1);
            response.sendRedirect("home");
        }
        }
       
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
