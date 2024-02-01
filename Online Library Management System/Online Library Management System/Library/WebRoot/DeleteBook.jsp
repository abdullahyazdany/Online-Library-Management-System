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
      
     function change()
     {
          var isbn=document.deletebook.isbn.value;
          location.href="getbooks?isbn="+isbn+"&page=/DeleteBook.jsp&stuid=&prefix=&bookid=";  
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
			    <h2 class="title">Delete Book</h2>
		      </blockquote>
		  </blockquote>
	  </div>
     <FORM action="DeleteBook" name="deletebook" method="post">
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
            ResultSet rs=st.executeQuery("select isbn_no,category from lms_isbn");
     %><td width="64"><span class="style1">ISBN No.</span></td>
       <TD width="136"><select name="isbn" onchange="change()">
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
      %></select>     </TD>
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
           				rs=st.executeQuery("select book_id from lms_books where isbn_no='"+(String)session.getAttribute("isbnno")+"' and status='Available'");
           				String bookid="";
           				while(rs.next())
           				{
                         bookid=rs.getString(1);
                         %>
      
           				<option value=<%=bookid%>><%=bookid%></option>
      <%             
        			    }
                }
                }
         catch(Exception e)
         {
             e.printStackTrace();
         }
          
      %>           </select>             </TD>
     </tr>
     <tr></tr>
     <tr></tr>
     <tr>
     <td align="center" colspan="2"><br><input type="submit" value="Delete Book"/></td>
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
