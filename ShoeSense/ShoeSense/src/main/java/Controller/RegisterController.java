/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import DAOs.AccountDAO;
import Modals.Account;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Date;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ADMIN
 */
public class RegisterController extends HttpServlet {
   
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
            out.println("<title>Servlet RegisterController</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RegisterController at " + request.getContextPath () + "</h1>");
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
        if (path.endsWith("/ShoeSense/register")) {
            request.getRequestDispatcher("/Register.jsp").forward(request, response);
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
        if (request.getParameter("btnRegis") != null) {
            String email = request.getParameter("email");
            String name = request.getParameter("username");
            String gender = request.getParameter("gender");
            String pass = request.getParameter("password");
            
//            Date DOB = Date.valueOf(request.getParameter("birthday"));
            String dateString = request.getParameter("birthday");
            LocalDate localDate = LocalDate.parse(dateString);
            java.sql.Date DOB = java.sql.Date.valueOf(localDate);

            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            System.out.println("password: " + pass);
             System.out.println("birthdate: " + DOB);

            Account accountAdd = new Account(email, pass, name, gender, DOB, phone, address, "User", "Active", null, null);
            
            AccountDAO accountDAO = new AccountDAO();
            Account ac = accountDAO.GetAccountByEmail(email);

            if (ac.getAccountEmail() != null) {
                request.setAttribute("alertMess", "Email đã tồn tại, vui lòng sử dụng email khác");
                request.getRequestDispatcher("Register.jsp").forward(request, response);
            } else {
                int kq = 0;
                String alertMess = "";
                try {
                    kq = accountDAO.AddNew(accountAdd);
                } catch (SQLException ex) {
                    Logger.getLogger(LoginController.class.getName()).log(Level.SEVERE, null, ex);
                }

                if (kq != 0) {
                    alertMess = "Đăng ký thành công, mời bạn đăng nhập!";
                    request.setAttribute("alertMess", alertMess);
                    request.getRequestDispatcher("Login.jsp").forward(request, response);
                } else {
                    alertMess = "Lỗi đăng ký, vui lòng thử lại!";
                    request.setAttribute("alertMess", alertMess);
                    request.getRequestDispatcher("Register.jsp").forward(request, response);
                }
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
