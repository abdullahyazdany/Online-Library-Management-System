<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page language="java" import="java.util.*,java.sql.*" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title></title>
<meta name="keywords" content="" />
<meta name="description" content="" />
<link href="default.css" rel="stylesheet" type="text/css" />
  <script language="javascript">
      function fun()
      {
          var jid=document.getbook.hidden.value;
          var issue=document.getbook.issue.value;
          location.href="viewjournals.jsp?jid="+jid+"&issue="+issue;
      }
     function change()
     {
          var isbn=document.getbook.isbn.value;
          location.href="getbooks?isbn="+isbn+"&page=/viewjournals.jsp&bookid=&stuid=&prefix=";  
     }
  </script>
<style type="text/css">
<!--
.style4 {color: #FFFFFF}
.style6 {color: #000000; font-weight: bold; }
-->
</style>
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
			    <h2 class="title">Catalog</h2>
		      </blockquote>
		  </blockquote>
	  </div>
     <table width="70%" border="0" align="center">
  <tr>
 <th width="21%" bgcolor="#B59A31"><span class="style4">ISBN NO.</span></th>
 <th width="20%" bgcolor="#B59A31"><span class="style4">Book ID</span></th>
 <th width="19%" bgcolor="#B59A31"><span class="style4">Title</span></th>
 <th width="18%" bgcolor="#B59A31"><span class="style4">Author</span></th>
 <th width="22%" bgcolor="#B59A31"><span class="style4">Status</span></th>
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
            ResultSet rs=st.executeQuery("select * from lms_books order by isbn_no");
            while(rs.next())
            {%>
            <tr>  <td bgcolor="#F7AF9B"><div align="center" class="style6"><%=rs.getString(1)%></div></td>
              <td bgcolor="#F7AF9B"><div align="center" class="style6"><%=rs.getString(2)%></div></td>
              <td bgcolor="#F7AF9B"><div align="center" class="style6"><%=rs.getString(3)%></div></td>
              <td bgcolor="#F7AF9B"><div align="center" class="style6"><%=rs.getString(4)%></div></td>
              <td bgcolor="#F7AF9B"><div align="center" class="style6"><%=rs.getString(5)%></div></td></tr>
              <%
              }
			  
                         
        }
        catch(Exception e)
        {
           e.printStackTrace();           
        }%>
         </table>    
    </center>
   
  </div>
<!-- end #sidebar -->
</div>
<!-- end #page -->
<div id="footer">
	<p>&nbsp;</p>
</div>
</body>
</html>
