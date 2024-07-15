<%-- 
    Document   : Admin_ImportManagement
    Created on : Jun 22, 2024, 1:18:54 AM
    Author     : ADMIN
--%>

<%@page import="Modals.ProductVariant"%>
<%@page import="Modals.Product"%>
<%@page import="DAOs.ProductVariantDAO"%>
<%@page import="DAOs.ProductDAO"%>
<%@page import="Modals.Import"%>
<%@page import="java.util.List"%>
<%@page import="DAOs.ImportDAO"%>
<%@page import="Modals.Account"%>
<%@page import="DAOs.AccountDAO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="style.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
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
                width: 2000px;
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
                height: 1900px;
                background-color: black;
                color: white;
            }

            .listcontent:hover{
                font-size: x-large;
                width: 350px;
                height: 1900px;
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
            }


        %>
         
        <%
        if (temp.getAccountRole().equalsIgnoreCase("Admin")) {
        %>
        <a href="" class="navbar ps-5">
            ShoeSense - ADMIN
        </a>
                <%
                    } else {
        %>
                <a href="" class="navbar ps-5">
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
                    <div id="manageproduct" class="manageproduct">
                        <h2>Import data</h2>

                        <a href="#addImportModal" class="btn btn-success m-2" id="btnaddimport" data-toggle="modal">
                            <i class="fa fa-plus"></i> 
                            <span>Add New Product</span>
                        </a>

                        <table id="example">
                            <thead>
                                <tr>
                                    <th class="align-middle">Import ID</th>
                                    <th class="align-middle">Account ID</th>
                                    <th class="align-middle">Account Name</th>
                                    <th class="align-middle">Product ID</th>
                                    <th class="align-middle">Product Name</th>
                                    <th class="align-middle">Variant ID</th>
                                    <th class="align-middle">Variant Size</th>
                                    <th class="align-middle">Variant Color</th>
                                    <th class="align-middle">Quantity</th>
                                    <th class="align-middle">Import Date</th>
                                    <th class="align-middle">Action</th>
                                </tr>
                            </thead>
                            <tbody id="data">
                            <%                        ImportDAO impdao = new ImportDAO();
                                AccountDAO accdao = new AccountDAO();
                                ProductDAO prodao = new ProductDAO();
                                ProductVariantDAO vardao = new ProductVariantDAO();

                                List<Import> listImp = impdao.getAllImport();
                                for (Import i : listImp) {
                                    Account acc = accdao.GetAccountById(String.valueOf(i.getAccountID()));
                                    Product pro = prodao.getProductById(i.getProductID());
                                    ProductVariant var = vardao.getProductVariantById(i.getVariantID());
                            %>
                            <tr>
                                <td class="align-middle"><p><%= i.getImportID()%></p></td>
                                <td class="align-middle"><p><%= i.getAccountID()%></p></td>
                                <td class="align-middle"><p><%= acc.getAccountName()%></p></td>
                                <td class="align-middle"><p><%= i.getProductID()%></p></td>
                                <td class="align-middle"><p><%= pro.getProductName()%></p></td>
                                <td class="align-middle"><p><%= i.getVariantID()%></p></td>
                                <td class="align-middle"><p><%= var.getVariantSize()%></p></td>
                                <td class="align-middle"><p><%= var.getVariantColor()%></p></td>
                                <td class="align-middle"><p><%= i.getQuantity()%></p></td>
                                <td class="align-middle"><p><%= i.getImportDate()%></p></td>
                                <td class="align-middle">
                                    <button type="button" class="btn btn-primary" data-toggle="modal"
                                            onclick="fillForm('<%= i.getImportID()%>', '<%= i.getAccountID()%>', '<%= pro.getProductName()%>', '<%= var.getVariantSize()%>', '<%= var.getVariantColor()%>', '<%= var.getVariantQuantity()%>')">
                                        Reverse
                                    </button>
                                </td>
                            </tr>
                            <% }%>
                        </tbody>
                    </table>
                </div>
                <!-- Add product -->
                <div id="addproduct" class="bg-white container p-5 mt-5 rounded-5" style="display: none;">
                    <div class="add product">
                        <form action="" method="post">
                            <div class="header m-2">
                                <h4 class="modal-title">Add Product</h4>
                            </div>
                            <div>
                                <div class="form-group">
                                    <label>Product Name</label>
                                    <input type="text" name="name" id="name" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label>Product Size</label>
                                    <input type="text" name="size" id="size" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label>Product Color</label>
                                    <input type="text" name="color" id="color" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label>Quantity</label>
                                    <input type="number" name="quantity" id="quantity" class="form-control" required>
                                </div>
                            </div>
                            <div class="buttongroup">
                                <input type="hidden" name="staffID" value="<%= session.getAttribute("id")%>">
                                <button type="submit" value="Add" name="addNewImport" id="addNewImport" class="rounded-3">Add</button>
                                <button type="reset" value="Cancel" id="btncancel" class="rounded-3">Cancel</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
        crossorigin="anonymous"></script>

        <script>
                                                const manageproduct = document.getElementById("manageproduct");
                                                const addproduct = document.getElementById("addproduct");

                                                const btnaddimport = document.getElementById("btnaddimport");

                                                const btncancel = document.getElementById("btncancel");

                                                btnaddimport.addEventListener("click", function () {
                                                    addproduct.style.display = "block";
                                                    manageproduct.style.display = "none";
                                                });

                                                btncancel.addEventListener("click", function () {
                                                    addproduct.style.display = "none";
                                                    manageproduct.style.display = "block";
                                                });

                                                function fillForm(importID, accountID, productName, variantSize, variantColor, quantity) {
                                                    document.getElementById("name").value = productName;
                                                    document.getElementById("size").value = variantSize;
                                                    document.getElementById("color").value = variantColor;
                                                    document.getElementById("quantity").value = -quantity;

                                                    // You can optionally set importID and accountID fields here if needed
                                                    // document.getElementById("importID").value = importID;
                                                    // document.getElementById("accountID").value = accountID;

                                                    // Show the addproduct form
                                                    addproduct.style.display = "block";
                                                    manageproduct.style.display = "none";
                                                }
        </script>



        <%
            String alertMess = (String) request.getAttribute("alertMess");
            if (alertMess != null && !alertMess.isEmpty()) {
        %>
        <script>
            alert("<%= alertMess%>");
        </script>
        <%
            }
        %>

    </body>
</html>