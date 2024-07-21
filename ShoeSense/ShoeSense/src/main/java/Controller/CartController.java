/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import DAOs.AccountDAO;
import DAOs.CartDAO;
import DAOs.ProductDAO;
import DAOs.ProductVariantDAO;
import Modals.Account;
import Modals.Cart;
import Modals.Product;
import Modals.ProductVariant;
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
public class CartController extends HttpServlet {
   
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
            out.println("<title>Servlet CartController</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CartController at " + request.getContextPath () + "</h1>");
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
        if (path.startsWith("/ShoeSense/cart/")) {
            String[] s = path.split("/");
            String id = s[s.length - 1];

            // Kiểm tra ID có phai la so nguyen hay khong
            boolean isInteger = true;
            try {
                Integer.parseInt(id);
            } catch (NumberFormatException e) {
                isInteger = false;
            }

            // Chỉ lấy user nếu id là số nguyên, còn nếu không phải số thì bỏ qua
            if (isInteger) {
                AccountDAO dao = new AccountDAO();
                Account u = dao.GetAccountById(id);
                HttpSession session = request.getSession();
                if (u != null && isInteger) {
                    CartDAO cdao = new CartDAO();
                    List<Cart> mycart = cdao.getAllInUserCart(Integer.parseInt(id));
                    session.setAttribute("userIn4", u);
                    request.setAttribute("mycartlist", mycart);
                    request.getRequestDispatcher("/Cart.jsp").forward(request, response);
                }
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
     if (request.getParameter("deletebtn") != null) {
            int cartID = Integer.parseInt(request.getParameter("cartID"));
            int userID = Integer.parseInt(request.getParameter("userID"));
            int productID = Integer.parseInt(request.getParameter("productID"));
            int variantID = Integer.parseInt(request.getParameter("variantID"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            Cart c = new Cart(cartID, userID, productID, variantID, quantity);
            CartDAO dao = new CartDAO();
            dao.deleteByVariantID(variantID);

            HttpSession session = request.getSession();
            session.setAttribute("cartList", c);
            response.sendRedirect("/ShoeSense/cart/" + userID);
        }

        if (request.getParameter("editCartbtn") != null) {
            int cartID = Integer.parseInt(request.getParameter("cartID"));
            int userID = Integer.parseInt(request.getParameter("userID"));
            int productID = Integer.parseInt(request.getParameter("productID"));
            int variant = Integer.parseInt(request.getParameter("variantID"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            Cart c = new Cart(cartID, userID, productID, variant, quantity);
            CartDAO dao = new CartDAO();
            
            ProductVariantDAO vardao = new ProductVariantDAO();
            ProductVariant var = vardao.getProductVariantById(variant);
            
            if (quantity <= var.getVariantQuantity()){
            
            
            
            int rs = dao.update(c);
            if (rs != 0) {
                HttpSession session = request.getSession();
                session.setAttribute("thongtingiohang", c);
                request.setAttribute("notificationMessage", "Chỉnh sửa thành công.");
                response.sendRedirect("/ShoeSense/cart/" + userID);
            } else {
                request.setAttribute("notificationMessage", "Error.");
                 doGet(request, response);
            }
                        }
            else {
                            request.setAttribute("notificationMessage", "Over Stock Limit.");
//                response.sendRedirect("/ShoeSense/cart/" + userID);
                doGet(request, response);
            }

        }

        if (request.getParameter("buy") != null) {
            int userID = Integer.parseInt(request.getParameter("userID"));
              CartDAO dao = new CartDAO();
                 List<Cart> listcart = dao.getAllInUserCart(userID);
//            for (Cart c : listcart) {
//                    ProductDAO productDAO = new ProductDAO();
//                    Product product = productDAO.getProductById(c.getProductID());
//                    Item i = new Item();
//                    i.setProduct(product);
//                    i.setProductQuantity(c.getQuantity());
//                    i.setSize(c.getSize());
//                    i.setPrice(product.getProductPrice());
//
//                    List<Item> items = c.getItems() != null ? c.getItems() : new ArrayList<Item>();
//                    items.add(i);
//                    c.setItems(items);
//                }

                HttpSession session = request.getSession();
                session.setAttribute("cartList", listcart);
            response.sendRedirect(request.getContextPath() + "/checkout");
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
