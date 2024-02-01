<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page language="java" import="java.util.*,java.sql.*" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title></title>
<meta name="keywords" content="" />
<meta name="description" content="" />
<link href="default.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
.style5 {color: #000000; font-weight: bold; font-size: 14px; }
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
        <jsp:include page="adminoptions.html"/>
	</div>
</div>
<div id="page">
  <!-- end #content -->
<div id="sidebar">
		<div id="news" class="boxed1">
			<blockquote>
			  <blockquote>
			    <h2 class="title">Book</h2>
		      </blockquote>
		  </blockquote>
	  </div>
    <FORM action="addbook" name="addbook" method="post" onSubmit="return fun()">
 <table border="0" align="center">
   <tr>
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
            ResultSet rs=st.executeQuery("select isbn_no,category from lms_isbn");
     %><td width="115"><span class="style5">ISBN Number</span></td>
    <TD width="154"><select name="isbn">
       <%
           while(rs.next())
           { 
		
     %>
     
     <option value=<%=rs.getString(1)%>><%=rs.getString(1)%>-<%=rs.getString(2)%></option>
     
     <%}%>
     </select></TD></tr>
     <tr>
     <%
       rs=st.executeQuery("select bookid_seq.nextval from dual");
           if(rs.next())
           { %>
     <td><span class="style5">Book ID</span></td>
     <TD><input type="text" name="bookid" value=<%=rs.getString(1)%> readonly/></TD>
     <%}
     }
        catch(Exception e)
		{
        	e.printStackTrace();
		}%>
     </tr>
     <tr>
     <td><span class="style5">Book Title</span></td>
     <TD><input type="text" name="title"/></TD>
     </tr>
     <tr>
     <td><span class="style5">Book Author</span></td>
     <TD><input type="text" name="author"/></TD>   
     </tr>
     <tr>
     <td><span class="style5">Book price</span></td>
     <TD><input type="text" name="bookprice"/></TD>   
     </tr>
     
     <tr>
     <td colspan="2" align="center"><input type="submit" value="Add"/> &nbsp;      <INPUT type="reset" value="reset"/></td>
     </tr>
     </table>
</FORM>
  </div>
<!-- end #sidebar -->
</div>
<!-- end #page -->
<div id="footer">
	<p>&nbsp;</p>
</div>
</body>
</html>
