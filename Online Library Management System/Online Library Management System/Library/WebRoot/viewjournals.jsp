
<%@ page language="java" import="java.util.*,java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title></title>
<meta name="keywords" content="" />
<meta name="description" content="" />
<link href="default.css" rel="stylesheet" type="text/css" />
 
<style type="text/css">
<!--
.style2 {color: #000000}
.style3 {color: #CC9900}
-->
</style>
<script language="javascript">
function fun()
      {var jid=document.getElementById("jid").value;
//alert(jid+"..................");
         
         var issue=document.getElementById("issue").value;
          //alert(issue);
          location.href="viewjournals.jsp?jid="+jid+"&issue="+issue;
      }
     function change()
     {
          var isbn=document.getbook.isbn.value;
          location.href="getbooks?isbn="+isbn+"&page=/viewjournals.jsp&bookid=&stuid=&prefix=";  
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
			    <h2 class="title">Journals</h2>
		      </blockquote>
		  </blockquote>
	  </div>
<FORM action="viewjournals.jsp" name="getbook" method="post">
 <table width="191" border="0" align="center">
    <tr>
   <td width="62"><span class="style2"><strong>Period</strong></span></TD>
   <td width="119"><select name="isbn" onChange="change()">
   <OPTION>--select--</OPTION>
   <option value="Daily">Daily</option>
   <option value="Weekly">Weekly</option>
   <option value="Fortnightly">Fortnightly</option>
   <option value="Monthly">Monthly</option>
   <option value="Annually">Annually</option>  </select>
   </td>
   </tr>
   </table>
   <br/>
   <%
   if(session.getAttribute("isbnno")!=null)
    {
      //out.print((String)session.getAttribute("isbnno")+" Journals");
            }%>
    <table border="0" align="center">
      <tr>
        <th width="129" bgcolor="#CC9900"><span class="style2">Journal Name</span></th>
        <th width="107" bgcolor="#CC9900"><span class="style2">Price</span></th>
        <th width="142" bgcolor="#CC9900"><span class="style2">Issue On</span></th>
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
             %>
      </tr>
      <tr>
        <td bgcolor="#FFF0C1"><span class="style2">
          <input type="hidden" name="jid" id="jid" value="<%=rs.getString(1)%>" />
            <%=rs.getString(2)%></span></td>
        <td bgcolor="#FFF0C1"><span class="style2"><%=rs.getString(3)%></span></td>
        <td bgcolor="#FFF0C1"><input name="issue" type="text" value="<%=rs.getString(5)%>"/></td>
        <td width="76"><input type="button" value="Update" onclick="fun()"/></td>
      </tr>
      <%}
          %>
    </table>
    </FORM>
          <%int i=0;
            if(request.getParameter("issue")!=null)
            {
               PreparedStatement pst=con.prepareStatement("update lms_journals set ISSUEDON=? where JURNALID=?");   
               pst.setString(1,request.getParameter("issue"));
               pst.setInt(2,Integer.parseInt(request.getParameter("jid")));
               i=pst.executeUpdate();
               if(i>0)
                  out.print("Updation success");
               else
                  out.print("Updation Failed");
             }
             
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
