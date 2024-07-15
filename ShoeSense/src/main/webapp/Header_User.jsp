<%-- 
    Document   : Header
    Created on : Jun 10, 2024, 9:59:07 AM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <link rel="stylesheet" href="style.css" />
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
        </style>
    </head>
    <body>
       <!--Header-->
        <header>
            <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
                <div class="container-fluid">
                    <a class="navbar-brand text-white fw-bold" style="font-size: xx-large;" href="/ShoeSense/">ShoeSense</a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                            data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                            aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarSupportedContent">
                        <!--Search-->
                        <form class="d-flex container" role="search" aria-label="Search" action="?sort=${param['sort']}&search=${param['search']}">

                            <input class="form-control me-2" name="search" type="search" placeholder="Search" aria-label="Search">
                            <button class="btn btn-outline-light" type="submit">Search</button>
                        </form>
                        <ul class="navbar-nav d-sm-flex flex-sm-row justify-content-sm-center row me-5">
                            <%
                                if (session.getAttribute("id") != null) {

                            %>
                            <!--Cart-->
                            <li class="nav-item col-sm-2">
                                <a href="/ShoeSense/cart/<%=session.getAttribute("id")%>" class="nav-link
                                   active
                                   text-white">
                                    <svg xmlns="http://www.w3.org/2000/svg" height="1.5em" viewBox="0 0 576 512"
                                         style="fill: #ffffff;">
                                    <path
                                        d="M0 24C0 10.7 10.7 0 24 0H69.5c22 0 41.5 12.8 50.6 32h411c26.3 0 45.5 25 38.6 50.4l-41 152.3c-8.5 31.4-37 53.3-69.5 53.3H170.7l5.4 28.5c2.2 11.3 12.1 19.5 23.6 19.5H488c13.3 0 24 10.7 24 24s-10.7 24-24 24H199.7c-34.6 0-64.3-24.6-70.7-58.5L77.4 54.5c-.7-3.8-4-6.5-7.9-6.5H24C10.7 48 0 37.3 0 24zM128 464a48 48 0 1 1 96 0 48 48 0 1 1 -96 0zm336-48a48 48 0 1 1 0 96 48 48 0 1 1 0-96z" />
                                    </svg>
                                </a>
                            </li>
                            <!--History-->
                            <li class="nav-item col-sm-2">
                                <a href="/ShoeSense/order/history/<%=session.getAttribute("id")%>" class="nav-link
                                   active
                                   text-white">
                                    <svg xmlns="http://www.w3.org/2000/svg" height="1.5em" viewBox="0 0 512 512"
                                         style="fill: #ffffff;">
                                    <path
                                        d="M75 75L41 41C25.9 25.9 0 36.6 0 57.9V168c0 13.3 10.7 24 24 24H134.1c21.4 0 32.1-25.9 17-41l-30.8-30.8C155 85.5 203 64 256 64c106 0 192 86 192 192s-86 192-192 192c-40.8 0-78.6-12.7-109.7-34.4c-14.5-10.1-34.4-6.6-44.6 7.9s-6.6 34.4 7.9 44.6C151.2 495 201.7 512 256 512c141.4 0 256-114.6 256-256S397.4 0 256 0C185.3 0 121.3 28.7 75 75zm181 53c-13.3 0-24 10.7-24 24V256c0 6.4 2.5 12.5 7 17l72 72c9.4 9.4 24.6 9.4 33.9 0s9.4-24.6 0-33.9l-65-65V152c0-13.3-10.7-24-24-24z" />
                                    </svg>
                                </a>
                            </li>

                            <!--User Information-->
                            <li class="nav-item col-sm-2">
                                <a href="/ShoeSense/user/profile/<%=session.getAttribute("id")%>" class="nav-link
                                   active
                                   text-white">
                                    <svg xmlns="http://www.w3.org/2000/svg" height="1.5em" viewBox="0 0 448 512"
                                         style="fill: #ffffff;">
                                    <path
                                        d="M224 256A128 128 0 1 0 224 0a128 128 0 1 0 0 256zm-45.7 48C79.8 304 0 383.8 0 482.3C0 498.7 13.3 512 29.7 512H418.3c16.4 0 29.7-13.3 29.7-29.7C448 383.8 368.2 304 269.7 304H178.3z" />
                                    </svg>
                                </a>
                            </li>
                            <!--Logout-->
                            <li class="nav-item col-sm-2">
                                <a href="/ShoeSense/logout" class="nav-link
                                   active
                                   text-white">
                                    <svg xmlns="http://www.w3.org/2000/svg" height="1.5em" viewBox="0 0 512 512"
                                         style="fill: #ffffff;">
                                    <path
                                        d="M377.9 105.9L500.7 228.7c7.2 7.2 11.3 17.1 11.3 27.3s-4.1 20.1-11.3 27.3L377.9 406.1c-6.4 6.4-15 9.9-24 9.9c-18.7 0-33.9-15.2-33.9-33.9l0-62.1-128 0c-17.7 0-32-14.3-32-32l0-64c0-17.7 14.3-32 32-32l128 0 0-62.1c0-18.7 15.2-33.9 33.9-33.9c9 0 17.6 3.6 24 9.9zM160 96L96 96c-17.7 0-32 14.3-32 32l0 256c0 17.7 14.3 32 32 32l64 0c17.7 0 32 14.3 32 32s-14.3 32-32 32l-64 0c-53 0-96-43-96-96L0 128C0 75 43 32 96 32l64 0c17.7 0 32 14.3 32 32s-14.3 32-32 32z" />
                                    </svg>
                                </a>
                            </li>
                            <%
                            } else {
                            %>
                            <!--Login-->
                            <li class="nav-item col-sm-2">
                                <a href="/ShoeSense/login" class="nav-link
                                   active
                                   text-white">
                                    <svg xmlns="http://www.w3.org/2000/svg" height="1.5em" viewBox="0 0 512 512"
                                         style="fill: #ffffff;">
                                    <path d="M217.9 105.9L340.7 228.7c7.2 7.2 11.3 17.1 11.3 27.3s-4.1 20.1-11.3 27.3L217.9 406.1c-6.4 6.4-15 9.9-24 9.9c-18.7 0-33.9-15.2-33.9-33.9l0-62.1L32 320c-17.7 0-32-14.3-32-32l0-64c0-17.7 14.3-32 32-32l128 0 0-62.1c0-18.7 15.2-33.9 33.9-33.9c9 0 17.6 3.6 24 9.9zM352 416l64 0c17.7 0 32-14.3 32-32l0-256c0-17.7-14.3-32-32-32l-64 0c-17.7 0-32-14.3-32-32s14.3-32 32-32l64 0c53 0 96 43 96 96l0 256c0 53-43 96-96 96l-64 0c-17.7 0-32-14.3-32-32s14.3-32 32-32z"/>
                                    </svg>
                                </a>
                            </li>
                            <%
                                }
                            %>
                        </ul>
                    </div>
                </div>
            </nav>
        </header>

    </body>
</html>
