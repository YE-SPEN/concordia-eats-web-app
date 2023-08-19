package com.jtspringproject.JtSpringProject;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.InjectMocks;

import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.when;
import static org.junit.jupiter.api.Assertions.assertEquals;

import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.ui.Model;

import com.jtspringproject.JtSpringProject.controller.AdminController;


import org.junit.runner.JUnitCore;
import org.junit.runner.Result;
import org.junit.runner.notification.Failure;


@SpringBootTest
class JtSpringProjectApplicationTests {

	
	    public static void main(String[] args) {
	        Result result = JUnitCore.runClasses(JtSpringProjectApplicationTests.class);
	        for (Failure failure : result.getFailures()) {
	            System.out.println(failure.toString());
	        }
	        System.out.println(result.wasSuccessful());
	}


	@Mock
    private HttpServletRequest request;

    @Mock
    private HttpServletResponse response;

    @Mock
    private Model model;
    
    @InjectMocks
    private AdminController AdminController;
 
		
    @Test
    public void testValidLogin() throws Exception {
        MockHttpServletRequest request = new MockHttpServletRequest();
        MockHttpServletResponse response = new MockHttpServletResponse();

        // Arrange
        String username = "jay";
        String password = "123";
        Connection con = Mockito.mock(Connection.class);
        PreparedStatement pst = Mockito.mock(PreparedStatement.class);
        Statement stmt = Mockito.mock(Statement.class);
        ResultSet rst = Mockito.mock(ResultSet.class);

        when(con.prepareStatement(anyString())).thenReturn(pst);
        when(con.createStatement()).thenReturn(stmt);
        when(stmt.executeQuery(anyString())).thenReturn(rst);
        when(rst.next()).thenReturn(true);
        when(rst.getInt(1)).thenReturn(1);
        when(rst.getString(2)).thenReturn(username);
        


        // Act
        String result = AdminController.userlogin(request, response, username, password, model);

        // Assert
        assertEquals("redirect:/index", result);
    }

    @Test
    public void testInvalidLogin() throws Exception {
        MockHttpServletRequest request = new MockHttpServletRequest();
        MockHttpServletResponse response = new MockHttpServletResponse();

        // Arrange
        String username = "testuser";
        String password = "testpassword";
        Connection con = Mockito.mock(Connection.class);
        PreparedStatement pst = Mockito.mock(PreparedStatement.class);
        Statement stmt = Mockito.mock(Statement.class);
        ResultSet rst = Mockito.mock(ResultSet.class);

        when(con.prepareStatement(anyString())).thenReturn(pst);
        when(con.createStatement()).thenReturn(stmt);
        when(stmt.executeQuery(anyString())).thenReturn(rst);
        when(rst.next()).thenReturn(false);

        // Act
        String result = AdminController.userlogin(request, response, username, password, model);

        // Assert
        assertEquals("userLogin", result);
    }
    
   
}
