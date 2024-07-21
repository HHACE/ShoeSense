<%-- 
    Document   : Admin_ProductVariantManagement
    Created on : Jun 22, 2024, 5:16:47 AM
    Author     : ADMIN
--%>

<%@page import="Modals.ProductVariant"%>
<%@page import="Modals.Product"%>
<%@page import="Modals.Account"%>
<%@page import="Modals.Import"%>
<%@page import="java.util.List"%>
<%@page import="DAOs.ProductVariantDAO"%>
<%@page import="DAOs.ProductDAO"%>
<%@page import="DAOs.AccountDAO"%>
<%@page import="DAOs.ImportDAO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <!--        <link rel="stylesheet" href="style.css">-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
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
                    <h2>Variant data</h2>

                    <table id="example" class="table table-striped">
                        <thead>
                            <tr>
                                <th class="align-middle">Variant ID</th>
                                <th class="align-middle">Product ID</th>
                                <th class="align-middle">Variant Image</th>
                                <th class="align-middle">Variant Size</th>
                                <th class="align-middle">Variant Color</th>
                                <th class="align-middle">Variant Quantity</th>
                                <th class="align-middle">Action</th>
                            </tr>
                        </thead>
                        <tbody id="data">
                            <%                                ProductDAO prodao = new ProductDAO();
                                ProductVariantDAO vardao = new ProductVariantDAO();

                                List<ProductVariant> listVar = vardao.getAllProductVariantByProductID((int) request.getAttribute("proID"));

                                for (ProductVariant var : listVar) {
                                    Product pro = prodao.getProductById(var.getProductID());
                            %>
                            <tr>
                                <td class="align-middle"><p><%= var.getVariantID()%></p></td>
                                <td class="align-middle"><p><%= var.getProductID()%></p></td>
                                <td class="align-middle"><img src='/ShoeSense/<%= var.getVariantImg()%>' alt="" width="80" height="80"></td>
                                <td class="align-middle"><p><%= var.getVariantSize()%></p></td>
                                <td class="align-middle"><p><%= var.getVariantColor()%></p></td>
                                <td class="align-middle"><p><%= var.getVariantQuantity()%></p></td>
                                <td class="align-middle">
                                    <button type="button" class="btn btn-primary"
                                            onclick="fillForm('<%= var.getVariantID()%>', '<%= pro.getProductID()%>', '<%= pro.getProductName()%>', '<%= var.getVariantSize()%>', '<%= var.getVariantColor()%>', '<%= var.getVariantQuantity()%>')">
                                        Edit
                                    </button>
                                    <form action="" method="post">
                                        <input type="hidden" name="variantID1" id="variantID1" value="<%= var.getVariantID()%>">
                                        <button type="submit" value="Delete" name="deleteVariant" class="btn btn-danger">Delete</button>
                                    </form>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
                <!-- Edit product -->
                <div id="addproduct" class="bg-white container p-5 mt-5 rounded-5" style="display: none;">
                    <div class="add product">
                        <form action="" method="post" enctype="multipart/form-data">
                            <div class="header m-2">
                                <h4 class="modal-title">Edit Variant</h4>
                            </div>
                            <div>
                                <div class="form-group">
                                    <label>Product Name</label>
                                    <input type="text" name="name" id="name" class="form-control" required disabled>
                                </div>
                                <div class="form-group">
                                    <label>Variant Image</label>
                                    <input name="img" type="file" class="form-control" value="">
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
                                <!-- Hidden field for variant ID -->
                                <input type="hidden" name="variantID2" id="variantID2" value="">
                            </div>
                            <div class="buttongroup">
                                <button type="submit" value="Edit" name="updateVariant" id="updateVariant" class="rounded-3">Edit</button>
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

                                                const btncancel = document.getElementById("btncancel");

                                                // Event listener for Cancel button
                                                btncancel.addEventListener("click", function () {
                                                    addproduct.style.display = "none";
                                                    manageproduct.style.display = "block";
                                                });

                                                // Function to fill form fields with variant data
                                                function fillForm(variantID, productID, productName, variantSize, variantColor, quantity) {
                                                    document.getElementById("name").value = productName;
                                                    document.getElementById("size").value = variantSize;
                                                    document.getElementById("color").value = variantColor;
                                                    document.getElementById("quantity").value = quantity;

                                                    // Set the value of the hidden input field
                                                    document.getElementById("variantID2").value = variantID;

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