package controller;

import dal.AccountDAO;
import dal.CourseDAO;
import dal.MajorDAO;
import dal.TransactionDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.Year;
import java.time.format.DateTimeFormatter;
import java.util.Map;

@WebServlet(name = "Dashboard", urlPatterns = {"/dashboard"})
public class Dashboard extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {

        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        CourseDAO cDAO = new CourseDAO();
        TransactionDAO tDAO = new TransactionDAO();
        AccountDAO aDAO = new AccountDAO();
        MajorDAO mDAO = new MajorDAO();
        Year currentYear = Year.now();
        Year lastYear = currentYear.minusYears(1);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy");
        //lay nam nay va nam ngoai
        String cYear = currentYear.format(formatter);
        String lYear = lastYear.format(formatter);
        request.setAttribute("cYear", cYear);
        request.setAttribute("lYear", lYear);

        //lay revanue nam nay va nam ngoai
        int cTotal = tDAO.getCurrentYearTotal();
        int lTotal = tDAO.getLastYearTotal();
        request.setAttribute("cTotal", cTotal);
        request.setAttribute("lTotal", lTotal);
        //
        Map<Integer, Integer> map = tDAO.getRevanueLast5Months();
        request.setAttribute("map", map);
        //
        int nCourse = cDAO.getNumbersOfCourseBePurchasedCurrentYear();
        request.setAttribute("nCourse", nCourse);
        //
        double rating = cDAO.getAverageratingOfAllCourses();
        request.setAttribute("rating", rating);
        //
        int nUser = aDAO.getNumbersOfUserCurrentYear();
        request.setAttribute("nUser", nUser);
        //
        Map<String, Integer> map2 = cDAO.getTop5SellerCourse();
        request.setAttribute("map2", map2);
        //
    
       
        //
        Map<String, Integer> map4 = mDAO.getNumberOfCoureWithEachMajor();
        request.setAttribute("map4", map4);

        request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
