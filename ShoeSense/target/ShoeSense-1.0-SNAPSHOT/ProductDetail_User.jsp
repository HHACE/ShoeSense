<%-- 
    Document   : ProductDetail_User
    Created on : Jun 19, 2024, 8:04:04 PM
    Author     : ADMIN
--%>

<%@page import="Modals.Order"%>
<%@page import="Modals.OrderDetail"%>
<%@page import="DAOs.OrderDetailDAO"%>
<%@page import="DAOs.OrderDAO"%>
<%@page import="Modals.Comment"%>
<%@page import="DAOs.CommentDAO"%>
<%@page import="java.util.List"%>
<%@page import="DAOs.ProductVariantDAO"%>
<%@page import="Modals.ProductVariant"%>
<%@page import="Modals.Product"%>
<%@page import="DAOs.ProductDAO"%>
<%@page import="Modals.Account"%>
<%@page import="DAOs.AccountDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

        <style>
            .disabled-label {
                pointer-events: none;
                background-color: rgb(193,193,193);
            }

            #comment{
                border: none;
                background-color: rgb(60, 60, 60);
                color: white;
            }
            #comment:active{
                background-color: black;
            }
        </style>
    </head>
    <body>

        <%

            Cookie[] cookies = request.getCookies();

            Account temp = (Account) session.getAttribute("acc");
            System.out.println(temp);
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

                if (temp != null && temp.getAccountRole().equals("Admin")) {
                    response.sendRedirect("/ShoeSense/admin/user/manage");
                }

//                if (!flag) {
//                    response.sendRedirect("/ShoeSense/login");
//                }
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

                if (temp != null && temp.getAccountRole().equals("Admin")) {
                    response.sendRedirect("/ShoeSense/admin/user/manage");
                }

//                if (!flag) {
//                    response.sendRedirect("/ShoeSense/Login");
//                }
            }


        %>

        <jsp:include page="Header_User.jsp"></jsp:include>

            <!--Modal Product Detail-->


        <%            ProductDAO pdao = new ProductDAO();
            ProductVariantDAO vardao = new ProductVariantDAO();

            Product p = (Product) session.getAttribute("thongtinsanpham");
            List<ProductVariant> varList = vardao.getAllProductVariantByProductID(p.getProductID());
        %>

        <div class="container">

            <div class="row">
                <img class="col-md-2 col-sm-3 rounded-5" id="detailproductimg" src="/ShoeSense/<%= p.getProductImg()%>" alt="detailproductimg">
                <form method="post" action=""> 
                    <div class="col-md-4 col-sm-3">
                        <section>
                            <h1 class="fs-2 pt-1 pb-2"><%= p.getProductName()%></h1>
                            <input type="hidden" name="proID" value="<%= p.getProductID()%>">
                            <% if (session.getAttribute("id") != null) {%>
                            <input type="hidden" name="userID" value ="<%= session.getAttribute("id")%>">
                            <% }%>
                        </section>
                        <section>
                            <label class="fs-5 pb-1 fw-bold">Price:</label>
                            <p class="fs-4" style="color: rgb(216, 97, 50);">
                                <%= String.format("%,.0f", p.getProductPrice())%> vnđ
                            </p>
                        </section>

                        <section>
                            <label class="fs-5 pb-1 fw-bold">Variant:</label>
                            <select class="form-select" name="variantID" id="variantID" required onchange="updateProductImage()">
                                <option value="" >None</option> <!-- Initial "None" option -->
                                <% for (ProductVariant var : varList) {%>
                                <option value="<%= var.getVariantID()%>" data-img="/ShoeSense/<%= var.getVariantImg()%>">
                                    Size <%= var.getVariantSize()%> | Color <%= var.getVariantColor()%> | In Stock <%= var.getVariantQuantity()%> 
                                </option>
                                <% }%>
                            </select>
                        </section>
                        <section>
                            <div class="p-2 quantity">
                                <label class="fs-5 pb-2 me-2 fw-bold">Total Stock: <%=vardao.getTotalProductVariantByProductId(p.getProductID())%></label>
                            </div>
                        </section>
                        <section>
                            <div class="p-2 quantity">
                                <label class="fs-5 pb-2 me-2 fw-bold">Amount: </label>
                                <input type="number" name="quantity" id="quantity" value="1" min="1" max="" class="no-spinners fs-4 text-center w-25 rounded-3 ">
                            </div>
                        </section>



                        <section>
                            <div class="p-2">
                                <label class="fs-5 pb-2 fw-bold">Description:</label>
                                <br>
                                <p>
                                    <textarea class="form-control" style="width: 150%;" cols="30" readonly rows="4"><%= p.getProductDis()%></textarea>
                                </p>
                            </div>
                            <% if (session.getAttribute("id") != null) {
                                    if (vardao.getTotalProductVariantByProductId(p.getProductID()) != 0) {
                            %>

                            <button type="submit" name="addNew" class="btn p-2" id="buttonThemvaogio">Add To Cart</button>
                            <% } else { %>
                            <button type="submit" name="addNew" class="btn p-2" id="buttonThemvaogio" disabled="">Out Of Stock</button>
                            <% } %>
                            <% } else { %>
                            <a href="/ShoeSense/login" class="btn btn-danger  fs-4" >
                                Login to buy
                            </a>
                            <% }%>
                        </section>
                    </div>
                </form>
            </div>
            <!-- Rest of your HTML content -->
            <%
                CommentDAO comdao = new CommentDAO();
                OrderDAO orddao = new OrderDAO();
                OrderDetailDAO oddao = new OrderDetailDAO();
                
                 boolean check = false;
   
                if(temp!=null) {
                List<Order> ordl = orddao.getAllOrderByAccountId(temp.getAccountID());
               
                for (Order ord : ordl){
                   if(oddao.checkOrderDetailByProductID(p.getProductID(),ord.getOrderID()) == true) {
                   check = true;
                   break;
                }
                }
                }
                if(check == true) {
                if (comdao.checkAccountCommentInProduct(temp.getAccountID(), p.getProductID())){
                
                Comment com = comdao.getAccountCommentByAccountID(temp.getAccountID(), p.getProductID());
            

                if (com.getCommentID() != 0) {
            %>
            <form method="post" action=""> 
                <div class="col-md-4 col-sm-3"> 


                    <section>
                        <div class="p-2">
                            <label class="fs-5 pb-2 fw-bold">Your comments:</label>
                            <br>


                            <p>
                                <textarea name="content" id="content" class="form-control" style="width: 150%;" cols="30" rows="4"><%= com.getContent()%></textarea>
                            </p>

                        </div>
                            <input type="hidden" name="accountID" id="accountID" value="<%= temp.getAccountID()%>">
                             <input type="hidden" name="productID" id="productID" value="<%=  p.getProductID()%>">
                        <button type="submit" name="btnEditComment" class="btn btn-primary" id="btnEditComment">Edit</button>
  

                    </section>



                </div>
            </form>
            <%
                }
} else{
            %>
            
                        <form method="post" action=""> 
                <div class="col-md-4 col-sm-3"> 


                    <section>
                        <div class="p-2">
                            <label class="fs-5 pb-2 fw-bold">Comments:</label>
                            <br>


                            <p>
                                <textarea name="content" id="content" class="form-control"  style="width: 150%;" cols="30" rows="4"></textarea>
                            </p>

                        </div>

                            <input type="hidden" name="accountID" id="accountID" value="<%= temp.getAccountID()%>">
                             <input type="hidden" name="productID" id="productID" value="<%=  p.getProductID()%>">
            
                        <button type="submit" name="btnAddNewComment" class="btn btn-primary" id="btnAddNewComment">Comment</button>

                    </section>



                </div>
            </form>
                            
                        <%
                }

}


                    
                    List<Comment> coml = comdao.getAllCommentByProductID(p.getProductID());
AccountDAO adao2 = new AccountDAO();


if (!coml.isEmpty()) {
for (Comment com : coml){
if (com.getCommentStatus().equalsIgnoreCase("Public")){
%>
                         <label class="fs-5 pb-2 fw-bold">Comments:</label>
                             <%
                                 break;
                                 }}}
                    for (Comment com : coml){
                    if (com.getCommentStatus().equalsIgnoreCase("Public")){
                    Account tempacc = adao2.GetAccountById(Integer.toString( com.getAccountID()));

            %>
              <div class="col-md-4 col-sm-3"> 
                                <section>
                        <div class="p-2">
                            <label class="fs-5 pb-2 fw-bold"><%= tempacc.getAccountName() %> | <%= com.getCreatedDate()%> </label>
                            <br>


                            <p>
                                <textarea name="content" id="content" class="form-control" style="width: 150%;" cols="30" rows="4" readonly=""><%= com.getContent()%></textarea>
                            </p>

                        </div>
  

                    </section>
                               </div>
            <%
                }}
            %>
        </div>

        <!-- Include Footer -->
        <jsp:include page="Footer.jsp"></jsp:include>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>

            <script>
                                    function updateProductImage() {
                                        var selectedVariantID = document.getElementById("variantID").value;
                                        var dropdown = document.getElementById("variantID");
                                        var selectedOption = dropdown.options[dropdown.selectedIndex];
                                        var variantQuantity = parseInt(selectedOption.innerText.match(/In Stock (\d+)/)[1]);

                                        if (selectedVariantID === "" || selectedOption.text === "None") {
                                            // No variant selected, revert to default product image
                                            document.getElementById("detailproductimg").src = "/ShoeSense/<%= p.getProductImg()%>";
                                            disableAddToCartButton(true);
                                        } else {
                                            var variantImg = selectedOption.getAttribute("data-img");
                                            if (variantImg && variantImg.includes("img")) {
                                                document.getElementById("detailproductimg").src = variantImg;
                                            } else {
                                                document.getElementById("detailproductimg").src = "/ShoeSense/<%= p.getProductImg()%>";
                                            }

                                            // Check if selected quantity exceeds available stock
                                            var selectedQuantity = parseInt(document.getElementById("quantity").value);
                                            if (selectedQuantity > variantQuantity || variantQuantity <= 0) {
                                                disableAddToCartButton(true); // Disable button if quantity exceeds stock or stock is zero
                                            } else {
                                                disableAddToCartButton(false); // Enable button if quantity is within stock
                                            }
                                        }
                                    }

                                    function disableAddToCartButton(disable) {
                                        var addToCartButton = document.getElementById("buttonThemvaogio");
                                        addToCartButton.disabled = disable;
                                        if (disable) {
                                            addToCartButton.textContent = "Out Of Stock";
                                        } else {
                                            addToCartButton.textContent = "Add To Cart";
                                        }
                                    }

                                    // Hook the updateProductImage function to the change event of the quantity input
                                    document.getElementById("quantity").addEventListener("change", updateProductImage);
        </script>

        <%
            String alertMess = (String) request.getAttribute("alrtMessdetailpro");
            if (alertMess != null && !alertMess.isEmpty()) {
        %>
        <script>
        alert("<%= alertMess%>");
        </script>
        <% }%>

    </body>
</html>