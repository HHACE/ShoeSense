<%-- 
    Document   : Login
    Created on : Jun 5, 2024, 12:45:20 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

    </head>
    <body>
        <jsp:include page="Header_User.jsp"></jsp:include>
        
 
        
          <div class="container">
            <div class="row justify-content-around">
                <!--Form Login-->
                <form method="post" action="login" id="loginform" class="col-6 p-3 m-5 bg-body-tertiary rounded-5">
                    <h1 class="text-center">Login</h1>
                    <div class="m-3">
                        <label class="form-label fw-bold">Email:</label>
                        <input id="email" type="text" name="email1" class="form-control" placeholder="Enter email">
                        <p id="emailerror"></p>
                    </div>
                    <div class="m-3">
                        <label class="form-label fw-bold">Password:</label>
                        <input id="password" type="password" name="password" class="form-control"
                               placeholder="Enter password">
                        <p id="passerror"></p>
                    </div>

                    <div class="text-center m-2">
                        <a class="link-dark" href="/ShoeSense/forgotpass" style="text-decoration: underline">Forgot password</a> <br>
                    </div>
                    <div class="text-center">
                        <button type="submit"
                                class="btn btn-dark fw-bold rounded-5" name="btnLogin" onclick="checkLogin()" value="login">Login</button>
<!--                        <button type="reset" onclick="checkReset()"
                                class="btn btn-secondary fw-bold rounded-5">Reset</button>-->
                        <button onclick="window.location.href = 'register'" id="RegisterButton" type="button"
                                    class="btn btn-secondary fw-bold rounded-5">Register</button>
                    </div>
                </form>
                </div>
              </div>
        
        
        
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
        crossorigin="anonymous"></script>
        
         <script>
//            window.addEventListener('load', () => {
//    var loadingscreen = document.querySelector('.loader');
//    if (loadingscreen) {
//        loadingscreen.classList.add("loader_hidden");
//        loadingscreen.addEventListener('transitionend', () => {
//            document.body.style.overflow = "auto";
//            document.body.classList.remove("loader");
//        });
//    }
//});

function checkReset() {
    document.getElementById('emailerror').innerHTML = "";
    document.getElementById('emailerror1').innerHTML = "";
    document.getElementById('usernameerror').innerHTML = "";
    document.getElementById('passerror').innerHTML = "";
    document.getElementById('passerror1').innerHTML = "";
    document.getElementById('repasserror').innerHTML = "";
    document.getElementById('birtherror').innerHTML = "";
    document.getElementById('phoneerror').innerHTML = "";
    document.getElementById('addresserror').innerHTML = "";

}

var emailValidation1 = /^[A-z]+[^\@\s]+\@[^\s]+\.[^\s]{2,}$/;
var emailValidation2 = /^[A-z]+\@[^\s]+\.[^\s]{2,}$/;
var numberValidation = /^0+[0-9]{9,10}$/;

function checkEmailLogin() {
    var email = document.getElementById('email').value;
    if (!emailValidation1.test(email) && !emailValidation2.test(email) && email == "") {

        return false;
    } else {
//            document.getElementById('emailerror').innerHTML = "";
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

//validate login form
function checkLogin() {
//    window.location.href = "/";
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
//        window.location.href = "login22222";
    } else {
        window.location.href = "login";
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
