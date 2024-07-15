<%-- 
    Document   : Admin_ProductManagement
    Created on : Jun 17, 2024, 10:18:14 AM
    Author     : ADMIN
--%>

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
                    <h2>Product management</h2>
                    <a href="#addEmployeeModal"  class="btn btn-success m-2" id="btnaddproduct" data-toggle="modal">
                        <i class="fa fa-plus"></i> 
                        <span >Add New Product</span>
                    </a>
                    <table id="example" class="display" style="width:100%">
                        <thead>
                            <tr>
                                <th>Product ID</th>
                                <th>Image</th>
                                <th>Name</th>
                                <th>Price</th>
                                <th>Category</th>
                                <th>Description</th>
                                <th>Status</th>
                                <th></th>

                            </tr>
                        </thead>
                        <tbody id="data">
                            <c:forEach items="${list}" var="c">
                                <c:set var="id" value="${c.productID}"/>
                                <tr>
                                    <td style="width: 10px">${id}</td>
                                    <td><img src='/ShoeSense/${c.productImg}' alt="" width="80" height="80"></td>
                                    <td>${c.productName}</td>

                                    <td>
                                        <fmt:formatNumber value="${c.getProductPrice()}" pattern="###,###,###" /> vnđ
                                    </td>

                                    <td>${c.getProductCategory()}</td>
                                    <td>${c.productDis}</td>
                                    <td>${c.productStatus}</td>
                                    <td>
                                        <a href="manage?type=update&pid=${c.productID}" class="btn btn-primary text-white m-2" ><i class="fa fa-pencil p-1"></i></a>
                                        <button type="button" class="btn btn-danger m-2" onclick="window.location.href = '/ShoeSense/product/variant/${c.productID}'">Variant</button>
                                          <a href="/ShoeSense/comment/manage/product/${c.productID}" class="btn btn-primary text-white m-2" >Comment</a>
                                        <form action="deleteProduct">
                                            <input value="${c.productID}" name="id" hidden>
                                            <button type="button" class="btn btn-danger m-2" onclick="confirmDelete(${c.productID})"><i class="fa fa-trash p-1"></i></button>

                                            
                                        </form>
                                            <c:if test="${c.productStatus == 'Public'}">
                                                 
                                        <a href="manage?type=hide&pid=${c.productID}" class="btn btn-primary text-white m-2" >Hide</a>
                                            </c:if>
                                             <c:if test="${c.productStatus == 'Hide'}">
                                              <a href="manage?type=public&pid=${c.productID}" class="btn btn-primary text-white m-2" >Public</a>
                                             </c:if>
                                              
                                              
                                           
                                        <script>
                                            function confirmDelete(productId) {
                                                if (confirm("Bạn có chắc chắn muốn xóa sản phẩm này?")) {
                                                    window.location.href = "manage?type=delete&pid=" + productId;
                                                } else {
                                                }
                                            }
                                        </script>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <!-- Add product -->
                <div id="addproduct" class="bg-white container p-5 mt-5 rounded-5" style="display: none;">
                    <div class="add product">
                        <form action="manage?type=add" method="post" enctype="multipart/form-data">
                            <div class="header m-2">						
                                <h4 class="modal-title">Add Product</h4>
                            </div>
                            <div class="">
                                <div class="form-group">

                                    <input name="type" value="add" type="hidden" class="form-control hidden" required>
                                    <label>Name</label>
                                    <input name="type" value="add" type="hidden" class="form-control hidden" required>
                                    <input name="name" type="text" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label>Image</label>
                                    <input name="img" type="file" class="form-control" value="">
                                </div>
                                <div class="form-group">
                                    <label>Size</label>
                                    <input name="size" class="form-control" type="text" required>
                                </div>
                                <div class="form-group">
                                    <label>Quantity</label>
                                    <input name="quantity" class="form-control" type="number" required>
                                </div>
                                <div class="form-group">
                                    <label>Price</label>
                                    <input name="price" class="form-control" type="number" required>
                                </div>
                                <div class="form-group">
                                    <label>Category</label>
                                    <input name="category" class="form-control" type="text" required>
                                </div>
                                <div class="form-group">
                                    <label>Description</label>
                                    <input name="description" class="form-control" type="text" required>
                                </div>
                            </div>
                            <div class="buttongroup">
                                <input type="hidden" name="staffID" value="<%= session.getAttribute("id")%>">
                                <button type="submit"  value="Add" name="addNewProduct" id="btnadd" class="rounded-3">Add</button>
                                <button type="reset" value="Cancel" id="btncancel" class="rounded-3">Cancel</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>  
        </div>
        <script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
        <script>
                                            const manage = document.getElementById("manageproduct");
                                            const add = document.getElementById("addproduct");
                                            const btnadd = document.getElementById("btnaddproduct");
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
