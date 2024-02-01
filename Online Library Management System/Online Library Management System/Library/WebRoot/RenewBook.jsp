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
          var isbn="";  
          var stuid=document.renewbook.stuid.value;
          location.href="getbooks?isbn="+isbn+"&page=/RenewBook.jsp&prefix=issue&bookid=&stuid="+stuid;  
     }
     function change1()
     {
         var isbn="";  
          var stuid=document.renewbook.stuid.value;
          var bookid=document.renewbook.bookid.value;
          location.href="getbooks?isbn="+isbn+"&page=/RenewBook.jsp&prefix=issue&stuid="+stuid+"&bookid="+bookid; 
     }
     function calculate()
     {
         var str1=new Date(document.renewbook.issuedate.value);
        var str2=new Date(document.renewbook.returndate.value);
        var bookid=document.renewbook.bookid.value;
        var stuid=document.renewbook.stuid.value;
	      location.href="calculatefine?page=/RenewBook.jsp&isbn=&prefix=&bookid="+bookid+"&stuid="+stuid; 
	  
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
			    <h2 class="title">Renew Book</h2>
		      </blockquote>
		  </blockquote>
	  </div>
   <FORM action="renewbook" name="renewbook" method="post">
 <table height="366" border="0" align="center">
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
            %><td width="142" height="34"><span class="style1">Student ID</span></td>
<TD width="142"><select name="stuid" onChange="change()">
             
                 <%
                if(session.getAttribute("stuid")!=null)
                {
                 %>
               <option value="<%=(String)session.getAttribute("stuid")%>"><%=(String)session.getAttribute("stuid")%></option>
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
             <option value=<%=rs.getString(1)%>><%=rs.getString(1)%></option>
      <%
            }%>
         </select></TD>
     </tr>
     <tr>
     <td height="31"><span class="style1">Book ID</span></td>
     <TD><select name="bookid" onChange="change1()">
     <%        System.out.println((String)session.getAttribute("stuid"));
              
                if(session.getAttribute("bookid")!=null)
                {
                 %>
               <option value="<%=(String)session.getAttribute("bookid")%>"><%=(String)session.getAttribute("bookid")%></option>
       <%       }
                else
                {
       %>
                <option>--select--</option>
       <%
                }
                if(session.getAttribute("stuid")!=null)
                {
                     System.out.println("values are going to be shown here");
       				 rs=st.executeQuery("select book_id from lms_books_issue where stu_id='"+(String)session.getAttribute("stuid")+"'");
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
     </select></TD>
     </tr>
  <%
      //if(session.getAttribute("bookid")!=null && session.getAttribute("stuid")!=null)
      //{
            System.out.println("values are going to be shown here");
      		rs=st.executeQuery("select to_char(issue_date),to_char(return_date),(sysdate-return_date)*10 from lms_books_issue where stu_id='"+(String)session.getAttribute("stuid")+"' and book_id='"+(String)session.getAttribute("bookid")+"'");
         	String bookid="";
         	int fine=0;
         	int fine1=0;
           	if(rs.next())
           	 {
      %>
                <tr> <td height="30"><span class="style1">Previous Issued Date</span></td>
        <td><input type="text" name=issuedate value="<%=rs.getString(1)%>" readonly/></td></TR>
     <tr>
     <td height="30"><span class="style1">Previous Return Date</span></td>
     <td><input type="text" name=returndate value="<%=rs.getString(2)%>" readonly/></td></TR>         		
      <%             fine=rs.getInt(3);
             }
             else
             {%>
            <tr> <td height="29"><span class="style1">Previous Issued Date</span></td>
        <td><input type="text" name=issuedate  readonly/></td></TR>
     <tr>
     <td height="32"><span class="style1">Previous Return Date</span></td>
     <td><input type="text" name=returndate  readonly/></td></TR>
                         
             <% }
    
     if(fine>0)
        { 
        fine1=fine;
     %> 
     <TR><td height="29"><span class="style1">Fine</span></td>
     <td><input type="text" name="fine" value="<%=fine1%>" readonly/></td></tr>     
     	
      <% }
      else
      {%>
        <TR><td height="30"><span class="style1">Fine</span></td>
        <td><input type="text" name="fine" value="<%=fine1%>" readonly/></td></tr>
        
      <%} %>           
     
     <tr>
     <%
            rs=st.executeQuery("select to_char(sysdate),to_char(sysdate+15) from dual");
     %>
             
               
       <%
                
           while(rs.next())
           { 
	  %>
             <td height="33"><span class="style1">Issue Date</span></td>
        <TD><input type="text" name="isuuedate" value="<%=rs.getString(1)%>" readonly></td></tr>
             
             <tr><td height="31"><span class="style1">Return Date</span></td>
             <TD><input type="text" name="returndate" value="<%=rs.getString(2)%>" readonly/></TD>
      <%
             }
      %>
     </tr>
     
     <tr>
     <td colspan="2" align="center"><INPUT type="submit" name="return1" value="Renew"/>&nbsp;
       <input type="reset" value="Clear"/></td></tr>
     </table>
 
    </FORM>
     
       <%  }
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
