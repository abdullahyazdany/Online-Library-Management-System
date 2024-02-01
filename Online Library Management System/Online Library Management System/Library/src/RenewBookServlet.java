import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
/*
 * Created on May 15, 2004
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
public class RenewBookServlet extends HttpServlet {

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
        String target="UserHome.jsp?status=Book Renewal Failed";
        try
		{
            Class.forName(driver);
            con=DriverManager.getConnection(url,dname,dpass);
		

		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		//String isbn=request.getParameter("isbn");
		String bookid=request.getParameter("bookid");
		String stuid=request.getParameter("stuid");
		int fine=Integer.parseInt(request.getParameter("fine"));
		Statement st=con.createStatement();
		con.setAutoCommit(false);
		st.addBatch("update lms_books_issue set issue_date=to_char(sysdate),return_date=to_char(sysdate+15) where stu_id='"+stuid+"' and book_id='"+bookid+"'");
		if(fine>0)
			st.addBatch("insert into lms_fine values('"+stuid+"',to_char(sysdate),"+fine+",'Cash','Fine Collected')");
		 int i[]=st.executeBatch();
         con.commit();
         target="UserHome.jsp?status=Book Renewal success";
         
         
		}
       catch(Exception e)
		{
     	try
			{
     		con.rollback();
     	
			}
     	catch(Exception e1)
			{
     		e1.printStackTrace();
     	
			}
     	e.printStackTrace();
     	target="UserHome.jsp?status=Book Renewal Failed";
     	
		}
     response.sendRedirect(target);
	}

}
