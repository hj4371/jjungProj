<%@page import="com.Library.vo.Notice"%>
<%@page import="com.Library.dao.NoticeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	//데이터 만들기
	String seq = request.getParameter("seq");
	NoticeDAO dao = new NoticeDAO();
	String pages = request.getParameter("pages");
	//System.out.println(pages);
	String mid = (String) request.getSession().getAttribute("mid");;
	Notice n=null;
	n = dao.getNotice(seq);
	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>library project_sung</title>
<link rel="stylesheet" type="text/css" href="css/noticeEdit.css" />
</head>
<body>
	<% if (mid == null) { %>
	<jsp:include page="header.jsp" flush="flase"></jsp:include>
	<% } else { %>
	<jsp:include page="welcomeheader.jsp" flush="flase"></jsp:include>
	<% } %>

	<div id="main">
		<div class="top-wrapper clear">
			<div id="content">
				<h2>Notice and Request</h2>
				<form action="noticeEditProc.jsp" method="post" >
					<div id="notice-article-detail" class="article-detail margin-large">
						<dl class="article-detail-row">
							<dt class="article-detail-title">제목</dt>
							<dd class="article-detail-data">
								&nbsp;<input name="title" value="<%=n.getTitle() %>" />
							</dd>
						</dl>
						<dl class="article-detail-row half-row">
							<dt class="article-detail-title">작성자</dt>
							<dd class="article-detail-data half-data">
								<%=n.getWriter() %>
							</dd>
						</dl>
						<dl class="article-detail-row half-row">
							<dt class="article-detail-title">조회수</dt>
							<dd class="article-detail-data half-data">
								<%=n.getHit() %>
							</dd>
						</dl>
						<div class="article-content">
							<textarea id="txtContent" class="txtContent" name="content"><%=n.getContent() %></textarea>
						</div>
					</div>
					<p class="article-comment margin-small">
						<input type="hidden" name="seq" value="<%=n.getSeq() %>" /> 
						<input type="submit" value="저장" class="btn-save button" /> 
						<input type="hidden" name="pages" value="<%=pages %>" /> 
						<a class="btn-cancelbutton" href="noticeDetail.jsp?seq=<%=n.getSeq()%>&pages=<%=pages %>">취소</a>
					</p>
				</form>
			</div>

		</div>
	</div>

</body>
</html>
