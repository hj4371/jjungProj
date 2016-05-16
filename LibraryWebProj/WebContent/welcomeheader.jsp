<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String mid = (String) request.getSession().getAttribute("mid");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>library project_sung</title>
<link rel="stylesheet" type="text/css" href="css/welcome.css"/>
</head>
<body>
	<section>
		<header>
			<div class="box1">
				<h1>Library Project</h1>
				<% if(mid.equals("ADMINISTER")) { %>
						<a class="admin" href="AdminPage.jsp"> Admin Page </a>
				<%} %>
				<span>
					<a href="main.jsp">HOME</a> | <a href="">SITEMAP</a> | <a href="mypage.jsp">MY PAGE</a> | <a href="logoutProc.jsp" >LOGOUT</a>
				</span>
			</div>
			<nav class="box2">
				<ul id="topnav">
        			<li>
            			<a href="books.jsp">BOOKS</a>
        			</li>
       				<li>
            			<a href="">Board</a>
           	 			<span>
                		<a href="notice.jsp">Notice and Request</a> |
                		<a href="comment.jsp">Comments</a> |
                		<a href="ask.jsp">Ask new ones</a>
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