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
.style9 {color: #000000; font-weight: bold; }
.style2 {color: #000000}
-->
</style>
 <script language="javascript">
  function change()
  {
     
     if(document.report.report1.value=="Weakly" || document.report.report1.value=="Monthly")
     {
          
          document.report.tdate.disabled=false;
          document.report.tmonth.disabled=false;
          document.report.tyear.disabled=false;
     }
     if(document.report.report1.value=="Daily")
     {
          document.report.tdate.disabled=true;
          document.report.tmonth.disabled=true;
          document.report.tyear.disabled=true;
     }
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
			    <h2 class="title">Reports</h2>
		      </blockquote>
		  </blockquote>
	  </div>
    <form action="report" name="report" method="post">
 <table border="0" align="center">
  <tr>
  <TD width="181" height="28"><span class="style9">Select Report Type   </span></TD><TD width="152"><span class="style9">
    <select name="report1" onChange="change()">
      <option value="Daily">Daily</option>
      <option value="Weakly">Weakly</option>
      <option value="Monthly">Monthly</option>
    </select>
  </span>      </TD>
      </tr>
      
      <tr>

  <TD height="28"><span class="style9">Select Type</span></TD>
  <TD><span class="style9">
    <select name="report2">
      <option value="issued">Issued Books</option>
      <option value="fines">Fines</option>
    </select>
    </span>  </TD>
      </tr>
      <tr>
      <TD height="29" align="center"><span class="style9">From</span></TD>
      <TD align="center"><span class="style9">To</span></TD>
   <tr>
   
   <TD height="30"><strong>
         <select name="fdate">
           <%
      for(int i=1;i<=31;i++)
      {
   %>
           <option><%=i%></option>
              <%}%>
             </select>
         <select name="fmonth">
           <OPTION>Jan</OPTION>
           <OPTION>Feb</OPTION>
           <OPTION>Mar</OPTION>
           <OPTION>Apr</OPTION>
           <OPTION>May</OPTION>
           <OPTION>Jun</OPTION>
           <OPTION>Jul</OPTION>
           <OPTION>Aug</OPTION>
           <OPTION>Sep</OPTION>
           <OPTION>Oct</OPTION>
           <OPTION>Nov</OPTION>
           <OPTION>Dec</OPTION>
         </select>
         <select name="fyear">
           <%
      for(int i=2004;i<=2020;i++)
      {
   %>
           <option><%=i%></option>
              <%}%>
         </select>
      </strong></TD>
   <TD><strong>
         <select name="tdate" disabled>
           <%
      for(int i=1;i<=31;i++)
      {
   %>
           <option><%=i%></option>
              <%}%>
             </select>
         <select name="tmonth" disabled>
           <OPTION>Jan</OPTION>
           <OPTION>Feb</OPTION>
           <OPTION>Mar</OPTION>
           <OPTION>Apr</OPTION>
           <OPTION>May</OPTION>
           <OPTION>Jun</OPTION>
           <OPTION>Jul</OPTION>
           <OPTION>Aug</OPTION>
           <OPTION>Sep</OPTION>
           <OPTION>Oct</OPTION>
           <OPTION>Nov</OPTION>
           <OPTION>Dec</OPTION>
         </select>
         <select name="tyear" disabled>
           <%
      for(int i=2004;i<=2020;i++)
      {
   %>
           <option><%=i%></option>
              <%}%>
         </select>
      </strong></TD>
   </tr>
   <tr><td colspan="2" align="center"><strong>
         <input type="submit" value="Get Reports"/>
   </strong></td>
   </table>
   
   </form>
   <%
     if(session.getAttribute("report")!=null)
     {
     %>
     <p align="right"><strong>Export To : <a href="ExportXLS">XLS</a> | <a href="ExportTXT" target="_blank">HTML</a></strong></p>
     <%=(String)session.getAttribute("report")%>
    <%}
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
