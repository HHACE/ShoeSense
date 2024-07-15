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
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">


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

            #showedit {
                background-color: rgb(49, 49, 49);
                border: 1px solid rgb(0, 0, 0);
                color: white;
            }

            #showedit:active {
                background-color:white;
                color: black;
            }

            #showchangepass {
                background-color: rgb(49, 49, 49);
                border: 1px solid rgb(0, 0, 0);
                color: white;
            }

            #showchangepass:active {
                background-color:white;
                color: black;
            }

            #editbtn {
                background-color: rgb(49, 49, 49);
                border: 1px solid rgb(0, 0, 0);
                color: white;
            }

            #editbtn:active {
                background-color:white;
                color: black;
            }

            #changepassbtn {
                background-color: rgb(49, 49, 49);
                border: 1px solid rgb(0, 0, 0);
                color: white;
            }

            #changepassbtn:active {
                background-color:white;
                color: black;
            }

            #backbtn {
                background-color: rgb(49, 49, 49);
                border: 1px solid rgb(0, 0, 0);
                color: white;
            }

            #backbtn:active {
                background-color:white;
                color: black;
            }

            #backbtn1 {
                background-color: rgb(49, 49, 49);
                border: 1px solid rgb(0, 0, 0);
                color: white;
            }

            #backbtn1:active {
                background-color:white;
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
                
//                            if (!temp.getAccountRole().equals("User")) {
//                 flag = false;
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
                    response.sendRedirect("/ShoeSense/Login");
                }
            }

            Account u = (Account) session.getAttribute("thongtinnguoidung");

        %>

        <jsp:include page="Header_User.jsp"></jsp:include>
        
        <!--Body home page-->
        <div class="container p-5">
            <div class="user-detail bg-white p-5">
                <div class="container">
                    <div>
                        <h3 class="m-3">Profile</h3>
                        <hr/>
                        <div class="row p-3 bg-body-tertiary rounded-5" id="profile">
                            <div class="col-9">
                                <div class="row m-3">
                                    <label class="col-3 fs-4 fw-bold">Email</label>
                                    <span class="col-8 fs-4"><%= u.getAccountEmail()%></span>
                                </div>
                                <div class="row m-3">
                                    <label class="col-3 fs-4 fw-bold">User name</label>
                                    <span class="col-8 fs-4"><%= u.getAccountName()%></span>
                                </div>
                                <div class="row m-3">
                                    <label class="col-3 fs-4 fw-bold">Gender</label>
                                    <span class="col-8 fs-4"><%= u.getAccountGender()%></span>
                                </div>
                                <div class="row m-3">
                                    <label class="col-3 fs-4 fw-bold">Day of birth</label>
                                    <span class="col-8 fs-4">
                                        <%
                                            SimpleDateFormat oldFormat = new SimpleDateFormat("yyyy-MM-dd");
                                            SimpleDateFormat newFormat = new SimpleDateFormat("dd-MM-yyyy");
//                                            Date dateOfBirth = u.getAccountBirthdate();
                                            String formattedDateOfBirth = newFormat.format(u.getAccountBirthdate());

                                        %>
                                        <%= formattedDateOfBirth%>
                                    </span>
                                </div>
                                <div class="row m-3">
                                    <label class="col-3 fs-4 fw-bold">Phone number</label>
                                    <span class="col-8 fs-4"><%= u.getAccountPhone()%></span>
                                </div>
                                                                <div class="row m-3">
                                    <label class="col-3 fs-4 fw-bold">Address</label>
                                    <span class="col-8 fs-4"><%= u.getAccountAddress()%></span>
                                </div>
                            </div>
                            <div class="col-3">
                                <button class="fs-4 p-2 m-3 rounded-3" id="showedit">Edit</button>
                                <button class="fs-4 p-2 m-3 rounded-3" id="showchangepass" >Change Pass</button>
                            </div>
                        </div>
                    </div>

                    <div class="row" id="editprofile" style="display: none;">
                        <!--------------------------->
                        <form action="<%=session.getAttribute("id")%>" method="post" id="editUser"  class="container p-3 bg-body-tertiary rounded-5" >
                            <h3 class="m-3">Edit profile</h3>
                            <div class="m-3">
                                <input type="hidden" name="id" value="<%= u.getAccountID()%>">
                            </div>
                            <div class="m-3">
                                <label class="form-label fw-bold">Username:</label>
                                <input id="username" type="text" name="username" class="form-control"
                                       placeholder="Enter username" value="<%= u.getAccountName()%>">
                                <p id="usernameerror"></p>
                            </div>
                          
                            <div class="m-3">
                                <label class="form-label fw-bold">Gender:</label>
                                <div id="gender" class="ratio-box">
                                    <input type="radio" id="male" name="gender" value="Male" class="form-check-input"
                                           <%= u.getAccountGender().equals("Male") ? "checked" : ""%> >
                                    <label for="male" class="form-check-label">Male</label>

                                    <input type="radio" id="female" name="gender" value="Female" class="form-check-input"
                                           <%= u.getAccountGender().equals("Female") ? "checked" : ""%> >
                                    <label for="female" class="form-check-label">Female</label>

                                    <input type="radio" id="other" name="gender" value="Other" class="form-check-input"
                                           <%= u.getAccountGender().equals("Other") ? "checked" : ""%> >
                                    <label for="other" class="form-check-label">Other</label>
                                </div>
                                <p id="gendererror"></p>
                            </div>
                          
                            <div class="m-3">
                                <label class="form-label fw-bold">Day of birth:</label>
                                <input id="birthday" type="date" name="birthday" class="form-control"
                                       value="<%= u.getAccountBirthdate()%>">
                                <p id="birtherror"></p>
                            </div>
                            <div class="m-3">
                                <label class="form-label fw-bold">Phone number:</label>
                                <input id="phone" type="text" name="phone" class="form-control"
                                       placeholder="Enter phone number" value="<%= u.getAccountPhone()%>">
                                <p id="phoneerror"></p>
                            </div>
                                                            <div class="m-3">
                                <label class="form-label fw-bold">Address:</label>
                                <textarea id="address" name="address"
                                          class="form-control" placeholder="Enter address"><%= u.getAccountAddress()%></textarea>
                                <p id="addresserror"></p>
                            </div>
                            <div class="m-3" align="center">
                                <button type="submit" onclick="checkEdit()" class="fs-4 rounded-5 ps-3 pe-3" id="editbtn" name="editbtn" value="edit" >Edit</button>
                                <button type="button" class="fs-4 rounded-5 ps-3 pe-3" id="backbtn">Back</button>
                            </div>
                        </form>
                    </div>


                    <div class="row" id="changepass" style="display: none;">
                        <form method="post" action="<%=session.getAttribute("id")%>"  class="container p-3 bg-body-tertiary rounded-5">
                            <h3 class="m-3">Change password</h3>
                            <div class="m-3">
                                <label class="form-label fw-bold">Old password:</label>
                                <input id="oldpass" type="password" name="oldpass" class="form-control"
                                       placeholder="Enter old password">
                                <input type="hidden" name="id" value="<%= u.getAccountID()%>">
                                <p id="oldpasserror"></p>
                            </div>
                            <div class="m-3">
                                <label class="form-label fw-bold">New password:</label>
                                <input id="newpass" type="password" name="newpass" class="form-control"
                                       placeholder="Enter new password">
                                <p id="newpasserror"></p>
                            </div>
                            <div class="m-3">
                                <label class="form-label fw-bold">Confirm new password:</label>
                                <input id="renewpass" type="password" name="renewpass" class="form-control"
                                       placeholder="Enter new password again">
                                <p id="renewpasserror"></p>
                            </div>
                            <div class="text-center">
                                <button type="submit" name="changepassbtn" id="changepassbtn" class="fs-4 rounded-5 ps-3 pe-3" onclick="checkChangePass()">Change Password</button>
                                <button type="button" class="fs-4 rounded-5 ps-3 pe-3" id="backbtn1">Back</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
     
                                <jsp:include page="Footer.jsp"></jsp:include>
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

        <jsp:include page="Footer.jsp"></jsp:include>
    </body>
</html>
