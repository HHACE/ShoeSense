/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAOs.ProductVariantDAO;
import Modals.ProductVariant;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;

/**
 *
 * @author ADMIN
 */
@MultipartConfig
public class ProductVariantsManagementController extends HttpServlet {

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
            out.println("<title>Servlet ProductVariantsManagementController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProductVariantsManagementController at " + request.getContextPath() + "</h1>");
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
        String[] s = path.split("/");
        String ss = s[s.length - 1];

    try {
        // Attempt to parse the last segment as an integer
        int id = Integer.parseInt(ss);
        
        // Set the 'proID' attribute on the request
        request.setAttribute("proID", id);
        
        // Forward the request to the Admin_ProductVariantManagement.jsp
        request.getRequestDispatcher("/Admin_ProductVariantManagement.jsp").forward(request, response);
    } catch (NumberFormatException e) {
        // Handle cases where the last segment is not a valid integer
        // Log the error or redirect to an error page
        e.printStackTrace(); // Log the exception for debugging
        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid ID format");
    }
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
        ProductVariantDAO vardao = new ProductVariantDAO();
        System.out.println(request.getParameter("deleteVariant"));

        if (request.getParameter("updateVariant") != null && request.getParameter("updateVariant").equals("Edit")) {

            int variantID = Integer.parseInt(request.getParameter("variantID2"));
            String productName = request.getParameter("name");
//                        String productPrice = request.getParameter("price");
            String size = request.getParameter("size");
            String color = request.getParameter("color");
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            
            
            Part filePart = request.getPart("img");
            String fileName = null;
            if (filePart != null){
                            String uploadPath = getServletContext().getRealPath("") + "img\\product";
//                        
            System.err.println(uploadPath);
//                        
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            fileName = getFileName(filePart);
            String filePath = uploadPath + File.separator + fileName;
            filePart.write(filePath);
            }
            


            ProductVariant var = vardao.getProductVariantById(variantID);

            var.setVariantImg("./img/product/" + fileName);
            var.setVariantSize(size);
            var.setVariantColor(color);
            var.setVariantQuantity(quantity);
            
            System.out.println(var.getVariantQuantity());
            
            vardao.updateProductVariant(var);

            
 
            
        }

        if (request.getParameter("deleteVariant") != null && request.getParameter("deleteVariant").equals("Delete")) {
            int variantID = Integer.parseInt(request.getParameter("variantID1"));
            System.out.println(variantID);
            vardao.deleteProductVariantByID(variantID);

        }

                                   String path = request.getRequestURI();
        String[] s = path.split("/");
        String ss = s[s.length - 1];

        int id = Integer.parseInt(ss);

        request.setAttribute("proID", id);

        request.getRequestDispatcher("/Admin_ProductVariantManagement.jsp").forward(request, response);
        

    }

    private String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        String[] tokens = contentDisposition.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
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
