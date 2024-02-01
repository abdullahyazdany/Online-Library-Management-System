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
import javax.servlet.http.HttpSession;
/*
 * Created on May 12, 2004
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
public class DeleteLibrarianServlet extends HttpServlet {

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
        String target="";
        HttpSession session=request.getSession();
        try
		{
        	System.out.println("request.getParameter(isbn)"+request.getParameter("isbn"));
            Class.forName(driver);
            con=DriverManager.getConnection(url,dname,dpass);
            con.setAutoCommit(false);
		    response.setContentType("text/html");
		    PrintWriter out = response.getWriter();
		    String libid=request.getParameter("libid");
		    Statement st=con.createStatement();
		    System.out.println("delete from lms_libregistration where reg_id='"+libid+"'");
		    System.out.println("delete from lms_libregistration where user_id='"+libid+"'");
		    int i=st.executeUpdate("delete from lms_libregistration where reg_id='"+libid+"'");
		    int j=st.executeUpdate("delete from lms_login where user_id='"+libid+"'");
		    if(i>0 && j>0)
		    {
		    	con.commit();
				target="AdminHome.jsp?status=Librarian Deletion Success";
		    }
			else
			{
				con.rollback();
				target="AdminHome.jsp?status=Librarian Deletion Failed";
			}
		}
        catch(Exception e)
		{
		   e.printStackTrace();
		   target="AdminHome.jsp?status=Librarian Deletion Failed";
		}
       response.sendRedirect(target);
	}

}
