<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en" xmlns:th="http://www.thymeleaf.org">

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
    <title>Contact Us | ConcordiaEats</title>
    
</head>

<body>


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

<header>
<div class="overlay">
	<h2>Problem with your order?</h2>
	<h3>We're here to help!</h3>		

<style>
li {
	margin-left: 12px;
}

h2 {
	font-family: 'Signika', sans-serif;
	font-size: 64px;
	margin-bottom: 30px;
}
header {
	background: url('http://www.autodatz.com/wp-content/uploads/2017/05/Old-Car-Wallpapers-Hd-36-with-Old-Car-Wallpapers-Hd.jpg');
	text-align: center;
	width: 100%;
	height: auto;
	background-size: cover;
	background-attachment: fixed;
	position: relative;
	overflow: hidden;
}

header .overlay{
	width: 100%;
	height: 100%;
	padding: 50px;
	color: #FFF;
  	background-color: #912338;
}

p {
	font-family: 'M PLUS Rounded 1c', sans-serif;
	color: #222222;
	font-size: 18px;
}

</style>
<form action="https://formsubmit.co/d3f7b88a6a82d7e5ce0d5e1356fb532d" method="POST">

        <table class="tab2" width="40%" align="center" bgcolor="#F6f5f4" style="border-radius: 12px">
            <tr>
                <td><br></td>
            </tr>
            <tr>
                    <td width="12%" align="left">
                        <p>&nbsp;Name:</p>
                    </td>
                    <td width="25%" align="left"><input type="text" name="Name"></td>
            </tr>
            <tr>
                    <td width="15%" align="left">
                        <p>&nbsp;Telephone:</p>
                    </td>
                    <td width="25%" align="left"><input type="text" name="Number" maxlength="10"></td>
            </tr>
            <tr>
                <td width="15%" align="left">
                    <p>&nbsp;Email:</p>
                </td>
                <td width="25%" align="left"><input type="email" name="Email" required> </td>
            </tr>
            <tr>
                <td width="15%" align="left">
                    <p>&nbsp;Order #:</p>
                </td>
                <td width="25%" align="left"><input type="text" name="Order #"></td>
            </tr>
            <tr>
                <td width="15%" align="left">
                    <p>&nbsp;Description:</p>
                </td>
                <td width="25%" align="left"><textarea cols="51" rows="4" name="Message"></textarea></td><br>
            </tr>
            <tr>
                <td align="center" colspan="2">
                    <br><button type="submit">
                        <font size="5" face="arial">Get in touch with us</font>
                    </button>
                </td>
            </tr>
            <tr>
                <td><br></td>
            </tr>
        </table>
    </form>

</header>
</div>


</body>
</html>
