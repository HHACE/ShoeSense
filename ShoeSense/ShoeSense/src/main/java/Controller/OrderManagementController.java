/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAOs.AccountDAO;
import DAOs.OrderDAO;
import DAOs.OrderDetailDAO;
import DAOs.OrderStatusLogDAO;
import DAOs.ProductDAO;
import DAOs.ProductVariantDAO;
import Modals.Account;
import Modals.Order;
import Modals.OrderDetail;
import Modals.OrderStatusLog;
import Modals.ProductVariant;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.sql.SQLException;
import java.text.NumberFormat;
import java.time.LocalDateTime;
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
public class OrderManagementController extends HttpServlet {

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
            out.println("<title>Servlet OrderManagementController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet OrderManagementController at " + request.getContextPath() + "</h1>");
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

        if (path.contains("processing")) {
            OrderDAO order1 = new OrderDAO();
            List<Order> orderList2 = order1.getAllOrderByStatus("Processing");
            request.setAttribute("listOr", orderList2);
            request.getRequestDispatcher("/Admin_OrderManagement.jsp").forward(request, response);
        } else if (path.contains("shipping")) {
            OrderDAO order1 = new OrderDAO();
            List<Order> orderList2 = order1.getAllOrderByStatus("Shipping");
            request.setAttribute("listOr", orderList2);
            request.getRequestDispatcher("/Admin_OrderManagement.jsp").forward(request, response);
        } else if (path.contains("cancel")) {
            OrderDAO order1 = new OrderDAO();
            List<Order> orderList2 = order1.getAllOrderByStatus("Cancel");
            request.setAttribute("listOr", orderList2);
            request.getRequestDispatcher("/Admin_OrderManagement.jsp").forward(request, response);
        } else if (path.contains("delivered")) {
            OrderDAO order1 = new OrderDAO();
            List<Order> orderList2 = order1.getAllOrderByStatus("Delivered");
            request.setAttribute("listOr", orderList2);
            request.getRequestDispatcher("/Admin_OrderManagement.jsp").forward(request, response);
        } else {
            OrderDAO order1 = new OrderDAO();
            List<Order> orderList2 = order1.getAllOrder();
            request.setAttribute("listOr", orderList2);
            request.getRequestDispatcher("/Admin_OrderManagement.jsp").forward(request, response);
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

        if (request.getParameter("Confirm") != null && request.getParameter("Confirm").equals("confirm")) {
            int orderID = Integer.parseInt(request.getParameter("orderID"));
            int userID = Integer.parseInt(request.getParameter("userID"));
            int staffID = Integer.parseInt(request.getParameter("staffID"));
//            String orderStatus = "Processing";
            OrderDAO odao = new OrderDAO();
            OrderDetailDAO oddao = new OrderDetailDAO();
//            ProductDAO pdao = new ProductDAO();
            ProductVariantDAO vardao = new ProductVariantDAO();
            Order ord = odao.getOrderById(orderID);

            List<OrderDetail> lod = oddao.getAllOrderDetailByOrderId(orderID);
//            int newQuantity = 0;

            ord.setOrderStatus("Shipping");

            odao.updateOrderStatus(ord);

            OrderStatusLogDAO osldao = new OrderStatusLogDAO();
            LocalDateTime currentTime = LocalDateTime.now();
            OrderStatusLog osl = new OrderStatusLog(orderID, staffID, currentTime, "Shipping");
            try {
                osldao.AddNewOrderStatusLog(osl);
            } catch (SQLException ex) {
                Logger.getLogger(OrderManagementController.class.getName()).log(Level.SEVERE, null, ex);
            }

//            for (OrderDetail j : lod) {
//
//                    ProductVariant var = vardao.getProductVariantById(j.getVariantID());
//                    var.setVariantQuantity(var.getVariantQuantity() - j.getQuantity());
//                    vardao.updateProductVariant(var);
//
//                
//            }
            String uEmail = "";
            Order orderById = odao.getOrderById(orderID);
            AccountDAO udao = new AccountDAO();
            Account u = udao.GetAccountById(String.valueOf(userID));
            uEmail = u.getAccountEmail();
            String to = uEmail;
//            String subject = "❤️ Đơn hàng của bạn đã được chúng tôi xác nhận. ❤️";
////            String body = "<html><body>"
////                    + "<p>Chào bạn,<b>" + u.getUserName() +"</b>,</p>"
////                    + "<p>❤️ Chúng tôi xin gửi lời cảm ơn chân thành đến bạn vì đã đặt hàng tại cửa hàng của chúng tôi.❤️</p>"
////                    + "<p>Mã đơn hàng của bạn là:<b> " + odao.getNewestOrder().getOrderID() + "</b></p>"
////                    + "<p>Tổng giá trị đơn hàng:<b> " + odao.getNewestOrder().getTotalPrice() + "</b>$</p>"
////                    + "<p>Đia chỉ giao hàng:<b> " + u.getUserAddress() + "</b></p>"
////                    + "<p>Nếu bạn có bất kỳ câu hỏi hoặc yêu cầu đặc biệt nào, vui lòng liên hệ với chúng tôi. "
////                    + "Chúng tôi luôn sẵn lòng hỗ trợ bạn.</p>"
////                    + "<p>Xin một lần nữa cảm ơn bạn đã tin tưởng và ủng hộ cửa hàng của chúng tôi.</p>"
////                    + "<p>Trân trọng,<br>"
////                    + "❤️ Đội ngũ cửa hàng ❤️</p>"
////                    + "</body></html>";
//            String body = "<html>\n"
//                    + "  <head>\n"
//                    + "    <style>\n"
//                    + "      body {\n"
//                    + "        font-family: Arial, sans-serif;\n"
//                    + "        margin: 20px;\n"
//                    + "        padding: 20px;\n"
//                    + "        background-color: #f7f7f7;\n"
//                    + "      }\n"
//                    + "\n"
//                    + "      p {\n"
//                    + "        font-size: 16px;\n"
//                    + "        line-height: 1.6;\n"
//                    + "        color: #333;\n"
//                    + "      }\n"
//                    + "\n"
//                    + "      b {\n"
//                    + "        color: #e44d26;\n"
//                    + "      }\n"
//                    + "\n"
//                    + "      .user-name {\n"
//                    + "        color: #FFFFFF;\n"
//                    + "      }\n"
//                    + "\n"
//                    + "      .thank-you {\n"
//                    + "        background-color: #e44d26;\n"
//                    + "        color: #fff;\n"
//                    + "        padding: 10px;\n"
//                    + "        border-radius: 5px;\n"
//                    + "        text-align: center;\n"
//                    + "        font-size: 18px;\n"
//                    + "        margin-bottom: 20px;\n"
//                    + "      }\n"
//                    + "\n"
//                    + "      .order-details {\n"
//                    + "        background-color: #fff;\n"
//                    + "        padding: 15px;\n"
//                    + "        border-radius: 5px;\n"
//                    + "        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);\n"
//                    + "      }\n"
//                    + "\n"
//                    + "      .footer {\n"
//                    + "        margin-top: 20px;\n"
//                    + "        font-size: 14px;\n"
//                    + "        color: #666;\n"
//                    + "      }\n"
//                    + "    </style>\n"
//                    + "  </head>\n"
//                    + "  <body>\n"
//                    + "    <div class=\"thank-you\">\n"
//                    + "      <p>Chào bạn, <b class=\"user-name\">" + u.getUserName() + "</b>,</p>\n"
//                    + "      <p>❤️ Chúng tôi xin gửi lời cảm ơn chân thành đến bạn vì đã đặt hàng tại cửa hàng của chúng tôi. "
//                    + "         Đơn hàng của bạn đã được xác nhận và đang được chuẩn bị đóng gói để giao hàng. ❤️</p>\n"
//                    + "    </div>\n"
//                    + "\n"
//                    + "    <div class=\"order-details\">\n"
//                    + "      <p>Mã đơn hàng của bạn là: <b>" + orderById.getOrderID() + "</b></p>\n"
//                    + "      <p>Sản phẩm: <b>" + odao.getOrderByID(orderID).getProductSizeAndName() + "</b></p>\n"
//                    //                    + "      <p> <img src='" + odao.getNewestOrder().getProductIMG() + "' alt=Product Image'></p>\n"
//                    + "      <p>Tổng giá trị đơn hàng: <b>" + formatCurrency(odao.getOrderByID(orderID).getTotalPrice()) + "</b></p>\n"
//                    + "      <p>Địa chỉ giao hàng: <b>" + u.getUserAddress() + "</b></p>\n"
//                    + "      <p>\n"
//                    + "        Nếu bạn có bất kỳ câu hỏi hoặc yêu cầu đặc biệt nào, vui lòng liên hệ với chúng tôi qua email fstore1703@gmail.com.\n"
//                    + "        Chúng tôi luôn sẵn lòng hỗ trợ bạn.\n"
//                    + "      </p>\n"
//                    + "    </div>\n"
//                    + "\n"
//                    + "    <p class=\"footer\">\n"
//                    + "      Xin một lần nữa cảm ơn bạn đã tin tưởng và ủng hộ cửa hàng của chúng tôi.\n"
//                    + "      <br />\n"
//                    + "      Trân trọng,\n"
//                    + "      <br />\n"
//                    + "      ❤️ Đội ngũ cửa hàng ❤️\n"
//                    + "    </p>\n"
//                    + "  </body>\n"
//                    + "</html>";
//            sendEmail(to, subject, body);
//            response.sendRedirect("/ShoeSense/order/manage");
            doGet(request, response);
        }

        if (request.getParameter("Deliver") != null && request.getParameter("Deliver").equals("deliver")) {
            int orderID = Integer.parseInt(request.getParameter("orderID"));
            int staffID = Integer.parseInt(request.getParameter("staffID"));
            OrderDAO odao = new OrderDAO();
//            OrderDetailDAO oddao = new OrderDetailDAO();

            Order ord = odao.getOrderById(orderID);
//            List<OrderDetail> lod = oddao.getAllOrderDetailByOrderId(orderID);

            ord.setOrderStatus("Delivered");

            odao.updateOrderStatus(ord);

            OrderStatusLogDAO osldao = new OrderStatusLogDAO();
            LocalDateTime currentTime = LocalDateTime.now();
            OrderStatusLog osl = new OrderStatusLog(orderID, staffID, currentTime, "Delivered");
            try {
                osldao.AddNewOrderStatusLog(osl);
            } catch (SQLException ex) {
                Logger.getLogger(OrderManagementController.class.getName()).log(Level.SEVERE, null, ex);
            }

//            response.sendRedirect("/ShoeSense/order/manage");
            doGet(request, response);
        }

        if (request.getParameter("Cancel") != null && request.getParameter("Cancel").equals("cancel")) {
            int orderID = Integer.parseInt(request.getParameter("orderID"));
            int staffID = Integer.parseInt(request.getParameter("staffID"));
            OrderDAO odao = new OrderDAO();
//            OrderDetailDAO oddao = new OrderDetailDAO();

            Order ord = odao.getOrderById(orderID);
//            List<OrderDetail> lod = oddao.getAllOrderDetailByOrderId(orderID);

            ord.setOrderStatus("Cancel");

            odao.updateOrderStatus(ord);

            OrderStatusLogDAO osldao = new OrderStatusLogDAO();
            LocalDateTime currentTime = LocalDateTime.now();
            OrderStatusLog osl = new OrderStatusLog(orderID, staffID, currentTime, "Cancel");
            try {
                osldao.AddNewOrderStatusLog(osl);
            } catch (SQLException ex) {
                Logger.getLogger(OrderManagementController.class.getName()).log(Level.SEVERE, null, ex);
            }

//            response.sendRedirect("/ShoeSense/order/manage/cancel");
            doGet(request, response);
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
