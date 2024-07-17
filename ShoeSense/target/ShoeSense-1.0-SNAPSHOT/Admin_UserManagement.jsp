<%-- 
    Document   : Admin_UserManagement
    Created on : Jun 11, 2024, 6:07:34 PM
    Author     : ADMIN
--%>
<%@page import="DAOs.AccountDAO"%>
<%@page import="Modals.Account"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <title>Customer Management</title>
        <link rel="stylesheet" href="style.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
            crossorigin="anonymous"
            />
        <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
            />
        <link
            rel="stylesheet"
            href="https://cdn.datatables.net/1.13.7/css/jquery.dataTables.min.css"
            />
        <style>
            .main-body{
                display: flex;
            }

            .body{
                width: 2000px;
                background-color: rgb(183, 183, 183);
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
                height: 850px;
                background-color: black;
                color: white;
            }

            .listcontent:hover{
                font-size: x-large;
                width: 350px;
                height: 850px;
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
                background-color: white;
                margin: 20px;
                border-radius: 20px;
                width: 100%;
                display: inline-block;
                justify-items: center;
                padding: 20px;
                font-size: large;
            }

        </style>
    </head>

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

    <body class="allbody">

        <a href="" class="navbar ps-5"> ShoeSense - ADMIN</a>
        <div class="main-body">
            <jsp:include page="Header_Admin.jsp"></jsp:include>
                <div class="container">
                    <div class="content">
                        <h1>Customer Management</h1>
                        <table id="example">
                            <thead>
                                <tr>
                                    <th class="align-middle">NO</th>
                                    <th class="align-middle">User ID</th>
                                    <th class="align-middle">User Name</th>
                                    <th class="align-middle">Gender</th>
                                    <th class="align-middle">Email</th>
                                    <th class="align-middle">Date of birth</th>
                                    <th class="align-middle">Phone number</th>
                                    <th class="align-middle">Address</th>
                                    <th class="align-middle">Status</th>
                                    <th class="align-middle"></th>
                                </tr>
                            </thead>
                            <tbody>
                            <c:set var="stt" value="0" />
                            <c:forEach items="${listUser}" var="o">
                                <c:set var="stt" value="${stt + 1}" />
                                <c:set var="account" value="${o}" scope="request" />
                                <tr>
                                    <td class="align-middle"><p>${stt}</p></td>
                                    <td class="align-middle"><p>${o.accountID}</p></td>
                                    <td class="align-middle"><p>${o.accountName}</p></td>
                                    <td class="align-middle"><p>${o.accountGender}</p></td>
                                    <td class="align-middle"><p>${o.accountEmail}</p></td>
                                    <td class="align-middle"><p>${o.accountBirthdate}</p></td>
                                    <td class="align-middle"><p>${o.accountPhone}</p></td>
                                    <td class="align-middle"><p>${o.accountAddress}</p></td>
                                    <td class="align-middle"><p>${o.accountStatus}</p></td>
                                    <td class="align-middle">
                                        <a href="/ShoeSense/admin/user/manage/detail/order/${o.accountID}" class="btn btn-primary text-white m-2" >Order Detail</a>
                                        <a href="/ShoeSense/admin/user/manage/detail/comment/${o.accountID}" class="btn btn-primary text-white m-2" >Comment Detail</a>
                                        <%                                                Account temp1 = (Account) request.getAttribute("account");

                                            if ("Active".equals(temp1.getAccountStatus())) {
                                        %>
                                        <a href="/ShoeSense/admin/user/manage/status/ban/${o.accountID}" onclick="return confirm('Bạn có chắc chắn muốn xóa nhân viên này không?')" class="btn btn-danger text-white m-2" name="delete" >Ban</a>
                                        <%
                                        } else {
                                        %>
                                        <a href="/ShoeSense/admin/user/manage/status/unban/${o.accountID}" onclick="return confirm('Bạn có chắc chắn muốn xóa nhân viên này không?')" class="btn btn-danger text-white m-2" name="delete" >Unbanned</a>
                                        <%
                                            }
                                        %>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.7.0.js"></script>
        <script src="https://cdn.datatables.net/1.13.7/js/jquery.dataTables.min.js"></script>
        <script>
                                            $(document).ready(function () {
                                                $("#example").DataTable();
                                            });
        </script>
        <script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
        <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
            crossorigin="anonymous"
        ></script>
    </body>
</html>


