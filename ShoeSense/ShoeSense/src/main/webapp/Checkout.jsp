<%-- 
    Document   : CheckOut
    Created on : Jul 5, 2024, 12:33:31 PM
    Author     : ADMIN
--%>

<%@page import="Modals.Product"%>
<%@page import="Modals.ProductVariant"%>
<%@page import="DAOs.ProductVariantDAO"%>
<%@page import="DAOs.ProductDAO"%>
<%@page import="java.util.List"%>
<%@page import="Modals.Cart"%>
<%@page import="DAOs.CartDAO"%>
<%@page import="DAOs.AccountDAO"%>
<%@page import="Modals.Account"%>
<%@page import="Modals.Account"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Checkout Form</title>
        
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">

        <style>

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

            
    table {
        border-collapse: collapse; /* Ensure borders collapse into a single border */
        width: 100%; /* Set table width to 100% */
    }

    /* Style for table header cells */
    th {
        border: 2px solid black; /* Border for header cells */
        padding: 10px; /* Padding inside header cells */
        text-align: center; /* Center-align text in header cells */
        background-color: lightgray; /* Background color for header cells */
    }

    /* Style for table data cells */
    td {
        border: 1px solid black; /* Border for data cells */
        padding: 8px; /* Padding inside data cells */
        text-align: center; /* Center-align text in data cells */
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

      //                            if (!temp.getAccountRole().equals("User")) {
      //                 flag = false;
      //            }
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

      //                                           if (!temp.getAccountRole().equals("User")) {
      //                 flag = false;
      //            }
                if (!flag) {
                    response.sendRedirect("/ShoeSense/login");
                }
            }


        %>
<jsp:include page="Header_User.jsp"></jsp:include>

<main class="mt-5 pt-4" style="padding-bottom: 100px">
    <div class="container">
        <!-- Heading -->
        <h2 class="my-5 text-center">Checkout form</h2>
        <!-- Grid row -->
        <div class="row">
            <!-- Cart Grid column -->
            <div class="col-md-6 col-lg-6">
                <h4 class="d-flex justify-content-between align-items-center mb-3">
                    <span class="text-primary">Your cart</span>
                </h4>
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th class="align-middle">Image</th>
                            <th class="align-middle">Product Name</th>
                            <th class="align-middle">Size</th>
                            <th class="align-middle">Color</th>
                            <th class="align-middle">Quantity</th>
                            <th class="align-middle">Cost</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%                                
                            CartDAO cartdao = new CartDAO();
                            ProductDAO prodao = new ProductDAO();
                            ProductVariantDAO vardao = new ProductVariantDAO();
                            
                            List<Cart> lcart = cartdao.getAllInUserCart(temp.getAccountID());
                            int TotalPrice = 0;
                            for (Cart cart : lcart) {
                                Product pro = prodao.getProductById(cart.getProductID());
                                ProductVariant var = vardao.getProductVariantById(cart.getVariantID());
                                
                                TotalPrice += pro.getProductPrice() * cart.getQuantity();
                        %>

                        <tr>
                            <td><img src="/ShoeSense/<%= pro.getProductImg()%>" width="90" height="90" alt="alt"/></td>
                            <td><%= pro.getProductName()%></td>
                            <td><%= var.getVariantSize()%></td>
                            <td><%= var.getVariantColor()%></td>
                            <td><%= cart.getQuantity()%></td>
                            <td><fmt:formatNumber type="number" pattern="#,###" value="<%=pro.getProductPrice() * cart.getQuantity()%>" />đ</td>
                        </tr>
                        <% } %>

                        <tr>
                            <td colspan="5" class="text-end">Total:</td>
                            <td><fmt:formatNumber type="number" pattern="#,###" value="<%=TotalPrice%>" />đ</td>
                        </tr>

                    </tbody>
                </table>
            </div>

            <!-- Checkout Form Grid column -->
            <div class="col-md-6 mb-6">
                <div class="container">
                    <!--Form Register-->
                    <form method="post" id="purchaseform" action="${pageContext.request.contextPath}/checkout">
                        <input id="accountID" name="accountID" type="hidden" class="form-control" value="<%=temp.getAccountID()%>">
                        <input id="totalPrice" name="totalPrice" type="hidden" class="form-control" value="<%=TotalPrice%>">
                        <div class="m-3">
                            <label class="form-label fw-bold">Email:</label>
                            <input id="email1" type="text" name="email" class="form-control" value="<%=temp.getAccountEmail()%>" disabled="">
                            <p id="emailerror1"></p>
                        </div>
                        <div class="m-3">
                            <label class="form-label fw-bold">Username:</label>
                            <input id="name1" type="text" name="name" class="form-control" value="<%=temp.getAccountName()%>" disabled="">
                            <p id="usernameerror"></p>
                        </div>
                        <div class="m-3">
                            <label class="form-label fw-bold">Phone number:</label>
                            <input id="phone" type="text" name="phone" class="form-control" placeholder="Enter phone number" value="<%=temp.getAccountPhone()%>">
                            <p id="phoneerror"></p>
                        </div>
                        <div class="m-3">
                            <label class="form-label fw-bold">Address:</label>
                            <textarea id="address" name="address" cols="30" rows="5" class="form-control" placeholder="Enter address"><%=temp.getAccountAddress()%></textarea>
                            <p id="addresserror"></p>
                        </div>
                        <div class="m-3">
                            <label class="form-label fw-bold">Payment Method:</label>
                            <select id="paymentMethod" name="paymentMethod" class="form-select">
                                <option value="Cash">Cash</option>
                                <option value="Bank">Bank</option>
                            </select>
                        </div>
                        <div id="qrCodeContainer" style="display: none;">
                            <img id="qrCodeImage" src="" alt="QR Code">
                        </div>
                        <div class="text-center">
                            <button onclick="checkRegis(event)" name="Order" id="Order" type="submit" class="btn btn-primary fw-bold rounded-5" value="order">Order</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</main>

<jsp:include page="Footer.jsp"></jsp:include>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>

<script>
    let qrScanned = false; // Flag to track if QR code is scanned

    function checkPhone() {
        var phone = document.getElementById('phone').value;
        // Simple regex to match a 10-digit phone number (adjust as per your requirements)
        var numberValidation = /^\d{10}$/;
        return numberValidation.test(phone);
    }

    function checkAddress() {
        var address = document.getElementById('address').value.trim();
        return address !== "";
    }

    function simulateQRCodeScanned() {
        if (qrScanned) {
            return; // Prevents re-scanning QR code if already scanned
        }

        var qrCodeData = "00020101021138540010A00000072701240006970436011010231026560208QRIBFTTA53037045802VN630411C5";
        
        // Display QR Code image
        var qrCodeImage = document.getElementById('qrCodeImage');
        qrCodeImage.src = 'https://api.qrserver.com/v1/create-qr-code/?data=' + qrCodeData + '&amp;size=200x200';

        // Show the QR code container
        var qrCodeContainer = document.getElementById('qrCodeContainer');
        qrCodeContainer.style.display = 'block';

        // Change the button text and disable it
        var orderButton = document.getElementById('Order');
        orderButton.textContent = 'Scan QR';
        orderButton.disabled = true;

        // Enable form submission after a delay to simulate QR scanning
        setTimeout(function() {
            orderButton.disabled = false;
        }, 5000 * 3); // Adjust delay as per your needs for scanning simulation

        qrScanned = true; // Set flag to true after first scan
    }

    function checkRegis(event) {
        let phoneerror = document.getElementById('phoneerror');
        let addresserror = document.getElementById('addresserror');

        let check = true;

        if (!checkPhone()) {
            check = false;
            phoneerror.innerHTML = "Phone is invalid";
            phoneerror.style.color = "red";
        } else {
            phoneerror.innerHTML = "";
        }
        if (!checkAddress()) {
            check = false;
            addresserror.innerHTML = "You have to provide your address";
            addresserror.style.color = "red";
        } else {
            addresserror.innerHTML = "";
        }

        // Check the selected payment method
        let paymentMethod = document.getElementById('paymentMethod').value;

        if (paymentMethod === 'Bank') {
            simulateQRCodeScanned(); // Simulate QR code scanned for Bank payment
            // Prevent form submission until QR code is scanned (handled in simulateQRCodeScanned function)
//            event.preventDefault();
            // Manually trigger form submission after QR code scanning simulation
//            setTimeout(function() {
//                document.getElementById('purchaseform').submit();
//            }, 5000); // Adjust delay as per your needs for scanning simulation
        } else if (paymentMethod === 'Cash') {
            // For Cash payment, validate fields and submit form directly
            if (check) {
                document.getElementById('purchaseform').submit();
            }
        }
    }
</script>

</body>
</html>