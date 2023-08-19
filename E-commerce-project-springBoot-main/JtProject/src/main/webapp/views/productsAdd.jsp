<!doctype html>
<%@page import="java.sql.*"%>
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
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.7.0/css/all.css"
	integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ"
	crossorigin="anonymous">
<title>Add New Product | ConcordiaEats</title>
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
<body>
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
					<li class="nav-item active"><a class="nav-link" href="/orders">Orders</a></li>
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
	</nav> <br>
	<div class="jumbotron container border border-info">
		<h3>Add a new Product</h3>
		<form action="sendData" method="post">
			<div class="row">
				<div class="col-sm-5">
					<%
					try {
						String url = "jdbc:mysql://localhost:3306/springproject";
						Class.forName("com.mysql.cj.jdbc.Driver");
						Connection con = DriverManager.getConnection(url, "root", "");
						Statement stmt = con.createStatement();
						Statement stmt2 = con.createStatement();
						ResultSet rs = stmt.executeQuery("select * from products order by id desc");
					%>
					<div class="form-group">
						<%
						if (rs.next()) {
						%>
						<label for="name">Id</label> 
						<input type="number" readonly="readonly" class="form-control border border-warning" name="id"  value="<%=rs.getInt(1) + 1%>">
						
						<%
						}
						%>
						

					</div>
					<div class="form-group">
						<label for="name">Name</label> 
						<input type="text" class="form-control border border-warning" required name="name" placeholder="Enter name">
					</div>
					
					<div class="form-group">
					
						<label for="category">Select Category</label> 
							<select class="form-control border border-warning" name="categoryid" required >
							<% 
							ResultSet rs2 = stmt2.executeQuery("select * from categories");
							while(rs2.next())
							{
								%>
								<option value="<%= rs2.getInt(1) %>"><%= rs2.getString(2) %> </option>
								<%	
							}
							%>
						</select>
					</div>
					<div class="form-group">
						<label for="price">Price</label> 
						<input type="number" class="form-control border border-warning" required name="price" step="any" placeholder="Price">
					</div>
					<div class="form-group">
						<label for="quantity">Available Quantity</label> 
						<input type="number" class="form-control border border-warning" required name="quantity" min="1" placeholder="Quantity">
					</div>
					
					
				</div>
				
				<div class="col-sm-5"><br>
				<div class="form-group">
						<label for="description">Product Description</label>
						<textarea class="form-control border border-warning" rows="4" name="description" placeholder="Product Details" value= "no product details"></textarea>
					</div>
					<div class="form-group">
					  <label for="productImage">Image URL</label>
					  <textarea class="form-control border border-warning" rows="2" placeholder="Enter URL Here" name="productImage"></textarea>
					</div>
					<input type="submit" class="btn btn-primary">
				</div>
			</div>
		</form>
		<%
		} catch (Exception e) {
		System.out.println("Exception: " + e);
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
		<script type="text/javascript">
						var loadFile = function(event) {
							var image = document.getElementById('imgPreview');
							image.src = URL.createObjectURL(event.target.files[0]);
						};
						</script>
</body>
</html></html>
