<%-- 
    Document   : Admin_ProductUpdate
    Created on : Jun 19, 2024, 9:22:02 AM
    Author     : ADMIN
--%>

<%@page import="Modals.Account"%>
<%@page import="DAOs.AccountDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <link rel="stylesheet" href="style.css">
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

            .allbody{

                background-color: rgb(182, 182, 182);
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

            .update{
                margin: 20px;
                text-align: center;
            }

            #editEmployeeModal{
                height: fit-content;
            }

            .update button{
                background-color: black;
                color: white;
                font-size: x-large;
                padding: 10px;
                border: none;
            }

            .update button:active{
                background-color: white;
                color: black;
                border: 1px solid;
            }

            .update a{
                background-color: black;
                color: white;
                padding: 10px;
                border: none;
                text-decoration: none;
            }

            .update a:active{
                background-color: white;
                color: black;
                padding: 10px;
                border: 1px solid black;
                text-decoration: none;
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
                    response.sendRedirect("/ShoeSense/Login");
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
            <div id="editEmployeeModal" class="container mt-5 bg-white p-5 rounded-5">

                <form action="" method="post" enctype="multipart/form-data" >
                    <div>						
                        <h4 class="modal-title mb-4">Update Product</h4>
                    </div>
                    <div>		
                        <input value="update" name="type" type="hidden" class="form-control hidden" >
                        <div class="form-group mb-3">
                            <label class="fs-4">ID: <span>${data.productID}</span></label>
                            <input value="${data.productID}" name="id" type="hidden" class="form-control" readonly required>
                        </div>
                        <div class="form-group">
                            <label>Product Name</label>
                            <input value="${data.productName}" name="name" type="text" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label>Image</label>
                            <input value="${data.productImg}" name="img" type="file" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label>Price</label>
                            <textarea  name="price" class="form-control" required>${data.productPrice}</textarea>
                        </div>
                        <div class="form-group">
                            <label>Catagory</label>
                            <input type="text" name="category"  class="form-control"  value="${data.productCategory}" required>
                        </div>
                        <div class="form-group">
                            <label>Description</label>
                            <textarea name="description" class="form-control" required>${data.productDis}</textarea>
                        </div>
                    </div>
                    <div class="update">
                        <button type="submit" class="rounded-3 fs-5" value="Update">Update</button>
                        <a href="/ShoeSense/product/manage?type=view" role="button" class="rounded-3 fs-5" >Cancel</a>
                    </div>
                </form>                
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
        <script>
            const manage = document.getElementById("manageproduct");
            const add = document.getElementById("addproduct");
            const btnadd = document.getElementById("manageproduct");
            const btncancel = document.getElementById("btncancel");

            btnadd.addEventListener("click", function () {
                add.style.display = "block";
                manage.style.display = "none";
            });

            btncancel.addEventListener("click", function () {
                add.style.display = "none";
                manage.style.display = "block";
            });
        </script>
    </body>
</html>

