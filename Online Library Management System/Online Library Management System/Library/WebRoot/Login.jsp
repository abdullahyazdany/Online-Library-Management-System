<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>Aged Beauty by Free Css Templates</title>
<meta name="keywords" content="" />
<meta name="description" content="" />
<link href="default.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
.style1 {
	color: #333333;
	font-weight: bold;
}
.style2 {
	color: #FF0000;
	font-weight: bold;
}
-->
</style>
</head>
<body>
<div id="header">
	<div id="logo">
		<h1><jsp:include page="header.html"/> </h1>
		
  </div>
	<div id="menu">
	</div>
</div>
<div id="page">
	<div id="content">
		<div id="welcome" class="boxed2">
			<h1 class="title"><FONT color="#00ffff">Welcome to Library!</FONT></h1>
			
	  </div>
		</div>
	<!-- end #content -->
	<div id="sidebar1">
		<div id="news" class="boxed1">
			<blockquote>
			  <blockquote>
			    <h2 class="title"><FONT color="#000000">Login</FONT></h2>
		      </blockquote>
		  </blockquote>
	  </div>
   <form name="login" id="f1" action="Login" method="post">&nbsp;<br /><br /><br />
   <table width="473" border="0" height="198">
   <tr>
    <td colspan="2">
                <%
				  if(request.getParameter("status")!=null)
				  {
				%>
				<%=request.getParameter("status")%>
                <%}
                %>
    </td>
   </tr>
   <tr>
    <td width="494" height="34"><h3><FONT color="#000000"><strong>Username</strong></FONT></h3></td>
    <td width="350"><label>
      <input name="login" type="text" id="textfield" size="22" />
    </label></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td height="32"><h3><FONT color="#000000"><strong>Password</strong></FONT></h3></td>
    <td><input name="password" type="password" id="textfield2" size="22" /></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2">
    <div align="center">
      <input type="submit" name="button" id="button" value="Sign In" />
    </div>    </td>
    </tr>
</table>
<i><p style="color: white; font-family: fantasy; font-size: 18px">CONTACT US</p>
      <p style="color: white;font-family: fantasy; font-size: 18px">ERB In Online Library Management System</p></i>
      <p style="color: white;font-family: fantasy; font-size: 18px">Contact: 9515093781</p></i>
      <p style="color: white;font-family: fantasy; font-size: 18px">Email: erblibrary123@gmail.com</p></i>
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
