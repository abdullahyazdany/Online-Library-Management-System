<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page language="java" import="java.util.*,java.sql.*" %>
<%@page session="true" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title></title>
<meta name="keywords" content="" />
<meta name="description" content="" />
<link href="default.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
.style7 {color: #000000; font-weight: bold; }
-->
</style>
 <script language="javascript">
     
     function change()
     {
          var isbn="";  
          var stuid=document.renewbook.stuid.value;
          location.href="getbooks?isbn="+isbn+"&page=/Changepassword.jsp&prefix=issue&bookid=&stuid="+stuid;  
     }
     function change1()
     {
         var isbn="";  
          var stuid=document.renewbook.stuid.value;
          var bookid=document.renewbook.bookid.value;
          location.href="getbooks?isbn="+isbn+"&page=/Changepassword.jsp&prefix=issue&stuid="+stuid+"&bookid="+bookid; 
     }
     function calculate()
     {
         var str1=new Date(document.renewbook.issuedate.value);
        var str2=new Date(document.renewbook.returndate.value);
        var bookid=document.renewbook.bookid.value;
        var stuid=document.renewbook.stuid.value;
	      location.href="calculatefine?page=/Changepassword.jsp&isbn=&prefix=&bookid="+bookid+"&stuid="+stuid; 
	  
     }
  </script>
</head>
<body>
<div id="header">
	<div id="logo">
		<h1><jsp:include page="header.html"/> 
	  </h1>
		
  </div>
   <script type="text/javascript">
function disableBackButton() {
	window.history.forward();
}
setTimeout("disableBackButton()", 0);
</script>
  
	<div id="menu">
   <% 
   String role=(String)session.getAttribute("role"); 
   if("admin".equals(role)) 
   {%>
 <jsp:include page="adminoptions.html"/> 
 <%}
 else if("librarian".equals(role))
   {%>
 <jsp:include page="useroptions.html"/> 
 <%}
 else if("student".equals(role)){
 %>
 <jsp:include page="studentoptions.html"/>
 <%
 }%>
	</div>
</div>
<div id="page">
  <!-- end #content -->
<div id="sidebar">
		<div id="news" class="boxed1">
			<blockquote>
			  <blockquote>
			    <h2 class="title">Change Password</h2>
		      </blockquote>
		  </blockquote>
	  </div>
    <FORM action="changepass" name="renewbook" method="post">
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
            ResultSet rs=st.executeQuery("select reg_id from lms_registration");
            %>
            
            <td width="124"><span class="style7">ID</span></td>
<TD width="150">

<%if(session.getAttribute("userid")!=null)
 {%>
<input type="text" name="stuid" value="<%= (String)session.getAttribute("userid") %>" readonly/>
<%} %>


</TD>
     </tr><tr><td><span class="style7">Old Password</span></td>
<%if(session.getAttribute("userid")!=null)
                {
                     rs=st.executeQuery("select password from lms_login where user_id='"+(String)session.getAttribute("userid")+"'");
       				if(rs.next())
       				  {%>
       				 <td> <input type="password" name="oldpass"  /></td>
       				  <% 
                 }}
        else
        {%>
       				 <td width="142"><input type="password" name="oldpass" /></td>
       				  <%
        }
        %>
        </tr>
        <tr>
        <TD><span class="style7">New Password</span></TD>
        <td><input type="password" name="newpass"/></td></tr>
        <tr>
        <td align="center" colspan="2">
        <input type="submit" value="Change"/></td>
       
        </tr>
        </table>
    </FORM>
        <%
        }
        catch(Exception e)
         {
             e.printStackTrace();
         }
                   
     %>
  </div>
<!-- end #sidebar -->
</div>
<!-- end #page -->
<div id="footer">
	<p>&nbsp;</p>
</div>
</body>
</html>
