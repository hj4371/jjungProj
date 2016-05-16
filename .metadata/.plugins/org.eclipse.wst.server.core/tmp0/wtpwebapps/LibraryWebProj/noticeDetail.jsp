<%@page import="com.Library.vo.Notice"%>
<%@page import="com.Library.dao.NoticeDAO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%

	String seq = request.getParameter("seq");
	NoticeDAO dao = new NoticeDAO();
	Notice n = dao.getNotice(seq);
	String pages = request.getParameter("pages");
	
	String mid = null;
	if (request.getSession().getAttribute("mid") == null) {
		request.getSession().setAttribute("returnURL", "/noticeDetail.jsp?seq="+seq+"&pages="+pages);
		response.sendRedirect("login.jsp");
	} else {
		mid = (String) request.getSession().getAttribute("mid");
	}

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>library project_sung</title>
<link rel="stylesheet" type="text/css" href="css/noticeDetail.css" />
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
				<div id="notice-article-detail" class="article-detail margin-large">
					<dl class="article-detail-row">
						<dt class="article-detail-title">제목</dt>
						<dd class="article-detail-data">
							<%=n.getTitle() %>
						</dd>
					</dl>
					<dl class="article-detail-row">
						<dt class="article-detail-title">작성일</dt>
						<dd class="article-detail-data">
							<%=n.getRegdate() %>
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
						<%=n.getContent() %>
					</div>
				</div>
				<p class="article-comment margin-small">
					<a class="btn-listbutton" href="notice.jsp?pages=<%=pages %>">목록</a>
					<%if (mid!=null && (mid.equals(n.getWriter())||mid.equals("ADMINISTER"))) { %>
					<a class="btn-editbutton"
						href="noticeEdit.jsp?seq=<%=n.getSeq()%>&pages=<%=pages %>">수정</a>
					<a class="btn-delbutton"
						href="noticeDelProc.jsp?seq=<%=n.getSeq()%>">삭제</a>
					<%} %>
				</p>

			</div>

		</div>
	</div>

</body>
</html>
