package controller.role;

import dal.RoleDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ManageRolesServlet", urlPatterns = {"/manage-roles"})
public class ManageRolesServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {

        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("manage-accounts");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // common
        RoleDAO rdb = new RoleDAO();
        
        // Get Data
        int accountId = Integer.parseInt(request.getParameter("accountId"));
        String[] roles = request.getParameterValues("roles");
        
        // Update roles
        if (roles != null && roles.length > 0) {
            rdb.updateRolesByAccountId(accountId, roles);
        }
        
        // Redirect
        response.sendRedirect("manage-accounts");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
