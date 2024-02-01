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
          if(document.register.regid.value=="" || document.register.name.value=="" || document.register.address.value=="" || document.register.phno.value=="" || document.register.pass.value=="" || document.register.cpass.value=="")
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
			    <h2 class="title">Add LIBRARIAN</h2>
		      </blockquote>
		  </blockquote>
	  </div>
   <form name="register" action="reg" onsubmit="return fun()" method="post">
   <center>
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
            ResultSet rs=st.executeQuery("select LIB_SEQ.nextval from dual");
           if(rs.next())
           { 
		
     %>
     <td width="120"><span class="style1">Librarian ID</span></td>
     <td width="184"><input type="text" name="regid" value="LIB<%=rs.getString(1)%>" readonly></td>
     <%}
     }
        catch(Exception e)
		{
        	e.printStackTrace();
		}%>
     </tr>
     <tr>
     <td><span class="style1">Name</span></td>
     <td><input type="text" name="name"/></td>
     </tr>
     <tr>
     <td><span class="style1">Address</span></td>
     <td><textarea name="address" rows="4" cols="15"></textarea></td>
     </tr>
     
     <tr>
     <td><span class="style1">Phone No</span></td>
     <td><input type="text" name="phno"/></td>
     </tr>
      <tr>
     <td><span class="style1">Email ID</span></td>
     <td><input type="text" name="email"/></td>
     </tr>
      <!--<tr>
     <td><span class="style1">Course</span></td>
     <td><input type="text" name="course"/></td>
     </tr>
      <tr>
     <td><span class="style1">Registration Fee</span></td>
     <td><input type="text" name="fee"/></td>
     </tr>
     --><tr>
     <td><span class="style1">Password</span></td>
     <td><input type="password" name="pass"></td>
     </tr>
     <tr>
     <td><span class="style1">Confirm Password</span></td>
     <td><input type="password" name="cpass"></td>
    </tr>
    <tr>
     <td><span class="style1">Photo</span></td>
     <td><input type="file" name="photo" class="textfield"
							onChange="preview(this)" ></td>
    </tr>
    
    <tr>
     <td colspan="2" align="center"><input type="submit" value="Register"/>  &nbsp;     <input type="reset" value="Reset"/>      </td>
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
