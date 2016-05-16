<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
    String mid = null;
	if(request.getSession().getAttribute("mid")==null){
		//로그인 상태 아님->로그인 페이지로 
		request.getSession().setAttribute("returnURL", "/noticeReg.jsp");
		response.sendRedirect("login.jsp");
	} else {
		mid = (String)request.getSession().getAttribute("mid");
	}

%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>library project_sung</title>
<link rel="stylesheet" type="text/css" href="css/noticeReg.css" />
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
				<form action="noticeRegProc.jsp" method="post">
					<h2>Notice and Request</h2>
					<div id="notice-article-detail" class="article-detail margin-large">
						<dl class="article-detail-row">
							<dt class="article-detail-title">제목</dt>
							<dd class="article-detail-data">
								&nbsp;<input name="title" />
							</dd>
						</dl>
						<div class="article-content">
							<textarea id="txtContent" class="txtContent" name="content"></textarea>
						</div>

					</div>
					<p class="article-comment margin-small">
						<input class="btn-save button" type="submit" value="저장" /> <a
							class="btn-cancelbutton" href="notice.jsp">취소</a>
					</p>
				</form>
			</div>
		</div>
	</div>

</body>
</html>
