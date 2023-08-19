<%@page import="java.sql.*"%>
<!doctype html>
<html lang="en" xmlns:th="http://www.thymeleaf.org"
      xmlns:sec="http://www.thymeleaf.org/thymeleaf-extras-springsecurity3">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
          integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css"
          integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
          <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js" integrity="sha384-h0AbiXch4ZDo7tp9hKZ4TsHbi047NrKGLO3SEJAg45jXxnGIfYzk4Si90RDIqNm1" crossorigin="anonymous"></script>
    <title>Home | ConcordiaEats</title>
</head>
<body>

<section class="wrapper">

	<% try { 
		int uid = (int)session.getAttribute("key");
		String url = "jdbc:mysql://localhost:3306/springproject";
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection con = DriverManager.getConnection(url, "root", "");
		
		Statement cartCount = con.createStatement();
		ResultSet fetchedCount = cartCount.executeQuery("SELECT count(*) FROM basketItems WHERE user_id = "+uid+";");							
	
		if (fetchedCount.next()) {
			int count = fetchedCount.getInt(1);
		}
	%>
	
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container-fluid">
        <a class="navbar-brand" href="index">
            <img th:src="https://467210.fs1.hubspotusercontent-na1.net/hubfs/467210/Concordia-eats-logo.png"  src="https://467210.fs1.hubspotusercontent-na1.net/hubfs/467210/Concordia-eats-logo.png" width="auto" height="80" class="d-inline-block align-top" alt=""/>
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
		
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mr-auto"></ul>
            <ul class="navbar-nav" style="font-size: 22px; font-weioght: bold;">
                <li class="nav-item active">
                    <a class="nav-link" th:href="@{/}" href="/index"><b>Home</b></a>
                </li>
                <li class="nav-item active">
                    <a class="nav-link" th:href="@{/shop}" href="/user/products"><b>Shop</b></a>
                </li>
                <li class="nav-item active">
                    <a class="nav-link" th:href="@{/cart}" href="/basket"><b>My Basket </b><%= fetchedCount.getInt(1) %></a>
                </li>
                <li class="nav-item active">
                    <a class="nav-link" href="/profileDisplay" ><b>Profile</b></a>
                </li>
                <li class="nav-item active">
                    <button class="nav-link" style="background-color: #fff; border-radius: 32px; border: 0px; padding-left: 18px; padding-right: 18px; border: 1px solid #222222;">
                        <a style="color: #222222;" href="/contact">Contact Us</a>
                    </button>
                </li>
                <li class="nav-item active">
                    <button class="nav-link" style="background-color: #912338; border-radius: 32px; border: 0px; padding-left: 18px; padding-right: 18px;">
                        <a style="color: #fff;" sec:authorize="isAuthenticated()" href="logout">Logout</a>
                    </button>
                </li>
            </ul>

        </div>
    </div>
</nav> 
	<%
		} catch (Exception ex) {
		out.println("Exception Occurred:: " + ex.getMessage());
		}
	%> 


<%
	try {
	    int uid = (int) session.getAttribute("key");
	    String url = "jdbc:mysql://localhost:3306/springproject";
	    Class.forName("com.mysql.cj.jdbc.Driver");
	    Connection con = DriverManager.getConnection(url, "root", "");
	    Statement stmt = con.createStatement();
	    ResultSet rs = stmt.executeQuery("SELECT id, p.name, c.name, description, price, discPrice, discPercent, image, p.quantity FROM products p, categories c WHERE p.categoryid=c.categoryid AND onDiscount=1 AND p.quantity > 0;");
	    boolean hasResult = rs.next();
%>
<div id="carousel-container" class="bg mt-5" <% if (!hasResult) { %>style="max-height: 52px;"<% } %>>
	<% if (hasResult) { %>
    <h1 style="margin-left: 40px; font-weight: bold;">Best Deals of the Day</h1>
    <% } %>
    <div <%if(hasResult){ %>class="bg-product mt-5"<%} %>>
        <div class="container product">
        	<%if (hasResult) {%>
            <div class="row">
                <div id="sliderproduct" class="carousel slide " data-ride="carousel" data-interval="10000">
                    <ol class="carousel-indicators">
                        <li data-target="#sliderproduct" data-slide-to="0" class="active"></li>
                        <li data-target="#sliderproduct" data-slide-to="1"></li>
                        <li data-target="#sliderproduct" data-slide-to="2"></li>
                    </ol>
                    <div class="carousel-inner" role="listbox" data-interval="10000000">
                        <% do { %>
                        <div class="carousel-item <% if(rs.isFirst()) { %>active<% } %>">
                            <div class="container text-center">
                                <div class="row">
                                    <div class="col-sm-6 image">
                                        <div class="item">
                                            <img class="img-fluid" src="<%= rs.getString(8) %>" alt="">
                                        </div><!--enditem-->
                                    </div><!--endcol-->
                                    <div class="col-sm-6">
                                        <div class="details">
                                            <h2 class="cr3"><%= rs.getString(2) %></h2>
                                            <h4 class="cr3"><%= rs.getString(3) %></h4>
                                            <p class="cr4"> <%= rs.getString(4) %></p>
                                            <h3 class="cr1"><br><b>
                                                    <s>$ <%= rs.getDouble(5) %></s><br>
                                                    <b>$ <%= rs.getDouble(6) %></b>
                                                </b><br><br>
                                            </h3>
                                            <form action="/addtobasket" method="post">
                                                <input type="hidden" name="userID" value="<%= uid %>">
                                                <input type="hidden" name="currentPage" value="redirect:/index#sliderproduct">
                                                <input type="hidden" name="productID" value="<%= rs.getInt(1) %>">
                                                <label for="quantity" style="color:#fff; font-size: 20px;"><b>QTY:</b>&nbsp;&nbsp;&nbsp;</label>
                                                <input type="number" id="qty" name="qty" min="1" max="<%= rs.getInt(9) %>" value="1" style="font-size: 20px;">&nbsp;&nbsp;&nbsp;
                                                <input type="submit" value="Add to basket" class="btn btn-food">
                                            </form>
                                        </div><!--enddetails-->
                                    </div><!--endcol-->
                                </div><!--endrow-->
                            </div><!--endcontainer-->
                        </div><!--endcarousel-item-->
                        <% } while (rs.next()); %>
                    </div><!--endslidesliderproduct-->
                    <a class="carousel-control-prev fa fa-angle-left" href="#sliderproduct " role="button" data-slide="prev"></a>
                    <a class="carousel-control-next fa fa-angle-right" href="#sliderproduct" role="button" data-slide="next"></a>
 				</div><!--endsliderproduct-->
            </div><!--endrow-->
            <% } else { %>
            <div class="row">
                <div class="col-md-12">
                    <p class="text-center" style="color: black; font-size: 24px;">No discounted products available at the moment.</p>
                </div>
            </div>
            <% }
                } catch (Exception ex) {
                    out.println("Exception Occurred:: " + ex.getMessage());
                }
            %>
        </div><!--endcontainer-->
    </div><!--endbg-product-->
</div><!--endcarousel-container-->                


<%
	try {
	    int uid = (int) session.getAttribute("key");
	    String url = "jdbc:mysql://localhost:3306/springproject";
	    Class.forName("com.mysql.cj.jdbc.Driver");
	    Connection con = DriverManager.getConnection(url, "root", "");
	    Statement stmt = con.createStatement();
	    ResultSet rs = stmt.executeQuery("SELECT DISTINCT id, p.name, c.name, description, price, discPrice, discPercent, image, p.quantity from products p, orders o, categories c, sales s where p.quantity > 0 AND p.categoryid IN (SELECT categoryid FROM products p, orders o, sales s WHERE o.user_id = "+uid+" and s.order_id = o.order_id and s.product_id = p.id) and p.categoryid = c.categoryid ORDER BY RAND() LIMIT 5;");
	    boolean hasResult = rs.next();
%>
<div id="carousel-container" class="bg mt-5" <% if (!hasResult) { %>style="max-height: 52px;"<% } %>>
	<% if (hasResult) { %>
    <h1 style="margin-left: 40px; font-weight: bold;">Recommended For You</h1>
    <% } %>
    <div <%if(hasResult){ %>class="bg-product mt-5"<%} %>>
        <div class="container product">
        	<%if (hasResult) {%>
            <div class="row">
                <div id="sliderproduct2" class="carousel slide " data-ride="carousel" data-interval="10000">
                    <ol class="carousel-indicators">
                        <li data-target="#sliderproduct2" data-slide-to="0" class="active"></li>
                        <li data-target="#sliderproduct2" data-slide-to="1"></li>
                        <li data-target="#sliderproduct2" data-slide-to="2"></li>
                    </ol>
                    <div class="carousel-inner" role="listbox" data-interval="10000000">
                        <% do { %>
                        <div class="carousel-item <% if(rs.isFirst()) { %>active<% } %>">
                            <div class="container text-center">
                                <div class="row">
                                	
                                    <div class="col-sm-6 image">
                                        <div class="item">
                                            <img class="img-fluid" src="<%= rs.getString(8) %>" alt="">
                                        </div><!--enditem-->
                                    </div><!--endcol-->
                                    <div class="col-sm-6">
                                        <div class="details">
                                            <h2 class="cr3"><%= rs.getString(2) %></h2>
                                            <h4 class="cr3"><%= rs.getString(3) %></h4>
                                            <p class="cr4"> <%= rs.getString(4) %></p>
                                            <h3 class="cr1"><br><b>
											  <% if (rs.getDouble(5) == rs.getDouble(6)) { %>
											    $ <%= rs.getDouble(5) %>
											  <% } else { %>
											    <s>$ <%= rs.getDouble(5) %></s><br>
											    <b>$ <%= rs.getDouble(6) %></b>
											  <% } %>
												</b><br><br>
											</h3>
                                            <form action="/addtobasket" method="post">
                                                <input type="hidden" name="userID" value="<%= uid %>">
                                                <input type="hidden" name="currentPage" value="redirect:/index#sliderproduct2">
                                                <input type="hidden" name="productID" value="<%= rs.getInt(1) %>">
                                                <label for="quantity" style="color:#fff; font-size: 20px;"><b>QTY:</b>&nbsp;&nbsp;&nbsp;</label>
                                                <input type="number" id="qty" name="qty" min="1" max="<%= rs.getInt(9) %>" value="1" style="font-size: 20px;">&nbsp;&nbsp;&nbsp;
                                                <input type="submit" value="Add to basket" class="btn btn-food">
                                            </form>
                                        </div><!--enddetails-->
                                    </div><!--endcol-->
                                </div><!--endrow-->
                            </div><!--endcontainer-->
                        </div><!--endcarousel-item-->
                        <% } while (rs.next()); %>
                    </div><!--endslidesliderproduct-->
                    <a class="carousel-control-prev fa fa-angle-left" href="#sliderproduct2" role="button" data-slide="prev"></a>
                    <a class="carousel-control-next fa fa-angle-right" href="#sliderproduct2" role="button" data-slide="next"></a>
 				</div><!--endsliderproduct-->
            </div><!--endrow-->
            <% } else { %>
            <div class="row">
                <div class="col-md-12">
                    <p class="text-center" style="color: black; font-size: 24px;">No recommended products available at the moment.</p>
                </div>
            </div>
            <% }
                } catch (Exception ex) {
                    out.println("Exception Occurred:: " + ex.getMessage());
                }
            %>
        </div><!--endcontainer-->
    </div><!--endbg-product-->
</div><!--endcarousel-container--> 


<%
	try {
	    int uid = (int) session.getAttribute("key");
	    String url = "jdbc:mysql://localhost:3306/springproject";
	    Class.forName("com.mysql.cj.jdbc.Driver");
	    Connection con = DriverManager.getConnection(url, "root", "");
	    Statement stmt = con.createStatement();
	    ResultSet rs = stmt.executeQuery("SELECT id, p.name, c.name, description, price, discPrice, discPercent, image, p.quantity FROM products p, categories c, favorites f WHERE p.quantity > 0 AND f.user_id = "+uid+" AND f.product_id = id AND p.categoryid = c.categoryid;");
	    boolean hasResult = rs.next();
%>
<div id="carousel-container" class="bg mt-5" <% if (!hasResult) { %>style="max-height: 52px;"<% } %>>
	<% if (hasResult) { %>
    <h1 style="margin-left: 40px; font-weight: bold;">My Favorites</h1>
    <% } %>
    <div <%if(hasResult){ %>class="bg-product mt-5"<%} %>>
        <div class="container product">
        	<%if (hasResult) {%>
            <div class="row">
                <div id="sliderproduct3" class="carousel slide " data-ride="carousel" data-interval="10000">
                    <ol class="carousel-indicators">
                        <li data-target="#sliderproduct3" data-slide-to="0" class="active"></li>
                        <li data-target="#sliderproduct3" data-slide-to="1"></li>
                        <li data-target="#sliderproduct3" data-slide-to="2"></li>
                    </ol>
                    <div class="carousel-inner" role="listbox" data-interval="10000000">
                        <% do { %>
                        <div class="carousel-item <% if(rs.isFirst()) { %>active<% } %>">
                            <div class="container text-center">
                                <div class="row">
                                    <div class="col-sm-6 image">
                                        <div class="item">
                                            <img class="img-fluid" src="<%= rs.getString(8) %>" alt="">
                                        </div><!--enditem-->
                                    </div><!--endcol-->
                                    <div class="col-sm-6">
                                        <div class="details">
                                            <h2 class="cr3"><%= rs.getString(2) %></h2>
                                            <h4 class="cr3"><%= rs.getString(3) %></h4>
                                            <p class="cr4"> <%= rs.getString(4) %></p>
                                            <h3 class="cr1"><br><b>
											  <% if (rs.getDouble(5) == rs.getDouble(6)) { %>
											    $ <%= rs.getDouble(5) %>
											  <% } else { %>
											    <s>$ <%= rs.getDouble(5) %></s><br>
											    <b>$ <%= rs.getDouble(6) %></b>
											  <% } %>
												</b><br><br>
											</h3>
                                            <form action="/addtobasket" method="post">
                                                <input type="hidden" name="userID" value="<%= uid %>">
                                                <input type="hidden" name="currentPage" value="redirect:/index#sliderproduct3">
                                                <input type="hidden" name="productID" value="<%= rs.getInt(1) %>">
                                                <label for="quantity" style="color:#fff; font-size: 20px;"><b>QTY:</b>&nbsp;&nbsp;&nbsp;</label>
                                                <input type="number" id="qty" name="qty" min="1" max="<%= rs.getInt(9) %>" value="1" style="font-size: 20px;">&nbsp;&nbsp;&nbsp;
                                                <input type="submit" value="Add to basket" class="btn btn-food">
                                            </form>
                                        </div><!--enddetails-->
                                    </div><!--endcol-->
                                </div><!--endrow-->
                            </div><!--endcontainer-->
                        </div><!--endcarousel-item-->
                        <% } while (rs.next()); %>
                    </div><!--endslidesliderproduct-->
                    <a class="carousel-control-prev fa fa-angle-left" href="#sliderproduct3" role="button" data-slide="prev"></a>
                    <a class="carousel-control-next fa fa-angle-right" href="#sliderproduct3" role="button" data-slide="next"></a>
 				</div><!--endsliderproduct-->
            </div><!--endrow-->
            <% } else { %>
            <div class="row">
                <div class="col-md-12">
                    <p class="text-center" style="color: black; font-size: 24px;">No favorite products available at the moment.</p>
                </div>
            </div>
            <% }
                } catch (Exception ex) {
                    out.println("Exception Occurred:: " + ex.getMessage());
                }
            %>
        </div><!--endcontainer-->
    </div><!--endbg-product-->
</div><!--endcarousel-container--> 

<style>
:root{
  --cr1:#fff;
  --cr2:#fff;
  --cr3:#fff;
  --cr4:#fff;
  --cr5:#BEB4B1;
  --fs1:34px;
  --fs2:24px;
  --fs3:20px;
  --fs4:16px;
  --fs5:14px;
}
body {
  background: #e5e5e5;
}
/* the same attribute */
.cr1{
  color: var(--cr1);
  margin-left: 20px;
  margin-right: 20px;
}
.c2{
  color:  var(--cr2);
  margin-left: 20px;
  margin-right: 20px;
}
.cr3{
  color:  var(--cr3);
  margin-left: 20px;
  margin-right: 20px;
}
.cr4{
  color:  var(--cr4);
  margin-left: 20px;
  margin-right: 20px;
}
.cr5{
  color:  var(--cr5);
  margin-left: 20px;
  margin-right: 20px;
}
.fs1{
  font-size: 34px;
}
.fs2{
  font-size: 24px;
}
.fs3{
  font-size: 20px;
}
.fs4{
  font-size: 16px;
}
.fs5{
  font-size: 14px;
}
.title {
    margin-top: 0;
    font-size: 24px;
    font-weight: bold;
    color: #333;
}
/* end the same attribute */
@font-face {
  src: url(ProductSansRegular_0.ttf);
  font-family: product;
}
*{padding: 0px;margin: 0px;box-sizing: border-box;font-family: segoe ui}
body,html{width:100%;height:100%;}
[class*="container"]{
  max-width: 1170px !important;
}

.bg-product{
  /* SET Height cho nÃÂ³ rÃ¡Â»Âi bÃ¡ÂºÂ£o sao ko lÃ¡Â»Âi? */
  /*height: 446px;*/
  background: #222222;
  /* overflow: hidden; */
}
#sliderproduct{
  width: 100%;
}
#sliderproduct .carousel-inner {
  overflow: visible;
}

#sliderproduct .col-sm-6.image {
  background: #fff;
  box-shadow: 0px 4px 8px 0px #959595;
  position: relative;
  /* ThÃÂªm cÃÂ¡i cÃ¡Â»Â§a nÃ¡Â»Â£ nÃÂ y vÃÂ o bÃ¡ÂºÂ£o sao nÃÂ³ ko trÃÂ n bÃ¡Â»Â ÃÂÃÂª */
  /*top: -44px;
  padding: 100px;
  padding-top: 40px;*/
}
#sliderproduct2{
  width: 100%;
}
#sliderproduct2 .carousel-inner {
  overflow: visible;
}

#sliderproduct2 .col-sm-6.image {
  background: #fff;
  box-shadow: 0px 4px 8px 0px #959595;
  position: relative;
  /* ThÃÂªm cÃÂ¡i cÃ¡Â»Â§a nÃ¡Â»Â£ nÃÂ y vÃÂ o bÃ¡ÂºÂ£o sao nÃÂ³ ko trÃÂ n bÃ¡Â»Â ÃÂÃÂª */
  /*top: -44px;
  padding: 100px;
  padding-top: 40px;*/
}
#sliderproduct3{
  width: 100%;
}
#sliderproduct3 .carousel-inner {
  overflow: visible;
}

#sliderproduct3 .col-sm-6.image {
  background: #fff;
  box-shadow: 0px 4px 8px 0px #959595;
  position: relative;
  /* ThÃÂªm cÃÂ¡i cÃ¡Â»Â§a nÃ¡Â»Â£ nÃÂ y vÃÂ o bÃ¡ÂºÂ£o sao nÃÂ³ ko trÃÂ n bÃ¡Â»Â ÃÂÃÂª */
  /*top: -44px;
  padding: 100px;
  padding-top: 40px;*/
}
.item {
  padding: 20px 20px 40px 20px;
}

.col-sm-6.image .item img.img-fluid {
  /* Ai mÃÂ°Ã¡Â»Ân thÃÂªm cÃÂ¡i vÃÂ o lÃÂ m phÃÂ¡ bÃ¡Â»Â cÃ¡Â»Â¥c css cÃ¡Â»Â§a ngÃÂ°Ã¡Â»Âi ta.. mÃÂºn trang web ÃÂÃ¡ÂºÂ¹p thÃÂ¬ phÃ¡ÂºÂ£i lÃ¡Â»Â±a cÃÂ¡i Ã¡ÂºÂ£nh ÃÂÃ¡ÂºÂ¹p ÃÂÃ¡ÂºÂ¹p vÃÂ o rÃ¡Â»Âi set cÃÂ¡i ÃÂÃ¡Â»Â rÃ¡Â»Âng cho nÃÂ³ vÃ¡Â»Â«a lÃÂ  ÃÂÃÂ°Ã¡Â»Â£c rÃ¡Â»Âi */
  /*min-width: 100%;*/
  width: 315px;
}
.col-sm-6.image h1 {
  margin-bottom: 20px;
}


#sliderproduct .top a {
  text-decoration: none;
  text-transform: uppercase;
  font-size: 18px;
  padding: 14px 22px;
  background: #fff;
  box-sizing: border-box !important;
  text-align: center;
  margin: 0px 2px;
  display: block;
  color: #222222;
  width: 96px;
}

#sliderproduct .col-sm-4.mr-auto {
  margin-top: 22px;
}

*{}

#sliderproduct p.cr1 {
  font-size: 20px;
  font-weight: 500;
  margin-bottom: 30px;
}

#sliderproduct .col-sm-6:last-child {
  /* CÃ¡ÂºÂ§n nÃÂ¢ng cao thÃÂªm kiÃ¡ÂºÂ¿n thÃ¡Â»Â©c vÃ¡Â»Â sÃ¡Â»Â­ dÃ¡Â»Â¥ng padding */
  padding-top: 27px;
  padding-bottom: 27px;
}
#sliderproduct .details p.d-inline-block {
  color: #fff;
}

#sliderproduct .details .fa {
  color: #fff;
  padding: 0px 3px;
}

#sliderproduct .rating {
  margin: 23px 0px;
}

#sliderproduct .details .btn {
  text-transform: uppercase;
  font-weight: 600;
  padding: 16px 22px;
  background: #fff;
  color: #222222;
  border-radius: 81px;
  font-size: 14px;
  display: inline-block;
}

#sliderproduct .details h2 {
  margin: 25px 0px 30px 0px;
  font-size: 32px;
  font-weight: 700;
}

#sliderproduct .details p.cr4 {
  font-weight: 500;
  font-size: 18px;
  line-height: 19px;
  margin-bottom: 0px;
  padding: 10px;
}
#sliderproduct .carousel-item{
  transition: 0.4s;
}


#sliderproduct a.carousel-control-prev{
  border-radius: 50%;
  background-color: #912338;
  width: 46px;
  height: 46px;
  font-size: 30px;
  text-align: center;
  line-height: 40px;
  opacity: 1;
  top: 50%;
  transform: translate(-50%,-60%);
}
#sliderproduct a.carousel-control-next{
border-radius: 50%;
  background-color: #912338;
  width: 46px;
  height: 46px;
  font-size: 30px;
  text-align: center;
  line-height: 40px;
  opacity: 1;
  top: 50%;
  transform: translate(40%,-60%);
}
#sliderproduct2 .top a {
  text-decoration: none;
  text-transform: uppercase;
  font-size: 18px;
  padding: 14px 22px;
  background: #fff;
  box-sizing: border-box !important;
  text-align: center;
  margin: 0px 2px;
  display: block;
  color: #222222;
  width: 96px;
}

#sliderproduct2 .col-sm-4.mr-auto {
  margin-top: 22px;
}

*{}

#sliderproduct2 p.cr1 {
  font-size: 20px;
  font-weight: 500;
  margin-bottom: 30px;
}

#sliderproduct2 .col-sm-6:last-child {
  /* CÃ¡ÂºÂ§n nÃÂ¢ng cao thÃÂªm kiÃ¡ÂºÂ¿n thÃ¡Â»Â©c vÃ¡Â»Â sÃ¡Â»Â­ dÃ¡Â»Â¥ng padding */
  padding-top: 27px;
  padding-bottom: 27px;
}
#sliderproduct2 .details p.d-inline-block {
  color: #fff;
}

#sliderproduct2 .details .fa {
  color: #fff;
  padding: 0px 3px;
}

#sliderproduct2 .rating {
  margin: 23px 0px;
}

#sliderproduct2 .details .btn {
  text-transform: uppercase;
  font-weight: 600;
  padding: 16px 22px;
  background: #fff;
  color: #222222;
  border-radius: 81px;
  font-size: 14px;
  display: inline-block;
}

#sliderproduct2 .details h2 {
  margin: 25px 0px 30px 0px;
  font-size: 32px;
  font-weight: 700;
}

#sliderproduct2 .details p.cr4 {
  font-weight: 500;
  font-size: 18px;
  line-height: 19px;
  margin-bottom: 0px;
  padding: 10px;
}
#sliderproduct2 .carousel-item{
  transition: 0.4s;
}


#sliderproduct2 a.carousel-control-prev{
  border-radius: 50%;
  background-color: #912338;
  width: 46px;
  height: 46px;
  font-size: 30px;
  text-align: center;
  line-height: 40px;
  opacity: 1;
  top: 50%;
  transform: translate(-70%,-60%);
}
#sliderproduct2 a.carousel-control-next{
border-radius: 50%;
  background-color: #912338;
  width: 46px;
  height: 46px;
  font-size: 30px;
  text-align: center;
  line-height: 40px;
  opacity: 1;
  top: 50%;
  transform: translate(40%,-60%);
}

#sliderproduct3 .top a {
  text-decoration: none;
  text-transform: uppercase;
  font-size: 18px;
  padding: 14px 22px;
  background: #fff;
  box-sizing: border-box !important;
  text-align: center;
  margin: 0px 2px;
  display: block;
  color: #222222;
  width: 96px;
}

#sliderproduct3 .col-sm-4.mr-auto {
  margin-top: 22px;
}

*{}

#sliderproduct3 p.cr1 {
  font-size: 20px;
  font-weight: 500;
  margin-bottom: 30px;
}

#sliderproduct3 .col-sm-6:last-child {
  /* CÃ¡ÂºÂ§n nÃÂ¢ng cao thÃÂªm kiÃ¡ÂºÂ¿n thÃ¡Â»Â©c vÃ¡Â»Â sÃ¡Â»Â­ dÃ¡Â»Â¥ng padding */
  padding-top: 27px;
  padding-bottom: 27px;
}
#sliderproduct3 .details p.d-inline-block {
  color: #fff;
}

#sliderproduct3 .details .fa {
  color: #fff;
  padding: 0px 3px;
}

#sliderproduct3 .rating {
  margin: 23px 0px;
}

#sliderproduct3 .details .btn {
  text-transform: uppercase;
  font-weight: 600;
  padding: 16px 22px;
  background: #fff;
  color: #222222;
  border-radius: 81px;
  font-size: 14px;
  display: inline-block;
}

#sliderproduct3 .details h2 {
  margin: 25px 0px 30px 0px;
  font-size: 32px;
  font-weight: 700;
}

#sliderproduct3 .details p.cr4 {
  font-weight: 500;
  font-size: 18px;
  line-height: 19px;
  margin-bottom: 0px;
  padding: 10px;
}
#sliderproduct3 .carousel-item{
  transition: 0.4s;
}


#sliderproduct3 a.carousel-control-prev{
  border-radius: 50%;
  background-color: #912338;
  width: 46px;
  height: 46px;
  font-size: 30px;
  text-align: center;
  line-height: 40px;
  opacity: 1;
  top: 50%;
  transform: translate(-50%,-60%);
}
#sliderproduct3 a.carousel-control-next{
border-radius: 50%;
  background-color: #912338;
  width: 46px;
  height: 46px;
  font-size: 30px;
  text-align: center;
  line-height: 40px;
  opacity: 1;
  top: 50%;
  transform: translate(40%,-60%);
}
.bg {
  height: 570px;
  overflow: hidden;
}

#sliderproduct ol.carousel-indicators {
  display: none;
}
#sliderproduct2 ol.carousel-indicators {
  display: none;
}
#sliderproduct3 ol.carousel-indicators {
  display: none;
}

.footer {
  position: fixed;
  bottom: 0;
  padding: 15px;
  width: 100%;
  text-align: center;
  background-color:#292929;
  color: #fff;
  font-family: sans-serif;
  font-size: 14px;
}
.footer img {
  width: 26px;
  position: relative;
  top: 0px;
  left: -3px;
}
.footer a {
  color: #fff;
  font-weight: bold;
  text-decoration: none;
  
}
  
}</style>
<div class="row">
   <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4" data-aos="zoom-in-down">
                            <div class="card">
                                <div class="card-content">
                                   <a class="img-card">
                                    	<img class="center" src="https://467210.fs1.hubspotusercontent-na1.net/hubfs/467210/tag-icon.png" />
                                   </a>
                                    <h4 class="card-title">
                                        Best Deals
                                    </h4>
                                    <p class="">
                                       Not sure what to eat? <br>Check out our top deals of the day. 
                                        <br>
                                    </p>
                                </div>
                                <div class="card-read-more">
                                    <a href="/user/products?filter=discounts" class="btn btn-link btn-block">
                                        Shop Deals
                                    </a>
                                </div>
                            </div>
                        </div>
     <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4" data-aos="zoom-in-down">
                            <div class="card">
                                <a class="img-card">
                                    <img class="center" src="https://467210.fs1.hubspotusercontent-na1.net/hubfs/467210/favourites-icon.png" />

                                </a>
                                <div class="card-content">
                                    <h4 class="card-title">
                                        My Favorites
                                    </h4>
                                    <p class="">
                                       See something you like? <br>Add it to your favorites for easy re-ordering.
                                        <br>
                                    </p>
                                </div>
                                <div class="card-read-more">
                                    <a href="/user/products?filter=favorites" class="btn btn-link btn-block">
                                        Go to My Favorites
                                    </a>
                                </div>
                            </div>
                        </div>
	<div class="col-xs-12 col-sm-6 col-md-6 col-lg-4" data-aos="zoom-in-down">
                            <div class="card">
                                <div style="align: center">
                                <a class="img-card">
                                    <img class="center" src="https://467210.fs1.hubspotusercontent-na1.net/hubfs/467210/phone-icon.png" />

                                </a>
                                </div>
                                <div class="card-content">
                                    <h4 class="card-title">
                                        Contact us
                                    </h4>
                                    <p class="">
                                      Problem with your order? <br>Our ConcordiaEats team is here to help. 
                                        <br>
                                    </p>
                                </div>
                                <div class="card-read-more">
                                    <a href="/contact" class="btn btn-link btn-block">
                                        Get in touch with us
                                    </a>
                                </div>
                            </div>
                        </div>

	<style>
        @import url('https://fonts.googleapis.com/css2?family=Titillium+Web:wght@200;300&display=swap');
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@200&display=swap');
        @import url('https://fonts.googleapis.com/css2?family=Arimo&display=swap');
        @import url('https://fonts.googleapis.com/css2?family=M+PLUS+Rounded+1c:wght@300&display=swap');
        @import url('https://fonts.googleapis.com/css2?family=Signika:wght@300&display=swap');

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Titillium Web', sans-serif;
        }

        html,
        body {
            -moz-box-sizing: border-box;
            box-sizing: border-box;
            height: 100%;
            width: 100%;

            font-family: 'Roboto', sans-serif;
            font-weight: 400;
        }
        
         ::selection {
            color:white;
            background: black;
            font-weight: 700;
        }

        .wrapper {
            display: table;
            height: 100%;
            width: 100%;
        }

        .container-fostrap {
            display: table-cell;
            background-color: #b1ade2;
            background-image: linear-gradient(315deg, #b1ade2 0%, #7ddff8 74%);
            padding: 1em;
            text-align: center;
            vertical-align: middle;
        }

        h1.heading {
            color: #fff;
            font-size: 1.15em;
            font-weight: 900;
            margin: 0 0 0.5em;
            color: #505050;
            text-shadow: 0px 4px 3px rgba(0, 0, 0, 0.4),
                0px 8px 13px rgba(0, 0, 0, 0.1),
                0px 18px 23px rgba(0, 0, 0, 0.1);
        }

        @media (min-width: 450px) {
            h1.heading {
                font-size: 3.55em;
            }
        }

        @media (min-width: 760px) {
            h1.heading {
                font-size: 3.05em;
            }
        }

        @media (min-width: 900px) {
            h1.heading {
                font-size: 3.25em;
                margin: 0 0 0.3em;
            }


        }

        .card {
            display: block;
            width: auto;
            margin: 20px;
            line-height: 1.42857143;
            background-color: #fff;
            border-radius: 2px;
            min-width: 15rem;
            min-height: 300px;
            overflow: hidden;
            transition: 0.5s ease;
            animation: start_animation 0.5s ease 1;
            box-shadow: rgba(0, 0, 0, 0.09) 0px 2px 1px, rgba(0, 0, 0, 0.09) 0px 4px 2px, rgba(0, 0, 0, 0.09) 0px 8px 4px, rgba(0, 0, 0, 0.09) 0px 16px 8px, rgba(0, 0, 0, 0.09) 0px 32px 16px;
        }

        .cfont {
            font-family: 'Arimo', sans-serif;
        }

        .card:hover {
            box-shadow: rgba(0, 0, 0, 0.16) 0px 3px 6px, rgba(0, 0, 0, 0.23) 0px 3px 6px;
        }

        .img-card {
            width: 100%;
            height: 150px;
            min-width: 14rem;
            border-top-left-radius: 2px;
            border-top-right-radius: 2px;
            display: flex;
            overflow: hidden;
        }

        .img-card img {
            margin-top: 15px;
            width: fit-content;
            height: 125px;
            object-fit: cover;

        }

        .card-content {
            padding: 15px;
            text-align: center;

        }

        .card-content p {
            font-family: 'M PLUS Rounded 1c', sans-serif;
            font-size: 18px;
        }

        .card-title {
            font-family: 'Signika', sans-serif;
            margin-top: 0px;
            font-weight: 600;
            font-size: 1.65em;
        }

        .card-title a {
            color: #000;
            text-decoration: none !important;
        }

        .card-read-more {
            border-top: 1px solid #D4D4D4;
            background-color: #912338;

        }

        .card-read-more a {
            text-decoration: none !important;
            padding: 10px;
            font-weight: 600;
            text-transform: uppercase;
            color: #fff;
            font-size: 16px;
        }

        .navbar {
            background-color: #fff;
            opacity: 0.9;
            z-index: 999;
            width: 100%;
        }

        .navbar::before {
            content: "";
            position: absolute;
            top: 0%;
            bottom: 0%;
            left: 0;
            right: 0;
            z-index: -1;
        }

        .nav-item a:hover {
            color: rgb(0, 195, 255);
            font-weight: bold;
            transition: 0.5s ease-in-out;
            
        }

        .navbar-brand {
            color: white;
            font-weight: 600;
            font-size: 20px;
        }

        .nav-item {
            margin-right: 20px;
        }	
        
        .center {
			  display: block;
			  margin-left: auto;
			  margin-right: auto;
			  width: 50%;
		}
        </section>
</div>	
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>

</body>
</html>
