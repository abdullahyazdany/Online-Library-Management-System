import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.Date;
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
 * Created on May 14, 2004
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
public class CalculateFine extends HttpServlet {

	String driver;
	String url;
	String dname;
	String dpass;
	Connection con;
	/**
	 * The doGet method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		ServletContext ctx=getServletContext();
        driver=ctx.getInitParameter("driver");
        url=ctx.getInitParameter("url");
        dname=ctx.getInitParameter("dname");
        dpass=ctx.getInitParameter("dpass");
        String target=request.getParameter("page");
        HttpSession session=request.getSession();
        try
		{
        	System.out.println("request.getParameter(isbn)"+request.getParameter("isbn"));
            Class.forName(driver);
            con=DriverManager.getConnection(url,dname,dpass);
		    response.setContentType("text/html");
		    PrintWriter out = response.getWriter();
		    String isbn=request.getParameter("isbn");
		    String stuid=request.getParameter("stuid");
            
            String bookid=request.getParameter("bookid");
            Statement st=con.createStatement();
            ResultSet rs=st.executeQuery("select issue_date,return_date from lms_books_issue where stu_id='"+stuid+"' and book_id='"+bookid+"'");
            if(rs.next())
            {
            	Date issue=rs.getDate(1);
				Date retur=rs.getDate(2);
				
				System.out.println(issue);
			    
				
			}
		 }
        catch(Exception e)
		{
        	e.printStackTrace();
        	
		}
        RequestDispatcher rd=request.getRequestDispatcher(target);
		rd.forward(request,response);
	}

}
