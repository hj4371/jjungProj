<%@page import="com.Library.vo.Member"%>
<%@page import="java.util.List"%>
<%@page import="com.Library.dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String mid = null;
	if (request.getSession().getAttribute("mid") == null) {
		request.getSession().setAttribute("returnURL", "/books.jsp");
		response.sendRedirect("login.jsp");
	} else {
		mid = (String) request.getSession().getAttribute("mid");
	}
	
	MemberDAO dao = new MemberDAO();
	List<Member> list = null;
	list = dao.getMembers("REGDATE");
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>library project_sung</title>
<link rel="stylesheet" type="text/css" href="css/AdminPage.css" />
</head>
<body>
	<% if (mid == null) { %>
	<jsp:include page="header.jsp" flush="flase"></jsp:include>
	<% } else { %>
	<jsp:include page="welcomeheader.jsp" flush="flase"></jsp:include>
	<% } %>

	<div id="main">
		<div class="list">
			<h2>Member List</h2>
			<table class="member">
			<tbody class="one">
				<% for(int i=0; i<list.size(); i++) { %>
					<%if(!list.get(i).getMid().equals("대출가능") ) { %>
						<tr>
							<td class="mid"><%= list.get(i).getMid() %></td>
							<td class="regdate"><%= list.get(i).getRegdate() %></td>
							<td class="name"><%= list.get(i).getName() %></td>
							<td class="phone"><%= list.get(i).getPhone() %></td>
							<% if(list.get(i).getBookregnum() !=0) { %>
								<td class="bookregnum">대출중   </td>
							<% } else { %>
								<td class="bookregnum">대출도서 없음</td>
									<% if( !list.get(i).getMid().equals("ADMINISTER")) {%>
								<td class="xbutton">
									<a href="adminDelProc.jsp?mid=<%=list.get(i).getMid() %>">x</a>
								</td>
									<%} %>
							<%} %>
						</tr>
						<%} %>
					<% } %>
					</tbody>
			</table>	
		</div>
	</div>
</body>
</html>