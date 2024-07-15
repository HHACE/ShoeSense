<%-- 
    Document   : home
    Created on : Jun 5, 2024, 12:44:18 PM
    Author     : ADMIN
--%>

<%@page import="DAOs.ProductVariantDAO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.nio.charset.StandardCharsets"%>
<%@page import="java.net.URLDecoder"%>

<%@page import="java.util.List"%>
<%@page import="Modals.Product"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DAOs.ProductDAO"%>
<%@page import="DAOs.AccountDAO"%>
<%@page import="Modals.Account"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
         <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <link rel="stylesheet" href="style.css" />
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

            #product div:hover{
                box-shadow: 5px 5px 5px gray;
            }

            .bannerimg{
                width: 1900px;
            }

            .page-item{
                padding: 5px;
            }

            #pagingitem a{
                color: rgb(137, 137, 137);
                border-radius: 100%;
                padding-left: 14px;
                padding-right: 14px;
            }

            #pagingitem a:hover{
                background-color: rgb(75, 75, 75);
                border: 1px solid black;
                color: white;
            }

            #pageprenext a{
                color: rgb(137, 137, 137);
                border-radius: 50px;
            }

            #pageprenext a:hover{
                background-color: rgb(75, 75, 75);
                border: 1px solid black;
                color: white;
            }

            #productDetail{
                width: 1900px;
            }

            #detailproductimg{
                width: 450px;
                height: 500px;
            }


            input[type="radio"]:checked + label.size-label{
                background-color: rgb(49, 49, 49);
                border: 1px solid rgb(0, 0, 0);
                color: white;
            }

            .quantity button{
                border: 1px solid rgb(137, 137, 137) ;
                color: rgb(106, 105, 105);
                border-radius: 5px;
                width: 40px;
                text-align: center;
                justify-content: center;

            }

            .quantity button:hover{
                background-color: rgb(147 117 80);
                border: 1px solid rgb(129, 102, 69);
                color: white;
            }

            #buttonThemvaogio{
                background-color: rgb(60, 60, 60);
                color: white;
            }

            #buttonThemvaogio:active{
                background-color: black;
            }

            #buttonMuangay{
                border: 1px solid;
            }

            #buttonMuangay:active{
                background-color: black;
                color: white;
            }

            #linkfooter{
                text-decoration: none;
                color: white;
            }
            
             .hethang{
            position: absolute;
            }

        </style>
    </head>
    <body>
        
                <%

            Cookie[] cookies = request.getCookies();
            
            Account temp = (Account) session.getAttribute("acc");
            

            
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
                
//                if (!flag) {
//                    response.sendRedirect("/ShoeSense/login");
//                }
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
                
                
//                if (!flag) {
//                    response.sendRedirect("/ShoeSense/Login");
//                }
            }

     

        %>
        
        <jsp:include page="Header_User.jsp"></jsp:include>
  <div class="bg-body-secondary">

            <div id="carouselExampleDark" class="carousel carousel-dark slide">
                <div class="carousel-indicators">
                    <button type="button" data-bs-target="#carouselExampleDark" data-bs-slide-to="0" class="active"
                            aria-current="true" aria-label="Slide 1"></button>
                    <button type="button" data-bs-target="#carouselExampleDark" data-bs-slide-to="1"
                            aria-label="Slide 2"></button>
                    <button type="button" data-bs-target="#carouselExampleDark" data-bs-slide-to="2"
                            aria-label="Slide 3"></button>
                </div>
                <!--Banner-->
                <div id="banner">
                    <div class="carousel-inner">
                        <div class="carousel-item active" data-bs-interval="10000">
                            <img id="bannerimg" src="/ShoeSense/img/banner/abanner1.jpg" class="d-block w-100" alt="banner1">
                            <div class="carousel-caption d-none d-md-block">
                            </div>
                        </div>
                        <div class="carousel-item" data-bs-interval="2000">
                            <img id="bannerimg" src="/ShoeSense/img/banner/abanner2.jpg" class="d-block w-100" alt="banner2">
                            <div class="carousel-caption d-none d-md-block">
                            </div>
                        </div>
                        <div class="carousel-item">
                            <img id="bannerimg" src="/ShoeSense/img/banner/abanner3.jpg" class="d-block w-100" alt="banner3">
                            <div class="carousel-caption d-none d-md-block">
                            </div>
                        </div>
                    </div>
                    <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleDark"
                            data-bs-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Previous</span>
                    </button>
                    <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleDark"
                            data-bs-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Next</span>
                    </button>
                </div>
            </div>
        </div>
        <div class="container mt-5 mb-5">
            <form action="?search=${param['search']}&sort=${param['sort']}&category=${param['category']}" method="get">
                <section class="bg-white p-5 p">
                    <div class="row m-2">
                        <a href="?search=${param['search']}&sort=${param['sort']}&category='Shoe'" class="col-4 text-center p-3 category">Shoe</a>
                        <a href="?search=${param['search']}&sort=${param['sort']}&category='Sandal'" class="col-4 text-center p-3 category">Sandal</a>
                        <a href="?search=${param['search']}&sort=${param['sort']}&category='Boot'" class="col-4 text-center p-3 category">Boot</a>
                         <a href="?search=${param['search']}&sort=${param['sort']}&category='Heel'" class="col-4 text-center p-3 category">Heel</a>
                    </div>
                    <div id="sort" class="row">
                        <div class="col-3">
                            <div class="form-floating row">
                                <div class="col-6">
                                    <div class="form-floating row">
                                        <select class="form-select form-select-sm" id="floatingSelectGrid" name="sort" onchange="this.form.submit()">
                                            <option selected value="0" ${param['sort'] == 0 ? "selected" : ""}>option</option>
                                            <option value="1" ${param['sort'] == 1 ? "selected" : ""}>By Name A-Z</option>
                                            <option value="2" ${param['sort'] == 2 ? "selected" : ""}>By Price (High - Low)</option>
                                            <option value="3" ${param['sort'] == 3 ? "selected" : ""}>By Price (Low - High)</option>
                                        </select>
                                        <label for="floatingSelectGrid">Sort</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <input type="hidden" name="category" value="${param['category']}">

                        <div class="row">
 <c:forEach var="o" items="${plist}">
    <c:if test="${o.productStatus == 'Public'}">
        <a id="product" href="/ShoeSense/product/detail/${o.productID}" class="m-5 col-sm-12 col-md-4 col-lg-2" style="text-decoration: none">
            <div class="card h-100" style="width: 13rem;">
                <img src="/ShoeSense/${o.productImg}" class="card-img " alt="product1">
                <div class="card-body">
                    <h5 class="card-title">${o.productName}</h5>
                    <p class="card-text">
                        <span class="fw-bold rounded-2 text-white bg-danger p-1">Giá tiền:</span>
                        <fmt:formatNumber pattern="###,###" value="${o.productPrice}"/> vnđ
                    </p>
                    
                    <c:set var="productId" value="${o.productID}" />
                    <%-- Retrieve stock information using a DAO method --%>
                    <%
                        ProductVariantDAO vardao = new ProductVariantDAO();
                        int totalVariantQuantity = vardao.getTotalProductVariantByProductId((Integer)pageContext.getAttribute("productId"));
   
                        
                        if (totalVariantQuantity >0){
                        %>
                          <p class="card-text">Stock: <%= totalVariantQuantity%></p>
                        <%
                        } else {
                    %>
                     <p class="card-text">Stock: Out Of Stock</p>
                                            <%
                        } 
                    %>
                    
                
                    
                </div>
            </div>
        </a>
    </c:if>
</c:forEach>
                        </div>
                    </div>
                    <div class="flex-c-m flex-w w-full p-t-45">
                        <div style="display: flex; justify-content: center;">
                            <ul class="pagination">
                                <li class="page-item ${param['index'] == 1 ? 'disabled' : ''}">
                                    <a class="page-link" href="?index=${param['index'] - 1}&sort=${param['sort']}&category=${param['category']}">Previous</a>
                                </li>
                                <c:forEach var="i" begin="1" end="${numberPage}">
                                    <li class="${param['index'] == i ? 'page-item active' : 'page-item'}">
                                        <a href="?index=${i}&sort=${param['sort']}&category=${param['category']}" class="page-link">${i}</a>
                                    </li>
                                </c:forEach>
                                <li class="page-item ${param['index'] == numberPage ? 'disabled' : ''}">
                                    <a class="page-link" href="?index=${param['index'] + 1}&sort=${param['sort']}&category=${param['category']}">Next</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </section>
            </form>
        </div>
        <!--Footer-->
        
        <jsp:include page="Footer.jsp"></jsp:include>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
        crossorigin="anonymous"></script>
        <script src="quantity.js"></script>
        <%            String alertMess = (String) request.getAttribute("alertMess");
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
