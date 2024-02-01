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
public class ReturnBookServlet extends HttpServlet {

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
        String target="UserHome.jsp?status=Book Return Failed";
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
		    
		    String status="cash";
		    int bookcost=Integer.parseInt(request.getParameter("bookcost"));
		    System.out.println("option--------->"+status);
		    int fine=Integer.parseInt(request.getParameter("totalcost"));
            Statement st=con.createStatement();
            Statement st1=con.createStatement();
            con.setAutoCommit(false);
            st.addBatch("delete from lms_books_issue where stu_id='"+stuid+"' and book_id='"+bookid+"'");
            st.addBatch("update lms_registration set n_books=n_books-1 where reg_id='"+stuid+"'");
           
            
            if(bookcost>0)
            {
            	status=request.getParameter("cash");
            	System.out.println("option--------->"+status);
              	if(status.equals("Deduct from Fee"))
              	{
            		st.addBatch("update lms_registration set fee=fee-"+fine+" where reg_id='"+stuid+"'");
              	}
              	st.addBatch("insert into lms_fine values('"+stuid+"',to_char(sysdate),"+fine+",'"+status+"','Book Lost id="+bookid+"')");
        	    st.addBatch("update lms_books set status='Lost' where book_id='"+bookid+"'");              	
            }
            else
          	{
            	if(fine>0)
            	{
          		st.addBatch("insert into lms_fine values('"+stuid+"',to_char(sysdate),"+fine+",'"+status+"','Fine Collected')");
            	}
          		st.addBatch("update lms_books set status='Available' where book_id='"+bookid+"'");
          	}
            
            
            int i[]=st.executeBatch();
            
            ResultSet rs=st.executeQuery("select stu_id from lms_booking where book_id='"+bookid+"' order by booking_date");
            //PreparedStatement pst=con.prepareStatement("inser into lms_mails values('"++"','"++"','")")
            if(rs.next())
            {
            	st.executeUpdate("insert into lms_mails values(msg_seg.nextval,'"+rs.getString(1)+"','The bookid-"+bookid+" is available. Collect the book with in 48 hours.')");
            	st.executeUpdate("update lms_books set status='Booked' where book_id='"+bookid+"'");
            }
            con.commit();
            target="UserHome.jsp?status=Book Returned";
            
            
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
        	target="UserHome.jsp?status=Book Return Failed";
        	
		}
        response.sendRedirect(target);
	}

}
