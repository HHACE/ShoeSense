/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAOs.AccountDAO;
import DAOs.CommentDAO;
import DAOs.OrderDAO;
import Modals.Account;
import Modals.Order;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ADMIN
 */
public class AdminUserManagementController extends HttpServlet {

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
            out.println("<title>Servlet AdminUserManagement</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminUserManagement at " + request.getContextPath() + "</h1>");
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
//        processRequest(request, response);
        String path = request.getRequestURI();
        AccountDAO u = new AccountDAO();

        if (path.contains("/ShoeSense/admin/user/manage/status/ban/")) {

            String[] s = path.split("/");
            int id = Integer.parseInt(s[s.length - 1]);

            u.banUserAccount(id);

            String role = "User";
            List<Account> user = u.getAllByRole(role);
            request.setAttribute("listUser", user);
            request.getRequestDispatcher("/Admin_UserManagement.jsp").forward(request, response);
        } else if (path.contains("/ShoeSense/admin/user/manage/detail/order/")) {

            String[] s = path.split("/");
            int id = Integer.parseInt(s[s.length - 1]);

            OrderDAO orddao = new OrderDAO();

            if (path.contains("processing")) {
                List<Order> user = orddao.getAllOrderByAccountIdAndStatus(id, "Processing");
                request.setAttribute("listOr", user);
                request.setAttribute("userID", id);
                request.getRequestDispatcher("/Admin_UserOrderDetail.jsp").forward(request, response);
            } else if (path.contains("shipping")) {
                List<Order> user = orddao.getAllOrderByAccountIdAndStatus(id, "Shipping");
                request.setAttribute("listOr", user);
                request.setAttribute("userID", id);
                request.getRequestDispatcher("/Admin_UserOrderDetail.jsp").forward(request, response);
            } else if (path.contains("cancel")) {
                List<Order> user = orddao.getAllOrderByAccountIdAndStatus(id, "Cancel");
                request.setAttribute("listOr", user);
                request.setAttribute("userID", id);
                request.getRequestDispatcher("/Admin_UserOrderDetail.jsp").forward(request, response);
            } else if (path.contains("delivered")) {
                List<Order> user = orddao.getAllOrderByAccountIdAndStatus(id, "Delivered");
                request.setAttribute("listOr", user);
                request.setAttribute("userID", id);
                request.getRequestDispatcher("/Admin_UserOrderDetail.jsp").forward(request, response);
            } else {
                List<Order> user = orddao.getAllOrderByAccountId(id);
                request.setAttribute("listOr", user);
                request.setAttribute("userID", id);
                request.getRequestDispatcher("/Admin_UserOrderDetail.jsp").forward(request, response);
            }

        } //    --------------------
        else if (path.contains("/ShoeSense/admin/user/manage/detail/comment/")) {

            String[] s = path.split("/");
            int id = Integer.parseInt(s[s.length - 1]);

 
                request.setAttribute("userID", id);
                request.getRequestDispatcher("/Admin_UserCommentDetail.jsp").forward(request, response);
            
        } //    --------------------
        else if (path.contains("/ShoeSense/admin/user/manage/status/unban/")) {

            String[] s = path.split("/");
            int id = Integer.parseInt(s[s.length - 1]);

            u.unbanUserAccount(id);

            String role = "User";
            List<Account> user = u.getAllByRole(role);
            request.setAttribute("listUser", user);
            request.getRequestDispatcher("/Admin_UserManagement.jsp").forward(request, response);
        } else {

            String role = "User";
            List<Account> user = u.getAllByRole(role);
            request.setAttribute("listUser", user);
            request.getRequestDispatcher("/Admin_UserManagement.jsp").forward(request, response);
        }
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
        processRequest(request, response);
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
