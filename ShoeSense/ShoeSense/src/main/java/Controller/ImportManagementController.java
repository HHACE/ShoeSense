/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAOs.AccountDAO;
import DAOs.ImportDAO;
import DAOs.ProductDAO;
import DAOs.ProductVariantDAO;
import Modals.Import;
import Modals.Product;
import Modals.ProductVariant;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Date;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ADMIN
 */
public class ImportManagementController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ImportManagementController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ImportManagementController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
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

//        if (path.contains("add")) {
//            request.getRequestDispatcher("/Admin_ImportAdding.jsp").forward(request, response);
//        } else {
        request.getRequestDispatcher("/Admin_ImportManagement.jsp").forward(request, response);
//        }

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        processRequest(request, response);
        System.out.println(request.getParameter("addNewImport"));

        if (request.getParameter("addNewImport") != null && request.getParameter("addNewImport").equals("Add")) {
            int staffID = Integer.parseInt(request.getParameter("staffID"));
            String productName = request.getParameter("name");
//                        String productPrice = request.getParameter("price");
            String size = request.getParameter("size");
            String color = request.getParameter("color");
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            ImportDAO impdao = new ImportDAO();
//                                AccountDAO accdao = new AccountDAO();
            ProductDAO prodao = new ProductDAO();
            ProductVariantDAO vardao = new ProductVariantDAO();

            Product pro = prodao.getProductByName(productName);
            if (pro == null || pro.getProductID() == 0) {
                pro = new Product(productName, 0, null, null, null, "Hide");
                try {
                    prodao.AddNew(pro);
                } catch (SQLException ex) {
                    Logger.getLogger(ImportManagementController.class.getName()).log(Level.SEVERE, null, ex);
                }

                pro = prodao.getProductByName(productName);
            }

            boolean varCheck = false;
            List<ProductVariant> varList = vardao.getAllProductVariantByProductID(pro.getProductID());
            ProductVariant var = null;
            if (varList != null) {
                for (ProductVariant varTemp : varList) {
                    if (varTemp.getVariantSize().equalsIgnoreCase(size) && varTemp.getVariantColor().equalsIgnoreCase(color)) {
                        varCheck = true;
                            if (varTemp.getVariantQuantity() + quantity < 0) {
                                quantity = varTemp.getVariantQuantity();
                                varTemp.setVariantQuantity(0);
                            } else {
                                varTemp.setVariantQuantity(varTemp.getVariantQuantity() + quantity);
                            }
                        vardao.updateProductVariant(varTemp);
                        var = varTemp;
                        break;
                    }

                }
            }

            if (varCheck == false) {
                var = new ProductVariant(pro.getProductID(), null, size, color, quantity);
                try {
                    vardao.AddNew(var);
                } catch (SQLException ex) {
                    Logger.getLogger(ImportManagementController.class.getName()).log(Level.SEVERE, null, ex);
                }

                varList = vardao.getAllProductVariantByProductID(pro.getProductID());
                if (varList != null) {
                    for (ProductVariant varTemp : varList) {
                        if (varTemp.getVariantSize().equalsIgnoreCase(size) && varTemp.getVariantColor().equalsIgnoreCase(color)) {

                            if (varTemp.getVariantQuantity() + quantity < 0) {
                                quantity = varTemp.getVariantQuantity();
                                varTemp.setVariantQuantity(0);
                            } else {
                                varTemp.setVariantQuantity(varTemp.getVariantQuantity() + quantity);
                            }

                            vardao.updateProductVariant(varTemp);
                            var = varTemp;
                            break;
                        }

                    }
                }
            }
            LocalDateTime currentTime = LocalDateTime.now();
//            Date sqlDate = Date.valueOf(currentTime.toLocalDate());

            Import imp = new Import(currentTime, staffID, pro.getProductID(), var.getVariantID(), quantity);

            try {
                impdao.AddNew(imp);
            } catch (SQLException ex) {
                Logger.getLogger(ImportManagementController.class.getName()).log(Level.SEVERE, null, ex);
                request.setAttribute("alertMess", "Import fail, please, try again");
                request.getRequestDispatcher("/Admin_ImportManagement.jsp").forward(request, response);
            }

            request.setAttribute("alertMess", "Import successful");
            request.getRequestDispatcher("/Admin_ImportManagement.jsp").forward(request, response);
        }

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
