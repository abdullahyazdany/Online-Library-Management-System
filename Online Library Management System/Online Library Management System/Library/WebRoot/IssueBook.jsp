<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page language="java" import="java.util.*,java.sql.*"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="content-type" content="text/html; charset=utf-8" />
		<title></title>
		<meta name="keywords" content="" />
		<meta name="description" content="" />
		<link href="default.css" rel="stylesheet" type="text/css" />
		<script language="javascript">
function fun() {
	location.href = "viewjournals.jsp";
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
		<script language="javascript">

function change() {
	var isbn = document.issuebook.isbn.value;
	location.href = "getbooks?isbn=" + isbn
			+ "&page=/IssueBook.jsp&prefix=issue";
}
function change1() {
	var isbn = document.issuebook.isbn.value;
	var stuid = document.issuebook.stuid.value;
	location.href = "getbooks?isbn=" + isbn
			+ "&page=/IssueBook.jsp&prefix=issue&stuid=" + stuid;
}
function fun() {
	if (document.issuebook.isbn.value == ""
			|| document.issuebook.bookid.value == "") {
		alert("All fields are Manditary");
		return false;
	}
	return true;
}
</script>
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
								Issuing Book
							</h2>
						</blockquote>
					</blockquote>
				</div>
				<FORM action="issuebook" name="issuebook" method="post"
					onsubmit="return fun()">
					<table align="center">
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
							%><td width="117" height="28" class="style1">
								ISBN No.
							</td>
							<TD width="167">
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
							<td height="28" class="style1">
								Book ID
							</td>
							<TD>
								<select name="bookid">
									<%
										System.out.println((String) session.getAttribute("isbnno"));

											if (session.getAttribute("isbnno") != null) {
												System.out.println("values are going to be shown here");
												//Vector v=new Vector();
												//v=(Vector)session.getAttribute("isbn");
												// Iterator i=v.iterator();

												//while(i.hasNext())
												//{
												//GetBooksBean bean=(GetBooksBean)i.next();
												rs = st
														.executeQuery("select book_id from lms_books where isbn_no='"
																+ (String) session.getAttribute("isbnno")
																+ "' and status='Available'");
												String bookid = "";
												while (rs.next()) {
													bookid = rs.getString(1);
									%>
									<option value=<%=bookid%>><%=bookid%></option>
									<%
										}
											}
									%>
								</select>
							</TD>
						</tr>
						<tr>
							<%
								rs = st.executeQuery("select reg_id from lms_registration");
							%><td height="26" class="style1">
								Student ID
							</td>
							<TD>
								<select name="stuid" onChange="change1()">

									<%
										if (session.getAttribute("stuid") != null) {
									%>
									<option value="<%=(String) session.getAttribute("stuid")%>"><%=(String) session.getAttribute("stuid")%></option>
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
									<option value=<%=rs.getString(1)%>><%=rs.getString(1)%></option>
									<%
										}
											rs = st
													.executeQuery("select fee,n_books from lms_registration where reg_id='"
															+ (String) session.getAttribute("stuid") + "'");
									%>
								</select>
							</TD>
						</tr>
						<%
							double fee = 0.0;
								int nbooks = 0;
								if (rs.next()) {
									fee = rs.getDouble(1);
									nbooks = rs.getInt(2);
						%>
						<tr>
							<td height="28" class="style1">
								Amount Remaining
							</td>
							<td>
								<input type="text" name="fee" value="<%=fee%>" readonly />
							</td>
							<td width="96" class="style1">
								Min. Rs 300
							</td>
						</tr>
						<tr>
							<td height="27" class="style1">
								No. of books issued
							</td>
							<td>
								<input type="text" name="nbooks" value="<%=nbooks%>" />
							</td>
							<td class="style1">
								Max. 3 books
							</td>
						</tr>
						<%
							} else {
						%>
						<tr>
							<td height="27" class="style1">
								Amount Remaining
							</td>
							<td>
								<input type="text" name="fee" readonly />
							</td>
							<td class="style1">
								Min. Rs 300
							</td>
						</tr>
						<tr>
							<td height="28" class="style1">
								No. of books issued
							</td>
							<td>
								<input type="text" name="nbooks" />
							</td>
							<td class="style1">
								Max. 3 books
							</td>
						</tr>
						<%
							}
						%>
						<tr>
							<%
								rs = st
											.executeQuery("select to_char(sysdate),to_char(sysdate+15) from dual");
							%>


							<%
								while (rs.next()) {
							%>
							<td height="27" class="style1">
								Issue Date
							</td>
							<TD>
								<input type="text" name="isuuedate" value="<%=rs.getString(1)%>"
									readonly>
							</td>
						</tr>

						<tr>
							<td height="30" class="style1">
								Return Date
							</td>
							<TD>
								<input type="text" name="returndate"
									value="<%=rs.getString(2)%>" readonly />
								<%
									}
								%>
							</TD>
						</tr>

						<tr>
							<td height="30" colspan="2" align="center" class="style1">
								<%
									if (fee < 300 || nbooks == 3) {
								%>
								Issue Not Possible
								<%
									} else {
								%>
								<input type="submit" name=return1 value="Issue" />
								&nbsp;
								<input type="reset" value="Clear" />
								<%
									}
								%>
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
