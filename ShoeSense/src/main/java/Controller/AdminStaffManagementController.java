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
import java.sql.Date;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ADMIN
 */
public class AdminStaffManagementController extends HttpServlet {
   
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
            out.println("<title>Servlet AdminStaffManagement</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminStaffManagement at " + request.getContextPath () + "</h1>");
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
        AccountDAO sdao = new AccountDAO();

//            if (path.contains("/ShoeSense/admin/user/manage/status/ban/")) {
                
        

                
                
                if (path.contains("/ShoeSense/admin/staff/manage/delete")) {
            String[] s = path.split("/");
            String id = s[s.length - 1];

            sdao.deleteAccountByID(Integer.parseInt(id));
            response.sendRedirect("/ShoeSense/admin/staff/manage");

        } else if (path.contains("/ShoeSense/admin/staff/manage/edit")) {
            String[] s = path.split("/");
            String id = s[s.length - 1];
  
            Account staff = sdao.GetAccountById(id);
            request.setAttribute("Staff", staff);
            request.getRequestDispatcher("/Admin_EditStaff.jsp").forward(request, response);

        }
                  else if (path.contains("/ShoeSense/admin/staff/manage/status/ban/")) {
                
                String[] s = path.split("/");
                int id = Integer.parseInt(s[s.length - 1]);
     
                
                sdao.banUserAccount(id);
                
                String role = "Staff";
                List<Account> staff = sdao.getAllByRole(role);
                String display = (String) request.getAttribute("display");
                  request.setAttribute("display", display);
                request.setAttribute("listStaff", staff);
                request.getRequestDispatcher("/Admin_StaffManagement.jsp").forward(request, response);
    } else if (path.contains("/ShoeSense/admin/staff/manage/status/unban/")) {
                
                String[] s = path.split("/");
                int id = Integer.parseInt(s[s.length - 1]);
     
                
                sdao.unbanUserAccount(id);
        
                String role = "Staff";
                List<Account> staff = sdao.getAllByRole(role);
                String display = (String) request.getAttribute("display");
                  request.setAttribute("display", display);
                request.setAttribute("listStaff", staff);
                request.getRequestDispatcher("/Admin_StaffManagement.jsp").forward(request, response);}
        
        else {
                        List<Account> staff = sdao.getAllByRole("Staff");
                String display = (String) request.getAttribute("display");
                request.setAttribute("display", display);
                request.setAttribute("listStaff", staff);
                request.getRequestDispatcher("/Admin_StaffManagement.jsp").forward(request, response);
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
       if (request.getParameter("addNewStaff") != null) {

            
                        String email = request.getParameter("email");
            String name = request.getParameter("staffname");
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

            Account s = new Account(email, pass, name, gender, DOB, phone, address, "Staff", "Active", null, null);
            
            
            AccountDAO sdao = new AccountDAO();
            Account ac = sdao.GetAccountByEmail(email);

            int kq = 0;
            boolean checkexist = false;
//            for (Staff i : ls) {
//                if (i.getStaffEmail().equalsIgnoreCase(email)) {
//                    checkexist = true;
//                }
//            }

            if(ac.getAccountEmail() != null){
            checkexist = true;
            }

            if (checkexist) {
                List<Account> staff = sdao.getAllByRole("Staff");
                request.setAttribute("listStaff", staff);
                request.setAttribute("display", "Email already exsited");
                request.getRequestDispatcher("/Admin_StaffManagement.jsp").forward(request, response);
            } else {
                try {
                    kq = sdao.AddNew(s);
                } catch (SQLException ex) {
                    Logger.getLogger(AdminStaffManagementController.class.getName()).log(Level.SEVERE, null, ex);
                }
                if (kq != 0) {
                     List<Account> staff = sdao.getAllByRole("Staff");
                    request.setAttribute("listStaff", staff);
//                    response.sendRedirect("/F-Store/AdminManager/staffmanagement");
                request.getRequestDispatcher("/Admin_StaffManagement.jsp").forward(request, response);
                } else {
                     List<Account> staff = sdao.getAllByRole("Staff");
                    request.setAttribute("listStaff", staff);
                    request.setAttribute("display", "Something went wrong, please, try again");

                    request.getRequestDispatcher("/Admin_StaffManagement.jsp").forward(request, response);
                }
            }
        }
       
               if (request.getParameter("update") != null) {
            int staffID =  Integer.parseInt(request.getParameter("id"));
            String staffName = request.getParameter("name");
            String gender = request.getParameter("gender");
            Date staffDOB = Date.valueOf(request.getParameter("DOB"));
            String staffPhone = request.getParameter("phone");
            String staffAddress = request.getParameter("address");

            AccountDAO sdao = new AccountDAO();
            Account s = new Account(staffID, staffName, gender, staffDOB, staffPhone, staffAddress); 
            int result = sdao.Update(s);
//            List<Account> staff = sdao.getAllByRole("Staff");
//            request.setAttribute("listStaff", staff);
//            response.sendRedirect("/ShoeSense/admin/staff/manage");

                if (result != 0) {
                List<Account> staff = sdao.getAllByRole("Staff");
                request.setAttribute("listStaff", staff);
                response.sendRedirect("/ShoeSense/admin/staff/manage");
            } else {
  
                
                 Account staff = sdao.GetAccountById(String.valueOf(staffID));

  
            request.setAttribute("alertMess", "Edit unsucessful, try again.");
            request.setAttribute("Staff", staff);

                
                request.getRequestDispatcher("/Admin_EditStaff.jsp").forward(request, response);
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
