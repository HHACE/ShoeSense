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
        <link rel="stylesheet" href="style.css"/>
    </head>
<body>
    <jsp:include page="Header_User.jsp"></jsp:include>
        <div class="container">
            <div class="row justify-content-around">
                <!--Form Login-->
                <form method="post" action="forgotpass" id="loginform" class="col-6 p-3 m-5 bg-body-tertiary rounded-5">
                    <h1 class="text-center">Reset Password</h1>
                    <div class="m-3">
                        <label class="form-label fw-bold">Email:</label>
                        <input id="email" type="text" name="email" class="form-control" placeholder="Enter email" value="${requestScope.email}" required="">
                        <p id="emailerror"></p>
                    </div>
                    <c:if test="${requestScope.report != null}">
                        <div style="color: green">${requestScope.report}</div>
                    </c:if>
                    <c:if test="${requestScope.error != null}">
                        <div style="color: red">${requestScope.error}</div>
                    </c:if>
                    <div class="text-center">
                        <button type="submit" 
                                class="btn btn-dark fw-bold rounded-5" name="btnOTPGet" value="otpGet">Reset Password</button>
                        <button type="button" onclick="window.location.href = '${pageContext.request.contextPath}/login'"
                                class="btn btn-dark fw-bold rounded-5" name="btnLogin" value="login">Back To Login Page</button>
                    </div>
                </form>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
        crossorigin="anonymous"></script>

    </body>
<jsp:include page="Footer.jsp"></jsp:include>
</html>
