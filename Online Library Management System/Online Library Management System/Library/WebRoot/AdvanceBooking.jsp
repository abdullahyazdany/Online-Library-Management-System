<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page language="java" import="java.util.*,java.sql.*"%>
<%@page session="true"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="content-type" content="text/html; charset=utf-8" />
		<title></title>
		<meta name="keywords" content="" />
		<meta name="description" content="" />
		<link href="default.css" rel="stylesheet" type="text/css" />
		<script language="javascript">

function change() {
	var isbn = document.advancebook.isbn.value;
	location.href = "getbooks?isbn=" + isbn
			+ "&page=/AdvanceBooking.jsp&prefix=";
}
function change1() {
	var isbn = document.advancebook.isbn.value;
	var stuid = document.advancebook.stuid.value;
	location.href = "getbooks?isbn=" + isbn
			+ "&page=/AdvanceBooking.jsp&prefix=&stuid=" + stuid;
}
function fun() {
	if (document.advancebook.isbn.value == ""
			|| document.advancebook.bookid.value == "") {
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
				<h1><jsp:include page="header.html" />
				</h1>

			</div>
			<div id="menu">
				<jsp:include page="studentoptions.html" />
			</div>
		</div>
		<div id="page">
			<!-- end #content -->
			<div id="sidebar">
				<div id="news" class="boxed1">
					<blockquote>
						<blockquote>
							<h2 class="title">
								Advanace Booking
							</h2>
						</blockquote>
					</blockquote>
				</div>
				<FORM action="advancebook" name="advancebook" method="post"
					onSubmit="return fun()">
					<table border="0" align="center">
						<tr>
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
									ResultSet rs = st
											.executeQuery("select isbn_no,category from lms_isbn");
							%><td width="90" height="31">
								<span class="style1">ISBN No.</span>
							</td>
							<TD width="160">
								<select name="isbn" onChange="change()">
									<%
										if (session.getAttribute("isbnno") != null) {
									%>
									<option value="<%=(String) session.getAttribute("isbnno")%>"><%=(String) session.getAttribute("isbnno")%></option>
									<%
										} else {
									%>
									<option>
										--select--
									</option>
									<%
										}
											while (rs.next()) {
									%>
									<option value=<%=rs.getString(1)%>><%=rs.getString(1)%>-<%=rs.getString(2)%></option>
									<%
										}
									%>
								</select>
							</TD>
						</tr>
						<tr>
							<td height="32">
								<span class="style1">Book ID</span>
							</td>
							<TD>
								<select name="bookid">
									<%
										if (request.getParameter("isbnno") != null) {
												String ino = request.getParameter("isbnno");
												rs = st
														.executeQuery("select BOOK_ID,BOOK_TITLE from LMS_BOOKS where ISBN_NO='"
																+ ino
																+ "' and STATUS like 'Available' and BOOK_ID not in (select BOOK_ID from LMS_BOOKING where ISBN_NO='"
																+ ino + "')");
												String bookid = "";
												while (rs.next()) {
													bookid = rs.getString(1);
									%>
									<option value=<%=bookid%>><%=bookid + " " + rs.getString(2)%></option>
									<%
										}
											}
									%>
								</select>
							</TD>
						</tr>
						<tr>
							<td height="32">
								<span class="style1">Student ID</span>
							</td>
							<td>
								<input type="text" name="stuid"
									value="<%=(String) session.getAttribute("userid")%>" readonly />
							</td>
						</tr>

						<tr>
							<td colspan="2" align="center">
								<div align="center">
									<input type="submit" value="Advance Book" />
									&nbsp;
									<input type="reset" value="Clear" />
								</div>
							</td>
						</tr>
					</table>
				</FORM>
				<%
					} catch (Exception e) {
						e.printStackTrace();
					}
				%>
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
