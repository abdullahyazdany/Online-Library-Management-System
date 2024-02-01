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
          var stuid=document.returnbook.stuid.value;
          location.href="getbooks?isbn="+isbn+"&page=/ReturnBook.jsp&prefix=issue&stuid="+stuid;  
     }
     function change1()
     {
         var isbn="";  
          var stuid=document.returnbook.stuid.value;
          var bookid=document.returnbook.bookid.value;
          location.href="getbooks?isbn="+isbn+"&page=/ReturnBook.jsp&prefix=issue&stuid="+stuid+"&bookid="+bookid; 
     }
     function calculate()
     {
        if(parseInt(document.returnbook.bookcost.value)>0)
        {
            //alert(document.returnbook.bookcost.value);
            //alert(document.returnbook.fine.value);
            document.returnbook.totalcost.value=parseInt(document.returnbook.bookcost.value)+parseInt(document.returnbook.fine.value);
            //alert(document.returnbook.totalcost.value);
	        document.returnbook.return1.disabled=false; 
	        checkbalance();
	    }
     }
     function enable()
     {
        //document.returnbook.bookcost.disabled=false;
        document.returnbook.return1.disabled=true;  
        document.returnbook.cash.disabled=false; 
        document.returnbook.bookcost.value=document.returnbook.bookcosthid.value;
        //document.returnbook.calculate.disabled=false;  
        calculate();
     }
     function checkbalance()
     {
        if(parseInt(document.returnbook.totalcost.value)>parseInt(document.returnbook.amount.value))
        {
           alert("Insufficient Amount\n Amount shoud be pay by Cash");  
           return false;
        }
        return true;
     }
     function feetype()
     {
        if(document.returnbook.cash.value=="Deduct from Fee")
        {
            if(!checkbalance())
            	document.returnbook.return1.disabled=true;
        } 
        else
                document.returnbook.return1.disabled=false; 	
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
			    <h2 class="title">Return Book</h2>
		      </blockquote>
		  </blockquote>
	  </div>
   <FORM action="returnbook" name="returnbook" method="post" onSubmit="return checkbalance()">
 <table width="386" height="394" border="0" align="center">
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
            int amount=0;
            %><td width="146"><span class="style1">Student ID</span></td>
<TD width="151"><select name="stuid" onChange="change()">
             
                 <%
                if(session.getAttribute("stuid")!=null)
                { 
                   amount=Integer.parseInt((String)session.getAttribute("amount"));
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
     <td><span class="style1">Book ID</span></td>
     <TD><select name="bookid" onChange="change1()">
     <%        System.out.println((String)session.getAttribute("stuid"));
              int price=0;
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
       				 rs=st.executeQuery("select i.book_id,b.book_price from lms_books_issue i,lms_books b where stu_id='"+(String)session.getAttribute("stuid")+"' and i.book_id=b.book_id");
           			 String bookid="";
           			 
           			 while(rs.next())
           			 {
                         bookid=rs.getString(1);
                         //price=rs.getInt(2);
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
      		rs=st.executeQuery("select to_char(i.issue_date),to_char(i.return_date),(sysdate-i.return_date)*10,b.book_price from lms_books_issue i,lms_books b where i.stu_id='"+(String)session.getAttribute("stuid")+"' and i.book_id='"+(String)session.getAttribute("bookid")+"' and i.book_id=b.book_id");
         	String bookid="";
         	int fine=0;
         	 int fine1=0;
           	if(rs.next())
           	 {
      %>
                <tr> <td><span class="style1">Issued Date</span></td>
        <td><input type="text" name=issuedate value="<%=rs.getString(1)%>" readonly/></td></TR>
     <tr>
     <td><span class="style1">Return Date</span></td>
     <td><input type="text" name=returndate value="<%=rs.getString(2)%>" readonly/></td></TR>  
     
     
     <%  
         fine=rs.getInt(3);
         price=rs.getInt(4);
        if(fine>0)
        { 
        fine1=fine;
     %> 
     <TR><td><span class="style1">Fine</span></td>
     <td><input type="text" name="fine" value="<%=fine1%>" /></td></tr>     
     	
      <% }
      else
      {%>
        <TR><td><span class="style1">Fine</span></td>
        <td><input type="text" name="fine" value="<%=fine1%>" readonly/></td></tr>
        
      <%}            
             }
             else
             {%>
            <tr> <td><span class="style1">Issued Date</span></td>
        <td><input type="text" name=issuedate  readonly/></td></TR>
     <tr>
     <td><span class="style1">Return Date</span></td>
     <td><input type="text" name=returndate  readonly/></td></TR>
     <TR>
     <td><span class="style1">Fine</span></td>
     <td><input type="text" name="fine" value="<%=fine1%>"  /></td></tr> 
                        
             <% }
           %>
     <tr><td><span class="style1">Amount Remaining</span></td>
     <td><input type="text" name="amount" value="<%=amount%>" readonly/></td></tr><tr>
     <td colspan="2"><input type="button" value="In case of loss of Book click here" onClick="enable()"/><br></td>
     <tr></tr>
     <tr><td><span class="style1">Book Cost</span></td><td><input type="hidden" name="bookcosthid" value="<%=price%>"/><input type="text" name="bookcost" value="0" readonly/></td><td width="75"></td></tr>
     <tr><td><span class="style1">Total Fine</span></td><td><input type="text" name="totalcost" value="<%=fine1%>" readonly/></td></tr>
     <TR>
     <td><span class="style1">Select Mode of Pay</span></td>
     <td><select name="cash" onChange="feetype()" disabled > 
         <OPTION value="Cash">Cash</OPTION>
         <option value="Deduct from Fee">Deduct from Fee</option>
                              </select></td></TR>
       	
     
     <tr></tr>
     <TR></TR>
     <TR></TR>
     <tr>
     <td align="center"><INPUT type="submit" name="return1" value="Return"/></td><TD><input type="reset" value="Clear"/></TD></tr>
     </table>
     
     
       <%  }
         catch(Exception e)
         {
             e.printStackTrace();
         }
          
            %>
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
