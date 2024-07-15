<%-- 
    Document   : OrderHistory
    Created on : Jul 1, 2024, 7:11:08 PM
    Author     : ADMIN
--%>
<%@page import="Modals.OrderStatusLog"%>
<%@page import="DAOs.OrderStatusLogDAO"%>
<%@page import="Modals.ProductVariant"%>
<%@page import="Modals.Product"%>
<%@page import="DAOs.ProductVariantDAO"%>
<%@page import="DAOs.ProductDAO"%>
<%@page import="DAOs.OrderDetailDAO"%>
<%@page import="Modals.OrderDetail"%>
<%@page import="java.util.List"%>
<%@page import="Modals.Order"%>
<%@page import="Modals.Order"%>
<%@page import="DAOs.OrderDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DAOs.AccountDAO"%>
<%@page import="Modals.Account"%>
<%@page import="Modals.Account"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
     <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
        <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
        <script>
            $(document).ready(function () {
                $('#example').DataTable();
            });
        </script>
        <link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.min.css">
        <style>
            body {
                background-color: #f8f9fa;
            }

            .navbar-brand {
                font-size: 1.5rem;
                font-weight: bold;
            }

            .navbar-toggler-icon {
                background-color: white;
            }

            .navbar-nav .nav-link {
                color: white;
            }

            .order-card {
                border: 1px solid #dfe1e5;
                border-radius: 10px;
                margin-bottom: 20px;
                padding: 20px;
                background-color: white;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            .order-info p {
                margin: 5px 0;
            }

            .order-status {
                font-weight: bold;
            }

            .order-details {
                padding-top: 20px;
            }
            

            .order-details h4 {
                margin-top: 10px;
            }

            .order-details p {
                margin: 5px 0;
            }

            .order-details hr {
                margin: 10px 0;
                border-top: 1px solid #dfe1e5;
            }

            .order-details .product-info {
                margin-top: 20px;
            }

            .order-details .product-info img {
                max-width: 100%;
                height: auto;
            }

            .order-details .product-info h4 {
                margin-bottom: 10px;
            }

            .order-details .row {
                align-items: center;
                
            }

            .order-details .col-md-3, .order-details .col-md-2 {
                margin-bottom: 10px;
            }

            .order-details .text-success, .order-details .text-warning, .order-details .text-primary {
                font-weight: bold;
            }
            .order-details .product-info img {
                max-width: 50%;
                height: auto;
                border-radius: 5px; /* Add border-radius for rounded corners */
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* Add box-shadow for a subtle effect */
            }

            .order-details .product-info h4 {
                margin-bottom: 10px;
                color: #333; /* Adjust the color of the product name */
            }

            .order-details .product-info h4 {
                margin-bottom: 10px;
                color: #333; /* Adjust the color of the product name */
                font-size: 1.2rem; /* Increase font size */
                font-weight: bold; /* Set font weight to bold */
            }

            .order-details .product-info p {
                margin: 5px 0;
                font-size: 1rem; /* Adjust font size */
                color: #555; /* Adjust the color of other text */
            }
            .order-details .row.justify-content-end {
                margin-top: 10px; /* Thêm margin để tạo khoảng cách với các sản phẩm */
            }

            .order-details .col-md-2 p.card-text {
                font-size: 1.2rem; /* Đặt kích thước font lớn hơn */
                font-weight: bold; /* Chữ in đậm */
                color: #333; /* Màu chữ đậm hơn */
                margin-bottom: 0; /* Loại bỏ khoảng cách dưới của đoạn chữ */
                margin-right: 20px;
            }
            .order-details .row.justify-content-end {
                margin-top: 10px; /* Thêm margin để tạo khoảng cách với các sản phẩm */
            }

            .order-details .col-md-2 {
                text-align: right; /* Đặt text-align là right để phần Total nằm ở bên phải */
            }
            .order {
                border: 2px solid #dfe1e5; /* Thêm khung viền cho mỗi order */
                border-radius: 10px; /* Bo tròn góc của khung viền */
                padding: 20px; /* Thêm padding cho nội dung bên trong khung viền */
                background-color: #fafafa;
            }

            .cancel-order-btn {
                background-color: #dc3545; /* Màu nền của nút Hủy đơn */
                color: #fff; /* Màu chữ trắng */
                border: none; /* Loại bỏ đường viền */
                padding: 8px 16px; /* Tăng độ lớn của nút */
                border-radius: 5px; /* Bo tròn góc của nút */
                cursor: pointer;
                transition: background-color 0.3s; /* Hiệu ứng màu nền thay đổi */
            }

            .cancel-order-btn:hover {
                background-color: #bd2130; /* Màu nền khi di chuột qua nút */
            }

            .order-details .text-success {
                font-weight: bold;
                color: green; /* Change to the desired green color */
            }

            .order-details .text-warning {
                font-weight: bold;
                color: orange; /* Change to the desired orange color */
            }

            .order-details .text-primary {
                font-weight: bold;
                color: blue; /* Change to the desired blue color */
            }
            .order-details .text-success {
                font-weight: bold;
                color: green; /* Change to the desired green color */
            }

            .order-details .text-success {
                font-weight: bold;
                color: yellow; /* Change to the desired yellow color */
            }

            #linkfooter{
                text-decoration: none;
                color: white;
            }
            
            .detailsproduct{
                border: 2px solid #dfe1e5;
                background-color: #e0e0e0;
                padding-top: 10px;
                border-radius: 10px;
            }
        </style>
    </head>

    <body>
    <%

            Cookie[] cookies = request.getCookies();
            
            Account temp = null;
            

            
            if (session.getAttribute("acc") != null) {
             temp = (Account) session.getAttribute("acc");
                boolean flag = false;
                if (cookies != null) {
                    for (Cookie cookie : cookies) {
                        if (cookie.getName().equals("account") && !cookie.getValue().equals("")) {
                            session.setAttribute("id", cookie.getValue());
                            flag = true;
                            break;
                        }
                    }
                }
                
                            if (temp != null && !temp.getAccountRole().equals("User")) {
                 response.sendRedirect("/ShoeSense/admin/finance");
            }
                
                if (!flag) {
                    response.sendRedirect("/ShoeSense/login");
                }
            } else {
            
                boolean flag = false;
                if (cookies != null) {
                    for (Cookie cookie : cookies) {
                        if (cookie.getName().equals("account") && !cookie.getValue().equals("")) {
                            session.setAttribute("id", cookie.getValue());
                            AccountDAO adao = new AccountDAO();
                            temp = (Account) adao.GetAccountById(cookie.getValue());
                            
                            flag = true;
                            break;
                        }
                    }
                }
                
                            if (temp != null && !temp.getAccountRole().equals("User")) {
                 response.sendRedirect("/ShoeSense/admin/finance");
            }
                
                if (!flag) {
                    response.sendRedirect("/ShoeSense/login");
                }
            }

   

        %>
        
 <jsp:include page="Header_User.jsp"></jsp:include>

<div class="container mt-5">
    <div class="bg-white p-5 rounded-3">
        <h1 class="text-center mb-4">Order History</h1>
        
        <div>
            <p>Status:
                <a href="/ShoeSense/order/history/<%=temp.getAccountID()%>/processing" class="btn btn-secondary">Processing</a>
                <a href="/ShoeSense/order/history/<%=temp.getAccountID()%>/shipping" class="btn btn-secondary">Shipping</a>
                <a href="/ShoeSense/order/history/<%=temp.getAccountID()%>/cancel" class="btn btn-secondary">Cancel</a>
                <a href="/ShoeSense/order/history/<%=temp.getAccountID()%>/delivered" class="btn btn-secondary">Delivered</a>
            </p>
        </div>
        
        <%
            ArrayList<Order> lo = (ArrayList<Order>) request.getAttribute("orderHistory");
            OrderDAO odao = new OrderDAO();
            OrderDetailDAO oddao = new OrderDetailDAO();
            OrderStatusLogDAO osldao = new OrderStatusLogDAO();
            if (lo.size() > 0) {
                for (Order i : lo) {
                    List<OrderStatusLog> osll = osldao.getAllOrderStatusLogByOrderId(i.getOrderID());
        %>
        <div class="order mb-4 fs-5">
            <div class="order-body">
                <h5 class="card-body">ID: <%= i.getOrderID()%></h5>
                <a class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#StatusLog<%= i.getOrderID()%>">Product Details</a>
                <%
                    for (OrderStatusLog osl : osll) {
                        if (osl.getOrderStatus().equals("Processing")) {
                %>
                <p class="card-text">Order Date: <%= osl.getStatusDate()%></p>
                <%
                        }
                    }
                %>
                <p>Order Status: <span class="text-success fw-bold"><%= i.getOrderStatus()%></span></p>
                <p>Payment Method: <span class="text-success fw-bold"><%= i.getPaymentMethod()%></span></p>
                <%
                    if ("Processing".equalsIgnoreCase(i.getOrderStatus())) {
                %>
                <form action="" method="post">
                    <input type="hidden" name="orderID" value="<%= i.getOrderID()%>">
                    <input type="hidden" name="userID" value="<%=session.getAttribute("id")%>">
                    <button type="submit" name="CancelOrder" class="btn btn-danger">Cancel Order</button>
                </form>
                <%
                    }
%>

            </div>
            <div class="order-details fw-bold">
                <%
                    List<OrderDetail> lod = oddao.getAllOrderDetailByOrderId(i.getOrderID());
                    ProductDAO prodao = new ProductDAO();
                    ProductVariantDAO vardao = new ProductVariantDAO();
                    for (OrderDetail j : lod) {
                        Product pro = prodao.getProductById(j.getProductID());
                        ProductVariant var = vardao.getProductVariantById(j.getVariantID());
                %>
                <div class="product-info">
                    <div class="row detailsproduct">
                        <div class="col-md-2">
                            <img src="/ShoeSense/<%= pro.getProductImg()%>" alt="<%= pro.getProductName()%> Image">
                        </div>
                        <div class="col-md-2">
                            <p>Product: <%= pro.getProductName()%></p>
                        </div>
                        <div class="col-md-2">
                            <p>Size: <%= var.getVariantSize()%></p>
                        </div>
                        <div class="col-md-2">
                            <p>Color: <%= var.getVariantColor()%></p>
                        </div>
                        <div class="col-md-2">
                            <p>Quantity: <%= j.getQuantity()%></p>
                        </div>
                        <div class="col-md-2">
                            <p>Price of products: <%= j.getTotal()%></p>
                        </div>
                   <%     
                                        if("Delivered".equalsIgnoreCase(i.getOrderStatus())) {


                %>
                <div class="row col-lg-9 "></div>
                                        <div class="row col-lg-3 ">
                                <a  href="/ShoeSense/product/detail/<%= j.getProductID() %>" class="btn btn-primary">Comment</a>
                        </div>
            
              <%  
}
                %>
                        
                    </div>
                </div>
                <%
                    }
                %>
                <div class="row justify-content-end">
                    <div class="col-md-2">
                        <p class="card-text">Total: <fmt:formatNumber value="<%= i.getTotalPrice()%>" type="number" pattern="###,### vnđ" /></p>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Status Log Modal -->
        <div class="modal fade" id="StatusLog<%= i.getOrderID()%>" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-scrollable modal-xl">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="staticBackdropLabel">Status Log</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="container-fluid">
                            <table style="width: 100%; text-align: center;">
                                <tr>
                                    <th>Status</th>
                                    <th>Date</th>
                                    <th>Staff ID</th>
                                    <th>Staff Name</th>
                                </tr>
                                <%
                                    List<OrderStatusLog> osll2 = osldao.getAllOrderStatusLogByOrderId(i.getOrderID());
                                    for (OrderStatusLog osl : osll2) {
                                %>
                                <tr>
                                    <td><%= osl.getOrderStatus()%></td>
                                    <td><%= osl.getStatusDate()%></td>
                                    <%
                                        AccountDAO adao2 = new AccountDAO();
                                        if (osl.getAcccountID() != 0) {
                                            Account staff = adao2.GetAccountById(Integer.toString(osl.getAcccountID()));
                                    %>
                                    <td><%= osl.getAcccountID()%></td>
                                    <td><%= staff.getAccountName()%></td>
                                    <%
                                        } else {
                                    %>
                                    <td>-</td>
                                    <td>-</td>
                                    <%
                                        }
                                    %>
                                </tr>
                                <%
                                    }
                                %>
                            </table>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
        
        <%
                }
            } else {
        %>
        <p class="text-center fs-4" style="color: Green;">No order has been made. Return <a href="/ShoeSense">Home</a></p>
        <%
            }
        %>
    </div>
</div>

<jsp:include page="Footer.jsp"></jsp:include>

<script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>

</body>
</html>

