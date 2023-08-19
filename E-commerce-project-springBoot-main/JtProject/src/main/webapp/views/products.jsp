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

<title>Product Manager | ConcordiaEats</title>
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
        .scrollBox {
		  	border: none;
		  	padding: 5px;
		  	width: 100%;
		  	height: 1000px;
		  	overflow: scroll;
		}
		p.discount {
			color: #339933; 
			font-weight: bold;
			font-size: 18px;
		}
		th.sticky {
		    border-collapse: collapse;
		    position: sticky;
		    top: 0;
		}
		th {
		    font-size: 18px;
		}
		p.soldout {
			color: red; 
			font-weight: bold;
			font-size: 18px;
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
                        <a style="color: #fff;" sec:authorize="isAuthenticated()" href="/logout">Logout</a>
                    </button></li>

				</ul>

			</div>
		</div>
	</nav> <br>
	<div class="container-fluid">
	 <style>
	   table {
	     border: 2px solid black;
	   }
	   th.bigger {
       font-size: 1.2em;
       font-weight: bold;
       }
	 </style>
	 
	 	<%
		String filterType = request.getParameter("filter");
		%>
		
	 	<h2>Manage Product & Discounts</h2>
	 	<table class="filterTable" style="border: none">	
			<tr style="cellpadding: 10;">
				<td>					
	 				<a style="margin: 20px 0" class="btn btn-primary" href="/admin/products/add">Add Product</a>
	    		</td>
				<td><h5>&nbsp;&nbsp;&nbsp;Filter by...&nbsp;&nbsp;&nbsp;</h5></td>
				<td scope="col">										
	        		<a class="btn btn-info" href="/admin/products?filter=discounts" style="background-color:<% if ( filterType != null && filterType.equals("discounts")) { %> #339933 <% } else { %> #fff; color: #222222 <% } %>">On Discount</a>
	    		</td>
	    		<td scope="col">
	   				&nbsp;&nbsp;&nbsp;<a href="/admin/products"><b>Clear Filters</b></a>
	   			</td>		
			</tr>
			<tbody>
			</tbody>
		</table>
		<br>
		<table align="left" class="table" style="width: 60%; margin-left:auto; margin-right:auto;">
		    <thead class="thead-light">
		      <tr>
		      	<th scope="col"></th>
		        <th scope="col">Item No.</th>
		        <th scope="col">Product Name</th>
		        <th scope="col">Quantity Sold</th>
		      </tr>
		    </thead>
		    <tbody>
		      <tr>
			      	<%
					try {
						String url = "jdbc:mysql://localhost:3306/springproject";
						Class.forName("com.mysql.cj.jdbc.Driver");
						Connection mcon = DriverManager.getConnection(url, "root", "");
						Statement maxstmt = mcon.createStatement();
						Statement minstmt = mcon.createStatement();						
						ResultSet max = maxstmt.executeQuery("SELECT * FROM products WHERE qtySold = (SELECT MAX(qtySold) FROM products)");
						ResultSet min = minstmt.executeQuery("SELECT * FROM products WHERE qtySold = (SELECT MIN(qtySold) FROM products)");
					
		            if (max.next()) { %>
		                <th class="bigger">Best Selling Item:</th>
		                <td><%= max.getInt(1) %></td>
		                <td><%= max.getString(2) %></td>
		                <td><%= max.getInt(10) %></td>
		            </tr>
		            <tr>
		                <% if (min.next()) { %>
		                	<th class="bigger">Least Selling Item:</th>
		                    <td><%= min.getInt(1) %></td>
		                    <td><%= min.getString(2) %></td>
		                    <td><%= min.getInt(10) %></td>
		                <% } %>
		      </tr>
			  <%
			  }
			  %>
		      
		    </tbody>
		    <%
			} catch (Exception ex) {
			out.println("Exception Occurred:: " + ex.getMessage());
			}
			%>
		  </table>
		
		
	<div class="container-fluid scrollBox">
		<table class="table">
			<thead class="thead-light">
			<tr>
				<th scope="col" width="6%" class="sticky">Item No.</th>
				<th scope="col" width="10%" class="sticky">Product Name</th>
				<th scope="col" width="10%" class="sticky">Preview</th>
				<th scope="col" width="8%" class="sticky">Category</th>
				<th scope="col" width="6%" class="sticky">On Hand</th>
				<th scope="col" width="10%" class="sticky">Price</th>
				<th scope="col" width="6%" class="sticky">Discount</th>
				<th scope="col" width="6%" class="sticky">Qty Sold</th>
				<th scope="col" width="18%" class="sticky">Description</th>
				<th scope="col" width="8%" class="sticky"></th>
				<th scope="col" width="6%" class="sticky"></th>
				<th scope="col" width="6%" class="sticky"></th>
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
						ResultSet rs = null;
						
						// Check for filter parameter
					    if (filterType != null && filterType.equals("discounts")) {
					            rs = stmt.executeQuery("SELECT * FROM products WHERE onDiscount = 1");
					    } 
					    else {
							rs = stmt.executeQuery("select * from products");
					    }
					%>
					<%
					while (rs.next()) {

					%>
					<td>
						<h5><%= rs.getInt(1) %></h5>
					</td>
					<td>
						<h5><%= rs.getString(2) %></h5>
						<% if (rs.getInt(5) == 0) { %>
							<p class="soldout">SOLD OUT </p>
						<% } %>
					</td>
					<td>
					     <img src="<%= rs.getString(3) %>" height="100px" width="100px" />
					</td>
					<td>
						<%
							int categoryid = rs.getInt(4);
							ResultSet rs2 = stmt2.executeQuery("select * from categories where categoryid = "+categoryid+";");
							if(rs2.next())
							{
								out.print(rs2.getString(2));
							}
						%>
						
					</td>
					<td>
						<%= rs.getInt(5) %>
					</td>
					<td>
						<% if (rs.getInt(7) == 0) { %>
							<h5><b>$ <%= rs.getDouble(6) %></b></h5>
						<% }
						%>
						<% if (rs.getInt(7) ==1) { %>
							<h5><s>$ <%= rs.getDouble(6) %></s><br></h5>
							<h5><b>$ <%= rs.getDouble(9) %></b></h5>
						<% }
						%>
					</td>
					<td>
						<% if (rs.getInt(7) != 0) { %>
							<p class="discount"><%= rs.getInt(8) %>%</p>
						<% }
						%>
					</td>
					<td>
						<%= rs.getInt(10) %>
					</td>
					<td>
						<%= rs.getString(11) %>
					</td>
					<td>
						<% if (rs.getInt(7) == 0) { %>
						<!-- Button trigger modal -->
						<button type="button" style="margin: 0px 0; background-color: #339933" class="btn btn-info" data-toggle="modal" data-target="#exampleModalCenter<%=rs.getInt(1)%>">
							Add	Discount
						</button>
	
						<!-- Modal -->
						<div class="modal fade" id="exampleModalCenter<%=rs.getInt(1)%>" tabindex="-1"
							role="dialog" aria-labelledby="exampleModalCenterTitle"
							aria-hidden="true">
							<div class="modal-dialog modal-dialog-centered" role="document">
								<div class="modal-content">
									<form action="/addDiscount" method="post">
										<div class="modal-header">
											<h5 class="modal-title" id="exampleModalLongTitle">Add Discount</h5>
											<button type="button" class="close" data-dismiss="modal"
												aria-label="Close">
												<span aria-hidden="true">&times;</span>
											</button>
										</div>
										<div class="modal-body  text-center">
											<input type="hidden" name="productID" value="<%=rs.getInt(1)%>">
											<input type="hidden" name="price" value="<%=rs.getDouble(6) %>">
											<input type="number" name="discountPercentage" class="form-control" max="100" min="0"
												id="discountPercentage" required="required" placeholder="Discount Percentage">    
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-secondary"
												data-dismiss="modal">Close</button>
											<input type="submit" value="Save Changes" class="btn btn-info" style="background-color: #339933">
										</div>
									</form>
								</div>
							</div>
						</div><br>
	
						<% }
						%>
						<% if (rs.getInt(7) != 0) { %>
							
						<form action="/removeDiscount" method="post">
							<input type="hidden" name="id" value="<%= rs.getInt(1) %>">
							<input type="submit" value="Remove Discount" class="btn btn-danger">	
						</form>
							
						<% }
							%>
					</td>
					<td>
						<form action="products/update" method="get">
							<input type="hidden" name="pid" value="<%=rs.getInt(1)%>">
							<input type="submit" value="Update" class="btn btn-warning">
						</form>
					</td>
					<td>
						<form action="products/delete" method="get">
							<input type="hidden" name="id" value="<%=rs.getInt(1)%>">
							<input type="submit" value="Delete" class="btn btn-danger">
						</form>
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
