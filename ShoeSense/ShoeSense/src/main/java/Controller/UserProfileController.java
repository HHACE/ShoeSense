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
import jakarta.servlet.http.HttpSession;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Date;

/**
 *
 * @author ADMIN
 */
public class UserProfileController extends HttpServlet {
   
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
            out.println("<title>Servlet UserProfileController</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UserProfileController at " + request.getContextPath () + "</h1>");
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
        if (path.startsWith("/ShoeSense/user/profile")) {
            String[] s = path.split("/");
            String id = s[s.length - 1];
            AccountDAO dao = new AccountDAO();
            
            
            Account u = dao.GetAccountById(id);
            
            if (u == null) {
                response.sendRedirect("/ShoeSense/login");
            } else {
                HttpSession session = request.getSession();
                session.setAttribute("thongtinnguoidung", u);
                if (u.getAccountRole().equals("User")){
                    request.getRequestDispatcher("/Profile_User.jsp").forward(request, response);
                } else{
                    request.getRequestDispatcher("/Profile_Admin.jsp").forward(request, response);
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
        String path = request.getRequestURI();
        
        if (request.getParameter("editbtn") != null && request.getParameter("editbtn").equals("edit")) {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("username");
            String gender = request.getParameter("gender");
            Date DOB = Date.valueOf(request.getParameter("birthday"));
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");

            Account u = new Account(id, name, gender, DOB, phone, address); 
            AccountDAO dao = new AccountDAO();
            int result = dao.Update(u);
            Account getuser = dao.GetAccountById(String.valueOf(id));
            if (result != 0) {
                HttpSession session = request.getSession();
                session.setAttribute("thongtinnguoidung", getuser);
                request.setAttribute("thongBaoCapNhat", "Edit sucessfully.");
  
                 
                                 if (getuser.getAccountRole().equals("User")){
                    request.getRequestDispatcher("/Profile_User.jsp").forward(request, response);
                } else{
                    request.getRequestDispatcher("/Profile_Admin.jsp").forward(request, response);
                }
                 
            } else {
                request.setAttribute("thongBaoCapNhat", "Edit unsucessful, try again.");
                HttpSession session = request.getSession();
                session.setAttribute("thongtinnguoidung", getuser);
                                 if (getuser.getAccountRole().equals("User")){
                    request.getRequestDispatcher("/Profile_User.jsp").forward(request, response);
                } else{
                    request.getRequestDispatcher("/Profile_Admin.jsp").forward(request, response);
                }
            }
        }

        if (request.getParameter("changepassbtn") != null) {
            AccountDAO dao = new AccountDAO();
            
            int id = Integer.parseInt(request.getParameter("id"));
            String oldpass = request.getParameter("oldpass");
            String newpass = request.getParameter("newpass");
            String hassnewpass = hashPassword(oldpass, "MD5");
            String alertMess = "";
            Account u1 = dao.GetAccountById(String.valueOf(id));
            if (!hassnewpass.equalsIgnoreCase(u1.getAccountPassword())) {
                alertMess = "Change fail, new password is the same as old password";
                request.setAttribute("alertMess", alertMess);
                request.setAttribute("display", "block");
                
                

                
                HttpSession session = request.getSession();
                session.setAttribute("thongtinnguoidung", u1);
                request.getRequestDispatcher("/Profile_User.jsp").forward(request, response);
            } else {
                Account u = new Account(id, newpass);
                int result = dao.UpdatePassword(u);
                if (result != 0) {
                    alertMess = "Change sucessfully, please, login again";
                    request.setAttribute("alertMess", alertMess);
                    response.sendRedirect("/ShoeSense/login");
                } else {
                    alertMess = "Change fail, please, try again";
                    request.setAttribute("alertMess", alertMess);
                    
                   HttpSession session = request.getSession();
                session.setAttribute("thongtinnguoidung", u1);
                                 if (dao.GetAccountById(String.valueOf(id)).getAccountRole().equals("User")){
                    request.getRequestDispatcher("/Profile_User.jsp").forward(request, response);
                } else{
                    request.getRequestDispatcher("/Profile_Admin.jsp").forward(request, response);
                }
                }
            }

        }
    }

        public String hashPassword(String password, String algorithm) {
        try {
            MessageDigest digest = MessageDigest.getInstance(algorithm);
            byte[] hashedBytes = digest.digest(password.getBytes());

            StringBuilder stringBuilder = new StringBuilder();
            for (byte b : hashedBytes) {
                stringBuilder.append(String.format("%02x", b));
            }

            return stringBuilder.toString();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        return null;
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
