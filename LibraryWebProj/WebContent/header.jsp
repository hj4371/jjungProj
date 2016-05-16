<%@page import="com.Library.dao.NoticeDAO"%>
<%@page import="com.Library.vo.Notice"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String error = (String)request.getAttribute("error");

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>library project_sung</title>
<link rel="stylesheet" type="text/css" href="css/header.css"/>
<script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
<script type="text/javascript" src="js/index.js"></script>
</head>
<body>
	<section>
		<header>
			<div class="box1">
				<h1>Library Project</h1>
				<% if(error!=null) { %>
						<p> <%=error %> </p>
				<%} %>
				<form action="loginProc.jsp" method="post">
				<span>
					<a href="main.jsp">HOME</a> | <a href="">SITEMAP</a> | <a href="#" id="loginText">LOGIN</a> | <a href="join.jsp" id="signupText">SIGN UP</a>
				</span>
				<div class="login">
						<div class="arrow-up"></div>
						<div class="formholder">
							<div class="randompad">
								<fieldset>
									<label name="email">ID</label> <input type="text" name="mid" />
									<label name="password">Password</label> <input type="password"	name="pwd" /> <input type="submit" value="Login" />
								</fieldset>
							</div>
						</div>
					</div>		
			</form>
			</div>
			<nav class="box2">
				<ul id="topnav">
        			<li>
            			<a href="login.jsp">BOOKS</a>
        			</li>
       				<li>
            			<a>Board</a>
           	 			<span>
                		<a href="login.jsp">Notice and Request</a> |
                		<a href="login.jsp">Comments</a> |
                		<a href="login.jsp">Ask new ones</a>
            			</span>
        			</li>
        			<li>
            			<a href="">Seats</a>
        			</li>
        			<li><a href="">Contact</a>
        				<span>
        					<a>Sung Hyun Jung</a> <a>hj4371@naver.com </a>
        				</span>
        			</li>
    			</ul>
			</nav>
		</header>
	</section>
	</body>
</html>