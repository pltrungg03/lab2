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

@WebServlet(name = "UsageTransactionServlet", urlPatterns = {"/usage-transaction"})
public class UsageTransactionServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        AccountDAO daoA = new AccountDAO();

        List<OrderHistory> listTU = daoA.getUsageTransaction((Account) request.getSession().getAttribute("user"));

        request.setAttribute("listTU", listTU);
        request.getRequestDispatcher("transaction-usage.jsp").forward(request, response);

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String from = request.getParameter("from");
        String to = request.getParameter("to");

        AccountDAO daoA = new AccountDAO();

        List<OrderHistory> listTU = daoA.filterUsageTransaction((Account) request.getSession().getAttribute("user"), from, to);

        request.setAttribute("listTU", listTU);
        request.setAttribute("from", from);
        request.setAttribute("to", to);
        request.getRequestDispatcher("transaction-usage.jsp").forward(request, response);
    }

}
