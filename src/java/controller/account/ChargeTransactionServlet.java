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
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Account;
import model.OrderHistory;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "ChargeTransactionServlet", urlPatterns = {"/charge-transaction"})
public class ChargeTransactionServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        AccountDAO daoA = new AccountDAO();

        List<OrderHistory> listTC = daoA.getChargeTransaction((Account) request.getSession().getAttribute("user"));

        request.setAttribute("listTC", listTC);
        request.getRequestDispatcher("transaction-charge.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String from = request.getParameter("from");
        String to = request.getParameter("to");

        AccountDAO daoA = new AccountDAO();

        List<OrderHistory> listTC = daoA.filterChargeTransaction((Account) request.getSession().getAttribute("user"), from, to);

        request.setAttribute("listTC", listTC);
        request.setAttribute("from", from);
        request.setAttribute("to", to);
        request.getRequestDispatcher("transaction-charge.jsp").forward(request, response);
    }

}
