<%@page import="com.Library.dao.BooklistDAO"%>
<%@page import="com.Library.vo.Booklist"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String search = request.getParameter("search");
	String filter = request.getParameter("filter");
	
	//데이터 만들기
	int pages = 1;
	String _pages = request.getParameter("pages");
	if (_pages != null && !_pages.equals("")) {
		pages = Integer.parseInt(_pages);
	}
	
	List<Booklist> list = null;
	BooklistDAO dao = new BooklistDAO();

	if(search!=null && search.length()>0 && filter!=null && filter.length()>0) {
		list = dao.searchBooks(search, filter, pages);
		//System.out.println("size:"+list.size());
		//System.out.println("pages:"+pages);
	} else {
		list = dao.getBooklists(pages, 10);
		//System.out.println("size:"+list.size());
		
	}
	
	int cnt = dao.getCount(search, filter);
	int startPageNum = pages - (pages - 1) % 10;
	int endPageNum = cnt / 10 + (cnt % 10 == 0 ? 0 : 1);


	String mid = null;
	if (request.getSession().getAttribute("mid") == null) {
		request.getSession().setAttribute("returnURL", "/books.jsp");
		response.sendRedirect("login.jsp");
	} else {
		mid = (String) request.getSession().getAttribute("mid");
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>library project_sung</title>
<link rel="stylesheet" type="text/css" href="css/books.css" />
</head>
<body>
	<% if (mid == null) { %>
	<jsp:include page="header.jsp" flush="flase"></jsp:include>
	<% } else { %>
	<jsp:include page="welcomeheader.jsp" flush="flase"></jsp:include>
	<% } %>

	<section>
	<form action="searchBook.jsp" method="post">
	<div class="content">
		<h1 class="sb_title">SEARCH BOOKS</h1>
		<div id="ui_element" class="sb_wrapper">
			<div class="sb_element">
				<input class="sb_input" type="search" name="search" required/>
				<input class="sb_search" type="submit" value=""/>
			</div>
			<ul class="sb_dropdown" style="display: none;">
				<li class="sb_filter">Filter your search</li>
						<li><input type="radio" name="filter" value="BOOKNAME" checked/><label for="title">Title</label></li>
						<li><input type="radio" name="filter" value="ISBN"/><label for="ISBN">ISBN</label></li>
						<li><input type="radio" name="filter" value="WRITER"/><label for="writer">Writer</label></li>
						<li><input type="radio" name="filter" value="PUBLISH"/><label for="publish">Publish</label></li>
						<li><input type="radio" name="filter" value="CATEGORY"/><label for="category">Category</label></li>
			</ul>
		</div>
	</div>
	</form>
	
	<!-- The JavaScript --> 
	<script type="text/javascript"  src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
	<script type="text/javascript" src="js/search.js"></script> </section>


	<section>
	<div id="main">
		<div class="top-wrapper clear">
			<div class="content2">
				<table class="article-list margin-small">
					<tbody>
						<% for(int i=0; i<list.size(); i++) { %>
						<tr>
							<td class="regnum"><%= list.get(i).getRegnum() %></td>
							<td class="bookname"><a href="bookDetail.jsp?regnum=<%=list.get(i).getRegnum()%>&pages=<%=pages%>&search=<%=search%>&filter=<%=filter%>"><%= list.get(i).getBookname() %></a></td>
							<td class="writer"><%=list.get(i).getWriter() %></td>
							<td class="publish"><%= list.get(i).getPublish() %></td>
							<td class="ISBN"><%= list.get(i).getISBN() %></td>
							<td class="hit"><%= list.get(i).getHit() %></td>
						</tr>
						<% } %>
					</tbody>
				</table>
				<!-- <p class="article-comment margin-small">
						<a class="btn-write button" href="noticeReg.jsp">글쓰기</a>
					</p> -->
				<p id="cur-page" class="margin-small">
					<span class="strong"><%=pages %></span> /
					<%=endPageNum %>
					page
				</p>
				<div id="pager-wrapper" class="margin-small">
					<div class="pager-clear">
						<p id="btnPrev"> 
							<% if(startPageNum != 1) { %>
							<a class="button btn-prev" href="books.jsp?pages=<%=startPageNum-5%>&search=<%=search%>&filter=<%=filter%>">이전</a> <%} %>
						</p>
						<ul class="numbering">
							<% for (int i = 0; i < 5; i++) { %>
							<li class="here">
								<% if (startPageNum + i <= endPageNum) { %> <% if(startPageNum + i == pages) { %>
								<a class="strong" href="books.jsp?pages=<%=startPageNum + i%>&search=<%=search%>&filter=<%=filter%>"><%=startPageNum + i%></a>
								<% } else if(startPageNum + i != pages) { %> 
								<a href="books.jsp?pages=<%=startPageNum + i%>&search=<%=search%>&filter=<%=filter%>"><%=startPageNum + i%></a>
								<% }%> <%} %>
							</li>
							<% } %>
						</ul>
						  	<p id="btnNext">
                        		<%if(startPageNum + 4 < endPageNum){ %>
                           			<a class="button btn-next" href="books.jsp?pages=<%=startPageNum+5 %>&search=<%=search%>&filter=<%=filter%>">다음</a>
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