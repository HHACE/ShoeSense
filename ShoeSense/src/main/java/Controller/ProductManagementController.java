/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAOs.CartDAO;
import DAOs.ImportDAO;
import DAOs.ProductDAO;
import Modals.Product;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.sql.SQLException;
import java.text.NumberFormat;
import java.util.List;
import java.util.Locale;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author ADMIN
 */
@MultipartConfig
public class ProductManagementController extends HttpServlet {

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
            out.println("<title>Servlet ProductManagementController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProductManagementController at " + request.getContextPath() + "</h1>");
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

        String type = request.getParameter("type");
        System.out.println("type: " + type);
        ProductDAO productDAO = new ProductDAO();
        CartDAO cartDAO = new CartDAO();

//                                        List<Product> listDefault = productDAO.getAllProduct();
//                        request.setAttribute("list", listDefault);
//                        request.getRequestDispatcher("/Admin_ProductManagement.jsp").forward(request, response);
        switch (type) {
            case "view":
                List<Product> list = productDAO.getAllProduct();
                request.setAttribute("list", list);
                request.getRequestDispatcher("/Admin_ProductManagement.jsp").forward(request, response);
                break;
            case "delete":
                        int productIdDelete = Integer.parseInt( request.getParameter("pid"));
//                        cartDAO.delete(Integer.parseInt(productIdDelete));
                        productDAO.deleteProductByID(productIdDelete);
                        response.sendRedirect("manage?type=view");
                break;
            case "update":
                //Product productUpdate = productDAO.getProductById(Integer.parseInt(request.getParameter("pid")));
                Product productUpdate = productDAO.getProductById(Integer.parseInt(request.getParameter("pid")));
                request.setAttribute("data", productUpdate);
                request.getRequestDispatcher("/Admin_ProductUpdate.jsp").forward(request, response);
                break;
                
                           case "hide":
                productDAO.hideProduct(Integer.parseInt( request.getParameter("pid")));
                response.sendRedirect("manage?type=view");
                break;
                case "public":
                productDAO.unhideProduct(Integer.parseInt( request.getParameter("pid")));
                response.sendRedirect("manage?type=view");
                break;
            default:
                List<Product> listDefault = productDAO.getAllProduct();
                request.setAttribute("list", listDefault);
                request.getRequestDispatcher("/Admin_ProductManagement.jsp").forward(request, response);
                break;
        }

//        String path = request.getRequestURI();
//        if (path.startsWith("/F-Store/Product/Detail/")) {
//            String[] s = path.split("/");
//            String id = s[s.length - 1];
//            ProductDAO dao = new ProductDAO();
//            CommentDAO cdao = new CommentDAO();
//            List<Comment> lc = cdao.getAllByProduct(Integer.parseInt(id));
//            Product p = dao.getProductById(Integer.parseInt(id));
//            if (p == null) {
//                response.sendRedirect("/F-Store/");
//            } else {
//                HttpSession session = request.getSession();
//                session.setAttribute("ListCmt", lc);
//                session.setAttribute("thongtinsanpham", p);
//                request.getRequestDispatcher("/ProductDetail.jsp").forward(request, response);
//            }
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
        String path = request.getRequestURI();

        switch (path) {
            case "/ShoeSense/product/manage":
                String type = request.getParameter("type");
                ProductDAO productDAO = new ProductDAO();
                System.out.println("type post:" + type);
                switch (type) {
                    case "add":
//                        int staffID = Integer.parseInt(request.getParameter("staffID"));
                        String productName = request.getParameter("name");
                        String productPrice = request.getParameter("price");
                        String size = request.getParameter("size");
//                        int productQuantity = Integer.parseInt(request.getParameter("quantity"));
                        Part filePart = request.getPart("img");
                        String uploadPath = getServletContext().getRealPath("") + "img\\product";
//                        
                        System.err.println(uploadPath);
//                        
                        File uploadDir = new File(uploadPath);
                        if (!uploadDir.exists()) {
                            uploadDir.mkdir();
                        }

                        String fileName = getFileName(filePart);
                        String filePath = uploadPath + File.separator + fileName;
                        filePart.write(filePath);
                        String category = request.getParameter("category");
                        String description = request.getParameter("description");

                        ProductDAO pdao = new ProductDAO();
                        ImportDAO importdao = new ImportDAO();
                        List<Product> lp = pdao.getAllProduct();
                        boolean checkname = false;
                        boolean checksize = false;
                        int proID = 0;

                        for (Product i : lp) {
                            if (i.getProductName().equalsIgnoreCase(productName)) {
                                checkname = true;
                                proID = i.getProductID();
                            }
//                            List<Size> ls = pdao.getSize(i.getProductID());
//                            for (Size j : ls) {
//                                if (j.getSize().equalsIgnoreCase(size)) {
//                                    checksize = true;
//                                    break;
//                                }
//                            }
                        }
                        if (!checkname) {
                            try {
                                productDAO.AddNew(new Product(productName, Double.parseDouble(productPrice), "./img/product/" + fileName, category, description, "Hide"));

//                            productDAO.addProductAndImport(staffID, productName, productPrice, size, productQuantity, "./img/product/" + fileName, description, category, productQuantity);
                            } catch (SQLException ex) {
                                Logger.getLogger(ProductManagementController.class.getName()).log(Level.SEVERE, null, ex);
                            }
                        }
                        else {
                            
//                            if (!checksize) {
//                                productDAO.addSize(String.valueOf(proID), size, path);
//                                importdao.addNewImport(staffID, proID, size, productQuantity);
//                            } else {
//                                productDAO.updateSize(proID, size, productQuantity);
//                                importdao.addNewImport(staffID, proID, size, productQuantity);
//                            }
                            request.setAttribute("alertMess", "Product already existed");
                            List<Product> listDefault = productDAO.getAllProduct();
                            request.setAttribute("list", listDefault);
                            request.getRequestDispatcher("/Admin_ProductManagement.jsp").forward(request, response);
                             break;
                        }

                        response.sendRedirect("manage?type=view");
                        break;
                    case "update":
                        String id = request.getParameter("id");
                        String productNameUpdate = request.getParameter("name");
                        String productPriceUpdate = request.getParameter("price");
                        Part filePartUpdate = request.getPart("img");
                        String uploadPathUpdate = getServletContext().getRealPath("")  + "img\\product";
                        File uploadDirUpdate = new File(uploadPathUpdate);
                        if (!uploadDirUpdate.exists()) {
                            uploadDirUpdate.mkdir();
                        }
                        String fileNameUpdate = getFileName(filePartUpdate);
                        String filePathUpdate = uploadPathUpdate + File.separator + fileNameUpdate;
                        filePartUpdate.write(filePathUpdate);
                        String productCategoryUpdate = request.getParameter("category");
                        String descriptionUpdate = request.getParameter("description");

                        productDAO.updateProduct(new Product(Integer.parseInt(id), productNameUpdate, Double.parseDouble(productPriceUpdate), "./img/product/" + fileNameUpdate, productCategoryUpdate, descriptionUpdate, productDAO.getProductById(Integer.parseInt(id)).getProductStatus()));
                        response.sendRedirect("manage?type=view");
                        break;
                }
                break;

        }
    }

    public String formatCurrency(float amount) {
        // Tạo một đối tượng NumberFormat để định dạng số tiền
        NumberFormat currencyFormatter = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));

        // Định dạng số tiền và trả về chuỗi đã định dạng
        return currencyFormatter.format(amount);
    }

    static final String from = "fstore1703@gmail.com";
    static final String password = "nlsdqrjpgtagttqi";

    private boolean sendEmail(String to, String subject, String body) {
        // Properties : khai báo các thuộc tính
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com"); // SMTP HOST
        props.put("mail.smtp.port", "587"); // TLS 587 SSL 465
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        // create Authenticator
        Authenticator auth = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                // TODO Auto-generated method stub
                return new PasswordAuthentication(from, password);
            }
        };

        // Phiên làm việc
        Session session = Session.getInstance(props, auth);

        // Tạo một tin nhắn
        MimeMessage msg = new MimeMessage(session);

        try {
            // Kiểu nội dung
            msg.addHeader("Content-type", "text/HTML; charset=UTF-8");

            // Người gửi
            msg.setFrom(from);

            // Người nhận
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to, false));

            // Tiêu đề email
            msg.setSubject(subject, "UTF-8");

            // Quy định email nhận phản hồi
            // msg.setReplyTo(InternetAddress.parse(from, false))
            // Nội dung
            msg.setContent(body, "text/HTML; charset=UTF-8");

            // Gửi email
            Transport.send(msg);
            System.out.println("Gửi email thành công");
            return true;
        } catch (Exception e) {
            System.out.println("Gặp lỗi trong quá trình gửi email");
            e.printStackTrace();
            return false;
        }
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


// package Controller;

// import DAOs.CartDAO;
// import DAOs.ImportDAO;
// import DAOs.ProductDAO;
// import Modals.Product;
// import java.io.File;
// import java.io.IOException;
// import java.io.PrintWriter;
// import java.sql.SQLException;
// import java.text.NumberFormat;
// import java.util.List;
// import java.util.Locale;
// import java.util.Properties;
// import java.util.logging.Level;
// import java.util.logging.Logger;
// import javax.mail.Authenticator;
// import javax.mail.Message;
// import javax.mail.PasswordAuthentication;
// import javax.mail.Session;
// import javax.mail.Transport;
// import javax.mail.internet.InternetAddress;
// import javax.mail.internet.MimeMessage;
// import jakarta.servlet.ServletException;
// import jakarta.servlet.annotation.MultipartConfig;
// import jakarta.servlet.http.HttpServlet;
// import jakarta.servlet.http.HttpServletRequest;
// import jakarta.servlet.http.HttpServletResponse;
// import jakarta.servlet.http.Part;

// @MultipartConfig
// public class ProductManagementController extends HttpServlet {

//     private static final Logger LOGGER = Logger.getLogger(ProductManagementController.class.getName());

//     @Override
//     protected void doGet(HttpServletRequest request, HttpServletResponse response)
//             throws ServletException, IOException {
//         String type = request.getParameter("type");
//         ProductDAO productDAO = new ProductDAO();
//         CartDAO cartDAO = new CartDAO();

//         switch (type) {
//             case "view":
//                 List<Product> list = productDAO.getAllProduct();
//                 request.setAttribute("list", list);
//                 request.getRequestDispatcher("/Admin_ProductManagement.jsp").forward(request, response);
//                 break;
//             case "delete":
//                 try {
//                     int productIdDelete = Integer.parseInt(request.getParameter("pid"));
//                     productDAO.deleteProductByID(productIdDelete);
//                     response.sendRedirect("manage?type=view");
//                 } catch (NumberFormatException | SQLException e) {
//                     LOGGER.log(Level.SEVERE, "Error deleting product", e);
//                     response.sendRedirect("manage?type=view&error=delete");
//                 }
//                 break;
//             case "update":
//                 try {
//                     Product productUpdate = productDAO.getProductById(Integer.parseInt(request.getParameter("pid")));
//                     request.setAttribute("data", productUpdate);
//                     request.getRequestDispatcher("/Admin_ProductUpdate.jsp").forward(request, response);
//                 } catch (NumberFormatException | SQLException e) {
//                     LOGGER.log(Level.SEVERE, "Error retrieving product for update", e);
//                     response.sendRedirect("manage?type=view&error=update");
//                 }
//                 break;
//             case "hide":
//                 try {
//                     productDAO.hideProduct(Integer.parseInt(request.getParameter("pid")));
//                     response.sendRedirect("manage?type=view");
//                 } catch (NumberFormatException | SQLException e) {
//                     LOGGER.log(Level.SEVERE, "Error hiding product", e);
//                     response.sendRedirect("manage?type=view&error=hide");
//                 }
//                 break;
//             case "public":
//                 try {
//                     productDAO.unhideProduct(Integer.parseInt(request.getParameter("pid")));
//                     response.sendRedirect("manage?type=view");
//                 } catch (NumberFormatException | SQLException e) {
//                     LOGGER.log(Level.SEVERE, "Error making product public", e);
//                     response.sendRedirect("manage?type=view&error=public");
//                 }
//                 break;
//             default:
//                 List<Product> listDefault = productDAO.getAllProduct();
//                 request.setAttribute("list", listDefault);
//                 request.getRequestDispatcher("/Admin_ProductManagement.jsp").forward(request, response);
//                 break;
//         }
//     }

//     @Override
//     protected void doPost(HttpServletRequest request, HttpServletResponse response)
//             throws ServletException, IOException {
//         String path = request.getRequestURI();
//         ProductDAO productDAO = new ProductDAO();

//         switch (path) {
//             case "/ShoeSense/product/manage":
//                 handleProductManagement(request, response, productDAO);
//                 break;
//             default:
//                 response.sendRedirect("manage?type=view&error=invalid");
//                 break;
//         }
//     }

//     private void handleProductManagement(HttpServletRequest request, HttpServletResponse response, ProductDAO productDAO) throws ServletException, IOException {
//         String type = request.getParameter("type");
//         switch (type) {
//             case "add":
//                 addProduct(request, response, productDAO);
//                 break;
//             case "update":
//                 updateProduct(request, response, productDAO);
//                 break;
//             default:
//                 response.sendRedirect("manage?type=view&error=invalid");
//                 break;
//         }
//     }

//     private void addProduct(HttpServletRequest request, HttpServletResponse response, ProductDAO productDAO) throws ServletException, IOException {
//         try {
//             String productName = request.getParameter("name");
//             String productPrice = request.getParameter("price");
//             Part filePart = request.getPart("img");
//             String uploadPath = getServletContext().getRealPath("") + "img/product";
//             File uploadDir = new File(uploadPath);
//             if (!uploadDir.exists()) {
//                 uploadDir.mkdir();
//             }

//             String fileName = getFileName(filePart);
//             String filePath = uploadPath + File.separator + fileName;
//             filePart.write(filePath);
//             String category = request.getParameter("category");
//             String description = request.getParameter("description");

//             List<Product> existingProducts = productDAO.getAllProduct();
//             boolean productExists = existingProducts.stream()
//                     .anyMatch(p -> p.getProductName().equalsIgnoreCase(productName));

//             if (!productExists) {
//                 productDAO.AddNew(new Product(productName, Double.parseDouble(productPrice), "./img/product/" + fileName, category, description, "Hide"));
//                 response.sendRedirect("manage?type=view");
//             } else {
//                 request.setAttribute("alertMess", "Product already exists");
//                 List<Product> listDefault = productDAO.getAllProduct();
//                 request.setAttribute("list", listDefault);
//                 request.getRequestDispatcher("/Admin_ProductManagement.jsp").forward(request, response);
//             }
//         } catch (NumberFormatException | SQLException e) {
//             LOGGER.log(Level.SEVERE, "Error adding product", e);
//             response.sendRedirect("manage?type=view&error=add");
//         }
//     }

//     private void updateProduct(HttpServletRequest request, HttpServletResponse response, ProductDAO productDAO) throws ServletException, IOException {
//         try {
//             String id = request.getParameter("id");
//             String productName = request.getParameter("name");
//             String productPrice = request.getParameter("price");
//             Part filePart = request.getPart("img");
//             String uploadPath = getServletContext().getRealPath("") + "img/product";
//             File uploadDir = new File(uploadPath);
//             if (!uploadDir.exists()) {
//                 uploadDir.mkdir();
//             }

//             String fileName = getFileName(filePart);
//             String filePath = uploadPath + File.separator + fileName;
//             filePart.write(filePath);
//             String category = request.getParameter("category");
//             String description = request.getParameter("description");

//             productDAO.updateProduct(new Product(Integer.parseInt(id), productName, Double.parseDouble(productPrice), "./img/product/" + fileName, category, description, productDAO.getProductById(Integer.parseInt(id)).getProductStatus()));
//             response.sendRedirect("manage?type=view");
//         } catch (NumberFormatException | SQLException e) {
//             LOGGER.log(Level.SEVERE, "Error updating product", e);
//             response.sendRedirect("manage?type=view&error=update");
//         }
//     }

//     private String getFileName(Part part) {
//         String contentDisposition = part.getHeader("content-disposition");
//         String[] tokens = contentDisposition.split(";");
//         for (String token : tokens) {
//             if (token.trim().startsWith("filename")) {
//                 return token.substring(token.indexOf('=') + 1).trim().replace("\"", "");
//             }
//         }
//         return null;
//     }

//     private String formatCurrency(float amount) {
//         NumberFormat currencyFormatter = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
//         return currencyFormatter.format(amount);
//     }

//     private boolean sendEmail(String to, String subject, String body) {
//         final String from = "fstore1703@gmail.com";
//         final String password = "nlsdqrjpgtagttqi";
//         Properties props = new Properties();
//         props.put("mail.smtp.host", "smtp.gmail.com");
//         props.put("mail.smtp.port", "587");
//         props.put("mail.smtp.auth", "true");
//         props.put("mail.smtp.starttls.enable", "true");

//         Authenticator auth = new Authenticator() {
//             @Override
//             protected PasswordAuthentication getPasswordAuthentication() {
//                 return new PasswordAuthentication(from, password);
//             }
//         };

//         Session session = Session.getInstance(props, auth);
//         MimeMessage msg = new MimeMessage(session);

//         try {
//             msg.addHeader("Content-type", "text/HTML; charset=UTF-8");
//             msg.setFrom(from);
//             msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to, false));
//             msg.setSubject(subject, "UTF-8");
//             msg.setContent(body, "text/HTML; charset=UTF-8");
//             Transport.send(msg);
//             return true;
//         } catch (Exception e) {
//             LOGGER.log(Level.SEVERE, "Error sending email", e);
//             return false;
//         }
//     }

//     @Override
//     public String getServletInfo() {
//         return "Product Management Controller";
//     }
// }
