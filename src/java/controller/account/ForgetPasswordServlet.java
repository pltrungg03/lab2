/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.account;

import dal.AccountDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
import util.GenerateOTP;
import util.SendMail;

/**
 *
 * @author Admin
 */
@WebServlet(name="ForgetPasswordServlet", urlPatterns={"/forget-password"})
public class ForgetPasswordServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ForgetPasswordServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ForgetPasswordServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
       // processRequest(request, response);
       request.getRequestDispatcher("forget-password.jsp").forward(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        ///processRequest(request, response);
        String email = request.getParameter("email");
        HttpSession session = request.getSession();
        AccountDAO accountdao = new AccountDAO();
       Account a = accountdao.checkAccountEmail(email);

        GenerateOTP generateotp = new GenerateOTP();
        String x =  "os" + generateotp.createCaptcha()+"xas";
        SendMail sendmail = new SendMail();
        if(a == null){
            request.setAttribute("error", "Email does not exist!!!");
            request.getRequestDispatcher("forget-password.jsp").forward(request, response);
        } else {
            sendmail.sentEmail(a.getEmail(), "Resert password", "Temporary password is: "+x);
            request.setAttribute("tempoPass", x);
            session.setAttribute("tempoPass", x);
            session.setAttribute("accountReset", a);
            Cookie cookie = new Cookie("resetpassword", "resetPassword");
            cookie.setMaxAge(60 * 5);
            response.addCookie(cookie);
            request.setAttribute("alert", "Temporary password was sent to your email !!!");
           request.getRequestDispatcher("reset-password.jsp").forward(request, response);
        }
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
