import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
/*
 * Created on May 11, 2004
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */

/**
 * @author Administrator
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class LoginServlet extends HttpServlet {
	
	String driver;
	String url;
	String dname;
	String dpass;
	Connection con;
	String role="Login.jsp";
		
			/**
	 * The doPost method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to post.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		ServletContext ctx=getServletContext();
        driver=ctx.getInitParameter("driver");
        url=ctx.getInitParameter("url");
        dname=ctx.getInitParameter("dname");
        dpass=ctx.getInitParameter("dpass");
        HttpSession session=request.getSession();
        try
		{
            Class.forName(driver);
            con=DriverManager.getConnection(url,dname,dpass);
		
        
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		String userid=request.getParameter("login");
		String pwd=request.getParameter("password");
		
		System.out.println(userid);
		System.out.println(pwd);
			Statement st=con.createStatement();
			ResultSet rs=st.executeQuery("select role from lms_login where user_id='"+userid+"' and password='"+pwd+"'");
			String type="";
			if(rs.next())
			{
				role=rs.getString(1);
				type=role;
				if(role.equals("admin"))
			           role="AdminHome.jsp"; 
				if(role.equals("student"))
				{  
					 System.out.println("Select return_date-2,sysdate,book_id from lms_books_issue where stu_id='"+userid+"'");
					  rs=st.executeQuery("Select return_date-2,sysdate,book_id from lms_books_issue where stu_id='"+userid+"'");
					  String bookid="";
					  while(rs.next())
					  {
				          if(rs.getDate(1).equals(rs.getDate(2)))
				          {
				          	bookid=rs.getString(3);
				          	System.out.println("bookid"+bookid);
				          	st.executeUpdate("insert into lms_mails values(msg_seg.nextval,'"+userid+"','Return date of bookid-"+bookid+" will be expire with in to days.')");
				          }  
					  }
			           role="StudentHome.jsp";
				}
				if(role.equals("librarian"))
					   role="UserHome.jsp";
			}
			else
				role="Login.jsp?status=Invalid Username and password";
			
			session.setAttribute("userid",userid);
			session.setAttribute("role", type);
			System.out.println("(String)session.getAttribute(userid)"+(String)session.getAttribute("userid"));
		}
		catch(Exception e)
		{
			e.printStackTrace();
			role="Login.jsp"; 
		}
		
		response.sendRedirect(role);
	}
}
