<%@page import="com.Library.dao.NoticeDAO"%>
<%@page import="com.Library.vo.Notice"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%

	String mid = null;
	if(request.getSession().getAttribute("mid")==null) {
		request.getSession().setAttribute("returnURL", "/notice.jsp");
		response.sendRedirect("login.jsp");
		
	} else {
		mid=(String)request.getSession().getAttribute("mid");
	}
		
	int pages=1;
	String _pages = request.getParameter("pages");
	if(_pages !=null && !_pages.equals("")) {
		pages = Integer.parseInt(_pages);
	}
	
	List<Notice> list = null;
	NoticeDAO dao = new NoticeDAO();
	
	String seq = request.getParameter("seq");
	
	String search = request.getParameter("search");
	String filter = request.getParameter("filter");
	
	if(search!=null && search.length()>0 && filter!=null && filter.length()>0) {
		list = dao.searchNotices(search, filter, pages);
		//System.out.println("size:"+list.size());
		//System.out.println("pages:"+pages);
	} else {
		list = dao.getNotices(pages,10);		
	}
	
	int cnt = dao.getCount();
	int startPageNum = pages - (pages-1)%5;
	int endPageNum = cnt/10 + (cnt%10==0?0:1);
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>library project_sung</title>
<link rel="stylesheet" type="text/css" href="css/notice.css" />
</head>
<body>
	<% if (mid == null) { %>
	<jsp:include page="header.jsp" flush="flase"></jsp:include>
	<% } else { %>
	<jsp:include page="welcomeheader.jsp" flush="flase"></jsp:include>
	<% } %>

	<section>
	<div id="main">
		<div class="top-wrapper clear">
			<div class="content">
				<h2>Notice and Request</h2>
				<form id="content-searchform" class="article-search-form"
					action="notice.jsp" method="post">
					<fieldset>
						<!-- <input type="hidden" name="pg" value="" /> -->
						<!-- <label for="f" class="hidden">검색필드</label> -->
						<select name="filter">
							<option value="TITLE">제목</option>
							<option value="CONTENT">내용</option>
						</select>
						<!-- <label class="hidden" for="q">검색어</label> -->
						<%if(search!=null) { %>
						<input type="text" name="search" value="<%=search %>" />
						<%} else { %>
						<input type="text" name="search" value="" />
						<%} %>
						<input type="submit" value="검색" />
					</fieldset>
				</form>
				<table class="article-list margin-small">
					<caption class="hidden">공지사항</caption>
					<thead>
						<tr>
							<th class="seq">번호</th>
							<th class="title">제목</th>
							<th class="writer">작성자</th>
							<th class="regdate">작성일</th>
							<th class="hit">조회수</th>
						</tr>
					</thead>
					<tbody>
						<% for(int i=0; i<list.size(); i++) { %>
						<tr>
							<td class="seq"><%= list.get(i).getSeq() %></td>
							<td class="title"><a class="titlego"
								href="noticeDetail.jsp?seq=<%=list.get(i).getSeq()%>&pages=<%=pages%>"><%= list.get(i).getTitle() %></a></td>
							<td class="writer"><%= list.get(i).getWriter() %></td>
							<td class="regdate"><%= list.get(i).getRegdate() %></td>
							<td class="hit"><%= list.get(i).getHit() %></td>
						</tr>
						<% } %>
					</tbody>
				</table>
				<p class="article-comment">
					<a class="btn-writebutton" href="noticeReg.jsp">글쓰기</a>
				</p>
				<p id="cur-page" class="margin-small">
					<span class="strong"><%=pages %></span> /
					<%=endPageNum %>
					page
				</p>
				<div id="pager-wrapper" class="margin-small">
					<div class="pager clear">
						<p id="btnPrev">
							<% if(startPageNum != 1) { %>
							<a class="button btn-prev"
								href="notice.jsp?pages=<%= startPageNum-5%>">이전</a>
							<%} %>
						</p>
						<ul class="numbering">
							<% for (int i = 0; i < 5; i++) { %>
							<li class="here">
								<% if (startPageNum + i <= endPageNum) { %> <% if(startPageNum + i == pages) { %>
								<a class="strong" href="notice.jsp?pages=<%=startPageNum + i%>"><%=startPageNum + i%></a>
								<% } else if(startPageNum + i != pages) { %> <a
								href="notice.jsp?pages=<%=startPageNum + i%>"><%=startPageNum + i%></a>
								<% }%> <%} %>
							</li>
							<% } %>
						</ul>
						<p id="btnNext">
							<%if(startPageNum + 4 < endPageNum){ %>
							<a class="button btn-next"
								href="notice.jsp?pages=<%=startPageNum+5 %>">다음</a>
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