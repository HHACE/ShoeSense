/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import DAOs.CommentDAO;
import DAOs.ProductDAO;
import Modals.Comment;
import Modals.Product;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

/**
 *
 * @author ADMIN
 */
public class CommentManagementController extends HttpServlet {
   
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
            out.println("<title>Servlet CommentManagementController</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CommentManagementController at " + request.getContextPath () + "</h1>");
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
            String[] s = path.split("/");
            int id = Integer.parseInt(s[s.length - 1]) ;
                            HttpSession session = request.getSession();
//                session.setAttribute("ListCmt", lc);
                session.setAttribute("ProductID", id);
            
                request.getRequestDispatcher("/Admin_CommentManagement.jsp").forward(request, response);
            
        
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
  if (request.getParameter("btnHide") != null) {
              int commentID = Integer.parseInt(request.getParameter("commentID"));
                          CommentDAO cdao = new CommentDAO();
                          Comment com = cdao.getCommentByID(commentID);
                          com.setCommentStatus("Hide");
                          cdao.updateCommentStatus(com);
      doGet(request, response);
  }
  
    if (request.getParameter("btnPublic") != null) {
              int commentID = Integer.parseInt(request.getParameter("commentID"));
                          CommentDAO cdao = new CommentDAO();
                          Comment com = cdao.getCommentByID(commentID);
                          com.setCommentStatus("Public");
                          cdao.updateCommentStatus(com);
     doGet(request, response);
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
