/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.premiumpack;

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

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "PremiumPackMangeController", urlPatterns = {"/manage-packs"})
public class PremiumPackMangeController extends HttpServlet {

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
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet PremiumPackMangeController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PremiumPackMangeController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);
        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("home");
            return;
        }
        PremiumPackDAO daoP = new PremiumPackDAO();

        request.setAttribute("listPack", daoP.getAllPack());
        request.getRequestDispatcher("admin/manage-pack.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String status = "";
            HttpSession session = request.getSession();
            Account user = (Account) session.getAttribute("user");
            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/home");
                return;
            }
            String action = request.getParameter("action");
            if (action.equals("add")) {
                doPost_Add(request, response);
                status = "Add";
            }
            if (action.equals("delete")) {
                doPost_Delete(request, response);
                status = "Delete";
            }
            if (action.equals("edit")) {
                doPost_Edit(request, response);
                status = "Edit";
            }
            if (response.getStatus() == 400) {
                response.sendRedirect("error");
            } else {
                response.sendRedirect(request.getContextPath() + "/manage-packs?status=" + status);
            }
        } catch (Exception ex) {
            response.sendRedirect("error");
        }
    }

    protected void doPost_Delete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String packIdRaw = request.getParameter("packId");
        try {
            int packId = Integer.parseInt(packIdRaw);
            if (packId == -1) {
                response.setStatus(400);
                return;
            }
            PremiumPackDAO daoP = new PremiumPackDAO();
            daoP.deletePackage(packId);
        } catch (Exception e) {
        }

        
    }

    protected void doPost_Edit(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String packIdRaw = request.getParameter("packId");
        String name = request.getParameter("name");
        String priceRaw = request.getParameter("price");
        String valueRaw = request.getParameter("value");
        System.out.println(packIdRaw + "==" + priceRaw + "xxx" + name +"qqqqq" + valueRaw);
        try {
            int packId = Integer.parseInt(packIdRaw);
            double price = Double.parseDouble(priceRaw);
            if (packId == -1) {
                response.setStatus(400);
                return;
            }
            int value = Integer.parseInt(valueRaw);
            PremiumPackDAO daoP = new PremiumPackDAO();
            daoP.updatePackage(packId, name, price, value);
        } catch (Exception e) {
        }
    }

    protected void doPost_Add(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String priceRaw = request.getParameter("price");
        String valueRaw = request.getParameter("value");
        try {
            double price = Double.parseDouble(priceRaw);
            int value = Integer.parseInt(valueRaw);
            PremiumPackDAO daoP = new PremiumPackDAO();
            daoP.insertPackage(name, price, value);
        } catch (Exception e) {
        }

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
