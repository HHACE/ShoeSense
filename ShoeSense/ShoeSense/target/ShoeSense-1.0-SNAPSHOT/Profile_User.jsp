<%-- 
    Document   : Profile_User
    Created on : Jun 11, 2024, 6:03:33 PM
    Author     : ADMIN
--%>

<%@page import="DAOs.AccountDAO"%>
<%@page import="java.text.ParseException"%>
<%@page import="java.sql.Date"%>
<%@page import="Modals.Account"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile Page</title>
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

<!-- Font Awesome CSS (optional, for icons) -->
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

            #showedit, #showchangepass, #editbtn, #changepassbtn, #backbtn, #backbtn1 {
                background-color: rgb(49, 49, 49);
                border: 1px solid rgb(0, 0, 0);
                color: white;
            }

            #showedit:active, #showchangepass:active, #editbtn:active, #changepassbtn:active, #backbtn:active, #backbtn1:active {
                background-color: white;
                color: black;
            }
        </style>
    </head>
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
                if (!flag) {
                    response.sendRedirect("/ShoeSense/Login");
                }
            }
            Account u = (Account) session.getAttribute("thongtinnguoidung");
        %>
        <jsp:include page="Header_User.jsp"></jsp:include>
        <div class="container mt-5" style="margin-bottom: 55px">
            <div class="row">
                <div class="col-md-8 offset-md-2">
                    <div class="card">
                        <div class="card-header">
                            <h3 class="text-center">Profile</h3>
                        </div>
                        <div class="card-body">
                            <div id="profile">
                                <div class="mb-3 row">
                                    <label class="col-sm-4 col-form-label">Email:</label>
                                    <div class="col-sm-8">
                                        <p class="form-control-plaintext"><%= u.getAccountEmail() %></p>
                                    </div>
                                </div>
                                <div class="mb-3 row">
                                    <label class="col-sm-4 col-form-label">User name:</label>
                                    <div class="col-sm-8">
                                        <p class="form-control-plaintext"><%= u.getAccountName() %></p>
                                    </div>
                                </div>
                                <div class="mb-3 row">
                                    <label class="col-sm-4 col-form-label">Gender:</label>
                                    <div class="col-sm-8">
                                        <p class="form-control-plaintext"><%= u.getAccountGender() %></p>
                                    </div>
                                </div>
                                <div class="mb-3 row">
                                    <label class="col-sm-4 col-form-label">Day of birth:</label>
                                    <div class="col-sm-8">
                                        <p class="form-control-plaintext">
                                            <%
                                                SimpleDateFormat oldFormat = new SimpleDateFormat("yyyy-MM-dd");
                                                SimpleDateFormat newFormat = new SimpleDateFormat("dd-MM-yyyy");
                                                String formattedDateOfBirth = newFormat.format(u.getAccountBirthdate());
                                            %>
                                            <%= formattedDateOfBirth %>
                                        </p>
                                    </div>
                                </div>
                                <div class="mb-3 row">
                                    <label class="col-sm-4 col-form-label">Phone number:</label>
                                    <div class="col-sm-8">
                                        <p class="form-control-plaintext"><%= u.getAccountPhone() %></p>
                                    </div>
                                </div>
                                <div class="mb-3 row">
                                    <label class="col-sm-4 col-form-label">Address:</label>
                                    <div class="col-sm-8">
                                        <p class="form-control-plaintext"><%= u.getAccountAddress() %></p>
                                    </div>
                                </div>
                                <div class="text-center">
                                    <button class="btn btn-primary me-2" id="showedit">Edit</button>
                                    <button class="btn btn-secondary" id="showchangepass">Change Pass</button>
                                </div>
                            </div>
                            <div id="editprofile" style="display: none;">
                                <form action="<%= session.getAttribute("id") %>" method="post" id="editUser" class="p-3">
                                    <h4 class="mb-3">Edit Profile</h4>
                                    <input type="hidden" name="id" value="<%= u.getAccountID() %>">
                                    <div class="mb-3">
                                        <label class="form-label">Username:</label>
                                        <input id="username" type="text" name="username" class="form-control" value="<%= u.getAccountName() %>">
                                        <p id="usernameerror" class="text-danger"></p>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Gender:</label>
                                        <div>
                                            <input type="radio" id="male" name="gender" value="Male" class="form-check-input" <%= u.getAccountGender().equals("Male") ? "checked" : "" %> >
                                            <label for="male" class="form-check-label">Male</label>
                                            <input type="radio" id="female" name="gender" value="Female" class="form-check-input" <%= u.getAccountGender().equals("Female") ? "checked" : "" %> >
                                            <label for="female" class="form-check-label">Female</label>
                                            <input type="radio" id="other" name="gender" value="Other" class="form-check-input" <%= u.getAccountGender().equals("Other") ? "checked" : "" %> >
                                            <label for="other" class="form-check-label">Other</label>
                                        </div>
                                        <p id="gendererror" class="text-danger"></p>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Day of Birth:</label>
                                        <input id="birthday" type="date" name="birthday" class="form-control" value="<%= u.getAccountBirthdate() %>">
                                        <p id="birtherror" class="text-danger"></p>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Phone Number:</label>
                                        <input id="phone" type="text" name="phone" class="form-control" value="<%= u.getAccountPhone() %>">
                                        <p id="phoneerror" class="text-danger"></p>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Address:</label>
                                        <textarea id="address" name="address" class="form-control"><%= u.getAccountAddress() %></textarea>
                                        <p id="addresserror" class="text-danger"></p>
                                    </div>
                                    <div class="text-center">
                                        <button type="submit" onclick="checkEdit()" class="btn btn-primary me-2" id="editbtn" name="editbtn">Edit</button>
                                        <button type="button" class="btn btn-secondary" id="backbtn">Back</button>
                                    </div>
                                </form>
                            </div>
                            <div id="changepass" style="display: none;">
                                <form method="post" action="<%= session.getAttribute("id") %>" class="p-3">
                                    <h4 class="mb-3">Change Password</h4>
                                    <div class="mb-3">
                                        <label class="form-label">Old Password:</label>
                                        <input id="oldpass" type="password" name="oldpass" class="form-control">
                                        <p id="oldpasserror" class="text-danger"></p>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">New Password:</label>
                                        <input id="newpass" type="password" name="newpass" class="form-control">
                                        <p id="newpasserror" class="text-danger"></p>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Confirm Password:</label>
                                        <input id="renewpass" type="password" name="renewpass" class="form-control">
                                        <p id="renewpasserror" class="text-danger"></p>
                                    </div>
                                    <div class="text-center">
                                        <button type="submit" onclick="checkChangePass()" class="btn btn-primary me-2" id="changepassbtn" name="changepassbtn">Change Pass</button>
                                        <button type="button" class="btn btn-secondary" id="backbtn1">Back</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="Footer.jsp"></jsp:include>

                
        <script>
            document.getElementById("showedit").addEventListener("click", function () {
                document.getElementById("profile").style.display = "none";
                document.getElementById("editprofile").style.display = "block";
                document.getElementById("changepass").style.display = "none";
            });

            document.getElementById("showchangepass").addEventListener("click", function () {
                document.getElementById("profile").style.display = "none";
                document.getElementById("editprofile").style.display = "none";
                document.getElementById("changepass").style.display = "block";
            });

            document.getElementById("backbtn").addEventListener("click", function () {
                document.getElementById("profile").style.display = "block";
                document.getElementById("editprofile").style.display = "none";
                document.getElementById("changepass").style.display = "none";
            });

            document.getElementById("backbtn1").addEventListener("click", function () {
                document.getElementById("profile").style.display = "block";
                document.getElementById("editprofile").style.display = "none";
                document.getElementById("changepass").style.display = "none";
            });

            function checkEdit() {
                var error = false;
                var username = document.getElementById("username").value;
                var gender = document.querySelector('input[name="gender"]:checked');
                var birthday = document.getElementById("birthday").value;
                var phone = document.getElementById("phone").value;
                var address = document.getElementById("address").value;

                if (username == "") {
                    document.getElementById("usernameerror").innerHTML = "Please enter your username";
                    error = true;
                } else {
                    document.getElementById("usernameerror").innerHTML = "";
                }

                if (gender == null) {
                    document.getElementById("gendererror").innerHTML = "Please select your gender";
                    error = true;
                } else {
                    document.getElementById("gendererror").innerHTML = "";
                }

                if (birthday == "") {
                    document.getElementById("birtherror").innerHTML = "Please enter your birthdate";
                    error = true;
                } else {
                    document.getElementById("birtherror").innerHTML = "";
                }

                if (phone == "") {
                    document.getElementById("phoneerror").innerHTML = "Please enter your phone number";
                    error = true;
                } else {
                    document.getElementById("phoneerror").innerHTML = "";
                }

                if (address == "") {
                    document.getElementById("addresserror").innerHTML = "Please enter your address";
                    error = true;
                } else {
                    document.getElementById("addresserror").innerHTML = "";
                }

                if (error) {
                    event.preventDefault();
                }
            }

            function checkChangePass() {
                var error = false;
                var oldpass = document.getElementById("oldpass").value;
                var newpass = document.getElementById("newpass").value;
                var renewpass = document.getElementById("renewpass").value;

                if (oldpass == "") {
                    document.getElementById("oldpasserror").innerHTML = "Please enter your old password";
                    error = true;
                } else {
                    document.getElementById("oldpasserror").innerHTML = "";
                }

                if (newpass == "") {
                    document.getElementById("newpasserror").innerHTML = "Please enter your new password";
                    error = true;
                } else {
                    document.getElementById("newpasserror").innerHTML = "";
                }

                if (renewpass == "") {
                    document.getElementById("renewpasserror").innerHTML = "Please confirm your new password";
                    error = true;
                } else if (newpass != renewpass) {
                    document.getElementById("renewpasserror").innerHTML = "Passwords do not match";
                    error = true;
                } else {
                    document.getElementById("renewpasserror").innerHTML = "";
                }

                if (error) {
                    event.preventDefault();
                }
            }
        </script>

<script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>

    </body>
</html>
