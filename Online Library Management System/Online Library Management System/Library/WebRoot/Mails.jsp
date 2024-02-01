<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page language="java" import="java.util.*,java.sql.*"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title></title>
		<meta name="keywords" content="" />
		<meta name="description" content="" />
		<link href="default.css" rel="stylesheet" type="text/css" />
		<script language="javascript">
      function fun()
      {
          var jid=document.getbook.hidden.value;
          var issue=document.getbook.issue.value;
          location.href="viewjournals.jsp?jid="+jid+"&issue="+issue;
      }
     function change()
     {
          var isbn=document.getbook.isbn.value;
          location.href="getbooks?isbn="+isbn+"&page=/viewjournals.jsp&bookid=&stuid=&prefix=";  
     }
  </script>
		<style type="text/css">
<!--
.style4 {
	color: #FFFFFF
}

.style6 {
	color: #000000;
	font-weight: bold;
}

a:link {
	color: #FF0000;
}

a:hover {
	color: #FFFFFF;
}
-->
</style>
	</head>
	<body>
		<div id="header">
			<div id="logo">
				<h1><jsp:include page="header.html" />
				</h1>

			</div>
			<div id="menu">
				<jsp:include page="useroptions.html" />
			</div>
		</div>
		<div id="page">
			<!-- end #content -->
			<div id="sidebar">
				<div id="news" class="boxed1">
					<blockquote>
						<blockquote>
							<h2 class="title">
								Mails
							</h2>
						</blockquote>
					</blockquote>
				</div>
				<table width="603" border="0" align="center">
					<tr>
						<th width="74" bgcolor="#B59631">
							<span class="style4">Msg ID.</span>
						</th>
						<th width="471" bgcolor="#B59631">
							<span class="style4">Content</span>
						</th>
					</tr>

					<%
						ServletContext ctx = getServletContext();
						String driver = ctx.getInitParameter("driver");
						String url = ctx.getInitParameter("url");
						String dname = ctx.getInitParameter("dname");
						String dpass = ctx.getInitParameter("dpass");
						try {
							Class.forName(driver);
							Connection con = DriverManager.getConnection(url, dname, dpass);
							Statement st = con.createStatement();
							String msgid = "";
                             
							System.out.println("select * from lms_mails where per_id='"
									+ (String) session.getAttribute("userid") + "'");
							ResultSet rs = st
									.executeQuery("select * from lms_mails where per_id='"
											+ (String) session.getAttribute("userid") + "'");
							while (rs.next()) {
								msgid = rs.getString(1);
					%>
					<tr>
						<td bgcolor="#F7AF9B">
							<div align="center" class="style6"><%=msgid%></div>
						</td>
						<td bgcolor="#F7AF9B">
							<span class="style6"><%=rs.getString(3)%></span>
						</td>
						<td width="36" bgcolor="#F7AF9B">
							<a href="DeleteMails?msgid=<%=msgid%>&page=UserHome.jsp">Delete</a>
						</td>
					</tr>
					<%
						}

						} catch (Exception e) {
							System.out.println(e);
							e.printStackTrace();
						}
					%>
				</table>
				</center>

			</div>
			<!-- end #sidebar -->
		</div>
		<!-- end #page -->
		<div id="footer">
			<p>
				&nbsp;
			</p>
		</div>
	</body>
</html>
