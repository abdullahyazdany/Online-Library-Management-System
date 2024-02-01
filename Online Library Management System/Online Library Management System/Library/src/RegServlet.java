import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
public class RegServlet extends HttpServlet {

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
        String target="AdminHome.jsp?status=Registration Failed";
        try
		{
            Class.forName(driver);
            con=DriverManager.getConnection(url,dname,dpass);
		    con.setAutoCommit(false); 

		    response.setContentType("text/html");
		    PrintWriter out = response.getWriter();
		    String regid=request.getParameter("regid");
		    String name=request.getParameter("name");
		    String address=request.getParameter("address");
		    String phno=request.getParameter("phno");
		    //int fee=Integer.parseInt(request.getParameter("fee"));
		    String pwd=request.getParameter("pass");
		    //String course=request.getParameter("course");
		    String email=request.getParameter("email");
		    String photo = request.getParameter("photo");
		    System.out.println("photo=" + photo);
			File f = new File(photo);
			FileInputStream fis = new FileInputStream(f);
			System.out.println("fole=" + f.length());

		    PreparedStatement pst1=con.prepareStatement("insert into lms_login values(?,?,?)");
		    pst1.setString(1,regid);
		    pst1.setString(2,pwd);
		    pst1.setString(3,"librarian");
		    int i=pst1.executeUpdate();
		    
		    PreparedStatement pst=con.prepareStatement("insert into lms_libregistration values(?,?,?,?,?,?)");
		    pst.setString(1,regid);
		    pst.setString(2,name);
		    pst.setString(3,address);
		    pst.setString(4,phno);
		    //pst.setInt(5,fee);
		    pst.setInt(5, 0);
		    //pst.setString(7, course);
		    pst.setString(6, email);
		   // pst.setBinaryStream(9, fis, (int) f.length());
		    int j=pst.executeUpdate();
		    if(i>0 && j>0)
		    {
		    	con.commit();
		    	target="AdminHome.jsp?status=Registration Success";
		    }
		    else
		    {
		    	con.rollback();
		    	target="AdminHome.jsp?status=Registration Failed";
		    }
		    	
		
		}
        catch(Exception e)
		{System.out.println(e);
        	e.printStackTrace();
        	target="AdminHome.jsp?status=Registration Failed";
		}
        response.sendRedirect(target);
	}

}
