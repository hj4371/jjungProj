<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String error = (String)request.getAttribute("error");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>library project_sung</title>
<link rel="stylesheet" type="text/css" href="css/login.css" />
<script type="text/javascript"
	src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
<script type="text/javascript" src="js/index.js"></script>
</head>
<body>
	<jsp:include page="header.jsp" flush="flase"></jsp:include>
	<section>
	<div id="main">
		<div class="top-wrapper clear">
			<div id="content">
				<h2>Login First</h2>
				<div id="join-form" class="join-form margin-large">
					<% if(error!=null){ %>
					<p><%=error%></p>
					<% } %>
					<form action="loginProc.jsp" method="post">
						<fieldset>
							<ul id="loginBox">
								<li><label for="uid">아이디</label><input name="mid"
									class="text" /></li>
								<li><label for="pwd">비밀번호</label><input type="password"
									name="pwd" class="text" /></li>

							</ul>
							<p>
								<input type="submit" id="btnLogin" value="LOGIN" />
							</p>
							<ul id="loginOption">
								<li><span>아이디 또는 비밀번호를 분실하셨나요?</span><a href="">ID/PWD
										찾기</a></li>
								<li><span>아이디가 없으신 분은 회원가입을 해주세요.</span><a href="join.jsp">회원가입</a></li>
							</ul>

						</fieldset>
					</form>
				</div>

			</div>

		</div>
	</div>
	</section>
</body>
</html>
