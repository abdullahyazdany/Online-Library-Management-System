import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * @author Administrator
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class ReportsServlet extends HttpServlet {

	String driver;
	String url;
	String dname;
	String dpass;
	Connection con;
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
        String target="/Failed.html";
        String html="";
        try
		{
            Class.forName(driver);
            con=DriverManager.getConnection(url,dname,dpass);
		

		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		String report1=request.getParameter("report1");
		String report2=request.getParameter("report2");
		String fdate=request.getParameter("fdate");
		String fmonth=request.getParameter("fmonth");
		String fyear=request.getParameter("fyear");
		Statement st=con.createStatement();
		String query="";
		
		if(report1.equals("Weakly") || report1.equals("Monthly"))
		{
			String tdate=request.getParameter("tdate");
			String tmonth=request.getParameter("tmonth");
			String tyear=request.getParameter("tyear");
				
		    if(report2.equals("issued") )
		    {
		    	html="<table border='0'><tr><th bgcolor='#CC9900'><span class='style2'>ISBN No</th><th bgcolor='#CC9900'><span class='style2'>Book ID</span></th><th bgcolor='#CC9900'><span class='style2'>Student ID</span></th><th bgcolor='#CC9900'><span class='style2'>Isued Date</span></th><th bgcolor='#CC9900'><span class='style2'>Return Date</span></th></tr>"; 
		    	query="select * from lms_books_issue where issue_date  between '"+fdate+"-"+fmonth+"-"+fyear+"' and '"+tdate+"-"+tmonth+"-"+tyear+"'";
		    }
		    else
		    {
		    	html="<table border='0'><tr><th bgcolor='#CC9900'><span class='style2'>Student ID</span></th><th bgcolor='#CC9900'><span class='style2'>Fine Date</span></th><th bgcolor='#CC9900'><span class='style2'>Amount</span></th><th bgcolor='#CC9900'><span class='style2'>Mode Of Pay</span></th><th bgcolor='#CC9900'><span class='style2'>Comments</span></th></tr>";
		    	query="select * from lms_fine where fine_date  between '"+fdate+"-"+fmonth+"-"+fyear+"' and '"+tdate+"-"+tmonth+"-"+tyear+"'";
		    }
		}
		else
		{
			if(report2.equals("issued") )
		    {
		    	html="<table border='0'><tr><th bgcolor='#CC9900'><span class='style2'>ISBN No</span></th><th bgcolor='#CC9900'><span class='style2'>Book ID</span></th><th bgcolor='#CC9900'><span class='style2'>Student ID</span></th><th bgcolor='#CC9900'><span class='style2'>Isued Date</span></th><th bgcolor='#CC9900'><span class='style2'>Return Date</span></th></tr>"; 
		    	query="select * from lms_books_issue where issue_date='"+fdate+"-"+fmonth+"-"+fyear+"'";
		    }
		    else
		    {
		    	html="<table border='1'><tr><th bgcolor='#CC9900'><span class='style2'>Student ID</span></th><th bgcolor='#CC9900'><span class='style2'>Fine Date</span></th><th bgcolor='#CC9900'><span class='style2'>Amount</span></th><th bgcolor='#CC9900'><span class='style2'>Mode Of Pay</span></th><th bgcolor='#CC9900'><span class='style2'>Comments</span></th></tr>";
		    	query="select * from lms_fine where fine_date='"+fdate+"-"+fmonth+"-"+fyear+"'";
		    }			
		}
		ResultSet rs=st.executeQuery(query);
		if(report2.equals("issued"))
		{
			while(rs.next())
			{
				html+="<tr><td bgcolor='#FFF0C1'><span class='style2'>"+rs.getString(1)+"</td><td bgcolor='#FFF0C1'><span class='style2'>"+rs.getString(2)+"</td><td bgcolor='#FFF0C1'><span class='style2'>"+rs.getString(3)+"</td><td bgcolor='#FFF0C1'><span class='style2'>"+rs.getString(4)+"</td><td bgcolor='#FFF0C1'><span class='style2'>"+rs.getString(5)+"</td></tr>"; 
			}
		}
		else
		{
			while(rs.next())
			{
				html+="<tr><td bgcolor='#FFF0C1'><span class='style2'>"+rs.getString(1)+"</td><td bgcolor='#FFF0C1'><span class='style2'>"+rs.getDate(2)+"</td><td bgcolor='#FFF0C1'><span class='style2'>"+rs.getString(3)+"</td><td bgcolor='#FFF0C1'><span class='style2'>"+rs.getString(4)+"</td><td bgcolor='#FFF0C1'><span class='style2'>"+rs.getString(5)+"</td></tr>"; 
			}
		}
	
	   }
        catch(Exception e)
		{
        	e.printStackTrace();
       	}
        HttpSession session = request.getSession();
        session.setAttribute("report", html);
        response.sendRedirect("Reports.jsp");
	}

}
