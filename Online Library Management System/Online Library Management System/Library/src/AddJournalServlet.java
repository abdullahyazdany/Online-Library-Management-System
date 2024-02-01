import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class AddJournalServlet extends HttpServlet
{

    public AddJournalServlet()
    {
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
        ServletContext ctx = getServletContext();
        driver = ctx.getInitParameter("driver");
        url = ctx.getInitParameter("url");
        dname = ctx.getInitParameter("dname");
        dpass = ctx.getInitParameter("dpass");
        String target = "AdminHome.jsp?status=Journal Insertion Failed";
        try
        {
            Class.forName(driver);
            con = DriverManager.getConnection(url, dname, dpass);
            response.setContentType("text/html");
            java.io.PrintWriter out = response.getWriter();
            String jname = request.getParameter("jname");
            String jprice = request.getParameter("jprice");
            String jperiod = request.getParameter("jperiod");
            String jissue = request.getParameter("jissue");
            PreparedStatement pst = con.prepareStatement("insert into lms_journals values((select nvl(max(JURNALID),100)+1 from LMS_JOURNALS),?,?,?,?)");
            pst.setString(1, jname);
            pst.setString(2, jprice);
            pst.setString(3, jperiod);
            pst.setString(4, jissue);
            int i = pst.executeUpdate();
            if(i > 0)
                target = "AdminHome.jsp?status=Journal Insertion success";
            else
                target = "AdminHome.jsp?status=Journal Insertion Failed";
        }
        catch(Exception e)
        {
            e.printStackTrace();
            target = "AdminHome.jsp?status=Journal Insertion Failed";
        }
        response.sendRedirect(target);
    }

    String driver;
    String url;
    String dname;
    String dpass;
    Connection con;
}
