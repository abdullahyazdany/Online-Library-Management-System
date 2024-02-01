<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page language="java" import="java.util.*,java.sql.*" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<meta name="keywords" content="" />
<meta name="description" content="" />
<link href="default.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
.style6 {color: #FFFFFF}
.style7 {color: #000000}
.style8 {color: #000000; font-weight: bold; }
a:link {
	color: #FF0000;
}
-->
</style>
 <script language="javascript">
      function fun()
      {
          if(document.addbook.title.value=="" || document.addbook.author.value=="" || document.addbook.bookprice.value=="")
          {
              alert("All fields are Manditary");
              return false;
          }
          return true;
     }
  </script>
</head>
<body>
<div id="header">
	<div id="logo">
		<h1><jsp:include page="header.html"/> 
	  </h1>
		
  </div>
	<div id="menu">
        <jsp:include page="useroptions.html"/> 
	</div>
</div>
<div id="page">
  <!-- end #content -->
<div id="sidebar">
		<div id="news" class="boxed1">
			<blockquote>
			  <blockquote>
			    <h2 class="title">Advance Bookings</h2>
		      </blockquote>
		  </blockquote>
	  </div>
        <table width="576" border="0" align="center">
          <tr>
            <th width="54" bgcolor="#B59E39"><span class="style6">ISBN No</span></th>
            <th width="73" bgcolor="#B59E39"><span class="style6">Book ID</span></th>
            <th width="105" bgcolor="#B59E39"><span class="style6">Student ID</span></th>
            <th width="113" bgcolor="#B59E39"><span class="style6">Booked Date</span></th>
            <th width="130" bgcolor="#B59E39"><span class="style6">ToDay</span></th>
            <th width="29" bgcolor="#B59E39"><span class="style6"></span></th>
            <th width="42" bgcolor="#B59E39"><span class="style6"></span></th>
          </tr>
          <%
        ServletContext ctx=getServletContext();
        String driver=ctx.getInitParameter("driver");
        String url=ctx.getInitParameter("url");
        String dname=ctx.getInitParameter("dname");
        String dpass=ctx.getInitParameter("dpass");
        try
		{
            Class.forName(driver);
            Connection con=DriverManager.getConnection(url,dname,dpass);
            Statement st=con.createStatement();
            String isbn="";
            String bookid="";
            String stuid="";
            String date="";
            String status="";
            String sysdate="";
            ResultSet rs=st.executeQuery("select lb.isbn_no,lb.book_id,lb.stu_id,lb.booking_date,lbs.status,sysdate,(sysdate-lb.booking_date) from lms_booking lb,lms_books lbs where lb.book_id=lbs.book_id order by lb.booking_date");
            while(rs.next())
            {
                 isbn=rs.getString(1);
                 bookid=rs.getString(2);
                 stuid=rs.getString(3);
                 date=rs.getString(4);
                 status=rs.getString(5);
                 sysdate=rs.getString(6);
                 
               
            %>
          <tr>
            <td bgcolor="#F7AF9B"><div align="center" class="style7"><strong><%=isbn%></strong></div></td>
            <td bgcolor="#F7AF9B"><div align="center" class="style8"><%=bookid%></div></td>
            <td bgcolor="#F7AF9B"><div align="center" class="style8"><%=stuid%></div></td>
            <td bgcolor="#F7AF9B"><div align="center" class="style8"><%=date%></div></td>
            <td bgcolor="#F7AF9B"><div align="center" class="style8"><%=sysdate%></div></td>
            <% if(status.equals("Booked"))
                 {
               %>
            <td width="29" bgcolor="#F7AF9B"><a href="issueadvancebook.jsp?bookid=<%=bookid%>&stuid=<%=stuid%>&isbn=<%=isbn%>" class="style8">Issue</a></td>
            <td width="42" bgcolor="#F7AF9B"><a href="deleteadvancebook.jsp?bookid=<%=bookid%>&stuid=<%=stuid%>&isbn=<%=isbn%>" class="style8">Delete</a></td>
            <%}
              %>
          </tr>
          <%
              }%>
        </table>
        </center>
<%}
        catch(Exception e)
        {
           e.printStackTrace();           
        }%>
  </div>
<!-- end #sidebar -->
</div>
<!-- end #page -->
<div id="footer">
	<p>&nbsp;</p>
</div>
</body>
</html>
