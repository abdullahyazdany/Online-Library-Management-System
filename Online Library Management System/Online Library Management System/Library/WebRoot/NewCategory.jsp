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
.style4 {color: #000000; font-weight: bold; }
-->
</style>
 <script language="javascript">
      function fun()
      {
          if(document.addcat.category.value=="")
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
			    <h2 class="title">Category</h2>
		      </blockquote>
		  </blockquote>
	  </div>
      <FORM action="addcat" name="addcat" method="post" onSubmit="return fun()">
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
            ResultSet rs=st.executeQuery("select isbn_seq.nextval from dual");
           if(rs.next())
           { 
		
     %>
     <td width="77" height="34"><span class="style4">ISBN No.</span></td>
     <TD width="147"><input type="text" name="isbn" value="<%=rs.getString(1)%>" readonly/></TD>
     <%}
     }
        catch(Exception e)
		{
        	e.printStackTrace();
		}%>
     </tr>
     <tr>
     <td height="28"><span class="style4">category</span></td>
     <TD><input type="text" name="category"/></TD>
     </tr>
     
     <tr>
     <td colspan="2" align="center"><input type="submit" value="Add"/>&nbsp;
       <INPUT type="reset" value="reset"/></td>
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
