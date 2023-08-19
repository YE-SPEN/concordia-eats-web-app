<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
<%@page import ="java.io.FileOutputStream" %>    
<%@page import=" java.io.ObjectOutputStream" %>
<%@ page import="java.net.URL" %> 
<%@ page import="java.io.InputStream" %>   
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

<title>Order Manager | ConcordiaEats</title>
<style>

        .nav-item a {
            color: white;
            font-size: 17px;
        }

    	 .nav-item:hover {
            color: rgb(0, 195, 255);
            font-weight: bold;
     	}

        .navbar-brand {
            color: white;
            font-weight: 600;
            font-size: 20px;
        }

        .nav-item {
            margin-right: 20px;
        }
        td {
        	font-size: 18px;
        	
        }
	   th {
	       font-size: 1.2em;
	       font-weight: bold;
	   }
		.modal-lg {
		  max-width: 60%;
		}
		p {
  			margin-bottom: 0.3em;
		}
		.dropdown-menu {
    	width: 100px;
  		}
	 </style>

</head>
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
	<div class="container">
		
		<h2><br>Order History</h2>
		<table class="table" style="margin-left:auto; margin-right:auto;">
		    <thead class="thead-light">
		      <tr>
		        <th scope="col">Order No.</th>
		        <th scope="col">User Name</th>
		        <th scope="col">Invoice Date </th>
		        <th scope="col">Order Status </th>
		        <th scope="col">Invoice Amount</th>
		        <th scope="col"></th>	
		        <th scope="col"></th>
		        
		      </tr>
		    </thead>
		    <tbody>
		      <tr>
			      	<%
					try {
						String url = "jdbc:mysql://localhost:3306/springproject";
						Class.forName("com.mysql.cj.jdbc.Driver");
						Connection mcon = DriverManager.getConnection(url, "root", "");
						Statement rstmt = mcon.createStatement();					
						ResultSet rs = rstmt.executeQuery("SELECT o.order_id, username, order_date, status, sum(discPrice*s.qtySold) FROM products p, orders o, users u, sales s WHERE u.user_id = o.user_id AND o.order_id = s.order_id AND p.id = s.product_id GROUP BY o.order_id;");
					
		            while (rs.next()) { %>
		                <td><b><%= rs.getInt(1) %></b></td>
		                <td><%= rs.getString(2) %></td>
		                <td><%= rs.getDate(3) %></td>
		                <td><%= rs.getString(4) %></td>
		                <td><b>$ <%= rs.getDouble(5) %></b></td>
		               <td>
			               <button type="button" style="margin: 0px 0" class="btn btn-warning" 
							data-toggle="modal" data-target="#update<%=rs.getInt(1)%>">Update Status
							</button>
							
							<div class="modal fade" id="update<%=rs.getInt(1)%>" tabindex="-1"
								role="dialog" aria-labelledby="exampleModalCenterTitle"
								aria-hidden="true">
								<div class="modal-dialog modal-dialog-centered" role="document">
									<div class="modal-content">
										<form action="/updateOrder" method="post">
											<div class="modal-header">
												<h5 class="modal-title" id="exampleModalLongTitle">Update Order# <%= rs.getInt(1) %></h5>
												<button type="button" class="close" data-dismiss="modal"
													aria-label="Close">
													<span aria-hidden="true">&times;</span>
												</button>
											</div>
											<div class="modal-body  text-center">
												<input type="hidden" name="orderID" value="<%=rs.getInt(1)%>">
												<select name="status" id="status">
								                    <option value="Processing">Processing</option>
								                    <option value="Shipped">Shipped</option>
								                    <option value="Delivered">Delivered</option>
								                </select>  
											</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-secondary"
													data-dismiss="modal">Close</button>
												<input type="submit" value="Update Status" class="btn btn-danger" style="background-color: #339933">
											</div>
										</form>
									</div>
								</div>
							</div><br>
							
		               <td>  
							<button type="button" style="margin: 0px 0; background-color: #339933" class="btn btn-danger" 
							data-toggle="modal" data-target="#order<%=rs.getInt(1)%>">View Order Details
							</button>
			
				             <div class="modal fade" id="order<%=rs.getInt(1)%>" tabindex="-1"
								role="dialog" aria-labelledby="exampleModalCenterTitle"
								aria-hidden="true">
								<div class="modal-dialog modal-lg" role="document">
									<div class="modal-content" style="margin-left:auto; margin-right:auto;">
										<div class="modal-header">
											<h2>Order# <%= rs.getInt(1) %></h2>
											<button type="button" class="close" data-dismiss="modal"
													aria-label="Close">
													<span aria-hidden="true">&times;</span>
											</button>
										</div>
										<div class="modal-body"> 
												<p><b>Order placed:</b> <%= rs.getDate(3) %></p>
												<p><b>Purchased by:</b> <%= rs.getString(2) %></p>
												<p><b>Current status:</b> <%= rs.getString(4) %></p> 
												<table class="table" style="width: 100%; margin-left:auto; margin-right:auto;">
													    <thead class="thead-light">
													      <tr>
													        <th scope="col">Product ID</th>
													        <th scope="col">Name</th>
													        <th scope="col">Quantity</th>
													        <th scope="col">Subtotal</th>													        
													      </tr>
													    </thead>
													    <tbody>
													      	<tr>
															    <%
																try {
																	int order = rs.getInt(1);
							                						Statement rs2tmt = mcon.createStatement();
							               							ResultSet rs2 = rs2tmt.executeQuery("SELECT id, name, s.qtySold, (discPrice*s.qtySold) FROM products p, sales s, orders o WHERE o.order_id = s.order_id AND s.product_id = id AND o.order_id = "+order+" ");
																
														        while (rs2.next()) { %>
														                <td><%= rs2.getInt(1) %></td>
														                <td><%= rs2.getString(2) %></td>
														                <td><%= rs2.getInt(3) %></td>
														                <td><b>$ <%= rs2.getDouble(4) %></b></td>
									                   		</tr>
															  <%
															  }
															  %>
															<tr>																													             
												                <td></td>
												                <td></td>
												                <td><b>Invoice Total:</b></td>
												                <td><b>$ <%= rs.getDouble(5) %></b></td>
															</tr>  
														
													    </tbody>
													    <%
														} catch (Exception ex) {
														out.println("Exception Occurred:: " + ex.getMessage());
														}
														%>
					  							</table> 
										</div>
										<div class="modal-footer">
												<button type="button" class="btn btn-secondary"
													data-dismiss="modal">Close</button>
										</div>
									</div>
								</div>
							</div><br>
						</td>
					</tr>
					<% } %>
		            
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
