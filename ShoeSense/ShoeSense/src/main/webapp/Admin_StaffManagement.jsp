<%-- 
    Document   : Admin_StaffManagement
    Created on : Jun 17, 2024, 7:17:33 AM
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
            href="https://cdn.datatables.net/1.13.7/css/jquery.dataTables.min.css"
            />
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
                height: 100vh;
                background-color: black;
                color: white;
            }

            .listcontent:hover{
                font-size: x-large;
                width: 250px;
                height: 100vh;
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
                    <div class="content" id="managestaff" style="width: 1270px">
                        <h1>Staff Management</h1>
                        <a class="btn btn-success m-2" id="btnaddstaff" >
                            <i class="fa fa-plus"></i> 
                            <span >Add New Staff</span>
                        </a>
                        <table id="example" style="width: 100%;">
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
                            <c:forEach items="${listStaff}" var="o">
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
                                    <td class="align-middle">
                                                                                <%                                                                                    Account temp1 = (Account) request.getAttribute("account");

                                            if ("Active".equals(temp1.getAccountStatus())) {
                                        %>
                                        <a href="/ShoeSense/admin/staff/manage/status/ban/${o.accountID}" onclick="return confirm('Are you sure about banning this staff?')" class="btn btn-danger text-white m-2" name="delete" >Ban</a>
                                        <%
                                        } else {
                                        %>
                                        <a href="/ShoeSense/admin/staff/manage/status/unban/${o.accountID}" onclick="return confirm('Are you sure about unbanning this staff?')" class="btn btn-danger text-white m-2" name="delete" >Unbanned</a>
                                        <%
                                            }
                                        %>
                                    </td>
                                    <td class="align-middle">
                                        <a href="/ShoeSense/admin/staff/manage/edit/${o.accountID}" class="btn btn-primary text-white m-2" ><i class="fas fa-pen"></i></a>
                                        <!--<a href="/ShoeSense/admin/staff/manage/delete/.." onclick="return confirm('Bạn có chắc chắn muốn xóa nhân viên này không?')" class="btn btn-danger text-white m-2" name="delete" ><i class="fa fa-trash p-1"></i></a>-->

                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <!-- Add staff -->
                <div id="addstaff" class="bg-white container p-5 mt-5 rounded-5" style="display: none;">
                    <div class="add product">
                        <form method="post" id="registerform" action="">
                            <h1 class="text-center">Add new staff</h1>
                            <%
                                String display = (String) request.getAttribute("display");
                                if (request.getAttribute("display") != null) {
                            %>
                            <p class="text-center" style="color: red;"><%= display%></p>
                            <%
                                }
                            %>
                            <div class="m-3">
                                <label class="form-label fw-bold">Email:</label>
                                <input id="email1" type="text" name="email" class="form-control" placeholder="Enter email">
                                <p id="emailerror1"></p>
                            </div>
                            <div class="m-3">
                                <label class="form-label fw-bold">Staffname:</label>
                                <input id="username" type="text" name="staffname" class="form-control" placeholder="Enter staffname">
                                <p id="usernameerror"></p>
                            </div>

                            <div class="m-3">
                                <label class="form-label fw-bold">Gender:</label>
                                <div id="gender" class="ratio-box">
                                    <input type="radio" id="male" name="gender" value="Male" class="form-check-input">
                                    <label for="male" class="form-check-label">Male</label>

                                    <input type="radio" id="female" name="gender" value="Female" class="form-check-input">
                                    <label for="female" class="form-check-label">Female</label>

                                    <input type="radio" id="other" name="gender" value="Other" class="form-check-input">
                                    <label for="other" class="form-check-label">Other</label>
                                </div>
                                <p id="gendererror"></p>
                            </div>

                            <div class="m-3">
                                <label class="form-label fw-bold">Password:</label>
                                <input id="password1" type="password" name="password" class="form-control"
                                       placeholder="Enter password">
                                <p id="passerror1"></p>
                            </div>
                            <div class="m-3">
                                <label class="form-label fw-bold">Confirm password:</label>
                                <input id="repassword" type="password" name="repassword" class="form-control"
                                       placeholder="Enter password again">
                                <p id="repasserror"></p>
                            </div>
                            <div class="m-3">
                                <label class="form-label fw-bold">Day of birth:</label>
                                <input id="birthday" type="date" name="birthday" class="form-control"
                                       placeholder="Enter your email">
                                <p id="birtherror"></p>
                            </div>
                            <div class="m-3">
                                <label class="form-label fw-bold">Phone number:</label>
                                <input id="phone" type="text" name="phone" class="form-control" placeholder="Enter phone number">
                                <p id="phoneerror"></p>
                            </div>
                            <div class="m-3">
                                <label class="form-label fw-bold">Address:</label>
                                <textarea id="address" name="address" cols="30" rows="5" class="form-control"
                                          placeholder="Enter address"></textarea>
                                <p id="addresserror"></p>
                            </div>
                            <div class="buttongroup text-center">
                                <input type="hidden" name="staffID" value="<%= session.getAttribute("id")%>">
                                <button type="submit"  value="Add" name="addNewStaff" id="btnadd" class="rounded-3" onclick="checkRegis()">Add</button>
                                <button type="reset" value="Cancel" id="btncancel" onclick="window.location.href = ''" class="rounded-3">Back</button>
                            </div>
                        </form>
                    </div>
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
        <script>

                                    var emailValidation1 = /^[A-z]+[^\@\s]+\@[^\s]+\.[^\s]{2,}$/;
                                    var emailValidation2 = /^[A-z]+\@[^\s]+\.[^\s]{2,}$/;
                                    var numberValidation = /^0+[0-9]{9,10}$/;

                                    function checkReset() {
                                        document.getElementById('emailerror').innerHTML = "";
                                        document.getElementById('emailerror1').innerHTML = "";
                                        document.getElementById('usernameerror').innerHTML = "";
                                        document.getElementById('gendererror').innerHTML = "";
                                        document.getElementById('passerror').innerHTML = "";
                                        document.getElementById('passerror1').innerHTML = "";
                                        document.getElementById('repasserror').innerHTML = "";
                                        document.getElementById('birtherror').innerHTML = "";
                                        document.getElementById('phoneerror').innerHTML = "";
                                        document.getElementById('addresserror').innerHTML = "";

                                    }
                                    function checkValidate() {
                                        checkEmailRegister();
                                        checkEmailLogin();
                                        checkUsername();
                                        checkPasswordLogin();
                                        checkPasswordRegister();
                                        checkBirthday();
                                        checkPhone();
                                        checkAddress();
                                    }


                                    function checkEmailLogin() {
                                        var email = document.getElementById('email').value;
                                        if (!emailValidation1.test(email) && !emailValidation2.test(email) && email == "") {

                                            return false;
                                        } else {
//            document.getElementById('emailerror').innerHTML = "";
                                            return true;
                                        }
                                    }


                                    function checkEmailRegister() {
                                        var email1 = document.getElementById('email1').value;
                                        if (email1 == "") {
//        document.getElementById('emailerror1').innerHTML = "Email cannot be empty";
//        document.getElementById('emailerror1').style.color = "red";
                                            return false;

                                        } else {
                                            if (!emailValidation1.test(email1) && !emailValidation2.test(email1)) {
//            document.getElementById('emailerror1').innerHTML = "Email is invalid";
//            document.getElementById('emailerror1').style.color = "red";
                                                return false;
                                            } else {
//            document.getElementById('emailerror1').innerHTML = "";
                                                return true;
                                            }
                                        }
                                    }

                                    function checkEmailEdit() {
                                        var email = document.getElementById('emailedit').value;
                                        if (email == "") {
//        document.getElementById('emailerror1').innerHTML = "Email cannot be empty";
//        document.getElementById('emailerror1').style.color = "red";
                                            return false;

                                        } else {
                                            if (!emailValidation1.test(email) && !emailValidation2.test(email)) {
//            document.getElementById('emailerror1').innerHTML = "Email is invalid";
//            document.getElementById('emailerror1').style.color = "red";
                                                return false;
                                            } else {
//            document.getElementById('emailerror1').innerHTML = "";
                                                return true;
                                            }
                                        }
                                    }

                                    function checkUsername() {
                                        var name = document.getElementById('username').value.trim();

                                        if (name == "") {
//        document.getElementById('usernameerror').innerHTML = "Username cannot be empty";
//        document.getElementById('usernameerror').style.color = "red";
                                            return false;
                                        } else {
//        document.getElementById('usernameerror').innerHTML = "";
                                            return true;
                                        }
                                    }

                                    function checkUsernameEdit() {
                                        var name = document.getElementById('usernameedit').value.trim();

                                        if (name == "") {
//        document.getElementById('usernameerror').innerHTML = "Username cannot be empty";
//        document.getElementById('usernameerror').style.color = "red";
                                            return false;
                                        } else {
//        document.getElementById('usernameerror').innerHTML = "";
                                            return true;
                                        }
                                    }

                                    function checkPasswordLogin() {
                                        var password = document.getElementById('password').value;

                                        if (password.length < 6 || password.length > 20 || password == "") {

                                            return false;
                                        } else {
//        document.getElementById('passerror').innerHTML = "";
                                            return true;
                                        }
                                    }

                                    function checkGender() {
                                        var genderRadios = document.getElementsByName('gender');
                                        var checked = false;

                                        for (var i = 0; i < genderRadios.length; i++) {
                                            if (genderRadios[i].checked) {
                                                checked = true;
                                                break;
                                            }
                                        }

                                        return checked;
                                    }

                                    function checkPasswordRegister() {
                                        var password = document.getElementById('password1').value;
                                        var repassword = document.getElementById('repassword').value;

                                        if (password.length < 6 || password.length > 20 || password == "") {
//        document.getElementById('passerror1').innerHTML = "Password must be between 6 and 20 characters";
//        document.getElementById('passerror1').style.color = "red";
                                            return false;
                                        } else {
//        document.getElementById('passerror1').innerHTML = "";
                                            return true;
                                        }
                                    }
                                    function checkRePassRegis() {
                                        var password = document.getElementById('password1').value;
                                        var repassword = document.getElementById('repassword').value;
                                        if (repassword != password) {
//        document.getElementById('repasserror').innerHTML = "Password does not match";
//        document.getElementById('repasserror').style.color = "red";
                                            return false;
                                        } else {
//        document.getElementById('repasserror').innerHTML = "";
                                            return true;
                                        }

                                    }

                                    function checkBirthday() {
                                        var birthday = document.getElementById('birthday').value;

                                        if (birthday === "") {
//        document.getElementById('birtherror').innerHTML = "Birthday cannot be empty";
//        document.getElementById('birtherror').style.color = "red";
                                            return false;

                                        } else {
//        document.getElementById('birtherror').innerHTML = "";
                                            return true;
                                        }
                                    }

                                    function checkBirthdayEdit() {
                                        var birthday = document.getElementById('birthdayedit').value;

                                        if (birthday === "") {
//        document.getElementById('birtherror').innerHTML = "Birthday cannot be empty";
//        document.getElementById('birtherror').style.color = "red";
                                            return false;

                                        } else {
//        document.getElementById('birtherror').innerHTML = "";
                                            return true;
                                        }
                                    }

                                    function checkPhone() {
                                        var phone = document.getElementById('phone').value;

                                        if (!numberValidation.test(phone)) {
//        document.getElementById('phoneerror').innerHTML = "Phone is invalid";
//        document.getElementById('phoneerror').style.color = "red";
                                            return false;
                                        } else {
//        document.getElementById('phoneerror').innerHTML = "";
                                            return true;
                                        }

                                    }

                                    function checkPhoneEdit() {
                                        var phone = document.getElementById('phoneedit').value;

                                        if (!numberValidation.test(phone)) {
//        document.getElementById('phoneerror').innerHTML = "Phone is invalid";
//        document.getElementById('phoneerror').style.color = "red";
                                            return false;
                                        } else {
//        document.getElementById('phoneerror').innerHTML = "";
                                            return true;
                                        }

                                    }

                                    function checkAddress() {
                                        var address = document.getElementById('address').value;
                                        var address = address.replace(/\s/g, '');
                                        if (address === "") {
//        document.getElementById('addresserror').innerHTML = " You have to provide your address";
//        document.getElementById('addresserror').style.color = "red";
                                            return false;
                                        } else {
//        document.getElementById('addresserror').innerHTML = "";
                                            return true;
                                        }
                                    }

                                    function checkAddressEdit() {
                                        var address = document.getElementById('addressedit').value;
                                        var address = address.replace(/\s/g, '');
                                        if (address === "") {
//        document.getElementById('addresserror').innerHTML = " You have to provide your address";
//        document.getElementById('addresserror').style.color = "red";
                                            return false;
                                        } else {
//        document.getElementById('addresserror').innerHTML = "";
                                            return true;
                                        }
                                    }

//validate login form
                                    function checkLogin() {
                                        let emailerror = document.getElementById('emailerror');
                                        let passerror = document.getElementById('passerror');
                                        let check = true;
                                        if (checkEmailLogin() == false) {
                                            check = false;
                                            emailerror.innerHTML = "Email is invalid";
                                            emailerror.style.color = "red";
                                        } else {
                                            emailerror.innerHTML = "";
                                        }

                                        if (checkPasswordLogin() == false) {
                                            passerror.innerHTML = "Password must be between 6 and 20 characters";
                                            passerror.style.color = "red";
                                            check = false;
                                        } else {
                                            passerror.innerHTML = "";
                                        }
                                        if (!check) {
                                            event.preventDefault();
                                        } else {
                                            window.location.href = "Login";
                                        }

                                    }

//validate register form
                                    function checkRegis() {
                                        let emailerror = document.getElementById('emailerror1');
                                        let passerror = document.getElementById('passerror1');
                                        let nameerror = document.getElementById('usernameerror');
                                        let gendererror = document.getElementById('gendererror');
                                        let repasserror = document.getElementById('repasserror');
                                        let birtherror = document.getElementById('birtherror');
                                        let phoneerror = document.getElementById('phoneerror');
//    let addresserror = document.getElementById('addresserror');

                                        let check = true;

                                        if (!checkEmailRegister()) {
                                            check = false;
                                            emailerror.innerHTML = "Email is invalid";
                                            emailerror.style.color = "red";
                                        } else {
                                            emailerror.innerHTML = "";
                                        }

                                        if (!checkUsername()) {
                                            check = false;
                                            nameerror.innerHTML = "Username cannot be empty";
                                            nameerror.style.color = "red";
                                        } else {
                                            nameerror.innerHTML = "";
                                        }

                                        if (!checkGender()) {
                                            check = false;
                                            gendererror.innerHTML = "Gender cannot be empty";
                                            gendererror.style.color = "red";
                                        } else {
                                            gendererror.innerHTML = "";
                                        }

                                        if (!checkPasswordRegister()) {
                                            check = false;
                                            passerror.innerHTML = "Password must be between 6 and 20 characters";
                                            passerror.style.color = "red";
                                        } else {
                                            passerror.innerHTML = "";
                                        }
                                        if (!checkRePassRegis()) {
                                            check = false;
                                            repasserror.innerHTML = "Password does not match";
                                            repasserror.style.color = "red";
                                        } else {
                                            repasserror.innerHTML = "";
                                        }
                                        if (!checkBirthday()) {
                                            check = false;
                                            birtherror.innerHTML = "Birthday cannot be empty";
                                            birtherror.style.color = "red";
                                        } else {
                                            birtherror.innerHTML = "";
                                        }
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

                                        if (!check) {
                                            event.preventDefault();
                                        } else {
                                            window.location.href = "login";
                                        }

                                    }

//validate edit form
                                    function checkEdit() {
                                        let emailerror = document.getElementById('emailediterror');
                                        let nameerror = document.getElementById('usernameediterror');
                                        let birtherror = document.getElementById('birthediterror');
                                        let phoneerror = document.getElementById('phoneediterror');
                                        let addresserror = document.getElementById('addressediterror');
                                        let check = true;

                                        if (!checkEmailEdit()) {
                                            check = false;
                                            emailerror.innerHTML = "Email is invalid";
                                            emailerror.style.color = "red";
                                        } else {
                                            emailerror.innerHTML = "";
                                        }

                                        if (!checkUsernameEdit()) {
                                            check = false;
                                            nameerror.innerHTML = "Username cannot be empty";
                                            nameerror.style.color = "red";
                                        } else {
                                            nameerror.innerHTML = "";
                                        }

                                        if (!checkBirthdayEdit()) {
                                            check = false;
                                            birtherror.innerHTML = "Birthday cannot be empty";
                                            birtherror.style.color = "red";
                                        } else {
                                            birtherror.innerHTML = "";
                                        }
                                        if (!checkPhoneEdit()) {
                                            check = false;
                                            phoneerror.innerHTML = "Phone is invalid";
                                            phoneerror.style.color = "red";
                                        } else {
                                            phoneerror.innerHTML = "";
                                        }
                                        if (!checkAddressEdit()) {
                                            check = false;
                                            addresserror.innerHTML = "You have to provide your address";
                                            addresserror.style.color = "red";
                                        } else {
                                            addresserror.innerHTML = "";
                                        }

                                        if (!check) {
                                            event.preventDefault();
                                        } else {
                                            window.location.href = "User";
                                        }
                                    }

                                    function checkoldpass() {
                                        var oldpass1 = document.getElementById('oldpass').value;
                                        var oldpass2 = document.getElementById('oldpasscheck').value;

                                        if (oldpass1 === oldpass2) {
                                            return true;
                                        } else {
                                            return false;
                                        }
                                    }

                                    function checkNewpass() {
                                        var newpass = document.getElementById('newpass').value;

                                        if (newpass.length < 6 || newpass.length > 20 || newpass == "") {
                                            return false;
                                        } else {
                                            return true;
                                        }

                                    }

                                    function checkReNewpass() {
                                        var newpass1 = document.getElementById('newpass').value;
                                        var newpass2 = document.getElementById('renewpass').value;
                                        if (newpass1 !== newpass2) {
                                            return false;
                                        } else {
                                            return true;
                                        }
                                    }



        </script>
        <script>
            const manage = document.getElementById("managestaff");
            const add = document.getElementById("addstaff");
            const btnadd = document.getElementById("btnaddstaff");
            var btncancel = document.getElementById("btncancel");

            btnadd.addEventListener("click", function () {
                add.style.display = "block";
                manage.style.display = "none";
            });

            btncancel.addEventListener("click", function () {
                location.reload();
            });
        </script>
        <%
            if (request.getAttribute("display") != null) {
        %>
        <script>
            const divContent1 = document.getElementById("addstaff");
            const divProfile = document.getElementById("managestaff");
            divContent1.style.display = "block";
            divProfile.style.display = "none";
        </script>
        <%
            }
        %>
    </body>
</html>



