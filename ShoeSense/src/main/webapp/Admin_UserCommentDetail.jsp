<%-- 
    Document   : Admin_UserCommentDetail
    Created on : Jul 5, 2024, 10:03:10 PM
    Author     : ADMIN
--%>
<%@page import="DAOs.ProductDAO"%>
<%@page import="Modals.Product"%>
<%@page import="Modals.Comment"%>
<%@page import="java.util.List"%>
<%@page import="DAOs.CommentDAO"%>
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

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://code.jquery.com/jquery-3.7.0.js"></script>
        <script src="https://cdn.datatables.net/1.13.7/js/jquery.dataTables.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
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
        <a href="" class="navbar ps-5">
            ShoeSense - ADMIN
        </a>
        <div class="main-body">
            <jsp:include page="Header_Admin.jsp"></jsp:include>
                <div class="body">
                    <div id="manageproduct" class="manageproduct">
                        <h2>Comment management</h2>



                        <table id="example" >
                            <thead>
                                <tr>
                                    <th>CommentID</th>
                                    <th>ProductID</th>
                                    <th>Product Name</th>
                                    <th>AccountID</th>
                                    <th>Account Name</th>
                                    <th>Content</th>
                                    <th>Created Date</th>
                                    <th>Status</th>
                                    <th></th>

                                </tr>
                            </thead>
                            <tbody id="data">
                            <%                          int userID = (int) request.getAttribute("userID");
                                ProductDAO dao = new ProductDAO();
                                CommentDAO cdao = new CommentDAO();
                                AccountDAO adao2 = new AccountDAO();
                                List<Comment> lc = cdao.getAllCommentByAccountID(userID);

                                for (Comment com : lc) {
                                    Product pro = dao.getProductById(com.getProductID());
                                    Account acc = adao2.GetAccountById(Integer.toString(com.getAccountID()));

                            %>
                            <tr>
                                <td><%= com.getCommentID()%></td>
                                <td><%= com.getProductID()%></td>
                                <td><%= pro.getProductName()%></td>
                                <td><%= com.getAccountID()%></td>
                                <td><%= acc.getAccountName()%></td>
                                <td><%= com.getContent()%></td>
                                <td><%= com.getCreatedDate()%></td>
                                <td><%= com.getCommentStatus()%></td>
                                <td>

                                    <form method="post" action="">
                                        <input value="<%= com.getCommentID()%>" name="commentID" id="commentID"  type="hidden">
                                        <%
                                            if (com.getCommentStatus().equalsIgnoreCase("Public")) {
                                        %>
                                        <button type="submit" name="btnHide" id="btnHide" class="btn btn-danger m-2">Hide</button>
                                        <%
                                        } else {
                                        %>
                                        <button type="submit" name="btnPublic" id="btnPublic" class="btn btn-danger m-2">Public</button>
                                        <%
                                            }
                                        %>

                                    </form>

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