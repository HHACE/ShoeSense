/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import DAOs.CartDAO;
import DAOs.CommentDAO;
import DAOs.ProductDAO;
import Modals.Cart;
import Modals.Comment;
import Modals.Product;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.util.List;

/**
 *
 * @author ADMIN
 */
public class UserProductController extends HttpServlet {
   
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
            out.println("<title>Servlet UserProductController</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UserProductController at " + request.getContextPath () + "</h1>");
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
        if (path.startsWith("/ShoeSense/product/detail/")) {
            String[] s = path.split("/");
            System.out.println("some some "+s[s.length - 1]);
            int id = Integer.parseInt(s[s.length - 1]);
            ProductDAO dao = new ProductDAO();
//            CommentDAO cdao = new CommentDAO();
//            List<Comment> lc = cdao.getAllByProduct(Integer.parseInt(id));
            Product p = dao.getProductById(id);
            if (p == null) {
                response.sendRedirect("/ShoeSense/");
            } else {
                HttpSession session = request.getSession();
//                session.setAttribute("ListCmt", lc);
                session.setAttribute("thongtinsanpham", p);
                request.getRequestDispatcher("/ProductDetail_User.jsp").forward(request, response);
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
  if (request.getParameter("addNew") != null) {
            int userID = Integer.parseInt(request.getParameter("userID"));
            int proID = Integer.parseInt(request.getParameter("proID"));
            int variantID = Integer.parseInt(request.getParameter("variantID"));
//            System.out.println(variantID);
            int quantity = Integer.parseInt(request.getParameter("quantity"));
         HttpSession session = request.getSession();
            Cart c = new Cart(userID, proID, variantID, quantity);
            CartDAO cdao = new CartDAO();
            ProductDAO pdao = new ProductDAO();
//            List<Size> ls = pdao.getSize(proID);
//            boolean checkQuantity = false;
//            for (Size i : ls) {
//                if (size.equalsIgnoreCase(size)) {
//                    if (i.getQuantity() > 0) {
//                        checkQuantity = true;
//                    }
//                }
//            }
            if (true) {
                Cart c2 = cdao.getCartByVariantIDAndAccountID(variantID, userID);
//                System.out.println(c2);
                if (c2.getCartID()!=0 ){
          
//                    c2.setQuantity(c2.getQuantity() + quantity);
//                    cdao.update(c2);
                    session.setAttribute("alrtMess", "Already In Cart");
                    response.sendRedirect("/ShoeSense/cart/"+userID);
                }else{
                    
     
                int kq = cdao.AddNew(c);
       

                if (kq != 0) {
                    session.setAttribute("alrtMess", "Added To Cart");
                    response.sendRedirect("/ShoeSense/cart/"+userID);
//                request.getRequestDispatcher("/Home_User.jsp").forward(request, response);
                } else {
                    session.setAttribute("alrtMess", "Something Went Wrong. Please, Try Again");
                    response.sendRedirect("/ShoeSense/home");
//                    request.getRequestDispatcher("/Home_User.jsp").forward(request, response);
                }
                           }
            } else {
                request.setAttribute("alrtMess", "Not enought Stock");
            }

        }

        if (request.getParameter("btnAddNewComment") != null) {
            int userID = Integer.parseInt(request.getParameter("accountID")) ;
            int productID = Integer.parseInt(request.getParameter("productID")) ;
            String content = request.getParameter("content");
            if(!content.equals("")){
            CommentDAO commentDAO = new CommentDAO();
             LocalDateTime currentTime = LocalDateTime.now();
            Comment com = new Comment(productID, userID,content,currentTime, "Public" );
            
            commentDAO.AddNew(com);
            response.sendRedirect("/ShoeSense/product/detail/" + productID);
            } else {
                 response.sendRedirect("/ShoeSense/product/detail/" + productID);
            }
        }
        
        
        
        if (request.getParameter("btnEditComment") != null) {
            int userID = Integer.parseInt(request.getParameter("accountID")) ;
            int productID = Integer.parseInt(request.getParameter("productID")) ;
            String content = request.getParameter("content");
            if(!content.equals("")){
            CommentDAO commentDAO = new CommentDAO();
             LocalDateTime currentTime = LocalDateTime.now();
            Comment com = commentDAO.getAccountCommentByAccountID(userID, productID);
            com.setContent(content);
            commentDAO.updateComment(com);
            response.sendRedirect("/ShoeSense/product/detail/" + productID);
            } else {
                 response.sendRedirect("/ShoeSense/product/detail/" + productID);
            }
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
