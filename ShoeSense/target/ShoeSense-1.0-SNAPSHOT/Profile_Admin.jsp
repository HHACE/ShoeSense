<%-- 
    Document   : Profile_Staff_Admin
    Created on : Jun 17, 2024, 10:30:01 AM
    Author     : ADMIN
--%>

<%@page import="DAOs.AccountDAO"%>
<%@page import="java.text.ParseException"%>
<%@page import="java.sql.Date"%>
<%@page import="Modals.Account"%>
<%@page import="java.text.SimpleDateFormat"%>
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
                
//                            if (temp.getAccountRole().equals("User")) {
//                 response.sendRedirect("/ShoeSense/user/profile/"+temp.getAccountID());
//            }
                
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
                
//                                           if (!temp.getAccountRole().equals("User")) {
//                 flag = false;
//            }
                
                if (!flag) {
                    response.sendRedirect("/ShoeSense/login");
                }
            }

            Account u = (Account) session.getAttribute("thongtinnguoidung");

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
        
        
        <!--Body home page-->
        <div class="container p-5">
    <div class="user-detail bg-white p-5">
        <div class="container">
            <div>
                <h3 class="m-3">My Profile</h3>
                <hr/>
                <div class="row p-3 bg-body-tertiary rounded-5" id="profile">
                    <div class="col-md-9">
                        <div class="row m-3">
                            <label class="col-4 col-md-3 fs-5 fw-bold">Email:</label>
                            <span class="col fs-5"><%= u.getAccountEmail()%></span>
                        </div>
                        <div class="row m-3">
                            <label class="col-4 col-md-3 fs-5 fw-bold">Username:</label>
                            <span class="col fs-5"><%= u.getAccountName()%></span>
                        </div>
                        <div class="row m-3">
                            <label class="col-4 col-md-3 fs-5 fw-bold">Gender:</label>
                            <span class="col fs-5"><%= u.getAccountGender()%></span>
                        </div>
                        <div class="row m-3">
                            <label class="col-4 col-md-3 fs-5 fw-bold">Day of Birth:</label>
                            <span class="col fs-5">
                                <% SimpleDateFormat oldFormat = new SimpleDateFormat("yyyy-MM-dd");
                                   SimpleDateFormat newFormat = new SimpleDateFormat("dd-MM-yyyy");
//                                   Date dateOfBirth = u.getAccountBirthdate();
                                   String formattedDateOfBirth = newFormat.format(u.getAccountBirthdate());
                                %>
                                <%= formattedDateOfBirth %>
                            </span>
                        </div>
                        <div class="row m-3">
                            <label class="col-4 col-md-3 fs-5 fw-bold">Phone Number:</label>
                            <span class="col fs-5"><%= u.getAccountPhone()%></span>
                        </div>
                        <div class="row m-3">
                            <label class="col-4 col-md-3 fs-5 fw-bold">Address:</label>
                            <span class="col fs-5"><%= u.getAccountAddress()%></span>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <button class="btn btn-primary fs-5 p-2 m-3 rounded-3" id="showedit">Edit Profile</button>
                        <button class="btn btn-primary fs-5 p-2 m-3 rounded-3" id="showchangepass">Change Password</button>
                    </div>
                </div>
            </div>

            <div class="row" id="editprofile" style="display: none;">
                <form action="<%= session.getAttribute("id") %>" method="post" id="editUser" class="container p-3 bg-body-tertiary rounded-5">
                    <h3 class="m-3">Edit Profile</h3>
                    <input type="hidden" name="id" value="<%= u.getAccountID()%>">
                    <div class="mb-3">
                        <label class="form-label fw-bold">Username:</label>
                        <input id="username" type="text" name="username" class="form-control" placeholder="Enter username" value="<%= u.getAccountName()%>">
                        <p id="usernameerror"></p>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-bold">Gender:</label>
                        <div id="gender" class="ratio-box">
                            <input type="radio" id="male" name="gender" value="Male" class="form-check-input" <%= u.getAccountGender().equals("Male") ? "checked" : ""%> >
                            <label for="male" class="form-check-label">Male</label>
                            <input type="radio" id="female" name="gender" value="Female" class="form-check-input" <%= u.getAccountGender().equals("Female") ? "checked" : ""%> >
                            <label for="female" class="form-check-label">Female</label>
                            <input type="radio" id="other" name="gender" value="Other" class="form-check-input" <%= u.getAccountGender().equals("Other") ? "checked" : ""%> >
                            <label for="other" class="form-check-label">Other</label>
                        </div>
                        <p id="gendererror"></p>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-bold">Day of Birth:</label>
                        <input id="birthday" type="date" name="birthday" class="form-control" value="<%= u.getAccountBirthdate()%>">
                        <p id="birtherror"></p>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-bold">Phone Number:</label>
                        <input id="phone" type="text" name="phone" class="form-control" placeholder="Enter phone number" value="<%= u.getAccountPhone()%>">
                        <p id="phoneerror"></p>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-bold">Address:</label>
                        <textarea id="address" name="address" class="form-control" placeholder="Enter address"><%= u.getAccountAddress()%></textarea>
                        <p id="addresserror"></p>
                    </div>
                    <div class="text-center">
                        <button type="submit" onclick="checkEdit()" class="btn btn-primary fs-5 rounded-5 ps-3 pe-3" id="editbtn" name="editbtn" value="edit">Edit</button>
                        <button type="button" class="btn btn-primary fs-5 rounded-5 ps-3 pe-3" id="backbtn">Back</button>
                    </div>
                </form>
            </div>

            <div class="row" id="changepass" style="display: none;">
                <form method="post" action="<%= session.getAttribute("id") %>" class="container p-3 bg-body-tertiary rounded-5">
                    <h3 class="m-3">Change Password</h3>
                    <div class="mb-3">
                        <label class="form-label fw-bold">Old Password:</label>
                        <input id="oldpass" type="password" name="oldpass" class="form-control" placeholder="Enter old password">
                        <input type="hidden" name="id" value="<%= u.getAccountID()%>">
                        <p id="oldpasserror"></p>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-bold">New Password:</label>
                        <input id="newpass" type="password" name="newpass" class="form-control" placeholder="Enter new password">
                        <p id="newpasserror"></p>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-bold">Confirm New Password:</label>
                        <input id="renewpass" type="password" name="renewpass" class="form-control" placeholder="Enter new password again">
                        <p id="renewpasserror"></p>
                    </div>
                    <div class="text-center">
                        <button type="submit" name="changepassbtn" id="changepassbtn" class="btn btn-primary fs-5 rounded-5 ps-3 pe-3" onclick="checkChangePass()">Change Password</button>
                        <button type="button" class="btn btn-primary fs-5 rounded-5 ps-3 pe-3" id="backbtn1">Back</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

     </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
        crossorigin="anonymous"></script>
        <%
            if (request.getAttribute("display") != null) {
        %>
        <script>
                                    const divContent1 = document.getElementById("changepass");
                                    const divProfile = document.getElementById("profile");
                                    divContent1.style.display = "block";
                                    divProfile.style.display = "none";
        </script>
        <%
            }
        %>
        
        
        
        <script>
            const btnShow = document.getElementById("showedit");
            const btnShowChangepass = document.getElementById("showchangepass");
            const btnBack = document.getElementById("backbtn");
            const btnBack1 = document.getElementById("backbtn1");
            const divContent = document.getElementById("editprofile");
            const divContent1 = document.getElementById("changepass");
            const divProfile = document.getElementById("profile");


            btnShow.addEventListener("click", function () {
                divContent.style.display = "block";
                divProfile.style.display = "none";
            });

            btnShowChangepass.addEventListener("click", function () {
                divContent1.style.display = "block";
                divProfile.style.display = "none";
            });


            btnBack.addEventListener("click", function () {
                window.location.reload(true);
            });

            btnBack1.addEventListener("click", function () {
                window.location.reload(true);
            });

var emailValidation1 = /^[A-z]+[^\@\s]+\@[^\s]+\.[^\s]{2,}$/;
var emailValidation2 = /^[A-z]+\@[^\s]+\.[^\s]{2,}$/;
var numberValidation = /^0+[0-9]{9,10}$/;

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

function checkOldPass() {
    var oldpass = document.getElementById('oldpass').value.trim();

    if (oldpass === "") {
//        document.getElementById('usernameerror').innerHTML = "Username cannot be empty";
//        document.getElementById('usernameerror').style.color = "red";
        return false;
    } else {
//        document.getElementById('usernameerror').innerHTML = "";
        return true;
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


//validate change password
function checkChangePass() {
    let oldpasserror = document.getElementById('oldpasserror');
    let newpasserror = document.getElementById('newpasserror');
    let renewpasserror = document.getElementById('renewpasserror');
    let check = true;

    if(!checkOldPass()){
        check = false;
        oldpasserror.innerHTML = "Enter your password";
        oldpasserror.style.color = "red";
    } else {
        oldpasserror.innerHTML = "";
    }

    if(!checkNewpass()){
        check = false;
        newpasserror.innerHTML = "Password must be between 6 and 20 characters";
        newpasserror.style.color = "red";
    } else {
        newpasserror.innerHTML = "";
    }
    
    if(!checkReNewpass()){
        check = false;
        renewpasserror.innerHTML = "Password does not match";
        renewpasserror.style.color = "red";
    } else {
        renewpasserror.innerHTML = "";
    }
   

    if (!check) {
        event.preventDefault();
    } else {
        window.location.href = "";
    }
}

//validate edit form
function checkEdit() {
    let nameerror = document.getElementById('usernameerror');
    let birtherror = document.getElementById('birtherror');
    let phoneerror = document.getElementById('phoneerror');
//    let addresserror = document.getElementById('addresserror');
    let check = true;

    if (!checkUsername()) {
        check = false;
        
        nameerror.innerHTML = "Username cannot be empty";
        nameerror.style.color = "red";
    } else {
        nameerror.innerHTML = "";
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
        window.location.href = "";
    }
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
