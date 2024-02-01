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
 * Created on May 31, 2004
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */

/**
 * @author Administrator
 * 
 *         TODO To change the template for this generated type comment go to
 *         Window - Preferences - Java - Code Style - Code Templates
 */
public class AdvanceBookingServlet extends HttpServlet {

	String driver;
	String url;
	String dname;
	String dpass;
	Connection con;

	/**
	 * The doPost method of the servlet. <br>
	 * 
	 * This method is called when a form has its tag value method equals to
	 * post.
	 * 
	 * @param request
	 *            the request send by the client to the server
	 * @param response
	 *            the response send by the server to the client
	 * @throws ServletException
	 *             if an error occurred
	 * @throws IOException
	 *             if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		ServletContext ctx = getServletContext();
		driver = ctx.getInitParameter("driver");
		url = ctx.getInitParameter("url");
		dname = ctx.getInitParameter("dname");
		dpass = ctx.getInitParameter("dpass");
		String target = "StudentHome.jsp?status=Advance Booking Failed";
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, dname, dpass);

			response.setContentType("text/html");
			PrintWriter out = response.getWriter();
			String isbn = request.getParameter("isbn");
			String bookid = request.getParameter("bookid");
			String stuid = request.getParameter("stuid");
			Statement st = con.createStatement();
			Statement st1 = con.createStatement();
			System.out.println("insert into lms_booking values('" + isbn
					+ "','" + bookid + "','" + stuid + "',sysdate)");
			st.executeUpdate("insert into lms_booking values('" + isbn + "','"
					+ bookid + "','" + stuid + "',sysdate)");
			st1.executeUpdate("update lms_books set status='Booked' where book_id="
					+ bookid);
			target = "StudentHome.jsp?status=Adavance Booking Success";
		} catch (Exception e) {
			e.printStackTrace();
			target = "StudentHome.jsp?status=Advance Booking Failed";
		}
		RequestDispatcher rd = request.getRequestDispatcher(target);
		rd.forward(request, response);

	}

}
