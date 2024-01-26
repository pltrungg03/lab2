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
import util.HashPassword;

/**
 *
 * @author Admin
 */
@WebServlet(name="ResetPasswordServlet", urlPatterns={"/reset-password"})
public class ResetPasswordServlet extends HttpServlet {
   
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
            out.println("<title>Servlet ResetPasswordServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ResetPasswordServlet at " + request.getContextPath () + "</h1>");
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
       HttpSession session = request.getSession();
       AccountDAO accountDao = new AccountDAO();
       Cookie[] cookie = request.getCookies();
       Cookie o = accountDao.getCookie(cookie, "resetpassword");
       if(o != null){
          String tempoPass = (String) session.getAttribute("tempoPass");
          request.setAttribute("tempoPass", tempoPass);
        request.getRequestDispatcher("reset-password.jsp").forward(request, response);
       
       } else {
         request.getRequestDispatcher("forget-password.jsp").forward(request, response);
       }
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
        //processRequest(request, response);
        AccountDAO accountDao = new AccountDAO();
        String temporaryPassword = request.getParameter("tempassword");
        String newPassword = request.getParameter("password");
        String confirmPassword = request.getParameter("repasswrod");
        HashPassword hash = new HashPassword();
        HttpSession session = request.getSession();
        String x = request.getParameter("tempo");
        Cookie[] cookie = request.getCookies();
       String cou = request.getParameter("count");
       int count = 0;
        if (cou == null) {
            count = 0;
        } else {
            try {
                count = Integer.parseInt(cou);
            } catch (Exception e) {
            }

        }
        
        Cookie o = accountDao.getCookie(cookie, "resetpassword");
       
       if(o == null){
           request.setAttribute("error", "Time expried !!!");
           request.getRequestDispatcher("forget-password.jsp").forward(request, response);
       }
        if(count == 4){
              request.setAttribute("error", "You input wrong temporary password 5 times!!!");
                 o.setMaxAge(0);
                response.addCookie(o);
               request.getRequestDispatcher("forget-password.jsp").forward(request, response);
        }
        if(!x.equals(temporaryPassword)){
            request.setAttribute("error", "Temporary password was wrong !!!");
            request.setAttribute("tempo", x);
            count++;
            request.setAttribute("count", count);
            request.getRequestDispatcher("reset-password.jsp").forward(request, response);
        }
       
        if(!newPassword.equals(confirmPassword)){
            request.setAttribute("error", "Confirm password must be equal new password !!!");
            request.setAttribute("tempo", x);
             request.getRequestDispatcher("reset-password.jsp").forward(request, response);
        } else {
           
            String hashNewpass = hash.md5(newPassword);
            Account a = (Account) session.getAttribute("accountReset");
            accountDao.changePass(a.getId(), hashNewpass);
               o.setMaxAge(0);
                response.addCookie(o);
            request.setAttribute("error", "Reset Password succesfully! You can login.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
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
