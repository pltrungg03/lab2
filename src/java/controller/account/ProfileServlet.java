package controller.account;

import dal.AccountDAO;
import dal.AlertDAO;
import model.Account;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.Base64;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "ProfileServlet", urlPatterns = {"/profile"})
public class ProfileServlet extends HttpServlet {
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);
        AlertDAO alertD = new AlertDAO();
        HttpSession session = request.getSession();
        
        dal.AccountDAO d = new AccountDAO();
        
        Account a = (Account) session.getAttribute("user");
        //Xoa avatar
        String delete = request.getParameter("deleteAvatar");
        if (delete != null) {
            d.updateAvatar(a.getId(), null);
        }
        if (a == null) {
            response.sendRedirect("login.jsp");
        } else {
            Account a1 = d.getAccountById(a.getId());
            request.setAttribute("alertList", alertD.getAlertByAccountId(a.getId()));
            request.setAttribute("n", alertD.countAlertByAccountId(Integer.toString(a.getId())));
            request.setAttribute("a", a1);
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        }        
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // processRequest(request, response);
        HttpSession session = request.getSession();
        Account a = (Account) session.getAttribute("user");
        dal.AccountDAO d = new AccountDAO();
        AlertDAO alertD = new AlertDAO();
        String fname = request.getParameter("fname");
        String lname = request.getParameter("lname");
        String phone = request.getParameter("phone");
        String country = request.getParameter("country");
        String dob = request.getParameter("dob");     
        
        String base64Data = request.getParameter("avatar");
      
       
        // Decode base64 string to get the original file content
        
        if (a == null) {
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
        
        //Update infomartion
        if (a != null && base64Data == null) {
            d.updateProfile(a.getId(), phone, country, dob, fname, lname, a.getEmail());
            Account a1 = d.getAccountById(a.getId());
            request.setAttribute("alertList", alertD.getAlertByAccountId(a.getId()));
            request.setAttribute("n", alertD.countAlertByAccountId(Integer.toString(a.getId())));
            request.setAttribute("a", a1);
            session.setAttribute("user", a1);
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        }
        //Updata avatar
       if (base64Data != null ) {
            d.updateAvatar(a.getId(), base64Data);
            Account a1 = d.getAccountById(a.getId());
            request.setAttribute("alertList", alertD.getAlertByAccountId(a.getId()));
            request.setAttribute("n", alertD.countAlertByAccountId(Integer.toString(a.getId())));
            request.setAttribute("a", a1);
            session.setAttribute("user", a1);
            request.getRequestDispatcher("profile.jsp").forward(request, response);
            
        }
        
    }
    
    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
