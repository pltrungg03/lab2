/**
 * AuthorizePaymentServlet class - requests PayPal for payment.
 *
 * @author Nam Ha Minh
 * @copyright https://codeJava.net
 */
package controller.paypal;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.paypal.base.rest.PayPalRESTException;
import model.Account;
import model.OrderDetail;
import model.PaymentServices;

@WebServlet("/authorize-payment")
public class AuthorizePaymentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public AuthorizePaymentServlet() {
    }

    

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Account acc = (Account) request.getSession().getAttribute("user");
        String amount = request.getParameter("amount");
        String priceRaw = request.getParameter("price");
        try {
            double price = Double.parseDouble(priceRaw);
            double total = price;
            OrderDetail orderDetail = new OrderDetail(amount,
                    String.format("%.2f", price),
                    String.format("%.2f", total));
            try {
                PaymentServices paymentServices = new PaymentServices();
                String approvalLink = paymentServices.authorizePayment(orderDetail, acc);

                response.sendRedirect(approvalLink);

            } catch (PayPalRESTException ex) {
                request.setAttribute("errorFeature", "Charge Wallet");
                request.setAttribute("errorTitle", "Charge Error");
                request.setAttribute("errorMessage", ex.getMessage());
                ex.printStackTrace();
                request.getRequestDispatcher("error.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            System.out.println(e);
        }
    }

}
