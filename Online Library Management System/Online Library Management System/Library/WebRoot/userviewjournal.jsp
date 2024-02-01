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
          location.href="getbooks?isbn="+isbn+"&page=/userviewjournal.jsp&bookid=&stuid=&prefix=";  
     }
  </script>
  <style type="text/css">
<!--
.style1 {
	color: #000000;
	font-weight: bold;
}
.style2 {color: #FFFFFF}
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
			    <h2 class="title">Journals</h2>
		      </blockquote>
		  </blockquote>
	  </div>
    <FORM action="viewjournals.jsp" name="getbook" method="post">
 <table width="179" border="0" align="center">
    <tr>
   <td width="65"><span class="style1">Period</span></TD>
   <td width="102"><select name="isbn" onChange="change()">
   <OPTION>--select--</OPTION>
   <option value="Daily">Daily</option>
   <option value="Weekly">Weekly</option>
   <option value="Fortnightly">Fortnightly</option>
   <option value="Monthly">Monthly</option>
   <option value="Annually">Annually</option>  </select>
   </td>
   </tr>
   </table>
   <center>
   <%
   if(session.getAttribute("isbnno")!=null)
    {
      out.print((String)session.getAttribute("isbnno")+" Journals");
            }%>
  <br/>
   <table width="413" border="0-" align="center">
    <tr>
    <th width="166" bgcolor="#B59631"><span class="style2">Journal Name</span></th>
    <th width="86" bgcolor="#B59631"><span class="style2">Price</span></th>
    <th width="147" bgcolor="#B59631"><span class="style2">Issue On</span></th>
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
            ResultSet rs=st.executeQuery("select * from lms_journals where period='"+(String)session.getAttribute("isbnno")+"'");
            while(rs.next())
            {
             %><tr><td bgcolor="#F7AF9B"><div align="center" class="style1">
       <div align="left"><%=rs.getString(2)%></div>
     </div></td>
             <td bgcolor="#F7AF9B"><div align="center" class="style1"><%=rs.getString(3)%></div></td>
             <td bgcolor="#F7AF9B"><div align="center" class="style1"><%=rs.getString(5)%></div></td>
             
             </tr>
          <%}
          %>
      </table>
    </FORM>
          <%
             
             }
             catch(Exception e)
             {
                  e.printStackTrace();
             }%>  
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
