<%-- 
    Document   : ForgotPassword
    Created on : Jun 5, 2024, 12:46:09 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
          <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <script src="validate.js"></script>
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
                width: 565px;
                height: 275px;
                display: flex;
                justify-content: center;
                align-items: center;
                background: #0000008f;
                border: 2px solid #fff;
                border-radius: 10px;
                margin: 45px;
            }
            
        </style>
    </head>
<body>
    <jsp:include page="Header_Login.jsp"></jsp:include>
    <section>
        <div class="form-box">
            
                <!--Form Login-->
                <form method="post" action="forgotpass" id="loginform">
                    <h2 class="text-center" style="color: #fff" >Reset Password</h2>
                    <div class="m-3">
                        <label class="form-label fw-bold" style="color: #fff"> Email:</label>
                        <input id="email" type="text" name="email" class="form-control" style="width: 470px" placeholder="Enter email" value="${requestScope.email}" required="">
                        <p id="emailerror"></p>
                    </div>
                    <c:if test="${requestScope.report != null}">
                        <div style="color: green ;margin-left: 18px; margin-bottom: 18px;">${requestScope.report}</div>
                    </c:if>
                    <c:if test="${requestScope.error != null}">
                        <div style="color: red; margin-left: 18px; margin-bottom: 18px;">${requestScope.error}</div>
                    </c:if>
                    <div class="text-center">
                        <button type="submit" 
                                class="btn btn-dark fw-bold rounded-5" name="btnOTPGet" value="otpGet">Reset Password</button>
                        <button type="button" onclick="window.location.href = '${pageContext.request.contextPath}/login'"
                                class="btn btn-dark fw-bold rounded-5" name="btnLogin" value="login">Back To Login Page</button>
                    </div>
                </form>          
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
        crossorigin="anonymous"></script>
        </section>
    </body>
<jsp:include page="Footer.jsp"></jsp:include>
</html>
