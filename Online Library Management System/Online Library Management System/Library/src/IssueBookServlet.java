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
public class IssueBookServlet extends HttpServlet {

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
        String target="UserHome.jsp?status=Book Issuing Failed";
        try
		{
            Class.forName(driver);
            con=DriverManager.getConnection(url,dname,dpass);
		

		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		String isbn=request.getParameter("isbn");
		String bookid=request.getParameter("bookid");
		String stuid=request.getParameter("stuid");
		int nbooks=Integer.parseInt(request.getParameter("nbooks"));
		nbooks++;
		Statement st=con.createStatement();
		con.setAutoCommit(false);
		st.addBatch("update lms_registration set n_books="+nbooks+" where reg_id='"+stuid+"'" );
		st.addBatch("update lms_books set status='Issued' where book_id='"+bookid+"'");
		st.addBatch("insert into lms_books_issue values('"+isbn+"','"+bookid+"','"+stuid+"',sysdate,sysdate+15,1)");
		
		int[] i=st.executeBatch();
		if(i.length==3)
		{
		     con.commit();	
		     target="UserHome.jsp?status=Book Issued ";
		}
		else
		{
			con.rollback();
			target="UserHome.jsp?status=Book Issuing Failed";
		}
		
		}
        catch(Exception e)
		{
        	e.printStackTrace();
        	target="UserHome.jsp?status=Book Issuing Failed";
		}
        RequestDispatcher rd=request.getRequestDispatcher(target);
		rd.forward(request,response);
	}

}
