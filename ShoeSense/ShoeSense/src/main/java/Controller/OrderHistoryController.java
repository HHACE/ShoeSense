/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import DAOs.AccountDAO;
import DAOs.OrderDAO;
import DAOs.OrderDetailDAO;
import DAOs.OrderStatusLogDAO;
import DAOs.ProductDAO;
import DAOs.ProductVariantDAO;
import Modals.Account;
import Modals.Order;
import Modals.OrderDetail;
import Modals.OrderStatusLog;
import Modals.ProductVariant;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ADMIN
 */
public class OrderHistoryController extends HttpServlet {
   
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
            out.println("<title>Servlet OrderHistoryController</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet OrderHistoryController at " + request.getContextPath () + "</h1>");
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
//        processRequest(request, response);

        String path = request.getRequestURI();

            String[] s = path.split("/");
          
            AccountDAO dao = new AccountDAO();

            HttpSession session = request.getSession();

        
        if (path.contains("processing")){
                    String id = s[s.length - 2];
            Account u = dao.GetAccountById(id);
            if (u != null) {
                OrderDAO ordao = new OrderDAO();
                List<Order> orderHistory = ordao.getAllOrderByAccountIdAndStatus(Integer.parseInt(id), "Processing");
                session.setAttribute("userIn4", u);
                request.setAttribute("orderHistory", orderHistory);
request.getRequestDispatcher("/OrderHistory.jsp").forward(request, response);
            }
        }
        else if (path.contains("shipping")) {
                    String id = s[s.length - 2];
            Account u = dao.GetAccountById(id);
            if (u != null) {
                OrderDAO ordao = new OrderDAO();
                List<Order> orderHistory = ordao.getAllOrderByAccountIdAndStatus(Integer.parseInt(id), "Shipping");
                session.setAttribute("userIn4", u);
                request.setAttribute("orderHistory", orderHistory);
request.getRequestDispatcher("/OrderHistory.jsp").forward(request, response);
            }
        }
        
        else if (path.contains("cancel")) {
                    String id = s[s.length - 2];
            Account u = dao.GetAccountById(id);
            if (u != null) {
                OrderDAO ordao = new OrderDAO();
                 List<Order> orderHistory = ordao.getAllOrderByAccountIdAndStatus(Integer.parseInt(id), "Cancel");
                session.setAttribute("userIn4", u);
                request.setAttribute("orderHistory", orderHistory);
request.getRequestDispatcher("/OrderHistory.jsp").forward(request, response);
            }
        }
        else if (path.contains("delivered")) {
                    String id = s[s.length - 2];
            Account u = dao.GetAccountById(id);
            if (u != null) {
                OrderDAO ordao = new OrderDAO();
                 List<Order> orderHistory = ordao.getAllOrderByAccountIdAndStatus(Integer.parseInt(id), "Delivered");
                session.setAttribute("userIn4", u);
                request.setAttribute("orderHistory", orderHistory);
request.getRequestDispatcher("/OrderHistory.jsp").forward(request, response);
            }
        }
        else{
            String id = s[s.length - 1];
            Account u = dao.GetAccountById(id);
            if (u != null) {
                OrderDAO ordao = new OrderDAO();
                List<Order> orderHistory = ordao.getAllOrderByAccountId(Integer.parseInt(id));
                session.setAttribute("userIn4", u);
                request.setAttribute("orderHistory", orderHistory);
request.getRequestDispatcher("/OrderHistory.jsp").forward(request, response);
            }
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
   if(request.getParameter("CancelOrder")!=null){
            int orderID = Integer.parseInt(request.getParameter("orderID"));
//            int productID = Integer.parseInt(request.getParameter("productID"));
//            int quantity = Integer.parseInt(request.getParameter("quantity"));
            int userID = Integer.parseInt(request.getParameter("userID"));
            
            OrderDAO odao = new OrderDAO();
            OrderDetailDAO oddao = new OrderDetailDAO();
            ProductDAO pdao = new ProductDAO();
            ProductVariantDAO vardao= new ProductVariantDAO();
            int kq = 0;
            
            Order ord = odao.getOrderById(orderID);
            ord.setOrderStatus("Cancel");
            
                 odao.updateOrderStatus(ord);
                 
                             OrderStatusLogDAO osldao = new OrderStatusLogDAO();
            LocalDateTime currentTime = LocalDateTime.now();
            OrderStatusLog osl = new OrderStatusLog(orderID, 0, currentTime, "Cancel");
            try {
                osldao.AddNewOrderStatusLog(osl);
            } catch (SQLException ex) {
                Logger.getLogger(OrderManagementController.class.getName()).log(Level.SEVERE, null, ex);
            } 
                
            List<OrderDetail> lod = oddao.getAllOrderDetailByOrderId(ord.getOrderID());
            
            for (OrderDetail od : lod){
              ProductVariant var = vardao.getProductVariantById(od.getVariantID());
              var.setVariantQuantity(var.getVariantQuantity() + od.getQuantity());
              vardao.updateProductVariant(var);
            }
             
           
            
            
//            List<OrderDetail> lo = odao.showOrderDetail(orderID);
//            for(OrderDetail i: lo){
//                int kq1 = odao.DeleteOrderDetail(orderID);
//            }
            
//            kq = odao.DeleteOrder(orderID);

       

//            response.sendRedirect("/Sho/OrderHistory/" + userID);
                doGet(request, response);
//             for (Product p : pro) {
//                    if (c.getProductID() == p.getProductID()) {
//                        int quantity = p.getProductQuantity() - c.getQuantity();
//                        pdao.updateQuantity(quantity, p.getProductID());
//                    }
//                    }
            
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
