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
     location.href="viewjournals.jsp";
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
			    <h2 class="title">Add Journal</h2>
		      </blockquote>
		  </blockquote>
	  </div>
    <FORM action="addJournal" name="addbook" method="post">
 <table width="296" border="0" align="center">
   <tr>
   <td width="104"><span class="style1">Journal Name</span></TD>
   <td width="182"><input type="text" name="jname"/></td>
   </tr>
   <tr>
   <td><span class="style1">Price</span></TD>
   <td><input type="text" name="jprice"/></td>
   </tr>
   <tr>
   <td><span class="style1">Period</span></TD>
   <td><select name="jperiod">
   <option value="Daily">Daily</option>
   <option value="Weekly">Weekly</option>
   <option value="Fortnightly">Fortnightly</option>
   <option value="Monthly">Monthly</option>
   <option value="Annually">Annually</option>  </select>   </td>
   </tr>
   <tr>
   <td><span class="style1">Issue On</span></TD>
   <td><input type="text" name="jissue"/></td>
   </tr>
     <tr>
   <td colspan="2"><div align="center">
     <input type="submit" name="add" value="Add Journal"/> &nbsp;    
     <input type="button" value="View" onClick="fun()"/>
   </div></td>
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
