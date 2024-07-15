/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import DAOs.AccountDAO;
import Modals.Account;
import Ultis.Helper;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ADMIN
 */
public class ForgotPasswordController extends HttpServlet {
   
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
            out.println("<title>Servlet ForgotPasswordController</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ForgotPasswordController at " + request.getContextPath () + "</h1>");
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
        if(path.startsWith("/ShoeSense/forgotpass")){
//                    HttpSession session = request.getSession();
//        if (session != null) {

//            session.invalidate(); // Xóa session
//        }
            request.getRequestDispatcher("ForgotPassword_Email.jsp").forward(request, response);
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
        HttpSession session = request.getSession();
        
         if (request.getParameter("btnOTPGet") != null && request.getParameter("btnOTPGet").equals("otpGet")) {
        
                        if (session != null) {
              session.setAttribute("tempEmail", null);
           }
                         String emailSesion = (String) session.getAttribute("tempEmail");
              System.out.println(emailSesion);
        String email = request.getParameter("email").trim();
        AccountDAO udao = new AccountDAO();
//        Account user = udao.checkAccountByEmail(email);
        boolean emailExisted=false;
             try {
                 emailExisted = udao.checkAccountByEmail(email);
             } catch (SQLException ex) {
                 Logger.getLogger(ForgotPasswordController.class.getName()).log(Level.SEVERE, null, ex);
             }

                
        if (emailExisted==true) {
            String newCode = Helper.getAlphaNumericString(8);
            Helper.send(email, "Reset Password", "The OTP code for your account is " + newCode);
            try {
                //            String hashPassword = Helper.hashPassword(newpass, "MD5");
                udao.otpUpdateCode(email, newCode);
            } catch (SQLException ex) {
                Logger.getLogger(ForgotPasswordController.class.getName()).log(Level.SEVERE, null, ex);
            }

            request.setAttribute("report", "New OTP code is sent to email. Please check email to receive new code");
            
            session.setAttribute("tempEmail", email);
            
            request.getRequestDispatcher("ForgotPassword_OTP.jsp").forward(request, response);
        } else {
            request.setAttribute("email", email);
            request.setAttribute("error", "Email not registered");
        }
        request.getRequestDispatcher("ForgotPassword_Email.jsp").forward(request, response);
         }
         
         
         if (request.getParameter("btnOTP") != null && request.getParameter("btnOTP").equals("otp")) {
            String otp = request.getParameter("otp").trim();
            
            String emailSesion = (String) session.getAttribute("tempEmail");

            AccountDAO udao = new AccountDAO();
            
            boolean checkOTP=false;
            boolean checkOTPTimer=false;
            try {
                System.out.println(emailSesion);
                checkOTPTimer = udao.otpCheckCodeTimer(emailSesion);
                checkOTP= udao.otpCheckCode(emailSesion, otp);
            } catch (SQLException ex) {
                Logger.getLogger(ForgotPasswordController.class.getName()).log(Level.SEVERE, null, ex);
            }
                
            
            if(checkOTP == true) {
                if(checkOTPTimer==true){
                    try {
                        udao.otpDeleteCode(emailSesion);
                    } catch (SQLException ex) {
                        Logger.getLogger(ForgotPasswordController.class.getName()).log(Level.SEVERE, null, ex);
                    }
                request.getRequestDispatcher("ForgotPassword_Password.jsp").forward(request, response);
                }
                else{
                    request.setAttribute("error", "OTP code is expired");
                }
            } else{
    
                    request.setAttribute("error", "OTP code is invalid");
            }
            
          
            
            request.getRequestDispatcher("ForgotPassword_OTP.jsp").forward(request, response);
         }
         
         if (request.getParameter("btnOTPGetAgain") != null && request.getParameter("btnOTPGetAgain").equals("otpGetAgain")) {
             String email = (String) session.getAttribute("tempEmail");
             AccountDAO udao = new AccountDAO();
             String newCode = Helper.getAlphaNumericString(8);
            Helper.send(email, "Reset Password", "The OTP code for your account is " + newCode);
            try {
                //            String hashPassword = Helper.hashPassword(newpass, "MD5");
                udao.otpUpdateCode(email, newCode);
            } catch (SQLException ex) {
                Logger.getLogger(ForgotPasswordController.class.getName()).log(Level.SEVERE, null, ex);
            }

            request.setAttribute("report", "New OTP code is sent to email. Please check email to receive new code");
            
            session.setAttribute("tempEmail", email);
            
            request.getRequestDispatcher("ForgotPassword_OTP.jsp").forward(request, response);
         }
         
         if (request.getParameter("btnOTPPassword") != null && request.getParameter("btnOTPPassword").equals("otpPass")) {
            String password = request.getParameter("password").trim();
           
            String emailSesion = (String) session.getAttribute("tempEmail");

            
            AccountDAO udao = new AccountDAO();
            
            int checkOTP=0;
            try {
                checkOTP= udao.otpUpdatePassword(emailSesion, password);
            } catch (SQLException ex) {
                Logger.getLogger(ForgotPasswordController.class.getName()).log(Level.SEVERE, null, ex);
            }
                
            
            if(checkOTP != 0){
                
                response.sendRedirect("/ShoeSense/login");
            } else{
    
                    request.setAttribute("error", "Something went wrong while updating the password");
                     request.getRequestDispatcher("ForgotPassword_Password.jsp").forward(request, response);
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
