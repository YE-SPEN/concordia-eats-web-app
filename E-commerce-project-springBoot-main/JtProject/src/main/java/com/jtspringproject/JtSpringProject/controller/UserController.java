package com.jtspringproject.JtSpringProject.controller;

import java.sql.Connection;
import java.time.*;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
// import java.sql.Statement;
import java.time.LocalDate;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class UserController{
	
	public UserController(){}
	
	@GetMapping("/register")
	public String registerUser()
	{
		return "register";
	}
	@GetMapping("/contact")
	public String contact()
	{
		return "contact";
	}
	@GetMapping("/basket")
	public String basket()
	{
		return "basket";
	}
	@GetMapping("/buy")
	public String buy()
	{
		return "buy";
	}
	@GetMapping("/orderconfirmation")
	public String orderConfirmation()
	{
		return "orderConfirmation";
	}	
	@GetMapping("/user/products")
	public String getproduct(Model model) {
		return "uproduct";
	}
	
	@RequestMapping(value = "newuserregister", method = RequestMethod.POST)
	public String newUseRegister(@RequestParam("username") String username,@RequestParam("password") String password,@RequestParam("email") String email)
	{
		try
		{
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject","root","");
			PreparedStatement pst = con.prepareStatement("insert into users(username,password,email) values(?,?,?);");
			pst.setString(1,username);
			pst.setString(2, password);
			pst.setString(3, email);
			

			//pst.setString(4, address);
			int i = pst.executeUpdate();
			System.out.println("data base updated"+i);
			
		}
		catch(Exception e)
		{
			System.out.println("Exception:"+e);
		}
		return "redirect:/";
	}
	@RequestMapping(value = "addfavorite", method = RequestMethod.POST)
	public String addFavorite(@RequestParam("userID") int userID, @RequestParam("productID") int productID, @RequestParam("currentPage") String page) {
		
		try	{
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject","root","");
			PreparedStatement pst = con.prepareStatement("INSERT INTO favorites(user_id,product_id) VALUES(?,?);");
			pst.setInt(1, userID);
			pst.setInt(2, productID);
			int i = pst.executeUpdate();
			System.out.println("data base updated"+i);
			
		}
		
    	catch(Exception e){
			System.out.println("Exception:"+e);
		}
    	return page;
    }
	@RequestMapping(value = "removefavorite", method = RequestMethod.POST)    
    	public String removeFavorite(@RequestParam("userID") int userID, @RequestParam("productID") int productID, @RequestParam("currentPage") String page) {
    	
    	try	{
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject","root","");
			PreparedStatement pst = con.prepareStatement("DELETE FROM favorites WHERE product_id=? AND user_id=?");
			pst.setInt(1, productID);
			pst.setInt(2, userID);
			int i = pst.executeUpdate();
			System.out.println("data base updated"+i);
		  
		}
		
    	catch(Exception e){
			System.out.println("Exception:"+e);
		}
    	return page;
    }
	
	@RequestMapping(value = "addtobasket", method = RequestMethod.POST)
	public String addToBasket(@RequestParam("userID") int userID, @RequestParam("productID") int productID, @RequestParam("qty") int quantity, @RequestParam("currentPage") String page) {
		
		try	{
			
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject","root","");
			
			PreparedStatement checkStmt = con.prepareStatement("SELECT * FROM basketItems WHERE user_id=? AND product_id=?;");
			checkStmt.setInt(1, userID);
			checkStmt.setInt(2, productID);
			
			ResultSet checkSet = checkStmt.executeQuery();
			
			if (checkSet.next()) {
				PreparedStatement updateStmt = con.prepareStatement("UPDATE basketItems SET quantity=(quantity+?) WHERE user_id=? AND product_id=?;");
				updateStmt.setInt(1, quantity);
				updateStmt.setInt(2, userID);
				updateStmt.setInt(3, productID);
				
				int i = updateStmt.executeUpdate();
				System.out.println("data base updated"+i);
			}
			
			else {
				PreparedStatement addStmt = con.prepareStatement("INSERT INTO basketItems(user_id,product_id,quantity) VALUES(?,?,?);");
				addStmt.setInt(1, userID);
				addStmt.setInt(2, productID);
				addStmt.setInt(3, quantity);
				
				addStmt.executeUpdate();
			}
		}
		
    	catch(Exception e){
			System.out.println("Exception:"+e);
		}
    	return page;
    }
	
	@RequestMapping(value = "removefrombasket", method = RequestMethod.POST)    
    	public String removeFromBasket(@RequestParam("userID") int userID, @RequestParam("productID") int productID) {
    	
    	try	{
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject","root","");
			PreparedStatement pst = con.prepareStatement("DELETE FROM basketItems WHERE product_id=? AND user_id=?");
			pst.setInt(1, productID);
			pst.setInt(2, userID);
			int i = pst.executeUpdate();
			System.out.println("data base updated"+i);
		  
		}
		
    	catch(Exception e){
			System.out.println("Exception:"+e);
		}
    	return "redirect:/basket";
    }
	
	public int getCategory(String x) {
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject","root","");
			Statement stmt = con.createStatement();
			String query = "SELECT categoryid FROM categories WHERE name LIKE '%" + x + "%'";
			ResultSet rs = stmt.executeQuery(query);
			int cat = 0;
			if (rs.next())
				cat = rs.getInt(1);
			return cat;
		}
		
		catch(Exception e)
		{
				System.out.println("Exception:"+e);
		}
		return 0;
		
	}
	
	@RequestMapping(value = "search",method = RequestMethod.POST)
	public String search(HttpServletRequest request, @RequestParam("search") String search, @RequestParam("column") String column) {
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject","root","");
			Statement stmt = con.createStatement();
			String query = "SELECT * FROM products WHERE name LIKE '%" + search + "%'";
			ResultSet rs = stmt.executeQuery(query);
			request.getSession().setAttribute("search", rs);
		}
		catch(Exception e)
		{
			System.out.println("Exception:"+e);
		}
		
		return "redirect:/user/products?filter=search";
	}
	
	@RequestMapping(value = "filter",method = RequestMethod.POST)
	public String filter(@RequestParam("filterType") String filterType, @RequestParam("id") int categoryID) {
		String redirect = "";
		String type = filterType;
		int id = categoryID;
		
		if (type.equals("category")) {
			redirect = "?filter=category&id=" + id;
		}
		
		if (type.equals("favorites")) {
			redirect = "?filter=favorites";
		}
		
		if (type.equals("discounts")) {
			redirect = "?filter=discounts";
		}
		
		return "redirect:/user/products" + redirect;
	}
	
	@RequestMapping(value = "placeorder", method = RequestMethod.POST)    
	public String placeOrder(@RequestParam("userID") int userID) {
	
		int lineQty = 0;
		int lineItem = 0;
		int orderNo = 0;
		LocalDate invoiceDate = LocalDate.now();
		
		try	{
			// generate order record
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject","root","");	
			PreparedStatement generateOrder = con.prepareStatement("INSERT into orders (user_ID, order_date, status) VALUES(?,?,'Processing')");
			generateOrder.setInt(1, userID);
			generateOrder.setDate(2, java.sql.Date.valueOf(invoiceDate));
			
			generateOrder.executeUpdate();
			
			// retrieve order ID
			PreparedStatement nextOrder = con.prepareStatement("SELECT max(order_id) from orders");
			ResultSet order = nextOrder.executeQuery();
			
			while(order.next()) {
				orderNo = order.getInt(1);
			}
			
			// query basket items
			PreparedStatement pst = con.prepareStatement("SELECT * from basketItems WHERE user_id=?");
			pst.setInt(1, userID);
	
			ResultSet rs = pst.executeQuery();
			
			while (rs.next()) {
				lineItem = rs.getInt(2);
				lineQty = rs.getInt(3);
				
				// update available inventory
				PreparedStatement updateInv = con.prepareStatement("UPDATE products SET qtySold=(qtySold+?), quantity=(quantity-?) WHERE id=?");
				updateInv.setInt(1, lineQty);
				updateInv.setInt(2, lineQty);
				updateInv.setInt(3, lineItem);
				
				updateInv.executeUpdate();
				
				
				// record sale
				PreparedStatement newSale = con.prepareStatement("INSERT into sales (order_id, product_id, qtySold) VALUES(?,?,?)");
				newSale.setInt(1, orderNo);
				newSale.setInt(2, lineItem);
				newSale.setInt(3, lineQty);
				
				newSale.executeUpdate();
			}
				
			// clear user basket
			PreparedStatement pst2 = con.prepareStatement("DELETE from basketItems WHERE user_id=?");
			pst2.setInt(1, userID);
			
			int i = pst2.executeUpdate();
			System.out.println("data base updated "+i);
			
		}
		
		catch(Exception e){
			System.out.println("Exception: "+e);
		}
		return "redirect:/orderconfirmation";
	}
	  
	
	   
}
