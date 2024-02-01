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
<script language="javascript">
     
     function change()
     {
          var isbn=document.issuebook.isbn.value;
          location.href="getbooks?isbn="+isbn+"&page=/IssueBook.jsp&prefix=issue";  
     }
     function change1()
     {
          var isbn=document.issuebook.isbn.value;
          var stuid=document.issuebook.stuid.value;
          location.href="getbooks?isbn="+isbn+"&page=/IssueBook.jsp&prefix=issue&stuid="+stuid;  
     }
     function fun()
      {
          if(document.issuebook.isbn.value=="" || document.issuebook.bookid.value=="")
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
 <jsp:include page="useroptions.html"/> 
	</div>
</div>
<div id="page">
  <!-- end #content -->
<div id="sidebar">
		<div id="news" class="boxed1">
			<blockquote>
			  <blockquote>
			    <h2 class="title">Issuing Book</h2>
		      </blockquote>
		  </blockquote>
	  </div>
   <FORM action="issuebook" name="issuebook" method="post" onsubmit="return fun()">
 <table align="center">
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
            //st.executeUpdate("update lms_books set status='Available' where book_id='"+request.getParameter("bookid")+"'");
            //st.executeUpdate("delete from lms_booking where book_id='"+request.getParameter("bookid")+"' and stu_id='"+request.getParameter("stuid")+"'");
            ResultSet rs=st.executeQuery("select isbn_no,category from lms_isbn");
     %><td width="145"><span class="style1">ISBN No.</span></td>
<TD width="168"><input type="text" name="isbn" value="<%=request.getParameter("isbn")%>"/>             </TD>
     </tr>
     <tr>
     <td><span class="style1">Book ID</span></td>
     <TD><input type=text name="bookid" value="<%=request.getParameter("bookid")%>"/>     </TD>
     </tr><tr>
     <td><span class="style1">Student ID</span></td>
     <TD><input type="text" name="stuid"  value="<%=request.getParameter("stuid")%>"/>
        
     <%       rs=st.executeQuery("select fee,n_books from lms_registration where reg_id='"+request.getParameter("stuid")+"'");
      %>     </TD>
     </tr>
     <%
          if(rs.next())
          {%>
     <tr><td><span class="style1">Amount Remaining</span></td>
     <td><input type="text" name="fee" value="<%=rs.getInt(1)%>" readonly/></td><td width="76"><span class="style1">Min. Rs 200 </span></td>
     </tr>
     <tr>
     <td><span class="style1">No. of books issued</span></td>
     <td><input type="text" name="nbooks" value="<%=rs.getInt(2)%>" readonly/></td><td><span class="style1">Max. 3 books</span></td>
     </tr>
          <%}else{%>
        <tr>  <td><span class="style1">Amount Remaining</span></td>
        <td><input type="text" name="fee" readonly/></td><td><span class="style1">Min. Rs 200 </span></td>
        </tr>
     <tr>
     <td><span class="style1">No. of books issued</span></td>
     <td><input type="text" name="nbooks"  readonly/></td><td><span class="style1">Max. 3 books</span></td>
     </tr>
                <%}%>
     <tr>
     <%
            rs=st.executeQuery("select to_char(sysdate),to_char(sysdate+15) from dual");
     %>
             
               
       <%
                
           while(rs.next())
           { 
	  %>
             <td><span class="style1">Issue Date</span></td>
        <TD><input type="text" name="isuuedate" value="<%=rs.getString(1)%>" readonly/></td></tr>
             
             <tr><td><span class="style1">Return Date</span></td>
             <TD><input type="text" name="returndate" value="<%=rs.getString(2)%>" readonly/>
      <%
             }
      %>     </TD>
     </tr>
     <tr></tr>
     <tr></tr>
     <tr></tr>
     <tr>
     <td align="center"><input type="submit" name=return1 value="Issue"/></td><td><input type="reset" value="Clear"/></td>
     </tr>
     </table>
   </FORM>
    <%}
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
