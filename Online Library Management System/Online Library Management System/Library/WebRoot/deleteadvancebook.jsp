
<%@ page language="java" import="java.util.*,java.sql.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'deleteadvancebook.jsp' starting page</title>
    
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    
    <!--
    <link rel="stylesheet" type="text/css" href="styles.css">
    -->
  </head>
  
  <body>
        <center>
  
  <br><br>
 <table>
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
                        Statement st1=con.createStatement();
            st.executeUpdate("delete from lms_booking where book_id='"+request.getParameter("bookid")+"' and stu_id='"+request.getParameter("stuid")+"'");
            ResultSet rs=st.executeQuery("select * from lms_booking where book_id='"+request.getParameter("bookid")+"' order by booking_date");
            
            if(rs.next())
            {
                st1.executeUpdate("update lms_books set status='Booked' where book_id='"+request.getParameter("bookid")+"'");
                st1.executeUpdate("insert into lms_mails values(msg_seg.nextval,'"+rs.getString(1)+"','The bookid-"+request.getParameter("bookid")+" is available. Collect the book with in 48 hours.')");
            }
            else
            {
                st1.executeUpdate("update lms_books set status='Available' where book_id='"+request.getParameter("bookid")+"'");
            }
           	
           %><jsp:forward page="/AdvanceBooks.jsp"/>
                <%}
         catch(Exception e)
         {
             e.printStackTrace();
             %><jsp:forward page="/AdvanceBooks.jsp"/>
                <%
         }
          
      %>                        
     

    

  </body>
</html>
