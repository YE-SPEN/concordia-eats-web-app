<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.*"%>

<!doctype html>
<html lang="en" xmlns:th="http://www.thymeleaf.org">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
	integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
	crossorigin="anonymous">

<title>Order Confirmed! | ConcordiaEats</title>
<style>
li {
	margin-left: 12px;
}

p.discount {
	color: #339933; 
	font-weight: bold;
	font-size: 18px;

}

p {
	font-size: 18px;

}

</style>
</head>
<body class="bg-light">

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
                    <a class="nav-link" th:href="@{/basket}" href="/basket"><b>My Basket </b><%= fetchedCount.getInt(1) %></a>
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
	
	<div class="container">
		<img src="https://467210.fs1.hubspotusercontent-na1.net/hubfs/467210/order-delivered.png" width="200px">
		<h1 style="margin-top: 10px">Your order is on its way...</h1>
		<h5><br>Thank you for shopping with ConcordiaEats! Your order has been received and is being processed. If you have any problems with your order or need to cancel, please reach out to our administration team.</h5>
        <br>

		<table class="table">
			<tbody>
				<tr>
					<td>					
						<a href="/index" type="button" class="btn btn-info btn-lg" style="background-color: #912338">
							Continue Shopping
						</a>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="/contact" type="button" class="btn btn-info btn-lg" style="background-color: #fff; color: #000">
							Contact Us
						</a>
					
					</td>
				</tr>
			</tbody>
		</table>
	

	
	<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
		integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
		integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
		crossorigin="anonymous"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
		integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
		crossorigin="anonymous"></script>
</body>
</html>
