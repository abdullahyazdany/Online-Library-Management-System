import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

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
public class SearchServlet extends HttpServlet {

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
        String target=request.getParameter("page");
        String prefix=request.getParameter("prefix");
        GetBooksBean bean;
        Vector v;
        HttpSession session=request.getSession();
        try
		{
        	System.out.println("request.getParameter(isbn)"+request.getParameter("isbn"));
            Class.forName(driver);
            con=DriverManager.getConnection(url,dname,dpass);
		    response.setContentType("text/html");
		    PrintWriter out = response.getWriter();
		    String option=request.getParameter("option");
		    String searchString=request.getParameter("searchString");
		    PreparedStatement st=con.prepareStatement("select * from lms_books where "+option+"=?");
		    st.setString(1, searchString);
		    ResultSet rs=st.executeQuery();
		    String s ="";
		    s+=" <center><table border='1'><tr><th bgcolor='#B59631'><span class='style2'>ISBN NO.</span></th> <th bgcolor='#B59631'><span class='style2'>Book ID</span></th> <th bgcolor='#B59631'><span class='style2'>Title</span></th> <th bgcolor='#B59631'><span class='style2'>Author</span></th> <th bgcolor='#B59631'><span class='style2'>Status</span></th></tr><tr>";
		    
		    while(rs.next())
		    {
		    	s+="<td bgcolor='#F7AF9B'><div align='center' class='style1'>"+rs.getString(1)+"</div></td><td bgcolor='#F7AF9B'><div align='center' class='style1'>"+rs.getString(2)+"</div></td><td bgcolor='#F7AF9B'><div align='center' class='style1'>"+rs.getString(3)+"</div></td><td bgcolor='#F7AF9B'><div align='center' class='style1'>"+rs.getString(4)+"</div></td><td bgcolor='#F7AF9B'><div align='center' class='style1'>"+rs.getString(5)+"</div></td>";
		    	s+="</tr><tr>";
		    }
		    session.setAttribute("books",s);
		}
        catch(Exception e)
		{
        	e.printStackTrace();
		}
        if(request.getParameter("page")!=null)
        {
        	response.sendRedirect("UserSearch.jsp");
        }
        else
        {
        	response.sendRedirect("Search.jsp");
        }
        
	}
}
