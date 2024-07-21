<%-- 
    Document   : Admin_OrderManagement
    Created on : Jun 17, 2024, 10:18:44 AM
    Author     : ADMIN
--%>

<%@page import="Modals.OrderStatusLog"%>
<%@page import="DAOs.OrderStatusLogDAO"%>
<%@page import="Modals.Account"%>
<%@page import="DAOs.AccountDAO"%>
<%@page import="Modals.ProductVariant"%>
<%@page import="Modals.Product"%>
<%@page import="DAOs.ProductVariantDAO"%>
<%@page import="DAOs.ProductDAO"%>
<%@page import="DAOs.OrderDetailDAO"%>
<%@page import="Modals.OrderDetail"%>
<%@page import="Modals.OrderDetail"%>
<%@page import="Modals.Order"%>
<%@page import="java.util.List"%>
<%@page import="DAOs.OrderDAO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!--                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">-->
        <title>JSP Page</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.7.0.js"></script>
        <script src="https://cdn.datatables.net/1.13.7/js/jquery.dataTables.min.js"></script>
        <script>
            $(document).ready(function () {
                $('#example').DataTable();
            });
        </script>
        <link rel="stylesheet" href="https://cdn.datatables.net/1.13.7/css/jquery.dataTables.min.css">
        <style>
            .main-body{
                display: flex;
            }

            .body{
                width: 100vw;
                height: 100vh;
                background-color: rgb(180, 180, 180);
            }

            .navbar{
                background-color: black;
                color: white;
                text-decoration: none;
                font-size: xx-large;
                font-weight: bold;
            }

            .listcontent{
                font-size: x-large;
                margin-left: -30px;
                padding-top: 30px;
                width: 130px;
                height: 100%;
                background-color: black;
                color: white;
            }

            .listcontent:hover{
                font-size: x-large;
                width: 250px;
                height: 100%;
                background-color: black;
                color: white;
                transition: all 0.1s linear;
            }

            .listcontent:hover span{
                display: inline-block;
            }

            .listcontent span{
                display: none;
            }

            .listcontent li{
                padding: 10px;
                width: 300px;
                list-style-type: none;
            }

            .listcontent li:active{
                background-color: white;
                padding: 10px;
                width: 318px;
                list-style-type: none;
            }

            .listcontent li a{
                padding-left: 20px;
                text-decoration: none;
                color: white;
                width: 160px;
            }

            .listcontent li a:active{
                text-decoration: none;
                color: black;
                width: 160px;
            }

            .content{
                background-color: rgb(233, 233, 233);
                margin: 20px;
                border-radius: 20px;
                width: 100%;
                display: inline-block;
                justify-items: center;
                padding-left: 20px;
                padding-right: 20px;
                padding-top: 10px;
                font-size: large;
            }



            .paymentamount{
                display: flex;
            }

            .amount{
                display: flex;
            }

            .today-data{
                background-color: rgb(207, 179, 235);
                padding: 10px;
                margin: 20px;
                border-radius: 10px;
                width: 350px;
            }
            .today-data:hover{
                background-color: rgb(159, 109, 209);
            }

            .month-data{
                background-color: rgb(143, 215, 197);
                padding: 10px;
                margin: 20px;
                border-radius: 10px;
                width: 350px;
            }

            .month-data:hover{
                background-color: rgb(55, 189, 156);
            }
            .year-data{
                background-color: rgb(234, 145, 149);
                padding: 10px;
                margin: 20px;
                border-radius: 10px;
                width: 350px;
            }

            .year-data:hover{
                background-color: rgb(215, 104, 110);
            }

            .fa-dollar{
                background-color: rgb(17, 85, 167);
                color: white;
                font-size: 1.5rem;
                padding: 1.3rem;
                height: 60px;
                width: 60px;
                margin-left: 50px;
                text-align: center;
                border-radius: 50%;
            }

            .manageproduct{
                background-color: rgb(255, 255, 255);
                margin: 20px;
                border-radius: 20px;
                padding: 30px;
                font-size: x-large;
            }

            .finance td{
                width: 50px;
            }

            .addproduct{
                font-size: x-large;
            }

            .buttongroup{
                text-align: center;
            }

            .buttongroup button{
                width: 100px;
                padding: 10px;
                margin-top: 20px;
                border: none;
                font-size: x-large;
                color: white;
                background: black;
            }

            .buttongroup button:active{
                border: 1px solid black;
                color: black;
                background: white;
            }


        </style>
    </head>
    <body class="allbody">
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

                if (!temp.getAccountRole().equals("Admin")) {
                    if (temp.getAccountRole().equals("User")) {
                        response.sendRedirect("/ShoeSense/");
                    }
//                 else {
//               response.sendRedirect("/ShoeSense/staff");
//               }
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

                if (temp != null && !temp.getAccountRole().equals("Admin")) {
                    if (temp.getAccountRole().equals("User")) {
                        response.sendRedirect("/ShoeSense/");
                    }
//                 else {
//               response.sendRedirect("/ShoeSense/staff");
//               }
                }

                if (!flag) {
                    response.sendRedirect("/ShoeSense/login");
                }
            }


        %>

        <%            if (temp.getAccountRole().equalsIgnoreCase("Admin")) {
        %>
        <a href="" class="navbar ps-5" style="width: auto">
            ShoeSense - ADMIN
        </a>
        <%
        } else {
        %>
        <a href="" class="navbar ps-5" style="width: auto">
            ShoeSense - Staff
        </a>
        <%
            }
        %>
        <div class="main-body">

            <%
                if (temp.getAccountRole().equalsIgnoreCase("Admin")) {
            %>
            <jsp:include page="Header_Admin.jsp"></jsp:include>
            <%
            } else {
            %>
            <jsp:include page="Header_Staff.jsp"></jsp:include>
            <%
                }
            %>
            <div class="body">
                <div id="manageproduct" class="manageproduct" style=" font-size: 1.25rem">


                    <h2>Order data</h2>


                    <div>
                        <p>Status:
                            <a href="/ShoeSense/order/manage/processing"  class="btn btn-secondary" >Processing</a>
                            <a href="/ShoeSense/order/manage/shipping"  class="btn btn-secondary" >Shipping</a>
                            <a href="/ShoeSense/order/manage/cancel"  class="btn btn-secondary" >Cancel</a>
                            <a href="/ShoeSense/order/manage/delivered"  class="btn btn-secondary" >Delivered</a>
                        </p>

                    </div>

                    <table id="example" style="width: 1300px">
                        <thead>
                            <tr>
                                <th class="align-middle">Order ID</th>
                                <th class="align-middle">Account</th>
                                <th class="align-middle">Address</th>
                                <th class="align-middle">Phone</th>

                                <th style="width: 110px" class="align-middle">Total</th>
                                <th class="align-middle">Purchase Method</th>
                                <th class="align-middle">Purchase Date</th>
                                <th class="align-middle">Status</th>
                                <th style="width: 150px" class="align-middle">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%                                OrderDAO odao = new OrderDAO();
                                AccountDAO adao2 = new AccountDAO();
                                OrderStatusLogDAO osldao = new OrderStatusLogDAO();
                                List<Order> listo = (List<Order>) request.getAttribute("listOr");
                                for (Order i : listo) {
                                    Account a = adao2.GetAccountById(Integer.toString(i.getAccountID()));
                                    List<OrderStatusLog> osll = osldao.getAllOrderStatusLogByOrderId(i.getOrderID());

                            %>
                            <tr>
                                <td class="align-middle"><p><%= i.getOrderID()%></p></td>
                                <td class="align-middle"><p><%= a.getAccountName()%></p></td>
                                <td class="align-middle"><p><%= i.getOrderAddress()%></p></td>
                                <td class="align-middle"><p><%= a.getAccountPhone()%></p></td>

                                <td class="align-middle">
                                    <p>
                                        <fmt:formatNumber
                                        value="<%= i.getTotalPrice()%>"
                                            type="number"
                                            pattern="###,### VNÐ"
                                            />
                                    </p>
                                </td>
                                <td class="align-middle"><p><%= i.getPaymentMethod()%></p></td>
                                        <%
                                            for (OrderStatusLog osl : osll) {
                                                if (osl.getOrderStatus().equals("Processing")) {


                                        %>
                                <td class="align-middle"><p><%= osl.getStatusDate()%></p></td>

                                <%
                                        }
                                    }
                                %>
                                <td>
                                    <%
                                        if (("Processing").equalsIgnoreCase(i.getOrderStatus())) {
                                    %>
                                    <p class="align-middle" style="color: green; font-weight: bold"><%= i.getOrderStatus()%></p>
                                    <%} else if (("Shipping").equalsIgnoreCase(i.getOrderStatus())) {%>
                                    <p class="align-middle" style="color: Orange; font-weight: bold"><%= i.getOrderStatus()%></p>
                                    <%} else if (("Cancel").equalsIgnoreCase(i.getOrderStatus())) {%>
                                    <p class="align-middle" style="color: red; font-weight: bold"><%= i.getOrderStatus()%></p>
                                    <%} else {%>
                                    <p class="align-middle" style="color: black; font-weight: bold"><%= i.getOrderStatus()%></p>
                                    <%}%>
                                </td>
                                <td class="align-middle">
                                    <a style="margin-bottom: 6px"class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#StatusLog<%= i.getOrderID()%>">Status Log</a>
                                    <a class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#OrderDetail<%= i.getOrderID()%>">Product Details</a>
                                    <!-- Product Details Modal -->
                                    <div class="modal fade" id="OrderDetail<%= i.getOrderID()%>">" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                        <div class="modal-dialog modal-dialog-scrollable modal-xl">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h1 class="modal-title fs-5" id="staticBackdropLabel">Order Detail</h1>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    <div class="container-fluid">
                                                        <table style="width: 100%;text-align: center;">
                                                            <tr>
                                                                <th>ID</th>
                                                                <th>Name</th>
                                                                <th>Image</th>
                                                                <th>Variant</th>
                                                                <th>Quantity</th>
                                                                <th>Total price</th>
                                                            </tr>
                                                            <%
                                                                OrderDetailDAO oddao = new OrderDetailDAO();
                                                                ProductDAO prodao = new ProductDAO();
                                                                ProductVariantDAO vardao = new ProductVariantDAO();

                                                                List<OrderDetail> detail = oddao.getAllOrderDetailByOrderId(i.getOrderID());
                                                                for (OrderDetail j : detail) {

                                                                    Product pro = prodao.getProductById(j.getProductID());
                                                                    ProductVariant var = vardao.getProductVariantById(j.getVariantID());
                                                            %>
                                                            <tr>
                                                                <td><%= j.getProductID()%></td>
                                                                <td><%= pro.getProductName()%></td>
                                                                <td><img src="/ShoeSense/<%= pro.getProductImg()%>" width="90" height="90" alt="alt"/></td>
                                                                <td>size: <%= var.getVariantSize()%> || color: <%= var.getVariantColor()%></td>
                                                                <td><%= j.getQuantity()%></td>
                                                                <td>
                                                                    <fmt:formatNumber
                                                                    value="<%= j.getTotal()%>"
                                                                        type="number"
                                                                        pattern="###,### VNÐ"
                                                                        /></td>
                                                            </tr>
                                                            <%

                                                                }
                                                            %>
                                                        </table>
                                                    </div>
                                                </div>
                                                <div class="modal-footer">

                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                    <form action="" method="post">
                                                        <input type="hidden" name="orderID" value="<%= i.getOrderID()%>">
                                                        <input type="hidden" name="userID" value="<%= i.getAccountID()%>">
                                                        <input type="hidden" name="staffID" value="<%= temp.getAccountID()%>">


                                                        <%
                                                            if (("Processing").equalsIgnoreCase(i.getOrderStatus())) {
                                                        %>
                                                        <button type="submit" name="Confirm" class="btn btn-primary" value="confirm">Confirmed</button>
                                                        <button type="submit" name="Cancel" class="btn btn-danger" value="cancel">Cancel</button>
                                                        <%} else if (("Shipping").equalsIgnoreCase(i.getOrderStatus())) {%>
                                                        <button type="submit" name="Deliver" class="btn btn-primary" value="deliver">Delivered</button>
                                                        <button type="submit" name="Cancel" class="btn btn-danger" value="cancel">Cancel</button>
                                                        <%}%>



                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Status Log Modal -->
                                    <div class="modal fade" id="StatusLog<%= i.getOrderID()%>">" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                        <div class="modal-dialog modal-dialog-scrollable modal-xl">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h1 class="modal-title fs-5" id="staticBackdropLabel">Status Log</h1>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    <div class="container-fluid">
                                                        <table style="width: 100%;text-align: center;">
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
                                                            <%                                                                }
                                                            %>
                                                        </table>
                                                    </div>
                                                </div>
                                                <div class="modal-footer">

                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                    <form action="" method="post">
                                                        <input type="hidden" name="orderID" value="<%= i.getOrderID()%>">
                                                        <input type="hidden" name="userID" value="<%= i.getAccountID()%>">

                                                        <!--                                                        <button type="submit" name="Confirm" class="btn btn-primary" value="confirm">Confirmed</button>
                                                                                                                <button type="submit" name="Cancel" class="btn btn-danger" value="cancel">Cancel</button>                  
                                                        -->
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>


                            <%

                                }
                            %>
                        </tbody>
                    </table>   
                </div>
            </div>  
        </div>
        <script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>

    </body>
</html>



