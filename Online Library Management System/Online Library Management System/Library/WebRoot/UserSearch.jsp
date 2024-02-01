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
          if(document.modifybook.title.value=="" || document.modifybook.author.value=="")
          {
              alert("All fields are Manditary");
              return false;
          }
          return true;
     }
     function change()
     {
          var option=document.search.option.value;
          location.href="getbooks?prefix="+option+"&page=/UserSearch.jsp";  
     }
  </script>
<style type="text/css">
<!--
.style1 {
	color: #000000;
	font-weight: bold;
}
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
			    <h2 class="title">Search</h2>
		      </blockquote>
		  </blockquote>
	  </div>
    <form name="search" action="Search" method="post">
       <input type="hidden" name="page" value="0"/>
    <center>
    
      <table border="0">
      <tr>
      <td width="95" height="32"><span class="style1">Select Type</span></td>
      <td width="103"><select name="option" onchange="change()">
      <%
      if(session.getAttribute("print")!=null)
         { %><option value="<%=(String)session.getAttribute("type")%>"><%=(String)session.getAttribute("print")%></option>
      <%}
      else
      {%>
      <option>--select--</option>
      <%}%>
      <option value="isbn_no">ISBN No</option>
      <OPTION value="book_title">Title</OPTION>
      <option value="book_author">Author</option>
      </select>     </td>
     </tr>
     <tr>
     <td height="32"><span class="style1">Select ID</span></td>
     <td><select name="searchString" tabindex="8">

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
             System.out.println((String)session.getAttribute("isbnno"));
                
                if(session.getAttribute("type")!=null)
                {
                     System.out.println("values are going to be shown here");
       				 ResultSet rs=st.executeQuery("select distinct( "+(String)session.getAttribute("type")+") from lms_books ");
           			 String bookid="";
           				while(rs.next())
           				{
                         bookid=rs.getString(1);
                         %>

			<option value="<%=bookid%>"><%=bookid%></option>
		  <%             
        			    }
                }
                }
         catch(Exception e)
         {
             e.printStackTrace();
         }
        
      %></select></TD></tr>
     <tr></tr>
     <tr></tr>
     <tr></tr> 
     <tr>
     <td colspan="2"><div align="center">
       <input type="submit" value="Search"/>       
     </div></td></tr></table>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
     
	     <%=(session.getAttribute("books")!=null)?((String)session.getAttribute("books")):""%>
	 
    </center>
       </form>
  </div>
<!-- end #sidebar -->
</div>
<!-- end #page -->
<div id="footer">
	<p>&nbsp;</p>
</div>
</body>
</html>
