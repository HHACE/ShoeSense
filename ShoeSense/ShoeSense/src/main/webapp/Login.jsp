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
        <style>
            @import url(https://fonts.googleapis.com/css?family=Poppins:100,100italic,200,200italic,300,300italic,regular,italic,500,500italic,600,600italic,700,700italic,800,800italic,900,900italic);
            section {
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
                width: 100%;
                background: url("img/images2.jpg");
                background-position: center;
                background-size: cover;
            }
            .form-box {
                position: relative;
                width: 400px;
                height: 450px;
                display: flex;
                justify-content: center;
                align-items: center;
                background: #0000008f;
                border: 2px solid #fff;
                border-radius: 10px;
            }
            h2 {
                font-size: 2rem;
                color: #fff;
                text-align: center;
            }
            .input-box {
                position: relative;
                margin: 30px 0;
                width: 320px;
                border-bottom: 2px solid #fff;
            }
            .input-box label {
                position: absolute;
                top: 50%;
                left: 5px;
                color: #fff;
                transform: translateY(-50%);
                pointer-events: none;
                font-size: 1rem;
                transition: 0.5s;
            }
            .input-box input {
                width: 100%;
                height: 25px;
                background: transparent;
                outline: none;
                border: none;
                font-size: 1em;
                padding: 0 35px 0 5px;
                color: #fff;
            }
            .input-box input.login1 {
                width: 90%;
                height: 25px;
                background: transparent;
                outline: none;
                border: none;
                font-size: 1em;
                padding: 0 35px 0 5px;
                color: #fff;
            }
            input:focus ~ label,
            input:valid ~ label {
                top: -10px;
            }
            .input-box ion-icon {
                position: absolute;
                right: 8px;
                color: #fff;
                font-size: 1.2em;
            }
            .f-password {
                margin: -15px 0 15px;
                font-size: 0.9em;
                color: #fff;
                display: flex;
                justify-content: space-between;
            }
            .f-password label input {
                margin-right: 3px;
            }
            .f-password a:hover {
                color: #fff;
            }
            button {
                width: 100%;
                height: 50px;
                border-radius: 0px 10px 0px 10px;
                font-size: 1.2rem;
                font-weight: 700;
                margin-top: 20px;
                background: #fff;
                color: #000;
            }
            button:hover {
                background: transparent;
                color: #fff;
            }
            .signup {
                font-size: 0.8rem;
                color: #fff;
                margin-top: 20px;
            }
            .signup a:hover {
                color: #fff;
            }

        </style>
    </head>
    <body>
        <jsp:include page="Header_Login.jsp"></jsp:include>
        <section>
                <div class="form-box">
                    <div class="form-value">
                        <form  method="post" action="login" id="loginform">
                            <h2 style="color: #fff" >Login</h2>
                            <div class="input-box">
                                <ion-icon name="mail-outline"></ion-icon>
                                <input class="login1" id="email" type="text" name="email1" required>
                                <label for="#">Email</label>
                            </div>
                            <div class="input-box">
                                <ion-icon name="lock-closed-outline"></ion-icon>
                                <input  id="password" type="password" name="password"  required>
                                <label for="#">Password</label>
                            </div>
                            <div class="f-password">                              
                                <a href="/ShoeSense/forgotpass">Forget Password</a>
                            </div>
                            <button type="submit"
                                 name="btnLogin" onclick="checkLogin()" value="login">Login</button>
                            <div class="signup">
                                <p>Don't have an account
                                    <a href="register">Register</a>
                                </p>
                            </div>
                        </form>
                    </div>
                </div>
            </section>
            <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
            <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
       
        
          
        
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
