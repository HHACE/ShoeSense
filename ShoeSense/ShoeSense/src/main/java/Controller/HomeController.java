/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import DAOs.OrderDAO;
import DAOs.ProductDAO;
import Modals.Order;
import Modals.Product;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author ADMIN
 */
public class HomeController extends HttpServlet {
   
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
            out.println("<title>Servlet HomeController</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet HomeController at " + request.getContextPath () + "</h1>");
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
               String path = request.getRequestURI();
        if (path.endsWith("/ShoeSense/home/user") || path.endsWith("/ShoeSense/")) {
                            ProductDAO productDAO = new ProductDAO();
                String search = request.getParameter("search") == null ? "" : request.getParameter("search");
                String sort = request.getParameter("sort") == null ? "" : request.getParameter("sort");
                String category = request.getParameter("category") == null ? "" : request.getParameter("category");
                search = search.trim();

                int totalproduct = productDAO.getNumberProduct(search);
                int numberPage = (int) Math.ceil((double) totalproduct / 8); // 3 - 2 product/1 3/2=2 4/2=2 5/2=3
                int index;
                String currentPage = request.getParameter("index");
                if (currentPage == null) {
                    index = 1;
                } else {
                    index = Integer.parseInt(currentPage);
                }

                category = category.replaceAll("^'+|'+$", "").replace("O", "");

                List<Product> plist = productDAO.getProduct(search, index, sort, category);
                request.setAttribute("numberPage", numberPage);
                request.setAttribute("plist", plist);
            request.getRequestDispatcher("/Home_User.jsp").forward(request, response);
        } 
        else {
            if (path.contains("/ShoeSense/admin")) {
                           OrderDAO order1 = new OrderDAO();
            List<Order> orderList2 = order1.getAllOrderByStatus("Delivered");
            request.setAttribute("listOr", orderList2);

               request.getRequestDispatcher("/Admin_Finance.jsp").forward(request, response);
            }
//            if (path.endsWith("/ShoeSense/staff")) {
//                           OrderDAO order1 = new OrderDAO();
//            List<Order> orderList2 = order1.getAllOrderByStatus("Delivered");
//            request.setAttribute("listOr", orderList2);
//
//               request.getRequestDispatcher("/Admin_Finance.jsp").forward(request, response);
//            }
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
        processRequest(request, response);
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
