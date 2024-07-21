<%-- 
    Document   : HeaderLogin
    Created on : Jul 6, 2024, 2:10:41 AM
    Author     : anhkh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
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
            .category a{
                text-decoration: none;
                color: black;
                font-size: large;
                font-weight: bold;
            }

            body{
                background-color: rgb(191, 191, 191);
            }

            #product div:hover{
                box-shadow: 5px 5px 5px gray;
            }

            .bannerimg{
                width: 1900px;
            }

            .page-item{
                padding: 5px;
            }

            #pagingitem a{
                color: rgb(137, 137, 137);
                border-radius: 100%;
                padding-left: 14px;
                padding-right: 14px;
            }

            #pagingitem a:hover{
                background-color: rgb(75, 75, 75);
                border: 1px solid black;
                color: white;
            }

            #pageprenext a{
                color: rgb(137, 137, 137);
                border-radius: 50px;
            }

            #pageprenext a:hover{
                background-color: rgb(75, 75, 75);
                border: 1px solid black;
                color: white;
            }

            #productDetail{
                width: 1900px;
            }

            #detailproductimg{
                width: 450px;
                height: 500px;
            }


            input[type="radio"]:checked + label.size-label{
                background-color: rgb(49, 49, 49);
                border: 1px solid rgb(0, 0, 0);
                color: white;
            }

            .quantity button{
                border: 1px solid rgb(137, 137, 137) ;
                color: rgb(106, 105, 105);
                border-radius: 5px;
                width: 40px;
                text-align: center;
                justify-content: center;

            }

            .quantity button:hover{
                background-color: rgb(147 117 80);
                border: 1px solid rgb(129, 102, 69);
                color: white;
            }

            #buttonThemvaogio{
                background-color: rgb(60, 60, 60);
                color: white;
            }

            #buttonThemvaogio:active{
                background-color: black;
            }

            #buttonMuangay{
                border: 1px solid;
            }

            #buttonMuangay:active{
                background-color: black;
                color: white;
            }

            #linkfooter{
                text-decoration: none;
                color: white;
            }

            .hethang{
                position: absolute;
            }
            .category {
                display: flex;
                align-items: center;
                justify-content: center;
                background-color: #fff; /* White background */
                color: #000; /* Black text */
                font-size: 25px;
                font-weight: bold;
                text-decoration: none;
                height: 80px; /* Adjust the height to your preference */
                border-radius: 8px; /* Add a subtle border radius */
                transition: background-color 0.3s ease, color 0.3s ease; /* Smooth transition on hover for background and text color */
            }

            .category:hover {
                background-color: #f0f0f0; /* Light gray background on hover */
            }
            .navbar-nav {
                margin-right: 6px;
            }

            .navbar-nav .dropdown-menu {
                min-width: 5px;
                margin-right: 6px;
            }

        </style>
    </head>
    <body>
        <header>
            <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
                <div class="container-fluid">
                    <a class="navbar-brand text-white fw-bold" style="font-size: xx-large; padding-left: 20px" href="/ShoeSense/">ShoeSense</a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                            data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                            aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <a class="navbar-brand text-white" style="font-size: x-large;" href="/ShoeSense/">
                       <i class="fas fa-home"></i> Home
                    </a>
                </div>
            </nav>
        </header>
    </body>
</html>
