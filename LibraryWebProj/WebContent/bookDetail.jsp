<%@page import="com.Library.vo.Member"%>
<%@page import="com.Library.dao.MemberDAO"%>
<%@page import="com.Library.dao.CommentDAO"%>
<%@page import="com.Library.vo.Comment"%>
<%@page import="java.util.List"%>
<%@page import="com.Library.vo.Booklist"%>
<%@page import="com.Library.dao.BooklistDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	String _regnum = request.getParameter("regnum");
	 int regnum=0;
	if (_regnum != null && !_regnum.equals("")) {
		regnum = Integer.parseInt(_regnum);
	}

	BooklistDAO dao = new BooklistDAO();
	Booklist book = dao.getBooklist(regnum);

	int pages = 1;
	String _pages = request.getParameter("pages");
	if (_pages != null && !_pages.equals("")) {
		pages = Integer.parseInt(_pages);
	}

	List<Comment> list = null;
	CommentDAO cdao = new CommentDAO();
	list = cdao.getComments(pages, 5, regnum);
	/* 	String seq = request.getParameter("seq"); */

	int cnt = cdao.getCount(regnum);
	int startPageNum = pages - (pages - 1) % 5;
	int endPageNum = cnt / 10 + (cnt % 10 == 0 ? 0 : 1);

	String mid = null;
	int a=0;
	boolean b=false;
	if (request.getSession().getAttribute("mid") == null) {
		request.getSession().setAttribute("returnURL", "/bookDetail.jsp?regnum="+regnum+"&pages="+pages);
		response.sendRedirect("login.jsp");
		
	} else {
		mid = (String) request.getSession().getAttribute("mid");
		
		MemberDAO mdao = new MemberDAO();
		Member m = mdao.getMember(mid);
		
		a = m.getBookregnum();
		/* System.out.println(a);	
		System.out.println(mid); */

		b=book.getStatus().equals(mid);
		/* System.out.println("b"+b); */
	}
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>library project_sung</title>
<link rel="stylesheet" type="text/css" href="css/bookDetail.css" />
</head>
<body>
	<% if (mid == null) { %>
	<jsp:include page="header.jsp" flush="flase"></jsp:include>
	<% } else { %>
	<jsp:include page="welcomeheader.jsp" flush="flase"></jsp:include>
	<% } %>
	
	<section>
		<div class="content">
		<h1 id="bookname"><%= book.getBookname() %></h1>
		<div id="showlist">
			<ul class="board">
				<li>저자&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%= book.getWriter() %></li>
				<li>발행처&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%= book.getPublish() %></li>
				<li>ISBN &nbsp;&nbsp;&nbsp;&nbsp;<%= book.getISBN() %></li>
				<li>소장위치&nbsp;&nbsp;&nbsp;<%= book.getLocations() %></li>
				<% if(book.getStatus().equals("대출가능")) {%>
					<li  class="status"><%= book.getStatus() %>
						<%if(a==0){ %>
						<a href="lendProc.jsp?regnum=<%=regnum %>" id="lend">대출</a>
						<%} %>
					</li>
				<%} else {%>
					<li  class="status">대출중
					<%if(b){ %>
					<a href="returnProc.jsp?regnum=<%=regnum %>" id="return">반납</a>
					<%} %>
					</li>
				<%} %>
				</form>
				<li>반납예정일&nbsp;&nbsp;&nbsp;<% if(book.getReturndate()!=null) { %>
					<%=book.getReturndate() %>
					<% } %> 
					</li>
				<form name="booking" method="post" action="" >
				<li>예약&nbsp;&nbsp;&nbsp;<%= book.getBooking() %>&nbsp;
				<input id="booking" class="button" type="button" value="예약" /></li>
				</form>
			</ul>
			<a class="img" href="" title="title1"><img src="images/<%=book.getImg() %>" width="200" height="250" alt="title1"/></a>
		</div>
		</div>
		
		
		
		<div class="comment">
		<form id="content-searchform" class="article-search-form" action="commentRegProc.jsp" method="post">
		<ul class="write-comment">
			<li class="input">
				<textarea id="txtContent" class="txtContent" name="content" rows="5" cols="105" >comment 쓰기</textarea>
				<p class="article-comment margin-small">
						<input type="hidden" name = "regnum" value="<%=regnum%>" /> 
						<input class="btn-write button"  type="submit" value="쓰기"/>
				</p>
			</li>
		</ul>
		</form>
		<div class="top-wrapper clear">
			<div class="content2">
				<table class="article-list margin-small">
					<tbody>
						<% for(int i=0; i<list.size(); i++) { %>
						<tr>
							<td class="commentbody"><%= list.get(i).getContent() %></td>
							<td class="writer"><%=list.get(i).getWriter() %></td>
							<td class="regdate"><%=list.get(i).getRegdate() %></td>
							<td class="xbutton">
								<% if(mid.equals("ADMINISTER") || list.get(i).getWriter().equals(mid)) { %>
									<a href="commentDelProc.jsp?regnum=<%=regnum %>&seq=<%=list.get(i).getSeq() %>">x</a>
								<%} %>
							</td>
						</tr>
						<% } %>
					</tbody>
				</table>
				<p id="cur-page" class="margin-small">
					<span class="strong"><%=pages %></span> / <%=endPageNum %>page</p>
				<div id="pager-wrapper" class="margin-small">
					<div class="pager-clear">
						<p id="btnPrev"> 
							<% if(startPageNum != 1) { %>
							<a class="button btn-prev"  href="bookDetail.jsp?pages=<%= startPageNum-5%>">이전</a> <%} %>
						</p>
						<ul class="numbering">
							<% for (int i = 0; i < 5; i++) { %>
							<li class="here">
								<% if (startPageNum + i <= endPageNum) { %> <% if(startPageNum + i == pages) { %>
								<a class="strong" href="bookDetail.jsp?pages=<%=startPageNum + i%>"><%=startPageNum + i%></a>
								<% } else if(startPageNum + i != pages) { %> 
								<a href="bookDetail.jsp?pages=<%=startPageNum + i%>"><%=startPageNum + i%></a>
								<% }%> <%} %>
							</li>
							<% } %>
						</ul>
						  	<p id="btnNext">
                        		<%if(startPageNum + 4 < endPageNum){ %>
                           			<a class="button btn-next" href="bookDetail.jsp?pages=<%=startPageNum+5 %>">다음</a>
                       			 <%} %>
                     		</p>
					</div>
				</div>
			</div>

		</div>
	</div>
	</section>

</body>
</html>