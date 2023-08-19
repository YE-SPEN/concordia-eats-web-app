<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
<%@page import="com.jtspringproject.JtSpringProject.*" %>
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

<title>Shop All Products | ConcordiaEats</title>
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

td {
	font-size: 16px;
	vertical-align: middle;
}

th {
    background-color: #222222;
    position: sticky;
    top: 0;
  }

.scrollBox {
  border: none;
  padding: 5px;
  width: 100%;
  height: 1000px;
  overflow: scroll;
}
::-webkit-scrollbar {
  width: 12px;
  height: 12px;
}
::-webkit-scrollbar-track {
  border: 1px #222222;
  border-radius: 10px;
}
::-webkit-scrollbar-thumb {
  background: #A8A8A8;  
  border-radius: 10px;
}
::-webkit-scrollbar-thumb:hover {
  background: #787878;  
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
		ResultSet fetchedCount = cartCount.executeQuery("SELECT count(*) FROM basketItems WHERE user_id = "+ uid +";");							
	
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
	<div class="container-fluid">
		<h2>Shop All Products</h2>
	</div>

	<div class="container-fluid scrollBox">
		<table class="table">
			<tr style="background-color: #222222; color: #fff">
				<th scope="col" width="10%">Item No.</th>
				<th scope="col" width="10%">Preview</th>
				<th scope="col" width="15%">Product Name
					<form method="post" action="/filter">
						<input type="hidden" name="column" value="name">
        				<input type="text" name="search" placeholder="search">
        				<button type="submit">Filter</button>
    				</form>
    			</th>
				<th scope="col" width="10%">Category
					<form method="post" action="/filter">
						<input type="hidden" name="column" value="category">
        				<input type="text" name="search" placeholder="search">
        				<button type="submit">Filter</button>
    				</form>
				</th>
				<th scope="col" width="6%">Price</th>
				<th scope="col" width="6%">Discount</th>
				<th scope="col" width="15%">Description</th>
				<th scope="col" width="15%"></th>
				<th scope="col" width="5%">Favorites</th>
				
			</tr>
			<tbody>
				<tr>

					<%
					try {
						int uid = (int)session.getAttribute("key");
						String url = "jdbc:mysql://localhost:3306/springproject";
						Class.forName("com.mysql.cj.jdbc.Driver");
						Connection con = DriverManager.getConnection(url, "root", "");
						Statement recos = con.createStatement();
						Statement stmt = con.createStatement();
						Statement stmt2 = con.createStatement();
						Statement stmt3 = con.createStatement();
						Statement stmt4 = con.createStatement();
						ResultSet rs = (ResultSet)session.getAttribute("filter");
					%>
					<%
					while (rs.next()) {
					%>
					<td>
						<h5><%= rs.getInt(1) %></h5>
						<%								
							int productid = rs.getInt(1);	
							ResultSet recResult = recos.executeQuery("SELECT * FROM products WHERE id=" + productid + " AND id IN (SELECT product_id FROM sales WHERE order_id in (SELECT order_id FROM orders where user_id = "+ uid +") AND qtySold > 2) LIMIT 3");
						
							if(recResult.next()) { %>
								<p class="discount">Recommended for You</p>
						<%
						} %>
					</td>
					<td><img src="<%= rs.getString(3) %>"
						height="125px" width="125px">
					</td>
					<td>
						<h5><%= rs.getString(2) %></h5>
						<%								
							ResultSet rs3 = stmt3.executeQuery("SELECT quantity FROM basketItems WHERE user_id="+ uid +" AND product_ID="+productid+";");
							
							if(rs3.next()) { %>
								<p class="discount">You have <%= rs3.getInt(1)%> in your basket.</p>
						<%
						} %>
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
						<% if (rs.getInt(8) != 0) { %>
							<p class="discount"><%= rs.getInt(8)%> % Off!</p>
						<% }
						%>
					</td>
					<td>
						<%= rs.getString(11) %>
					</td>

					<td>
						<form action="/addtobasket" method="post">
							<input type="hidden" name="userID" value="<%= uid %>">
							<input type="hidden" name="currentPage" value="redirect:/user/products">
							<input type="hidden" name="productID" value="<%=rs.getInt(1)%>">
							<label for="quantity"><b>QTY:</b></label>
							<input type="number" id="qty" name="qty" min="1" max="<%= rs.getInt(5) %>" value="1">&nbsp;&nbsp;&nbsp;     
							<input type="submit" value="Add to Basket" class="btn btn-info" style="background-color: #339933">
							
						</form>
					</td>
					<td>
						<%													
							ResultSet rs4 = stmt4.executeQuery("SELECT * FROM favorites WHERE user_id="+ uid +" AND product_ID="+productid+";");
							
							if(rs4.next()) { %>
								<form action="/removefavorite" method="post">
									<input type="hidden" name="userID" value="<%= uid %>">
									<input type="hidden" name="productID" value="<%=rs.getInt(1)%>">
									<input type="image" width="60px" src="https://467210.fs1.hubspotusercontent-na1.net/hubfs/467210/heart-full.png">							
								</form>
							<%  }
							else {
							%>
								<form action="/addfavorite" method="post">
									<input type="hidden" name="userID" value="<%= uid %>">
									<input type="hidden" name="productID" value="<%=rs.getInt(1)%>">
									<input type="image" width="60px" src="https://467210.fs1.hubspotusercontent-na1.net/hubfs/467210/heart-hollow.png">							
								</form>
							<% } %>
					</td>

				</tr>
				<%
				}
				%>

			</tbody>
		</table>
		
		<!-- Add to Basket Modal -->
		<div class="modal fade" id="basketmessage" tabindex="-1"
			role="dialog" aria-labelledby="exampleModalCenterTitle"
			aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered" role="document">
				<div class="modal-content">
						<div class="modal-header">
							<h4 class="modal-title" id="exampleModalLongTitle">Your basket has been updated!</h4>
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-footer">
							<p>Your credit card will be charged the full order amount upon submission.</p>
							<button type="button" class="btn btn-secondary"
								data-dismiss="modal">Keep Shopping</button>
							<a href="/basket" type="button" class="btn btn-info btn" style="background-color: #912338">
								Checkout
							</a>
						</div>
				</div>
			</div>
		</div>
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
