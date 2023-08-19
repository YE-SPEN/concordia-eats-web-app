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

<title>Customer Manager | ConcordiaEats</title>
</head>

<style>
     .nav-item {
        margin-right: 14px;
        font-size: 18px; 
     }
     
     .nav-item:hover {
            color: rgb(0, 195, 255);
            font-weight: bold;
     }
     		
</style>

<body class="bg-light">
		<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
		<div class="container-fluid">
			<a class="navbar-brand" href="/adminhome"> <img
				src="https://467210.fs1.hubspotusercontent-na1.net/hubfs/467210/Concordia-eats-logo-white.png" width="auto" height="60"
				class="d-inline-block align-top" alt="" />
			</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>

			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav mr-auto"></ul>
				<ul class="navbar-nav">
					<li class="nav-item active"><a class="nav-link" href="/admin/categories">Categories</a></li>
					<li class="nav-item active"><a class="nav-link" href="/admin/products">Products</a></li>
					<li class="nav-item active"><a class="nav-link" href="/admin/customers">Customers</a></li>
					<li class="nav-item active">
						<button class="nav-link" style="background-color: #fff; border-radius: 32px; border: 0px; padding-left: 18px; padding-right: 18px; border: 1px solid #222222;">
	                        <a style="color: #222222;" href="/adminhome">Admin Home</a>
	                    </button>
					</li>
					<li class="nav-item active">                    
					<button class="nav-link" style="background-color: #912338; border-radius: 32px; border: 0px; padding-left: 18px; padding-right: 18px;">
                        <a style="color: #fff;" sec:authorize="isAuthenticated()" href="logout">Logout</a>
                    </button></li>

				</ul>

			</div>
		</div>
	</nav><br>
	<div class="container-fluid">

		
		<table class="table">
			<thead class="thead-light">
			<tr>
				<th scope="col">UserId</th>
				<th scope="col">Customer Name</th>
				<th scope="col">Email</th>
				<th scope="col">Address</th>
			</tr>
			</thead>
			<tbody>
				<tr>

					<%
					try {
						String url = "jdbc:mysql://localhost:3306/springproject";
						Class.forName("com.mysql.cj.jdbc.Driver");
						Connection con = DriverManager.getConnection(url, "root", "");
						Statement stmt = con.createStatement();
						Statement stmt2 = con.createStatement();
						ResultSet rs = stmt.executeQuery("select * from users");
					%>
					<%
					while (rs.next()) {
					%>
					<td>
						<%= rs.getInt(1) %>
					</td>
					<td>
						<%= rs.getString(2) %>
					</td>
					<td>
						<%= rs.getString(6) %>
						</td>
					<td>
						<%= rs.getString(5) %>
					</td>

				</tr>
				<%
				}
				%>

			</tbody>
		</table>
		<%
		} catch (Exception ex) {
		out.println("Exception Occurred:: " + ex.getMessage());
		}
		%>
	</div>



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
