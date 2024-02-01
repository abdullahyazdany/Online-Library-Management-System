import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Vector;

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
public class GetBooksServlet extends HttpServlet {

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
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		ServletContext ctx=getServletContext();
        driver=ctx.getInitParameter("driver");
        url=ctx.getInitParameter("url");
        dname=ctx.getInitParameter("dname");
        dpass=ctx.getInitParameter("dpass");
        String isbn=request.getParameter("isbn");
	    String stuid=request.getParameter("stuid");
        String target=request.getParameter("page");
        target=target+"?isbnno="+isbn;
        String prefix=request.getParameter("prefix");
        String bookid=request.getParameter("bookid");
        GetBooksBean bean;
        Vector v;
        HttpSession session=request.getSession();
        try
		{
        	Class.forName(driver);
            con=DriverManager.getConnection(url,dname,dpass);
		    response.setContentType("text/html");
		    PrintWriter out = response.getWriter();
		   
		    
		    Statement st=con.createStatement();
		    
		    if(prefix.equals("isbn_no"))
		    	session.setAttribute("print","ISBN No");
		    if(prefix.equals("book_title"))
		    	session.setAttribute("print","Title");
		    if(prefix.equals("book_author"))
		    	session.setAttribute("print","Author");
		    
		    ResultSet rs=st.executeQuery("select fee from lms_registration where reg_id='"+stuid+"'");
		    if(rs.next())
		    {
		    	session.setAttribute("amount",rs.getString(1));
		    }
		    //v=new Vector();
	    	//while(rs.next())
	 	   // {
			//   bean=new GetBooksBean();
			//   bean.setBookid(rs.getString(1));
			//   v.add(bean);
		  //  }
	    	//session.setAttribute("bookids",v);
		    session.setAttribute("type",prefix);
	    	session.setAttribute("isbnno",isbn);
	    	session.setAttribute("stuid",stuid);
	    	System.out.println("=================="+isbn);
	    	session.setAttribute("bookid",bookid);
	    	System.out.println("session.getAttribute(isbnno)"+session.getAttribute("stuid"));
	   }
        catch(Exception e)
		{
        	e.printStackTrace();
        	
		}
        RequestDispatcher rd=request.getRequestDispatcher(target);
		rd.forward(request,response);
	}

}
