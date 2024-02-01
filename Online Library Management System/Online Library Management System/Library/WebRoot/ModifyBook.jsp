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
          var isbn=document.getbook.isbn.value;
          location.href="getbooks?isbn="+isbn+"&page=/ModifyBook.jsp&bookid=&stuid=&prefix=";  
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
			    <h2 class="title">Modify Book </h2>
		      </blockquote>
		  </blockquote>
	  </div>
    <FORM action="ModifyBook.jsp" name="getbook" method="post">
 <table width="242" height="98" align="center">
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
            ResultSet rs=st.executeQuery("select isbn_no,category from lms_isbn");
     %><td><span class="style1">ISBN No.</span></td>
     <TD><select name="isbn" onchange="change()">
             <%
                if(session.getAttribute("isbnno")!=null)
                {
                 %>
               <option value="<%=(String)session.getAttribute("isbnno")%>"><%=(String)session.getAttribute("isbnno")%></option>
       <%       }
                else
                {
       %>
                <option>--select--</option>
       <%
                }
           while(rs.next())
           { 
	  %>
             <option value=<%=rs.getString(1)%>><%=rs.getString(1)%>-<%=rs.getString(2)%></option>
      <%
            }
      %>
      </select>     </TD>
     </tr>
     <tr>
     <td><span class="style1">Book ID</span></td>
     <TD><select name="bookid">
     <%        System.out.println((String)session.getAttribute("isbnno"));
                
                if(session.getAttribute("isbnno")!=null)
                {
                     System.out.println("values are going to be shown here");
       				 //Vector v=new Vector();
       				 //v=(Vector)session.getAttribute("isbn");
        			// Iterator i=v.iterator();
        
        			//while(i.hasNext())
        			//{
        			  //GetBooksBean bean=(GetBooksBean)i.next();
           				rs=st.executeQuery("select book_id from lms_books where isbn_no='"+(String)session.getAttribute("isbnno")+"'");
           				String bookid="";
           				while(rs.next())
           				{
                         bookid=rs.getString(1);
                         %>
      
           				<option value=<%=bookid%>><%=bookid%></option>
      <%             
        			    }
                }
        
      %> 
      </select>     </TD>
     </tr>
     <tr></tr>
     <tr></tr>
     <tr>
     <td align="center" colspan="2"><input type="submit" value="Get Details"/></td>
     </tr>
     </table>
</FORM>

<FORM action="ModifyBook" name="modifybook" method="post" onSubmit="return fun()">
<%
      if(request.getParameter("isbn")!=null && request.getParameter("bookid")!=null)
      {
        rs=st.executeQuery("select isbn_no,book_id,book_title,book_author,status from lms_books where isbn_no='"+request.getParameter("isbn")+"' and book_id='"+request.getParameter("bookid")+"'");
        while(rs.next())
        {
%>

 <table width="400" height="190" border="0" align="center">
 <tr>
     <td width="104"><span class="style1">ISBN No</span></td>
     <TD width="168"><input type="text" name="isbn" value=<%=rs.getString(1)%> readonly/></TD>
     </tr>
     <tr>
     <td><span class="style1">Book ID</span></td>
     <TD><input type="text" name="bookid" value=<%=rs.getString(2)%> readonly/></TD>
     </tr>
   <tr>
   
     <td><span class="style1">Book Title</span></td>
     <TD><input type="text" name="title" value="<%=rs.getString(3)%>"/></TD>
     </tr>
     <tr>
     <td><span class="style1">Book Author</span></td>
     <TD><input type="text" name="author" value="<%=rs.getString(4)%>"/></TD>
     </tr>
     
     <%
       if(rs.getString(5).equals("Lost"))
       {
     %>
     <tr>
     <td><span class="style1">Book Status</span></td>
     <TD><input type="text" name="status" value="Available"/></TD><td width="112"><font color="red">This is book is lost</font></td>
     </tr>
     <%
       }
     %>
     <tr></tr>
     <tr></tr>
     <%
       if(rs.getString(5).equals("Available") || rs.getString(5).equals("Lost"))
       {
     %>
     <tr>
     <td colspan="2" align="center"><input type="submit" value="Update Details"/></td>
     </tr>
     <%
       }
       else
       {
     %>
       <tr><td colspan="2"><div align="center"><font color="red"> This Book Is Issued</font></div></td></tr>
     <%}%>
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
