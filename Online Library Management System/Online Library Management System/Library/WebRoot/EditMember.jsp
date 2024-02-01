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
          if(document.register.regid.value=="" || document.register.name.value=="" || document.register.address.value=="" || document.register.phno.value=="" || document.register.fee.value=="" || document.register.pass.value=="" || document.register.cpass.value=="")
          {
              alert("All fields are Manditary");
              return false;
          }
        
          
          return true;
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
   <script language="javascript">
      function fun()
      {
          if(document.modifymember.name.value=="" || document.modifymember.address.value=="" || document.modifymember.phno.value=="" || document.modifymember.fee.value=="")
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
			    <h2 class="title">Modify Student</h2>
		      </blockquote>
		  </blockquote>
	  </div>
   <FORM action="EditMember.jsp" name="getbook" method="post">
 <table width="409" height="84" border="0" align="center">
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
            %><td width="88"><span class="style1">Student ID</span></td>
     <TD width="89"><select name="stuid">
              <option>--select--</option>
       <%            
           while(rs.next())
           { 
	  %>
             <option value=<%=rs.getString(1)%>><%=rs.getString(1)%></option>
      <%
            }
      %></select></TD>
     </tr>
     <tr></tr>
     <tr></tr>
     <tr>
     <td align="center" colspan="4">
       <input type="submit" value="Get Details"/>
     </td>
     </tr>
     </table>
  </FORM>
<br><FORM action="ModifyMember" name="modifymember" method="post" onSubmit="return fun()">
<%
      if(request.getParameter("stuid")!=null)
      {
        rs=st.executeQuery("select * from lms_registration where reg_id='"+request.getParameter("stuid")+"'");
        if(rs.next())
        {
%>

 <table border="0" align="center">
 <tr>
     <td width="107"><span class="style1">Student ID</span></td>
     <TD width="159"><input type="text" name="stuid" value=<%=rs.getString(1)%> readonly/></TD>
     </tr>
     <tr>
     <td><span class="style1">Name</span></td>
     <TD><input type="text" name="name" value="<%=rs.getString(2)%>"/></TD>
     </tr>
   <tr>
   
     <td><span class="style1">Address</span></td>
     <TD><textarea name="address"><%=rs.getString(3)%></textarea></TD>
     </tr>
     <tr>
     <td><span class="style1">Phone Number</span></td>
     <TD><input type="text" name="phno" value="<%=rs.getString(4)%>"/></TD>
     </tr>
     <tr>
     <td><span class="style1">Fee</span></td>
     <TD><input type="text" name="fee" value="<%=rs.getString(5)%>"/></TD>
     </tr>
     
     <tr>
     <td><span class="style1">Course</span></td>
     <TD><input type="text" name="course" value="<%=rs.getString(7)%>"/></TD>
     </tr>
     <tr>
     <td><span class="style1">Email ID</span></td>
     <TD><input type="text" name="email" value="<%=rs.getString(8)%>"/></TD>
     </tr>
     <tr></tr>
     <tr></tr>
     <tr>
     <td colspan="2" align="center"><br><input type="submit" value="Update Details"/></td>
     </tr>
     </table>
</FORM>
  <%
  }
  }
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
