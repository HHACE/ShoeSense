<%-- 
    Document   : Cart
    Created on : Jun 19, 2024, 8:34:29 PM
    Author     : ADMIN
--%>

<%@page import="com.oracle.wls.shaded.org.apache.bcel.generic.AALOAD"%>
<%@page import="DAOs.ProductVariantDAO"%>
<%@page import="Modals.ProductVariant"%>
<%@page import="DAOs.AccountDAO"%>
<%@page import="java.util.List"%>
<%@page import="DAOs.ProductDAO"%>
<%@page import="Modals.Cart"%>
<%@page import="Modals.Product"%>
<%@page import="Modals.Account"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
        <style>
            body{
               background: url("<%= request.getContextPath() %>/img/nen.jpg");
                background-position: center;
                background-size: cover;
            } 
            
            #linkfooter{
                text-decoration: none;
                color: white;
            }

            .card-text > li{
                padding-top: 5px;
            }

            #payment > li{
                list-style-type: none;
            }

            #logoimg{
                border-radius: 10px;
            }
            .category a{
                text-decoration: none;
                color: black;
                font-size: large;
                font-weight: bold;
            }

            body{
                background-color: rgb(191, 191, 191);
            }


            #linkfooter{
                text-decoration: none;
                color: white;
            }

            #minus{
                border-radius: 5px 0 0 5px;
            }

            #plus{
                border-radius: 0 5px 5px 0;
            }
            .img-small {
                max-width: 200px;
                max-height: 200px;
            }

            .small-font {
                font-size: 0.8em;
            }
            .small-title {
                font-size: 1.2em;
            }

        </style>
    </head><!-- comment -->


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
            <!--Body home page-->
            <div class="bg-body-secondary">
                <div id="carouselExampleDark" class="carousel carousel-dark slide">
                    <div class="container pt-5">

                        <h1>Your Cart</h1>
                        <div class="row">
                            <!-- Cart items go here -->
                        <%                            Account u = (Account) session.getAttribute("userIn4");

                            ProductDAO pdao = new ProductDAO();
                            ProductVariantDAO vardao = new ProductVariantDAO();

                            List<Cart> cart = (List<Cart>) request.getAttribute("mycartlist");
                            if (cart.size() > 0) {
                                for (Cart i : cart) {
                                    Product pro = pdao.getProductById(i.getProductID());
                                    ProductVariant var = vardao.getProductVariantById(i.getVariantID());

                        %>
                        <div class="col-12">
                            <div class="card mb-3">
                                <form action="" method="post" class="update-form">
                                    <div class="row g-0">
                                        <div class="col-md-2">
                                            <img src="/ShoeSense/<%= pro.getProductImg()%>" alt="product" class="m-3 rounded-3" style="max-width: 160px; max-height: 160px;">
                                        </div>
                                        <div class="col-md-8">
                                            <div class="card-body row" style="font-size: 0.8em;"> <!-- Giảm kích thước font xuống 80% -->
                                                <div class="col-lg-2 fs-5">
                                                    <label>ProductDetail</label> 
                                                    <h5 class="card-title" style="font-size: 1em; margin-top: 3px"> <%= pro.getProductName()%> </h5> <!-- Giữ kích thước tiêu đề tương đối lớn hơn một chút -->
                                                    <p class="card-text  fs-6 mt-3"><fmt:formatNumber pattern="###,###" value="<%= pro.getProductPrice()%>"/> VNÐ</p>
                                                </div>

                                                <div class="col-lg-2 fs-5">
                                                    <label for="Size">Size</label>                 
                                                    <p value="<%=var.getVariantID()%>">  <%= var.getVariantSize()%></p>
                                                    </select></div>
                                                <div class="col-lg-3 fs-5">
                                                    <label for="variant">Color</label>
                                                    <p value="<%=var.getVariantID()%>">  <%= var.getVariantColor()%></p>
                                                    </select></div>
                                                <div class="col-lg-2 fs-5"><label for="quantity">Quantity</label>
                                                    <div class="input-group" style="width: 70px ">
                                                        <input type="number" class="form-control text-center rounded-3" id="quantity" min="1" name="quantity" value="<%= i.getQuantity()%>">
                                                    </div></div>
                                                <div class="col-lg-2 fs-5">
                                                    <%
                                                        double price = i.getQuantity() * pro.getProductPrice();
                                                    %>
                                                    <label>Total</label>
                                                    <br/>
                                                    <td class="align-middle"><fmt:formatNumber pattern="###,###" value="<%= price%>"/> VNÐ</td>
                                                    <input type="hidden" name="productID" value="<%= i.getProductID()%>">
                                                    <input type="hidden" name="variantID" value="<%= i.getVariantID()%>">
                                                    <input type="hidden" name="cartID" value="<%= i.getCartID()%>">
                                                    <input type="hidden" name="userID" value="<%= i.getUserID()%>">
                                                </div>
                                                <!-- Size selection -->
                                                <!-- Quantity selection -->
                                            </div>
                                        </div>
                                        <div class="col-md-1">

                                            <button class="btn btn-secondary ms-3 mt-5 mb-2" name="deletebtn" value="delete" onclick="return confirm('Do you want to delete it?')">
                                                <i class="fas fa-trash-alt"></i>
                                            </button>
                                            <button class="btn btn-secondary ms-3 mb-5 mt-2" name="editCartbtn" value="edit">  <i class="fas fa-edit"></i></button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <%
                            }
                        } else {
                        %>
                        <div class="container" align="center">
                            <h2>Cart is empty</h2>
                            <p class="fs-4">Go to <a href="/ShoeSense">Home page</a> to look for product.</p>
                        </div>
                        <%                            }
                        %>

                    </div>
                    <div class="row">
                        <!-- Cart items go here -->
                        <div class="col-12">
                            <div class="card mb-3">
                                <div class="row g-0">


                                </div>
                            </div>
                        </div>
                    </div>
                    <%
                        int totalall = 0;
                        for (Cart j : cart) {
                            Product pro = pdao.getProductById(j.getProductID());
                            totalall += j.getQuantity() * pro.getProductPrice();
                        }
                        if (cart.size() > 0) {
                    %>
                    <div class="row">
                        <div class="col-12 text-end">
                            <h4>Total: <fmt:formatNumber pattern="###,###" value="<%= totalall%>"/> vnđ </h4>
                        </div>
                    </div>
                    <div class="row">
                        <form action="/ShoeSense/checkout" method="get">
                            <!-- Các trường và nút "Checkout" nằm trong form này -->
                            <!-- ... (mã HTML của trang cart.jsp) ... -->

                            <div class="row">

                                <div class="col-12 text-end mb-5">
                                    <button class="btn btn-primary" >Checkout</button>
                                </div>
                            </div>

                            <!-- ... (mã HTML của trang cart.jsp) ... -->
                        </form>
                    </div>
                    <%
                        }
                    %>
                </div>
            </div>
            <!--<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>-->      
        </div>




        <jsp:include page="Footer.jsp"></jsp:include>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
                    integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
            crossorigin="anonymous"></script>
            <script src="validate.js"></script>
        <%
            String alertMess = (String) request.getAttribute("notificationMessage");
            if (alertMess != null && !alertMess.isEmpty()) {
        %>
        <script>
                                                alert("<%= alertMess%>");
        </script>
        <%

            }
        %>
        <script>
            function tang() {

                let quantityInput = document.querySelector("#quantity")
                let quantity = Number.parseInt(quantityInput.value);
                quantityInput.value = quantity + 1;
            }
            function giam() {
                while (quantityInput.value > 0) {
                    let quantityInput = document.querySelector("#quantity")
                    let quantity = Number.parseInt(quantityInput.value);
                    quantityInput.value = quantity - 1;

                }
            }
            for (let i = 0; i < quantities.length; i++) {
                const minusButton = quantities[i].previousElementSibling;
                const plusButton = quantities[i].nextElementSibling;

                minusButton.onclick = function () {
                    giam(this);
                };

                plusButton.onclick = function () {
                    tang(this);
                };
            }
        </script>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const updateForms = document.querySelectorAll(".update-form");

                updateForms.forEach(form => {
                    const quantityInput = form.querySelector('input[name="quantity"]');

                    quantityInput.addEventListener("input", function () {
                        // Gửi yêu cầu cập nhật khi số lượng thay đổi
                        updateCartInfo(form);
                    });
                });
            });

            function updateCartInfo(form) {
                // Sử dụng Fetch API hoặc AJAX để gửi yêu cầu cập nhật lên máy chủ
                fetch('Cart', {
                    method: 'POST',
                    body: new FormData(form),
                })
                        .then(response => response.json())
                        .then(data => {
                            // Xử lý phản hồi từ máy chủ nếu cần
                            console.log(data);
                        })
                        .catch(error => console.error('Error:', error));
            }
        </script>



    </body>
</html>
