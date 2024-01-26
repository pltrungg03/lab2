/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.premiumpack;

import dal.AccountDAO;
import dal.PremiumPackDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;

@WebServlet(name = "UpgradePremiumServlet", urlPatterns = {"/upgrade-premium"})
public class UpgradePremiumServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UpgradePremiumServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpgradePremiumServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);
        HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("user");
        AccountDAO daoA = new AccountDAO();
        String expiredVIP = daoA.dateExpiredVIP(acc);
        // list all package
        PremiumPackDAO daoP = new PremiumPackDAO();
        request.setAttribute("listPack", daoP.getAllPack());

        request.setAttribute("expiredVIP", expiredVIP);
        request.getRequestDispatcher("upgrade-vip.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);
        HttpSession session = request.getSession();
        String daysRaw = request.getParameter("days");
        String priceRaw = request.getParameter("price");
        // list all package
        PremiumPackDAO daoP = new PremiumPackDAO();
        request.setAttribute("listPack", daoP.getAllPack());

        try {
            int days = Integer.parseInt(daysRaw);
            double price = Double.parseDouble(priceRaw);
            Account acc = (Account) session.getAttribute("user");
            AccountDAO daoA = new AccountDAO();

            if (acc.getWallet() < price) {
                String expiredVIP = daoA.dateExpiredVIP(acc);
                request.setAttribute("expiredVIP", expiredVIP);
                request.setAttribute("err", "You don't have enough money to purchase this package");
                request.getRequestDispatcher("upgrade-vip.jsp").forward(request, response);
            } else {
                daoA.upgradeVIP(acc, days, price);
                acc = daoA.getAccountById(acc.getId());
                session.removeAttribute("user");
                session.setAttribute("user", acc);
                request.setAttribute("message", "Purchase success!");
                String expiredVIP = daoA.dateExpiredVIP(acc);
                request.setAttribute("expiredVIP", expiredVIP);
                request.getRequestDispatcher("upgrade-vip.jsp").forward(request, response);
            }

        } catch (Exception e) {
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
