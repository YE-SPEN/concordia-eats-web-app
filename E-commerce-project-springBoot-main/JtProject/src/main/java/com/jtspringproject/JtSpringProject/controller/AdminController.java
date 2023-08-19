package com.jtspringproject.JtSpringProject.controller;

import java.sql.*;
import java.time.*;

import javax.servlet.http.*;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;



@Controller
public class AdminController {
	int adminlogcheck = 0;
	String usernameforclass = "";
	public static int id;
	
	public AdminController(){}
	
	public static int getID() {
		return id;
	}
	
	@RequestMapping(value = {"/","/logout"})
	public String returnIndex() {
		adminlogcheck =0;
		usernameforclass = "";
		return "userLogin";
	}
	
	@GetMapping("/index")
	public String index(Model model) {
		if(usernameforclass.equalsIgnoreCase(""))
			return "userLogin";
		else {
			model.addAttribute("username", usernameforclass);
			return "index";
		}
			
	}
	@GetMapping("/userloginvalidate")
	public String userlog(Model model) {
		
		return "userLogin";
	}
	
		@GetMapping("/orders")
	public String orders(Model model) {
		
		return "orders";
	}
	
	@RequestMapping(value = "userloginvalidate", method = RequestMethod.POST)
	public String userlogin(HttpServletRequest request, HttpServletResponse response, @RequestParam("username") String username, @RequestParam("password") String pass,Model model) {
		
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject","root","");
			PreparedStatement pst = con.prepareStatement("INSERT INTO sessions (session_id, user_id) VALUES (?, ?)");
			Statement stmt = con.createStatement();
			ResultSet rst = stmt.executeQuery("select * from users where username = '"+username+"' and password = '"+ pass+"' ;");
			if(rst.next()) {
				usernameforclass = rst.getString(2);
				id = rst.getInt(1);
				LocalDateTime now = LocalDateTime.now();
				pst.setObject(1, now);
				pst.setInt(2, id);
				pst.executeUpdate();
				request.getSession().setAttribute("key" , id);
				return "redirect:/index";
				}
			else {
				model.addAttribute("message", "Invalid Username or Password");
				return "userLogin";
			}
			
		}
		catch(Exception e)
		{
			System.out.println("Exception:"+e);
		}
		return "userLogin";
			
	}
	
	
	@GetMapping("/admin")
	public String adminlogin(Model model) {
		
		return "adminlogin";
	}
	@GetMapping("/adminhome")
	public String adminHome(Model model) {
		if(adminlogcheck!=0)
			return "adminHome";
		else
			return "redirect:/admin";
	}
	@GetMapping("/loginvalidate")
	public String adminlog(Model model) {
		
		return "adminlogin";
	}
	@RequestMapping(value = "loginvalidate", method = RequestMethod.POST)
	public String adminlogin( @RequestParam("username") String username, @RequestParam("password") String pass,Model model) {
		
		if(username.equalsIgnoreCase("admin") && pass.equalsIgnoreCase("123")) {
			adminlogcheck=1;
			return "redirect:/adminhome";
			}
		else {
			model.addAttribute("message", "Invalid Username or Password");
			return "adminlogin";
		}
	}
	@GetMapping("/admin/categories")
	public String getcategory() {
		return "categories";
	}
	@RequestMapping(value = "admin/sendcategory",method = RequestMethod.GET)
	public String addcategorytodb(@RequestParam("categoryname") String catname)
	{
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject","root","");
			Statement stmt = con.createStatement();
			PreparedStatement pst = con.prepareStatement("insert into categories(name) values(?);");
			pst.setString(1,catname);
			int i = pst.executeUpdate();
			
		}
		catch(Exception e)
		{
			System.out.println("Exception:"+e);
		}
		return "redirect:/admin/categories";
	}
	
	@GetMapping("/admin/categories/delete")
	public String removeCategoryDb(@RequestParam("id") int id)
	{
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject","root","");
			Statement stmt = con.createStatement();
			
			PreparedStatement pst = con.prepareStatement("delete from categories where categoryid = ? ;");
			pst.setInt(1, id);
			int i = pst.executeUpdate();
			
		}
		catch(Exception e)
		{
			System.out.println("Exception:"+e);
		}
		return "redirect:/admin/categories";
	}
	
	@GetMapping("/admin/categories/update")
	public String updateCategoryDb(@RequestParam("categoryid") int id, @RequestParam("categoryname") String categoryname)
	{
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject","root","");
			Statement stmt = con.createStatement();
			
			PreparedStatement pst = con.prepareStatement("update categories set name = ? where categoryid = ?");
			pst.setString(1, categoryname);
			pst.setInt(2, id);
			int i = pst.executeUpdate();
			
		}
		catch(Exception e)
		{
			System.out.println("Exception:"+e);
		}
		return "redirect:/admin/categories";
	}

	@GetMapping("/admin/products")
	public String getproduct(Model model) {
		return "products";
	}
	@GetMapping("/admin/products/add")
	public String addproduct(Model model) {
		return "productsAdd";
	}

	@GetMapping("/admin/products/update")
	public String updateproduct(@RequestParam("pid") int id, Model model) {
		String pname,pdescription,pimage;
		int pid,pprice,pquantity,pcategory;
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject","root","");
			Statement stmt = con.createStatement();
			Statement stmt2 = con.createStatement();
			ResultSet rst = stmt.executeQuery("select * from products where id = "+id+";");
			
			if(rst.next())
			{
			pid = rst.getInt(1);
			pname = rst.getString(2);
			pimage = rst.getString(3);
			pcategory = rst.getInt(4);
			pquantity = rst.getInt(5);
			pprice =  rst.getInt(6);
			pdescription = rst.getString(7);
			model.addAttribute("pid",pid);
			model.addAttribute("pname",pname);
			model.addAttribute("pimage",pimage);
			ResultSet rst2 = stmt.executeQuery("select * from categories where categoryid = "+pcategory+";");
			if(rst2.next())
			{
				model.addAttribute("pcategory",rst2.getString(2));
			}
			model.addAttribute("pquantity",pquantity);
			model.addAttribute("pprice",pprice);
			model.addAttribute("pdescription",pdescription);
			}
		}
		catch(Exception e)
		{
			System.out.println("Exception:"+e);
		}
		return "productsUpdate";
	}
	
	@RequestMapping(value = "admin/products/updateData",method=RequestMethod.POST)
	public String updateproducttodb(@RequestParam("id") int id, @RequestParam("name") String name, @RequestParam("productImage") String productImage, @RequestParam("categoryid") int categoryid, @RequestParam("quantity") int quantity, @RequestParam("price") double price, @RequestParam("description") String description) {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject","root","");
			
			PreparedStatement pst = con.prepareStatement("UPDATE products SET name = ?, image = ?, categoryid = ?, quantity = ?, price = ?, description = ? WHERE id = "+id+";");
			pst.setString(1,name);
			pst.setString(2, productImage);
			pst.setInt(3, categoryid);
			pst.setInt(4, quantity);
			pst.setDouble(5, price);;
			pst.setString(6, description);
			pst.executeUpdate();			
		}
		catch(Exception e)
		{
			System.out.println("Exception:"+e);
		}
		return "redirect:/admin/products";
	}
	
	@GetMapping("/admin/products/delete")
	public String removeProductDb(@RequestParam("id") int id)
	{
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject","root","");
			
			
			PreparedStatement pst = con.prepareStatement("delete from products where id = ? ;");
			pst.setInt(1, id);
			int i = pst.executeUpdate();
			
		}
		catch(Exception e)
		{
			System.out.println("Exception:"+e);
		}
		return "redirect:/admin/products";
	}
	
	@PostMapping("/admin/products")
	public String postproduct() {
		return "redirect:/admin/categories";
	}
	@RequestMapping(value = "admin/products/sendData",method=RequestMethod.POST)
	public String addproducttodb(@RequestParam("id") int id, @RequestParam("name") String name, @RequestParam("productImage") String productImage, @RequestParam("categoryid") int categoryid, @RequestParam("quantity") int quantity, @RequestParam("price") double price, @RequestParam("description") String description) {	
		try
		{
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject","root","");
			//String url = productImage;
			//url = url.replace(",","");
			PreparedStatement pst = con.prepareStatement("insert into products(`id`, `name`, `image`, `categoryid`, `quantity`, `price`, `discPrice`, `description`) values(?,?,?,?,?,?,?,?);");
			pst.setInt(1, id);
			pst.setString(2,name);
			pst.setString(3, productImage);
			pst.setInt(4, categoryid);
			pst.setInt(5, quantity);
			pst.setDouble(6, price);
			pst.setDouble(7, price);
			pst.setString(8, description);
			pst.executeUpdate();
		}
		catch(Exception e)
		{
			System.out.println("Exception:"+e);
		}
		return "redirect:/admin/products";
	}
	
	@GetMapping("/admin/customers")
	public String getCustomerDetail() {
		return "displayCustomers";
	}
	
	@GetMapping("/admin/discounts")
	public String getDiscounts() {
		return "discountedProducts";
	}
		
	@RequestMapping(value = "addDiscount",method=RequestMethod.POST)
	public String adddiscounttodb(@RequestParam("productID") int productID, @RequestParam("price") double price, @RequestParam("discountPercentage") int discountPercentage) {
	    
	    try {
	    	
	        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject","root","");
	        
	        PreparedStatement pst = con.prepareStatement("update products set OnDiscount= ?, discPercent= ?, discPrice= price- (price*?/100)  where id= ?;" );
	        pst.setInt(1, 1); 
	        pst.setDouble(2, discountPercentage);
	        pst.setDouble(3, discountPercentage);
	        pst.setInt(4, productID);
	        int i = pst.executeUpdate();
	        System.out.println("discount added"+i);
	    } catch(Exception e) {
	        System.out.println("Exception:"+e);
	    }
	    
	    return "redirect:/admin/products";
	}
	
	@RequestMapping(value = "removeDiscount",method=RequestMethod.POST)
	public String removeDiscount(@RequestParam("id") int id)
	{
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject","root","");
			PreparedStatement pst = con.prepareStatement("update products set OnDiscount= ?, discPercent = ?, discPrice = price where id= ?;");
			pst.setInt(1, 0);
			pst.setInt(2, 0);
			pst.setInt(3, id);
			int i = pst.executeUpdate();
			
		}
		catch(Exception e)
		{
			System.out.println("Exception:"+e);
		}
		return "redirect:/admin/products";
	}
	
	@RequestMapping(value = "updateOrder",method=RequestMethod.POST)
	public String updateOrder(@RequestParam("orderID") int orderID, @RequestParam("status") String status) {
	    
	    try {
	    	
	        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject","root","");
	        
	        PreparedStatement pst = con.prepareStatement("UPDATE orders SET status= ? WHERE order_id= ?;" );
	        pst.setString(1, status); 
	        pst.setInt(2, orderID);
	        int i = pst.executeUpdate();
	        System.out.println("discount added"+i);
	    } 
	    
	    catch(Exception e) {
	        System.out.println("Exception:"+e);
	    }
	    
	    return "redirect:/orders";
	}	
	
	@GetMapping("profileDisplay")
	public String profileDisplay(Model model) {
		String displayusername,displaypassword,displayemail,displayaddress;
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject","root","");
			Statement stmt = con.createStatement();
			ResultSet rst = stmt.executeQuery("select * from users where username = '"+usernameforclass+"';");
			
			if(rst.next())
			{
			int userid = rst.getInt(1);
			displayusername = rst.getString(2);
			displayemail = rst.getString(6);
			displaypassword = rst.getString(3);
			displayaddress = rst.getString(7);
			model.addAttribute("userid",userid);
			model.addAttribute("username",displayusername);
			model.addAttribute("email",displayemail);
			model.addAttribute("password",displaypassword);
			model.addAttribute("address",displayaddress);
			}
		}
		catch(Exception e)
		{
			System.out.println("Exception:"+e);
		}
		System.out.println("Hello");
		return "updateProfile";
	}
	
	@RequestMapping(value = "updateuser",method=RequestMethod.POST)
	public String updateUserProfile(@RequestParam("userid") int userid,@RequestParam("username") String username, @RequestParam("email") String email, @RequestParam("password") String password, @RequestParam("address") String address) 
	
	{
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject","root","");
			
			PreparedStatement pst = con.prepareStatement("update users set username= ?,email = ?,password= ?, address= ? where user_id = ?;");
			pst.setString(1, username);
			pst.setString(2, email);
			pst.setString(3, password);
			pst.setString(4, address);
			pst.setInt(5, userid);
			int i = pst.executeUpdate();	
			usernameforclass = username;
		}
		catch(Exception e)
		{
			System.out.println("Exception:"+e);
		}
		return "redirect:/index";
	}

}


