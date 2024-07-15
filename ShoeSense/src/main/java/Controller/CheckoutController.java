/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import DAOs.CartDAO;
import DAOs.OrderDAO;
import DAOs.OrderDetailDAO;
import DAOs.OrderStatusLogDAO;
import DAOs.ProductDAO;
import DAOs.ProductVariantDAO;
import Modals.Cart;
import Modals.Order;
import Modals.OrderDetail;
import Modals.OrderStatusLog;
import Modals.Product;
import Modals.ProductVariant;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ADMIN
 */
public class CheckoutController extends HttpServlet {
   
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
            out.println("<title>Servlet CheckoutController</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CheckoutController at " + request.getContextPath () + "</h1>");
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
        request.getRequestDispatcher("/Checkout.jsp").forward(request, response);
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
//        processRequest(request, response);
            if (request.getParameter("Order") != null) {
            int accountid = Integer.parseInt(request.getParameter("accountID")) ;
            int total = Integer.parseInt(request.getParameter("totalPrice")) ;
            String payment = request.getParameter("paymentMethod");
//            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            
            
            OrderDAO orddao = new OrderDAO();
            OrderStatusLogDAO osldao = new OrderStatusLogDAO();
            OrderDetailDAO oddao = new OrderDetailDAO();
            
            CartDAO cartdao = new CartDAO();
            ProductDAO prodao = new ProductDAO();
            ProductVariantDAO vardao = new ProductVariantDAO();
            
            Order ord = new Order(accountid, address, payment, total, "Processing");

            
                try {
                    orddao.AddNewOrder(ord);
                    
                    ord = orddao.getNewestOrderinAccount(ord.getAccountID());
                    
                    LocalDateTime currentTime = LocalDateTime.now();
                    OrderStatusLog osl = new OrderStatusLog(ord.getOrderID(), 0, currentTime, "Processing");
                    osldao.AddNewOrderStatusLog(osl);
                    
                    List<Cart> cartl = cartdao.getAllInUserCart(ord.getAccountID());
                    
                    for (Cart cart : cartl) {
                            Product pro = prodao.getProductById(cart.getProductID());
                                OrderDetail od = new OrderDetail(ord.getOrderID(), cart.getProductID(), cart.getVariantID(), cart.getQuantity(), pro.getProductPrice()* cart.getQuantity());
                                oddao.AddNewOrderDetail(od);
                                
                                ProductVariant var = vardao.getProductVariantById(cart.getVariantID());
                                var.setVariantQuantity(var.getVariantQuantity() - cart.getQuantity());
                                vardao.updateProductVariant(var);
                                
                                
                                   cartdao.deleteWhenBuy(cart.getCartID());
                                
                    }
            
                 
                    
                } catch (SQLException ex) {
                    Logger.getLogger(CheckoutController.class.getName()).log(Level.SEVERE, null, ex);
                }
            
                response.sendRedirect("cart/"+accountid);
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
